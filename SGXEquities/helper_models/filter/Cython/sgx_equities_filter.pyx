import numpy as np
import pandas as pd


class SGXEquitiesFilter:

    def __init__(self, strategy_config):
        # REDACTED

    def filter_tradeable_equities(self, time_now, set_of_securities_holding_positions):
        """ Filter the collection of equities to find those which are shortable.
        """
        # REDACTED

    def assert_shortable(self, equity):
        """ Asserts that the equity is shortable as it has high volume and low price spreads.
        """
        # REDACTED

    def assert_high_dollar_volume(self, equity):
        """ Asserts that the equity has sufficiently high volume.
        """
        # REDACTED

    def assert_low_price_spread(self, equity):
        """ Asserts that the price spread of equity is small.
        """
        # REDACTED

    def create_volume_and_price_spreads(self, time_now):
        """
        Creates a series of price spreads and volumes for each equity. Relative spreads are used to determine
        whether the spread of a particular equity is wide or narrow
        """
        # REDACTED

    def create_quantiles(self):
        """ Calculate quantile numbers based on the volume and price spreads series.
        """
        # REDACTED

    def receive_data(self, list_of_data):
        # REDACTED