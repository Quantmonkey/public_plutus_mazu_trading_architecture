import pandas as pd
import numpy as np

from datetime import datetime


class Sampler:
    def __init__(self, strategy_config):
        # REDACTED

    def get_volume_based_intervals_from_historical_data(self, sampling_usage, security,
                                                        sampling_interval, daily_bar_df):
        """ Function called once every week to download past historical data to get volume related information
        """
        # REDACTED

    def ready_to_sample_loop_by_time(self, sampling_usage, current_time, sampling_interval):
        """General function called by any model whenever general sampling is required
        """
        # REDACTED

    def ready_to_sample_data(self, sampling_usage, security, security_data_structure, sampling_interval, sampling_type="TIME"):
        """General function called by any model whenever sampling is required for specific data
        """
        # REDACTED

    def check_if_ready_for_dollar_volume_sampling(self, sampling_usage, security, security_data_structure):
        """Helper function to return if a security is ready for volume sampling
        """
        # REDACTED

    def check_if_ready_for_volume_sampling(self, sampling_usage, security, security_data_structure):
        """Helper function to return if a security is ready for volume sampling
        """
        # REDACTED

    def check_if_ready_for_time_sampling(self, sampling_usage, security, security_data_structure, sampling_interval):
        """Helper function to return if a security is ready for time sampling
        """
        # REDACTED

    def get_volume_sampling_interval(self, equity) -> int:
        """
        Function to access volume sampling interval
        """
        # REDACTED
