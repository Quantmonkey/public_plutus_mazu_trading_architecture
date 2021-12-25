import pandas as pd
import os


class FeatureManager:
    def __init__(self, strategy_config, name):
        # REDACTED

    def create_entry_signal(self, datetime_index):
        """Initialise a new entry row
        """
        # REDACTED

    def record_entry_primary_features(self, dict_of_securities_and_their_market_value_and_quantity):
        """Records initial market value of primary securities and initial quantity
        """
        # REDACTED

    def create_modifier_signal(self, datetime_index):
        """Initialises a new modifier row
        """
        # REDACTED

    def record_modifier_primary_features(self, dict_of_securities_and_their_market_value_and_quantity):
        """Records market value of primary securities and initial quantity at time of modifier
        """
        # REDACTED

    def save_and_reset_modifier_signal(self):
        """Used when we want to create a new modifier row, saves it to the current signal dataframe
        """
        # REDACTED

    def record_other_features(self, row_type, dict_of_securities_and_their_features):
        """Receives a dictionary of features and feature values
        """
        # REDACTED

    def record_exit_primary_features(self, datetime_index, triple_barrier_label,
                                     dict_of_securities_and_their_market_value,
                                     dict_of_securities_and_their_transaction_costs):
        """Used to mark the end of a signal"""
        # REDACTED

    def save_and_reset_current_signal(self):
        """Called to save our current signals df and to clear it
        """
        # REDACTED

    def get_signal_rolling_pnl_sum(self, time_start):
        """Called to calculate the pnl sum for a window of signals
        """
        # REDACTED

    def save_dataframes(self):
        """Helper function to save remainder dataframes that is not saved when strategy ends"""
        # REDACTED
