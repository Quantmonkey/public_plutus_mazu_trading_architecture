import math
import numpy as np
import pandas as pd


class SGXEquitiesVwap:
    def __init__(self, strategy_config):
        # REDACTED

    def collect_volume_data(self, equities_and_short_interval_dfs, equities_and_long_interval_dfs, updating=False):
        """Collect the volumes from the short and long interval dataframes containing the last size and clean it
        """
        # REDACTED

    def process_volume_data(self):
        """
        Processes the volume data collected to calculate mean weights of 30 second intervals and 5 min intervals
        """
        # REDACTED

    def generate_weight(self):
        """
        Calculate weight from historical data for the equity, used for slicing order vector.
        """
        # REDACTED

    def slice_order(self, order_vector, time_now):
        """ Generate child orders based on weights
        """
        # REDACTED

    def initialise_data_structures(self, list_of_equities):
        """Assign universe to data structures
        """
        # REDACTED
