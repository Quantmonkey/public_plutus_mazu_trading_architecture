import requests
import pickle
import os
import pandas as pd

from datetime import datetime
from helper_models.general.exception_handler import ExceptionHandler
exception_handler = ExceptionHandler()


class SGXEquitiesScraper:
    """Helper class that scrapes data off websites, and processes data for our strategies.
    """

    def __init__(self, strategy_config):
        # REDACTED

    def impose_cdp_regulations(self, trading_universe):
        """
        Downloads data from CDP lending pool ("https://www1.cdp.sgx.com/sgx-cdp-web/lendingpool/show"),
        and calculates the number of lots that we can short for each security in our trading universe.

        Securities that are not in the lending pool cannot be short overnight, or a heavy fine will be
        imposed. Even if the security is in the lending pool, we want to make sure that we are not taking
        too big a short position in case there are insufficient lots in the lending pool for us to short.

        Args:
            trading_universe (Dict {security (str): security_id (int)}): securities in our universe.

        Returns:
            cdp_sieved_equities (Dict {security (str): shortable_lots (int)}):
        """
        # REDACTED

    @exception_handler.except_download_cdp_data
    def download_cdp_data(self):
        """
        Helper function to scrape cdp lending pool website for data. When downloading fails,
        we will switch to using our backup cdp pool.

        Returns:
            cdp_lending_pool_df (pd.DataFrame): DataFrame of securities and their lending pool data.
        """
        # REDACTED