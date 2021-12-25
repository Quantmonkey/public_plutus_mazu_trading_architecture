import pandas as pd
import threading

from datetime import datetime, time
from algotrader_com.interfaces.connection import connect_to_algotrader, wait_for_algotrader_to_disconnect
from algotrader_com.services.strategy import StrategyService

from primary_models.sgx_equities_universe_model import SGXEquitiesUniverseModel
from primary_models.sgx_equities_data_model import SGXEquitiesDataModel
from primary_models.sgx_equities_alpha_model import SGXEquitiesAlphaModel
from primary_models.sgx_equities_portfolio_model import SGXEquitiesPortfolioModel
from primary_models.sgx_equities_execution_model import SGXEquitiesExecutionModel

from helper_models.general.exception_handler import ExceptionHandler
from helper_models.general.persistence import SGXEquitiesPersistence
from helper_models.backtest.backtest_recorder import BacktestRecorder
from helper_models.data.hygieia import Hygieia
from sgx_equities_strategy_config import SGXEquitiesStrategyConfig
exception_handler = ExceptionHandler()

class SGXEquitiesStrategyService(StrategyService):
    """ Main logic for SGXEquities, inherited from Algotrader StrategyService Class
    """
    def __init__(self):
        StrategyService.__init__(self)
        # primary models, initialised at on_init
        self.universe_model = None
        self.data_model = None
        self.alpha_model = None
        self.portfolio_model = None
        self.execution_model = None

        # helper models, initialised at on_init
        self.strategy_config = None
        self.backtest_recorder = None
        self.persistence = None
        self.hygieia = None

        # internal data structures
        self.current_time = None
        self.ready_to_start = False  # lock to protect strategy from starting before on_start is called
        self.check_pickled_strategies = False  # lock to prevent initiating primary models and persistence twice
        self.persistence_thread = None  # daemon thread to perform pickling of strategy
        self.skip_daily_update_because_weekly_update_done = False

        # data structures for tracking periodic updates
        self.previous_weekly_update_datetime = None
        self.previous_daily_update_datetime = None
        self.previous_hourly_update_datetime = None

    def on_tick(self, tick):
        """Called whenever we receive an Algotrader tick object.
        """
        if self.ready_to_start:
            self.let_data_model_handle_tick_data(tick)
            self.current_time = self.data_model.current_time
            self.main_event_loop()

    def on_trade(self, trade):
        """Called whenever we receive an Algotrader trade object.
        """
        if self.ready_to_start:
            self.let_data_model_handle_trade_data(trade)
            self.current_time = self.data_model.current_time

    def on_bar(self, bar):
        """Called whenever we receive an Algotrader bar object.
        """
        if self.ready_to_start:
            self.let_data_model_handle_bar_data(bar)
            self.current_time = self.data_model.current_time
            self.check_if_time_to_do_periodic_updates()

            # multi-threaded pickling of the strategy state
            self.persistence_thread = threading.Thread(name='pickle_save_daemon',
                                                       target=self.persistence.check_if_ready_to_and_pickle_entire_strategy,
                                                       args=(self, bar.date_time,))
            self.persistence_thread.setDaemon(True)
            self.persistence_thread.start()

    def on_order_status(self, order_status):
        """Called whenever we receive an Algotrader order_status object
        """
        self.execution_model.receive_order_status_and_update(order_status)

    def on_transaction(self, transaction):
        """Called whenever we receive an Algotrader transaction object.
        """
        self.portfolio_model.receive_transaction_and_update(transaction)

    @exception_handler.except_main_event_loop
    def main_event_loop(self):
        """
        Strategy's main method, which is called on each tick. This method can be broken into 3 steps:

            1. Alpha Model: emitting signals
                - preprocessing latest market data for, and updating factor models
                - calling factor models to generate signals, and aggregating these signals
                - emitting signals to the portfolio model

            2. Portfolio Model: creating order vector
                - read latest instructions from themis' scales
                - normalize, and sum up signals from Alpha model
                - optimise portfolio to reduce market risk exposure
                - produce optimal portfolio, while applying themis and cdp pool restrictions
                - emit order vector, which is equal to (optimal portfolio - current portfolio)

            3. Execution Model: executing order vector
                - call vwap to slice order vector into 10 child orders
                - call child order manager to manage each child order
                - create pending orders and add them to a queue (list object)
                - send pending orders one at a time
        """
        if self.current_time is not None:
            self.alpha_model.preprocess_data_for_factor_models()
            self.alpha_model.update_factor_models()
            self.alpha_model.get_factor_model_signals()
            factors_and_dict_of_signal = self.alpha_model.emit_alpha_signals()

            self.portfolio_model.get_external_instructions_from_themis()
            self.portfolio_model.update_optimal_portfolio(factors_and_dict_of_signal)
            self.portfolio_model.update_order_vector()
            order_vector = self.portfolio_model.emit_order_vector()

            child_orders = self.execution_model.slice_order(order_vector)
            self.execution_model.execute_new_order_vectors(child_orders)
            self.execution_model.send_pending_orders()

    def check_if_time_to_do_periodic_updates(self):
        """Contains logic for all updates that are done periodically.
        """
        if self.current_time is not None:
            weekly_update_needed = (self.current_time - self.previous_weekly_update_datetime) >= pd.Timedelta("7days")
            daily_update_needed = (self.current_time - self.previous_daily_update_datetime) >= pd.Timedelta("1days")
            hourly_update_needed = (self.current_time - self.previous_hourly_update_datetime) >= pd.Timedelta('1H')

            if weekly_update_needed:
                self.previous_weekly_update_datetime += pd.Timedelta("7days")
                self.perform_weekly_updates()

            if daily_update_needed:
                # If today is a friday, push forward 2 days to skip weekends
                if self.previous_daily_update_datetime.weekday() == 3:
                    self.previous_daily_update_datetime += pd.Timedelta('3days')
                else:
                    self.previous_daily_update_datetime += pd.Timedelta('1day')
                self.perform_daily_updates()

            if hourly_update_needed:
                self.previous_hourly_update_datetime += pd.Timedelta('1H')
                self.portfolio_model.scrape_cdp_pool_data()

    def initialise_previous_update_datetimes_on_start(self):
        """Called on strategy start, initialise all previous update datetimes for periodic updating logic to work.
        """
        time_now = self.strategy_config.BACKTEST_START_DATE if self.strategy_config.BACKTEST_START_DATE is not None else datetime.now()

        # initialise previous weekly update datetime to be the friday of the week we run the strategy, right after exchange closes
        weekday = time_now.weekday()
        last_closing_time = self.strategy_config.TRADING_HOURS['trading_intervals'][-1][-1]
        self.previous_weekly_update_datetime = pd.to_datetime(datetime.combine(time_now, last_closing_time)).tz_localize("Asia/Singapore") +\
                                               pd.Timedelta(days=4-weekday)

        # initialise previous daily update datetime to be the day before we run the strategy, right after exchange closes
        self.previous_daily_update_datetime = pd.to_datetime(datetime.combine(time_now, last_closing_time)).tz_localize("Asia/Singapore") - pd.Timedelta('1days')

        # initialise previous hourly update datetime to be current hour (hourly updates are only used for live trading)
        hour = datetime.now().hour
        self.previous_hourly_update_datetime = pd.to_datetime(datetime.combine(datetime.now(), time(hour, 0))).tz_localize('Asia/Singapore')

    @exception_handler.except_perform_weekly_updates
    def perform_weekly_updates(self):
        """
        Performs a weekly universe reset. The following updates are made:

            1. Universe Model: universe reset
                - downloads latest historical data and update universe to select most liquid securities
                - update subscriptions to securities, by unsubscribing to removed securities and subscribing to new ones
                - propagates latest universe to the other primary models

            2. Data Model: update data structures

            3. Alpha Model: update data structures and create factor models
                - call Sampler class to get latest volume bar size
                - creating new factor models for new universe
                - refitting of all downstream models
                - pass updated downstream models to factor models

            4. Portfolio Model: initialising new data structures

            5. Execution Model: initialising new data structures
                - download trade data for VWAP to update order slicing
                - download tick data for child order manager to update latest metrics for managing child orders
        """
        oustanding_orders = self.portfolio_model.get_outstanding_orders_from_resync_portfolios()

        # Perform the weekly updates
        set_of_securities_holding_positions = self.alpha_model.get_securities_currently_holding_positions(oustanding_orders)
        self.universe_model.reset_universe(self.current_time + pd.Timedelta('1day'), set_of_securities_holding_positions)
        self.universe_model.propagate_universes([self.data_model, self.alpha_model, self.portfolio_model, self.execution_model])

        self.data_model.update_data_structures_with_new_universe()

        self.alpha_model.fit_sampler_with_volume_intervals(self.current_time + pd.Timedelta('1day'))
        self.alpha_model.update_data_structures_with_new_universe(self.current_time + pd.Timedelta('1day'))
        self.alpha_model.refit_updated_downstream_model()
        self.alpha_model.pass_updated_downstream_model_to_factors()

        self.portfolio_model.initialise_data_structures()

        self.execution_model.initialise_data_and_models(self.current_time + pd.Timedelta('1day'))

        # Skip daily update because weekly update has just completed
        self.skip_daily_update_because_weekly_update_done = True

    @exception_handler.except_perform_daily_updates
    def perform_daily_updates(self):
        """
        Perform a daily update. The following updates are made:
            1. Alpha model: check if following day is a trading day
                - mute factor models when the following day is a no-trade day

            2. Execution model: updating VWAP and child order manager
                - Download latest daily data and perform updates
        """
        # Perform daily updates
        self.alpha_model.check_if_tomorrow_is_a_trading_day()
        if self.skip_daily_update_because_weekly_update_done:
            self.skip_daily_update_because_weekly_update_done = False
        else:
            self.execution_model.recalculate_new_metrics_for_vwap_and_com(self.current_time + pd.Timedelta('1days'))

    def initiate_models_and_persistence(self, force_load=False):
        """
        Called on_init, prompts the user if strategy should load from a pickled state (if pickled state exists, and if we are live trading)

        If loading from a pickled state, call persistence to load and restore data structures. Otherwise, initialise new primary models and
        proceed to on_start

        Args:
            force_load (bool): forcefully loads pickled states even during backtest, for debugging purposes. Default: False
        """
        if not self.check_pickled_strategies:
            self.check_pickled_strategies = True
            pickled_models = self.persistence.load_pickled_strategy(force_load=force_load)

            # If we are loading a pickled strategy state
            if pickled_models is not None:
                self.universe_model = pickled_models['Universe Model']
                self.data_model = pickled_models['Data Model']
                self.alpha_model = pickled_models['Alpha Model']
                self.portfolio_model = pickled_models['Portfolio Model']
                self.execution_model = pickled_models['Execution Model']
                self.previous_weekly_update_datetime = pickled_models['Previous Weekly Filter Datetime']
                self.previous_daily_update_datetime = pickled_models['Previous Daily Filter Datetime']

                # Reinitialise strategy, which involves subscribing, new execution schedule etc
                self.universe_model.on_start_subscription()

                self.portfolio_model.update_order_vector(recalculating=True)
                rescheduled_order_vector = self.portfolio_model.emit_order_vector(recalculating=True)

                self.execution_model.clear_all_order_data_structures()
                rescheduled_child_orders = self.execution_model.slice_order(rescheduled_order_vector)
                self.execution_model.reschedule_order_vectors(rescheduled_child_orders)
                self.ready_to_start = True

            # Normal strategy initialisation
            else:
                self.universe_model = SGXEquitiesUniverseModel(self.strategy_config)
                self.data_model = SGXEquitiesDataModel(self.strategy_config)
                self.alpha_model = SGXEquitiesAlphaModel(self.strategy_config)
                self.portfolio_model = SGXEquitiesPortfolioModel(self.strategy_config)
                self.execution_model = SGXEquitiesExecutionModel(self.strategy_config)

    def prepare_universe_model(self):
        """Called on_start, prepares universe model by doing an initial universe filtering and clustering.
        """
        time_now = self.strategy_config.BACKTEST_START_DATE if self.strategy_config.BACKTEST_START_DATE else datetime.now()

        # universe model retrieves full list of equities and ids.
        self.universe_model.retrieve_securities_and_id()

        # universe model does the filtering, clustering and propagates filtered universe
        self.universe_model.reset_universe(time_now, set_of_securities_holding_positions=set())
        self.universe_model.propagate_universes([self.data_model, self.alpha_model, self.portfolio_model, self.execution_model])

    def prepare_data_model(self):
        """Called on_start, calls data model to initialise data structures with trading universe
        """
        self.data_model.assign_universe_to_data_structures()

    def prepare_alpha_model(self):
        """Called on_start, alpha model calls sampler to get volume bar size, and initialise data structures
        """
        time_now = self.strategy_config.BACKTEST_START_DATE if self.strategy_config.BACKTEST_START_DATE else datetime.now()
        self.alpha_model.fit_sampler_with_volume_intervals(time_now)
        self.alpha_model.assign_universe_to_data_structures(time_now)
        self.alpha_model.create_factor_models()
        self.alpha_model.fit_factor_models_with_downstream_models()

    def prepare_portfolio_model(self):
        """Called on_start, portfolio model initialises data structures
        """
        self.portfolio_model.initialise_data_structures()
        self.portfolio_model.scrape_cdp_pool_data()

    def prepare_execution_model(self):
        """Called on_start, execution model initialises VWAP and child order manager with latest historical data.
        """
        # Download historical data for vwap and child order manager
        time_now = self.strategy_config.BACKTEST_START_DATE if self.strategy_config.BACKTEST_START_DATE else datetime.now()
        self.execution_model.initialise_data_and_models(time_now)

    def let_data_model_handle_tick_data(self, tick):
        """Data model collects tick and propagates data to all primary models
        """
        self.data_model.collect_equities_tick(tick)
        self.data_model.propagate_data([self.alpha_model, self.portfolio_model, self.execution_model])

    def let_data_model_handle_bar_data(self, bar):
        """Data model collects bar and propagates data to all primary models
        """
        self.data_model.collect_currencies_bar(bar)
        self.data_model.propagate_data([self.alpha_model, self.portfolio_model, self.execution_model])

    def let_data_model_handle_trade_data(self, trade):
        """Data model collects trade and propagates data to all primary models
        """
        self.data_model.collect_equities_trade(trade)
        self.data_model.propagate_data([self.alpha_model, self.portfolio_model, self.execution_model])

    def on_init(self, lifecycle_event):
        """Algotrader on_init method, which is called when strategy first begins, before on_start
        """
        self.strategy_config = SGXEquitiesStrategyConfig(self)
        self.persistence = SGXEquitiesPersistence(self.strategy_config)
        self.backtest_recorder = BacktestRecorder(self.strategy_config, self.strategy_config.BACKTEST_FILE_PATH)
        self.hygieia = Hygieia(self.strategy_config)
        self.python_to_at_entry_point.set_strategy_name(self.strategy_config.STRATEGY_NAME)
        self.initiate_models_and_persistence()

    def on_start(self, lifecycle_event):
        """Algotrader on_start method, which is called when strategy first begins, after on_init
        """
        self.strategy_config.verbose.orate_strategy_starter_type(self.strategy_config.BACKTEST_START_DATE)

        if not self.ready_to_start:
            self.initialise_previous_update_datetimes_on_start()
            self.prepare_universe_model()
            self.prepare_data_model()
            self.prepare_alpha_model()
            self.prepare_portfolio_model()
            self.prepare_execution_model()
            self.ready_to_start = True

    def on_exit(self, lifecycle_event):
        """Algotrader on_exit method, called when backtesting has ended.
        """
        pickling_process = threading.Thread(target=self.save_backtest_results)
        pickling_process.start()
        self.backtest_recorder.block_strategy_from_exiting_before_pickling()

    def save_backtest_results(self):
        """Called on_exit, calls backtest recorder to save backtest results
        """
        self.alpha_model.get_factors_to_save_their_features()

        # REDACTED

        self.backtest_recorder.record_backtest_results(dict_to_be_pickled)


"""
AlgoTrader Python to Java
"""
only_subscribe_methods_list = ["onInit", "onStart", "onRunning", "onBar", "onTick", "onTrade", "onTransaction", "onOrderStatus", "onExit"]
strategy = SGXEquitiesStrategyService()
_python_to_at_entry_point = connect_to_algotrader(strategy, only_subscribe_methods_list)
wait_for_algotrader_to_disconnect(_python_to_at_entry_point)
