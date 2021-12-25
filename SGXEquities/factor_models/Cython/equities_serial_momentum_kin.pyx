import warnings
import pandas as pd
import numpy as np
import time as timing
import math

from helper_models.general.exception_handler import ExceptionHandler
from helper_models.general.signals import Signal
from helper_models.general.sampler import Sampler
from helper_models.general.trading_hours_manager import TradingHoursManager
from helper_models.factor.feature_generator import FeatureGenerator
from helper_models.factor.feature_manager import FeatureManager

from typing import List, Dict, Union
from arch.unitroot import ADF, KPSS
from sklearn.linear_model import LinearRegression

class EquitiesCrossSectionalClusterReturns:
    def __init__(self, strategy_config, cluster_of_equities):
        # REDACTED

    def generate_signals(self, universe_muted=False):
        """Model's main method: To do the calculations so that the correct signals are generated
        """
        # REDACTED

    def check_if_trades_has_crossed_triple_barrier(self):
        """Called each loop to check if we should be trading, used to enforce stops and no weekend holdings
        """
        # REDACTED

    def check_if_all_data_structures_are_ready(self):
        """Ensures all our data structures are ready before we begin our tests for trading conditions
        """
        # REDACTED

    def check_trade_within_timestop_barrier(self):
        """Closes and marks not stationary a relative difference after it has been open beyond a time threshold
        """
        # REDACTED

    def check_trade_within_stop_loss_barrier(self):
        """Checks if we have crossed the stop loss barrier, if we haven't mark as not stationary and cooldown
        """
        # REDACTED

    def check_trade_within_take_profit_barrier(self):
        """Checks if we have crossed the take_profit_barrier, if we have, we should exit out of our positions
        """
        # REDACTED

    def emit_exit_signals(self, equity):
        """Nulls every equity signal we have
        """
        # REDACTED

    def record_features(self, equity, feature):
        """Helper function to record the correct features
        """
        # REDACTED

    def generate_relative_difference_series(self):
        """Helper function to generate the relative difference series that decisions will be made from
        """
        # REDACTED

    def test_if_relative_differences_are_stationary(self):
        """Helper function to generate ADF p-values for each of the relative returns differences
        """
        # REDACTED

    def equity_should_be_active(self, equity, need_to_be_stationary=True):
        """Helper function to check if an equity should be active
        For an equity to be active, it needs to be stationary and are currently not under cooldown from either timestop or stoploss
        """
        # REDACTED

    def get_rolling_window_from_halflife(self):
        """Helper function to get halflife of any of the relative returns that are stationary
        """
        # REDACTED

    def calculate_halflife_from_array(self, array):
        """Helper function to calculate halflife from a given array
        """
        # REDACTED

    def get_latest_zscore(self):
        """Helper function to generate zscore for all the returns differences
        """
        # REDACTED

    def get_cumulative_size_from_zscore(self):
        """Gets the number of relative differences we're planning to hold based on zscore
        """
        # REDACTED

    def get_correct_cumulative_size(self, equity, size):
        """Ensures we don't decrease the cumulative size as the relative difference reverts
        """
        # REDACTED

    def get_signal_weights_from_cumulative_size(self):
        """Produces cumulative positions from cumulative size as signals
        """
        # REDACTED

    def check_if_any_signal_modifiers(self, universe_muted):
        """Logic to modify signals other than from the primary indicator, zscore
        """
        # REDACTED

    def check_if_modify_positions_if_not_stationary_or_on_cooldown(self):
        """Helper function to check if stationary or on cooldown
        """
        # REDACTED

    def check_if_modify_positions_if_universe_is_muted(self, universe_muted):
        """Helper function that checks if universe is muted
        """
        # REDACTED

    def check_if_modify_signals_if_time_thresholds_are_not_met(self):
        """Helper signals to check if we should reject these signals if time thresholds are not met
        """
        # REDACTED

    def check_if_modify_signals_if_ev_is_negative(self):
        """Helper function to check if we should reject these signals if they have negative EV
        """
        # REDACTED

    def generate_primary_features(self, tag, equity):
        """Helper method to return primary signal features based on whether its a entry or modifier
        """
        # REDACTED

    def generate_additional_features(self, equity):
        """Helper method to generate and return additional signal features
        """
        # REDACTED

    @exception_handler.except_generate_moment_features_for_multiple_windows
    def generate_moment_features_for_multiple_windows(self, feature_window_multipliers, rolling_window,
                                                      arrays_of_time_series):
        """Helper function to call feature generator to generate features
        """
        # REDACTED

    def generate_autoregressive_features_for_multiple_windows(self, arrays_of_time_series):
        """Helper function to call feature generator to generate features
        """
        # REDACTED

    def get_ev_from_downstream_model(self, equity, tag: str,
                                     primary_features: Dict[str, Dict[str, Union[int, float]]],
                                     additional_features: Dict[str, Dict[str, Union[int, float, str]]]) -> List[float]:
        """Called whenever we want to enter a new position or make a modification to an existing one
        Uses the downstream models to check if EV is positive given some features
        Returns True if EV is positive and False if not
        """
        # REDACTED

    def prevent_entry_from_negative_ev_and_cooldown(self, equity):
        """Helper method that prevents entry of position when EV is predicted to be negative
        It also introduces a cooldown period before the factor can attempt to trade again
        To simulate having entered the trade
        """
        # REDACTED

    def generate_position_time_threshold_booleans(self):
        """Helper method to generate time threshold booleans for our signals
        We use these booleans to perform additional modifications or to check if we need to record features
        """
        # REDACTED

    def generate_position_modification_booleans(self):
        """Helper method to generate position modification booleans for our signals
        We use these booleans to perform additional modifications or to check if we need to record features
        """
        # REDACTED

    def generate_timestop_barrier(self, equity):
        """Helper function that returns a timestop threshold
        """
        # REDACTED

    def check_if_need_to_record_features(self):
        """DOCUMENTATION REDACTED
        """
        # REDACTED

    def propagate_signals(self):
        """Returns the model's signals, only called after generate signals
        """
        # REDACTED

    def populate_signals(self):
        """Creates signal objects and populates them with data to be propagated to the alpha model
        """
        # REDACTED

    def get_feature_manager_to_save_dataframes(self):
        """Helper function called at the end of the strategy to get feature manager to save dataframes
        """
        # REDACTED

    def get_preprocessed_data(self, equity, preprocessed_data):
        """Helper function called by alpha model to pass preprocessed data to factor model
        """
        # REDACTED

    def receive_downstream_model(self, downstream_model):
        """Helper functions to get downstream models from downstream model manager
        """
        # REDACTED