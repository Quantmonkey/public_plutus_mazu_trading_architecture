import numpy as np
import pandas as pd
import yfinance as yf

from datetime import datetime
from sklearn.linear_model import ElasticNet
from helper_models.general.exception_handler import ExceptionHandler
exception_handler = ExceptionHandler()


class FactorManager:
    """
    Factor Manager retrieves returns across various risk factors, isolates the effects
    of these risk factors and allows us to regress any portfolio of securities with risk factors
    via Arbitrage Portfolio theory, and obtain its risk coefficients.
    """

    def __init__(self, strategy_config):
        # REDACTED

    def prepare_factor_manager(self):
        """ Prepares the collection of ETFs representing various factors and collates them into self.combined_etfs.
        """
        # REDACTED

    @exception_handler.except_update_risk_premiums
    def update_risk_premiums(self, current_time=datetime.now()):
        """
        Downloads latest daily close price for each factor, calculates and stores their returns internally.

        Args:
            current_time (datetime.datetime): Used to decide the time period for downloading data
        """
        # REDACTED

    def isolate_risk_factor_premiums(self):
        """
        Isolates the effect of a specific risk factor premium by # DOCUMENTATION REDACTED
        """
        # REDACTED

    def get_risk_factor_coefficients_for_returns_series(self, returns_series):
        """
        Obtains the risk factor coefficients of a returns series of a portfolio, by # DOCUMENTATION REDACTED

        Args:
            returns_series (pd.Series): daily returns of the series.

        Returns:
            risk_factor_coefficients (Dict {factor_name (str): risk_coefficient (float)}): Beta of the portfolio and the specific risk factor.
        """
        # REDACTED

