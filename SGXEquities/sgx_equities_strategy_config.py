import pandas as pd
import os

from algotrader_com.domain.market_data import Bar, Tick, Trade
from algotrader_com.domain.order import LimitOrder, MarketOrder
from datetime import time, datetime
from dotenv import load_dotenv
from helper_models.general.verbose import Verbose


class SGXEquitiesStrategyConfig:
    """General class storing data structures, parameters and hyperparameters for all our strategies and models.
    """
    def __init__(self, algotrader_strategy_service):
        # Load environment variables from .env file
        load_dotenv("config.env")

        #############################
        ## MAIN STRATEGY CONSTANTS ##
        #############################
        self.verbose = Verbose(verbosity="ESSENTIAL")
        self.TT_ACCOUNT_ID =
        self.IB_ACCOUNT_ID =
        self.QH_ACCOUNT_ID =
        self.STRATEGY_NAME =
        self.STRATEGY_ID =
        self.LOT_SIZE =
        self.SECURITY_FAMILY_NAME =
        self.TIMEZONE =
        self.BACKTEST_START_DATE =
        self.TRADING_HOURS =
        self.VALID_PICKLING_HOURS =
        self.BACKTEST_NAME =
        self.BACKTEST_FILE_PATH =
        self.RECORDS_FILE_PATH =
        self.PERSISTENCE_FILE_PATH =
        self.MUTED_TRADING_DAYS_FILE_PATH =
        self.UNWANTED_SECURITIES_FILE_PATH =
        self.SWORD_OF_THEMIS =
        self.SCALES_OF_THEMIS =

        #############################
        ## INFLUXDB CONFIGURATIONS ##
        #############################
        self.INFLUX_DB_CONFIG =

        ################################
        ## DATA MODEL HYPERPARAMETERS ##
        ################################
        self.FILTER_TICK_PERIOD =
        self.FILTER_TRADE_PERIOD =
        self.FILTER_BAR_PERIOD =
        self.MINIMUM_ACCEPTABLE_PCT_CHANGE =
        self.MAXIMUM_ACCEPTABLE_PCT_CHANGE =

        ###############################
        ## UNIVERSE MODEL PARAMETERS ##
        ###############################
        self.FILTER_PERCENTILE =

        ####################################
        ## UNIVERSE MODEL HYPERPARAMETERS ##
        ####################################
        self.CDP_SHORTABLE_PROPORTION =
        self.CURRENCIES_AND_ID = {}
        self.MAX_CLUSTER_TO_TEST_FOR = 
        self.DOWNLOAD_HISTORICAL_DATA_FOR_UNIVERSE_PERIOD = 
        self.ROLLING_CORRELATION_WINDOW = # Controls Universe Model Clustering

        #####################################
        ## GENERAL FACTOR MODEL PARAMETERS ##
        #####################################
        self.TIME_THRESHOLD_BEFORE_ENTERING = # Threshold for taking positions after exchange opens
        self.TIME_THRESHOLD_AFTER_OPEN = # Prevents exiting positions right after exchange opens
        self.TIME_THRESHOLD_BEFORE_CLOSE = # Prevents entering/ exiting positions when exchange is closing
        self.SIGNAL_HALFLIFE_DECAY_PCT =
        self.NUMBER_OF_TIME_SLICES_IN_A_DAY = # Helper parameter to control LG PRICE COINT LENGTH with the LG PRICE COINT LENGTH MULTIPLIER
        self.FEATURE_WINDOWS_MULTIPLIERS =
        self.ACTIVATE_METALABELING =
        self.ENABLE_REFITTING =

        ###########################################
        ## SERIAL MOMENTUM RSRS MODEL PARAMETERS ##
        ###########################################
        self.SERIAL_MOMENTUM_RSRS_CORRELATION_LENGTH_MULTIPLIER =
        self.SERIAL_MOMENTUM_RSRS_FORWARD_SENSITIVITY_MULTIPLIER =
        self.SERIAL_MOMENTUM_RSRS_LOOKBACK_SENSITIVITY_MULTIPLIER =
        self.SERIAL_MOMENTUM_RSRS_TAKE_PROFIT_GRADIENT_MULTIPLIER =
        self.SERIAL_MOMENTUM_RSRS_STOP_LOSS_GRADIENT_MULTIPLIER =

        ################################################
        ## SERIAL MOMENTUM RSRS MODEL HYPERPARAMETERS ##
        ################################################
        self.SERIAL_MOMENTUM_RSRS_CORRELATION_LENGTH =
        self.SERIAL_MOMENTUM_RSRS_LOOKBACK_FORWARD_CALCULATION_COOLDOWN =
        self.SERIAL_MOMENTUM_RSRS_R2_THRESHOLD =
        self.SERIAL_MOMENTUM_RSRS_MAX_NUMBER_OF_DAYS_AS_HOLDING =
        self.SERIAL_MOMENTUM_RSRS_STARTING_SD =
        self.SERIAL_MOMENTUM_RSRS_POSITION_SIZE_MAX =
        self.SERIAL_MOMENTUM_RSRS_THRESHOLD_FOR_SMALL_MODIFICATION =
        self.SERIAL_MOMENTUM_RSRS_POSITION_CALCULATION =

        ##############################################
        ## CROSS SECTIONAL CLUSTER MODEL PARAMETERS ##
        ##############################################
        self.CROSS_SECTIONAL_LG_PRICE_STATIONARY_LENGTH_MULTIPLIER =
        self.CROSS_SECTIONAL_PCT_DIFFERENCE_LENGTH_MULTIPLIER =
        self.CROSS_SECTIONAL_HALFLIFE_SENSITIVITY_MULTIPLIER =
        self.CROSS_SECTIONAL_TAKE_PROFIT_STD_MULTIPLIER =
        self.CROSS_SECTIONAL_STOP_LOSS_STD_MULTIPLIER =

        ###################################################
        ## CROSS SECTIONAL CLUSTER MODEL HYPERPARAMETERS ##
        ###################################################
        self.CROSS_SECTIONAL_PCT_DIFFERENCE_LENGTH =
        self.CROSS_SECTIONAL_LG_PRICE_STATIONARY_LENGTH =
        self.CROSS_SECTIONAL_STATIONARY_CALCULATION_COOLDOWN =
        self.CROSS_SECTIONAL_ADF_STATIONARY_P_THRESHOLD =
        self.CROSS_SECTIONAL_MINIMUM_HALFLIFE =
        self.CROSS_SECTIONAL_STARTING_SD =
        self.CROSS_SECTIONAL_SIZE_MAX =

        ###############################
        ## LGSPREAD MODEL PARAMETERS ##
        ###############################
        self.SERIAL_COINTEGRATION_LG_PRICE_COINT_LENGTH_MULTIPLIER = # Controls the main parameter of how much data is required before we test for stationarity
        self.SERIAL_COINTEGRATION_HALFLIFE_SENSITIVITY_MULTIPLIER = # Controls how sensitive the strategy is when dealing with time stops and zscore
        self.SERIAL_COINTEGRATION_TAKE_PROFIT_STD_MULTIPLIER = # Controls take profit barrier
        self.SERIAL_COINTEGRATION_STOP_LOSS_STD_MULTIPLIER = # Controls stop loss barrier

        ####################################
        ## LGSPREAD MODEL HYPERPARAMETERS ##
        ####################################
        self.SERIAL_COINTEGRATION_STARTING_SD = # Controls the zscore that we enter positions in
        self.SERIAL_COINTEGRATION_ADF_STATIONARY_P_THRESHOLD = # Controls the p-value threshold for difference stationarity
        self.SERIAL_COINTEGRATION_KPSS_P_THRESHOLD =
        self.SERIAL_COINTEGRATION_STATIONARY_CALCULATION_COOLDOWN =
        self.SERIAL_COINTEGRATION_MINIMUM_HEDGE_RATIO_LIMIT = # Controls the max ratio of hA: hB we are willing to accept
        self.SERIAL_COINTEGRATION_MAXIMUM_HEDGE_RATIO_LIMIT =
        self.SERIAL_COINTEGRATION_THRESHOLD_FOR_SMALL_MODIFICATION =
        self.SERIAL_COINTEGRATION_SPREAD_SIZE_MAX = # Controls the max position of spreads we are willing to enter
        self.SERIAL_COINTEGRATION_LG_PRICE_COINT_LENGTH = # Control the length that tests for stationarity
        self.SERIAL_COINTEGRATION_TEST_DIFFERENCE_STATIONARY =
        self.SERIAL_COINTEGRATION_TEST_TREND_STATIONARY =
        self.SERIAL_COINTEGRATION_MINIMUM_HALFLIFE =

        #################################
        ## ALPHA MODEL HYPERPARAMETERS ##
        #################################
        self.RESAMPLING_METHOD =
        self.SIGNAL_GENERATION_COOLDOWN =
        self.TIME_PREPROCESSING_SAMPLING_RATE =
        self.VOLUME_PREPROCESSING_SAMPLING_RATE =
        self.LENGTH_TO_GET_VOLUME_SAMPLING =
        self.ALPHA_FACTOR_MODELS = []
        self.ALPHA_PREPROCESSING_MAX_PRICE_LENGTH = 
        self.EQUITIES_AND_COMMISSIONS = # Percentage of market value
        self.EQUITIES_AND_SLIPPAGES = # Percentage of bid ask spread
        self.MUTED_TRADING_DAYS = []  # Initialised by reading from an external text file

        ####################################
        ## UNIVERSE MODEL HYPERPARAMETERS ##
        ####################################
        self.ROLLING_CORRELATION_WINDOW =

        #####################################
        ## EXECUTION MODEL HYPERPARAMETERS ##
        #####################################
        self.WIDE_PRICE_SPREAD_PERCENTILE =
        self.CHILD_ORDER_COMPLETION_PERIOD =
        self.HISTORICAL_WINDOW =
        self.AGGRESSIVE_EXPONENT =
        self.DOWNLOAD_HISTORICAL_DATA_FOR_EXECUTION_PERIOD =

        #####################################
        ## PORTFOLIO MODEL HYPERPARAMETERS ##
        #####################################
        self.THEMIS_UPDATE_COOLDOWN =
        self.RISK_FACTORS_UPDATE =
        self.ACTIVATE_PORTFOLIO_OPTIMIZER =

        #############################
        ## SAMPLER HYPERPARAMETERS ##
        #############################
        self.SAMPLING_VOLUME_LIQUIDITY_MODIFIER =

        ####################################
        ## FACTOR MANAGER HYPERPARAMETERS ##
        ####################################
        self.ELASTIC_NET_ALPHA =
        self.ELASTIC_NET_l1_RATIO =
        self.ELASTIC_NET_ITERATIONS =
        self.NUMBER_OF_DAYS_OF_RISK_FACTOR_PRICES =

        self.RISK_FREE_RATE_ETF = {}

        self.ASSET_PREMIUM_ETFS = {'}

        self.STRATEGY_PREMIUM_ETFS = {}

        self.SECTOR_PREMIUM_ETFS = {}

        self.GEOGRAPHY_PREMIUM_ETFS = {}

        ######################################
        ## ALGOTRADER FUNCTIONS AND CLASSES ##
        ######################################
        self.ALGOTRADER_MARKET_ORDER = MarketOrder
        self.ALGOTRADER_LIMIT_ORDER = LimitOrder
        self.ALGOTRADER_BAR_OBJECT = Bar
        self.ALGOTRADER_TICK_OBJECT = Tick
        self.ALGOTRADER_TRADE_OBJECT = Trade

        self.ALGOTRADER_STRATEGY_SERVICE = algotrader_strategy_service
        self.ALGOTRADER_GET_BARS_BY_TIME_WINDOW_FUNCTION = algotrader_strategy_service.python_to_at_entry_point. \
            historical_data_service.get_bars_by_security_min_date_max_date_and_bar_size
        self.ALGOTRADER_GET_TICKS_BY_MAX_DATE_FUNCTION = algotrader_strategy_service.python_to_at_entry_point.historical_data_service.get_ticks_by_max_date
        self.ALGOTRADER_GET_TRADES_BY_MAX_DATE_FUNCTION = algotrader_strategy_service.python_to_at_entry_point.historical_data_service.get_trades_by_max_date

        self.ALGOTRADER_SUBSCRIPTION_FUNCTION = algotrader_strategy_service.python_to_at_entry_point.subscription_service.subscribe_market_data_event
        self.ALGOTRADER_UNSUBSCRIPTION_FUNCTION = algotrader_strategy_service.python_to_at_entry_point.subscription_service.unsubscribe_market_data_event

        self.ALGOTRADER_GET_SECURITY_FAMILY_BY_FAMILY_NAME = algotrader_strategy_service.python_to_at_entry_point.lookup_service.get_security_family_by_name
        self.ALGOTRADER_GET_SECURITIES_BY_SECURITY_FAMILY = algotrader_strategy_service.python_to_at_entry_point.lookup_service.get_securities_by_security_family

        self.ALGOTRADER_PAUSE_SIMULATION_FUNCTION = algotrader_strategy_service.python_to_at_entry_point.market_data_service.pause_simulation_data
        self.ALGOTRADER_RESUME_SIMULATION_FUNCTION = algotrader_strategy_service.python_to_at_entry_point.market_data_service.resume_simulation_data

        self.ALGOTRADER_SEND_ORDER_FUNCTION = algotrader_strategy_service.python_to_at_entry_point.order_service.send_order
        self.ALGOTRADER_CANCEL_ORDER_FUNCTION = algotrader_strategy_service.python_to_at_entry_point.order_service.cancel_order_by_int_id

        self.ALGOTRADER_GET_TRANSACTIONS_BY_FILTER = algotrader_strategy_service.python_to_at_entry_point.portfolio_service.get_transactions_by_filter
        self.ALGOTRADER_GET_PORTFOLIO_VALUE_OF_STRATEGY_ON_DATE = algotrader_strategy_service.python_to_at_entry_point.portfolio_service.get_portfolio_value_of_strategy_on_date
        self.ALGOTRADER_GET_REALIZED_PL_OF_STRATEGY = algotrader_strategy_service.python_to_at_entry_point.portfolio_service.get_realized_pl_of_strategy

    def update_no_trading_days(self):
        """ Helper function to read in muted trading days from external text file, and update internal variable
        """
        raw_dates = open(self.MUTED_TRADING_DAYS_FILE_PATH).read().split('\n')
        processed_dates = [datetime.strptime(x, "%Y-%m-%d").date() for x in raw_dates]
        self.MUTED_TRADING_DAYS = processed_dates

    def __getstate__(self):
        """
        Helper function that deletes all AlgoTrader functions when pickling our strategy,
        as AlgoTrader functions/classes are Socket objects that cannot be pickled.
        """
        state = self.__dict__.copy()
        state['ALGOTRADER_STRATEGY_SERVICE'] = None
        state['ALGOTRADER_GET_BARS_BY_TIME_WINDOW_FUNCTION'] = None
        state['ALGOTRADER_GET_TICKS_BY_MAX_DATE_FUNCTION'] = None
        state['ALGOTRADER_GET_TRADES_BY_MAX_DATE_FUNCTION'] = None
        state['ALGOTRADER_SUBSCRIPTION_FUNCTION'] = None
        state['ALGOTRADER_UNSUBSCRIPTION_FUNCTION'] = None
        state['ALGOTRADER_GET_SECURITY_FAMILY_BY_FAMILY_NAME'] = None
        state['ALGOTRADER_GET_SECURITIES_BY_SECURITY_FAMILY'] = None
        state['ALGOTRADER_PAUSE_SIMULATION_FUNCTION'] = None
        state['ALGOTRADER_RESUME_SIMULATION_FUNCTION'] = None
        state['ALGOTRADER_SEND_ORDER_FUNCTION'] = None
        state['ALGOTRADER_CANCEL_ORDER_FUNCTION'] = None
        state['ALGOTRADER_GET_TRANSACTIONS_BY_FILTER'] = None
        state['ALGOTRADER_GET_PORTFOLIO_VALUE_OF_STRATEGY_ON_DATE'] = None
        state['ALGOTRADER_GET_REALIZED_PL_OF_STRATEGY'] = None

        return state