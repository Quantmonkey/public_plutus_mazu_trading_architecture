import pandas as pd

from helper_models.general.exception_handler import ExceptionHandler
from helper_models.general.sampler import Sampler
from helper_models.general.trading_hours_manager import TradingHoursManager
exception_handler = ExceptionHandler()


class SGXEquitiesDataModel:

    def __init__(self, strategy_config):
        # REDACTED

    def collect_equities_trade(self, trade):
        """Method that checks if a trade is clean and then assigns a unique timestamp to it
        """
        # REDACTED

    def collect_equities_bar(self, bar):
        """Collects the bar data from the strategy's onBar method
        """
        # REDACTED

    def collect_currencies_bar(self, bar):
        """ Collects currency bar data from onBar method.
        """
        # REDACTED

    def collect_equities_tick(self, tick):
        """Collects the tick data from the strategy's onTick method
        """
        # REDACTED

    def propagate_data(self, models):
        """Sends fresh data to other models at tick resolution
        """
        # REDACTED

    def assign_universe_to_data_structures(self):
        """Initiates the data model with the universes it requires
        """
        # REDACTED

    def update_data_structures_with_new_universe(self):
        """Called weekly after reset, updates data structures with the latest universe
        """
        # REDACTED

    def assert_clean_data(self, data):
        """Assert data is clean by ensuring it is within trading hours and data is reasonable
        """
        # REDACTED

    def assert_data_is_valid(self, data, equity):
        """Asset data contains valid information to do further checks downstream
        """
        # REDACTED

    def assert_not_outlier(self, data, equity):
        """Assert data is reasonable
        """
        # REDACTED

    def receive_subscribed_universe(self, data):
        """Receive subscribed equity from universe model
        """
        # REDACTED