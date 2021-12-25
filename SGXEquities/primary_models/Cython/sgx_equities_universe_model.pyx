import numpy as np
import warnings

from helper_models.general.exception_handler import ExceptionHandler
from helper_models.cluster.sgx_equities_cluster import SGXEquitiesCluster
from helper_models.filter.sgx_equities_filter import SGXEquitiesFilter
from helper_models.data.historical_downloader_new import HistoricalDownloader
from itertools import combinations

class SGXEquitiesUniverseModel:

    def __init__(self, strategy_config):
        # REDACTED

    @exception_handler.except_reset_universe
    def reset_universe(self, time_now, set_of_securities_holding_positions):
        """DOCUMENTATION REDACTED
        """
        # REDACTED

    def download_historical_data(self, time_now):
        """ Downloads past 6 months daily bar data, and past 1 week tick data for filter and cluster models.
        """
        # REDACTED

    def create_equities_and_tick_size(self):
        """ Called once a week. Collect tick sizes for both alpha and execution model.
        """
        # REDACTED

    def cluster_equities(self):
        """ Called once a week. The cluster model performs clustering based on closing prices of data.
        """
        # REDACTED

    def create_equities_pairs_from_clusters(self):
        """ Creates nC2 pairs from universe as part of pair trading model
        """
        # REDACTED

    def unsubscribe_from_old_universe(self):
        """DOCUMENTATION REDACTED
        """
        # REDACTED

    def subscribe_to_new_universe(self):
        """DOCUMENTATION REDACTED
        """
        # REDACTED

    def clear_historical_data(self):
        """DOCUMENTATION REDACTED
        """
        # REDACTED

    def retrieve_securities_and_id(self):
        """Retrieves full dictionary of equities and ids from Algotrader platform.
        """
        # REDACTED

    def propagate_universes(self, models):
        """Propagates the subscribed universe to every universe
        """
        # REDACTED
