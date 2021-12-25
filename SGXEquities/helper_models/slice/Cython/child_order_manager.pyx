import warnings
import numpy as np
import pandas as pd

from helper_models.general.exception_handler import ExceptionHandler
warnings.filterwarnings('error', category=RuntimeWarning)
exception_handler = ExceptionHandler()


class ChildOrderManager:
    def __init__(self, strategy_config):
        # REDACTED

    def get_all_benchmarks(self, equity):
        """
        Calculates benchmarks for spread size, volume, volatility, tick frequency, and waiting time for each equity,
        based on its historical data.
        """
        # REDACTED

    @exception_handler.except_get_wide_spread_threshold
    def get_wide_spread_threshold(self):
        """
        Calculates the threshold for an equity's spread to be considered wide, based on a quantiling of historical mean
        spreads across all equities.
        """
        # REDACTED

    def get_mean_volumes(self, equity):
        """
        Calculates mean bid and ask volume for this equity. Volumes need to be grouped by each trading hour
        since volume traded is not uniform throughout the day.
        """
        # REDACTED

    def get_mean_ticks_in_each_period(self, equity):
        """
        Calculate the mean number of ticks coming in for this equity in each period. This period needs to be
        grouped by trading hour since ticks coming in is not uniform throughout the day
        """
        # REDACTED

    def get_mean_price_spread(self, equity):
        """Calculate the average spread of ticks for this equity
        """
        # REDACTED

    def get_maximum_waiting_ticks(self, equity):
        """
        Calculates the maximum waiting ticks for each equity. The calculation is based on comparing equity's
        volatility with its past 30 days mean volatility, and multiplying the fraction with mean number of ticks
        in 30 seconds. Calculations should be grouped by trading hour.
        """
        # REDACTED

    def assert_wide_spread(self, tick, equity):
        """ Judge whether the equity's spread is wide or narrow. Return True if wide, False if narrow.
        """
        # REDACTED

    def get_micro_price(self, hour, equity, tick):
        """
        Calculate micro price for the equity. Sets suspiciously low volumes on either bid or ask
        sides to the mean volume for our calculations, in order to combat market manipulators.
        """
        # REDACTED

    @exception_handler.except_record_ticks_and_check_if_need_to_send_order
    def record_ticks_and_check_if_need_to_send_order(self, time_now):
        """ Called each tick to update waiting ticks for each equity.
        """
        # REDACTED

    def create_order(self, latest_tick, equity, time_now):
        """ Creates and order to pass to execution model. This function is called whenever maximum waiting ticks is up.
        """
        # REDACTED

    def create_wide_spread_order(self, tick, equity, time_now):
        """ # DOCUMENTATION REDACTED
        """
        # REDACTED

    def create_narrow_spread_order(self, tick, equity, time_now):
        """ # DOCUMENTATION REDACTED
        """
        # REDACTED

    def initialise_data_structures(self):
        """ Initiates all data structures needed for the Child Order Manager
        """
        # REDACTED

    def receive_data_structures_from_execution_model(self, data_structures):
        """ DOCUMENTATION REDACTED
        """
        # REDACTED

    def collect_and_process_tick_data(self, counts_per_completion_period_dfs,
                                      volumes_and_counts_dfs, mid_prices_and_price_spreads_dfs, updating=False):
        """Vectorized collecting and updating all statistics needed for child order manager to function per day.
        Then iterate to convert the dataframes used in vectorized operations to load into the dynamic data structures (lists and dicts)
        """
        # REDACTED