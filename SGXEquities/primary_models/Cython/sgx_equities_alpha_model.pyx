from helper_models.downstream.downstream_model_manager import DownstreamModelManager
from factor_models.equities_serial_cointegration_lg_spread_pair import EquitiesSerialCointegrationLgSpreadPair
from factor_models.equities_cross_sectional_cluster_returns import EquitiesCrossSectionalClusterReturns
from factor_models.equities_serial_momentum_rsrs import EquitiesSerialMomentumRSRS
from helper_models.general.exception_handler import ExceptionHandler
from helper_models.general.signals import Signal
from helper_models.general.sampler import Sampler
from helper_models.data.historical_downloader_new import HistoricalDownloader
from helper_models.general.trading_hours_manager import TradingHoursManager
from datetime import datetime
from tqdm import tqdm
import pandas as pd
import numpy as np

exception_handler = ExceptionHandler()

class SGXEquitiesAlphaModel:
    """
    Alpha model allows us to seek alpha in the market and produce signals to take
    positions whenever such opportunities exist.

    Under the Alpha model is an ensemble of factor models, each producing signals based on specific subsets of
    indicators in the market. Alpha model aggregates these signals (see Signal.__add__) from these factor
    models and passes them to the portfolio model.
    """

    def __init__(self, strategy_config):
        # REDACTED

    def fit_sampler_with_volume_intervals(self, time_now):
        """
        Updates the alpha model to know when to sample (dollar/volume/time) bars for each security.

        For dollar and volume bars, data for past 1 month will be downloaded and the size of each bar for a security
        will depend on the amount of trading volume that occurred for that security in the past month.
        """
        # REDACTED

    def preprocess_data_for_factor_models(self):
        """
        Preprocesses tick and trade data received for each factor model.
        Some examples include:
            1. Resampling into bars (time/volume/dollar)
            2. Calculating log prices
        """
        # REDACTED

    @exception_handler.except_calculate_preprocessed_data_and_record
    def calculate_preprocessed_data_and_record(self, latest_tick, equity):
        """
        Calculate latest (log) prices and resamples trades into bars for the equity.

        Args:
            latest_tick (Algotrader tick): latest tick for the security, used for calculating its latest price
            equity (str): symbol for the security, acts as a key for various dictionary data structures
        """
        # REDACTED

    def append_volume_bar_to_equities_and_volume_bar_lists(self, new_bars, equity):
        # REDACTED

    def calculate_latest_sgd_price_and_update(self, latest_tick, equity):
        """
        Helper function to obtain the latest sgd price of the security, performing currency conversions
        if necessary.

        Args:
            latest_tick (Algotrader tick): latest tick for the security, used for calculating its latest price
            equity (str): symbol for the security, acts as a key for various dictionary data structures
        """
        # REDACTED

    def append_trades_to_lists_for_bar_creation(self, latest_trade, equity):
        """
        Helper function to append trades to a list for resampling into bars.

        Args:
            latest_trade(Algotrader trade): latest trade data for the security, containing volume and last price information.
            equity (str): symbol for the security, acts as a key for various dictionary data structures
        """
        # REDACTED

    def append_latest_log_sgd_prices_to_list(self, equity):
        """
        Helper function to append log prices to a list for the log spread mean reversion factor.

        Args:
            equity (str): symbol for the security, acts as a key for various dictionary data structures
        """
        # REDACTED

    def create_time_bar(self, equity) -> bool:
        """
        Helper function to create time bars. Resampling into time bars occur every fixed time interval (e.g 1 MIN)

        Args:
            equity (str): symbol for the security, acts as a key for various dictionary data structures
        """
        # REDACTED

    def create_volume_bar(self, equity, sampling_interval) -> bool:
        """
        Helper function to create volume bars. Resampling into volume bars occur every fixed volume interval (e.g once per 50000 lots traded)
        Args:
            equity (str): symbol for the security, acts as a key for various dictionary data structures
            sampling_interval
        """
        # REDACTED

    def store_cumulative_volume_to_dictionaries(self, equity):
        """
        Helper function to store cumulative volume for a security to a dictionary. In addition, a volume
        sign indicator is calculated and used as a feature for downstream models.

        Args:
            equity (str): symbol for the security, acts as a key for various dictionary data structures
        """
        # REDACTED

    def dump_bar_lists(self, equity):
        """
        Helper function to empty our bar lists, so we can start trading sessions from a clean slate.

        Args:
            equity (str): symbol for the security, acts as a key for various dictionary data structures
        """
        # REDACTED

    def update_factor_models(self):
        """
        Updates each factor model under the alpha model with fresh data, and call factor models to do their own features recording.

        NESTED DATA STRUCTURE:
            self.factors_and_dict_of_factor_models (Dict {factor (str): dict_of_factor_models (Dict)}): Double layered Dictionary

                factor (str): factor name, e.g. EquitiesSerialCointegrationLgSpreadPair
                dict_of_factor_models (Dict {factor_model_universe (tuple): factor_model (Object)})

                    factor_model_universe (tuple): respective universe of the factor model.
                        E.g. for mean reversion pairs, this will be (equity_1 (str), equity_2 (str))
                    factor_model (Object): Custom class object containing all the logic of the factor model.
        """
        # REDACTED

    def update_specific_factor_models(self, factor, factor_model, equity):
        """
        Helper function to update each factor

        Args:
            factor (str): factor name, e.g. EquitiesSerialCointegrationLgSpreadPair
            factor_model (Object): Custom class object containing all the logic of the factor model.
            equity (str): symbol for the security, acts as a key for various dictionary data structures
        """
        # REDACTED

    def get_factor_model_signals(self):
        """
        Calls each factor model to generate signals. These signals are stored in a dictionary,
        grouped by what type of factor it is.

        NESTED DATA STRUCTURE:
            self.factors_and_dict_of_signals (Dict{factor (str): dict_of_signals (Dict)}: Double layered dictionary

                factor (str): factor name, e.g. EquitiesSerialCointegrationLgSpreadPair
                dict_of_signals (Dict{equity (str): signal (Signal)})

                    equity (str): symbol for the security, acts as a key for various dictionary data structures
                    signal (Signal): custom Signal object with weight, expected values etc. (check helper_model/general/signals)

            self.factors_and_dict_of_factor_models (Dict {factor (str): dict_of_factor_models (Dict)}): Double layered Dictionary

                factor (str): factor name, e.g. EquitiesSerialCointegrationLgSpreadPair
                dict_of_factor_models (Dict {factor_model_universe (tuple): factor_model (Object)})

                    factor_model_universe (tuple): respective universe of the factor model.
                        E.g. for mean reversion pairs, this will be (equity_1 (str), equity_2 (str))
                    factor_model (Object): Custom class object containing all the logic of the factor model.
        """
        # REDACTED

    def update_latest_signal(self, factor, factor_model, factor_model_universe):
        """
        Calls the specific factor model to generate signals for the alpha model.

        Args:
            factor (str): factor name, e.g. EquitiesSerialCointegrationLgSpreadPair
            factor_model (Object): Custom class object containing all the logic of the factor model.
            factor_model_universe (tuple): respective universe of the factor model.
        """
        # REDACTED

    def retain_previous_signal_if_not_exiting_after_generating_signals(self, factor, factor_model,
                                                                       factor_model_universe):
        """
        Calls the specific factor model to generate signals for the alpha model. In this scenario,
        only exit signals will be accepted because factor model universe is muted.

        Args:
            factor (str): factor name, e.g. EquitiesSerialCointegrationLgSpreadPair
            factor_model (Object): Custom class object containing all the logic of the factor model.
            factor_model_universe (tuple): respective universe of the factor model.
        """
        # REDACTED

    def retain_previous_signal_without_generating_signals(self, factor, factor_model_universe):
        """
        In this scenario, exchanges are closed, so alpha model will retain its latest signal.

        Args:
            factor (str): factor name, e.g. EquitiesSerialCointegrationLgSpreadPair
            factor_model_universe (tuple): respective universe of the factor model.
        """
        # REDACTED

    def emit_alpha_signals(self):
        """
        Emits signals to the portfolio model when there are changes in positions,
        and updates self.previous_factors_and_dict_of_signals to reflect latest positions.
        """
        # REDACTED

    def create_factor_models(self):
        """ Creates a factor model for each factor_model_universe the model is going to trade.
        """
        # REDACTED

    def fit_factor_models_with_downstream_models(self):
        """Allows the downstream model manager to pass downstream models for each factor object
        """
        # REDACTED

    def refit_updated_downstream_model(self):
        """ Called once a week after resetting the universe, refit each downstream model for each factor.
        """
        # REDACTED

    def pass_updated_downstream_model_to_factors(self):
        """ For each factor, get the downstream model manager to pass the updated downstream models to the factor objects
        """
        # REDACTED

    def get_securities_currently_holding_positions(self, oustanding_orders):
        """Method called by main strategy to go through the factor dictionaries and to see which securities are holding positions
        """
        # REDACTED

    def check_which_factor_object_is_holding_positions(self, outstanding_orders):
        """Helper method to go through the factor dictionaries and to see which factor objects are holding positions
        """
        # REDACTED

    def assign_universe_to_data_structures(self, time_now):
        """ Called at the start of the strategy, initiates the alpha model with the data structures it requires.
        """
        # REDACTED

    def update_data_structures_with_new_universe(self, time_now):
        """ Called every week when we reset universe. Updates data structures with the new universe.
        """
        # REDACTED

    @exception_handler.except_download_historical_data_and_preprocess
    def download_historical_data_and_preprocess(self, equities, time_now, resample_by):
        """
        Helper function that downloads historical data, and preprocesses data for factor models. This allows
        us to have a warm start, being able to trade immediately after strategy starts instead of having to collect
        and preprocess data one bar at a time.

        Currently, the data that needs to be preprocessed is:
            1. close price from resampled bars    (Requires trade data)
            2. volume dictionaries, updated on trade and requires tick mid-price    (Requires tick and trade data)

        Args:
            equities (set): collection of equities that we are downloading and preprocessing.
            time_now (datetime.datetime): current time, used as reference for downloading historical data
            resample_by (str): which method used to resample trades, TIME/VOLUME/DOLLAR. Default value: VOLUME
        """
        # REDACTED

    def download_historical_data_and_preprocess_close_price(self, equities, resample_by, time_now):
        """
        Helper function that downloads historical trade data, resamples into bars and preprocesses
        for factor models.

        Args:
            equities (set): collection of equities that we are downloading and preprocessing.
            resample_by (str): which method used to resample trades, TIME/VOLUME/DOLLAR. Default value: VOLUME
            time_now (datetime.datetime): current time.
        """
        # REDACTED

    def sample_volume_bars(self, trade_df, sampling_interval):
        """
        Samples volume bars from a trade dataframe

        Args:
            trade_df (pd.DataFrame): The trade dataframe to sample from
            sampling_interval (int): The amount of volume that constitutes a bar
        Returns:
            (pd.DataFrame): The bar dataframe with OHLC and datetime columns
        """
        # REDACTED

    def download_historical_data_and_preprocess_volume_dictionaries(self, equities, time_now):
        """
        Helper function that downloads historical tick and trade data, and preprocesses
        volume related data. To calculate volume and datetime, we need trade data, and to calculate
        volume sign, we need both tick mid_price and trade last_price.

        This is achieved in a 3 step process:
            1: Downloading trade data 1 day at a time until we have the correct number of data points.
            Keep track of the number of days of data that we downloaded. We need to download the same
            number of days of tick data
            2: Download tick data, number of days determined by (1).
            3: Merge trade and tick data, calculate:
                (a) volume ---------- df.last_size
                (b) date_time ---------- df.index
                (c) vol_sign ----------- compare df.last_price & df.mid_price

        Args:
            equities (set): collection of equities that we are downloading and preprocessing.
            time_now (datetime.datetime): current time.
        """
        # REDACTED

    def get_factors_to_save_their_features(self):
        """Helper function called at the end of the strategy to get factor objects to save their dataframes
        """
        # REDACTED

    def check_if_tomorrow_is_a_trading_day(self):
        """
        Helper function called at the end of each day, check if trading activity occurs next day.
        If tomorrow is a half or no trading day, mute our universe to avoid entering
        positions in a situation where exiting is not possible.
        """
        # REDACTED

    def receive_data_from_data_model(self, data):
        """ Helper function to receive data from data model.
        """
        # REDACTED

    def receive_subscribed_universe(self, data):
        """ Helper function to receive subscribed equities and currencies from universe model
        """
        # REDACTED
