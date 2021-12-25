import pandas as pd
import numpy as np

from functools import partial
from itertools import combinations
from scipy.optimize import minimize
from helper_models.portfolio.factor_manager import FactorManager
from helper_models.data.historical_downloader_new import HistoricalDownloader
from helper_models.general.exception_handler import ExceptionHandler
exception_handler = ExceptionHandler()


class PortfolioOptimizer:
    """
    Helper class that optimizes our portfolio positions to minimize market risk exposure.

    The goal of this class is to allow us to achieve consistent returns in any market condition (high quality of alpha),
    even if some net returns are compromised.
    """

    def __init__(self, strategy_config):
        # REDACTED

    def prepare_optimizer(self, current_time, securities_and_id_for_trading):
        """
        Prepares the portfolio optimizer by:
            1. call self.factor_manager to download and update daily risk premiums for each risk factor.
            2. download latest daily close prices for each security in our trading universe.
            3. calculate risk coefficients for each security.

        Args:
            current_time (datetime.datetime): time now, use for historical download period
            securities_and_id_for_trading (Dict {security (str): id (int)}) securities we are trading
        """
        # REDACTED

    def download_securities_close_prices(self, current_time, securities_and_id_for_trading):
        """
        Helper function to download daily close price data for our trading universe. Stores
        historical data in an interval variable self.securities_close_df

        Args:
            current_time (datetime.datetime): time now, used to determine historical period of bar data
            securities_and_id_for_trading (Dict {security(str): id(int)}): securities in our trading universe
        """
        # REDACTED

    @exception_handler.except_portfolio_optimizer_optimize
    def optimize(self, signal_weights, expected_values):
        """
        Calls scipy.optimize.minimize to minimize our portfolio exposure to # DOCUMENTATION REDACTED
        The objective function to minimize is: # DOCUMENTATION REDACTED

        Args:
            signal_weights (Dict {security_symbol (str): weight(int)}): Dictionary of weights for each security
            expected_values (Dict {security_symbol (str): expected_value(float)}): Dictionary of expected values for each security.

        Returns:
            optimized_signal_weights (Dict {security_symbol (str): weight(int)}): Dictionary of weights for each security after optimization.
        """
        # REDACTED

    def preprocess_data(self, signal_weights, expected_values):
        """
        Helper function to preprocess input data, calculating metrics such as total positions,
        expected value per unit security, number of securities etc.

        Args:
            signal_weights (Dict {security_symbol (str): weight(int)}): Dictionary of weights for each security
            expected_values (Dict {security_symbol (str): expected_value(float)}): Dictionary of expected values for each security.
        """
        # REDACTED

    def get_beta_coefficients_for_securities(self):
        """
        Helper function to calculate, for each security, the risk coefficients of a portfolio consisting of 1 unit
        of the security summed over all risk factors.
        """
        # REDACTED

    def cost_function(self, guess):
        """
        Calculates the total market risk exposure of the portfolio. The calculation is as follows:
            # DOCUMENTATION REDACTED

        Args:
            guess (List [weight(float)]): A list of weights w_i such that sum_{i} w_i == 1

        Returns:
            total_cost (float):
               # DOCUMENTATION REDACTED
        """
        # REDACTED
