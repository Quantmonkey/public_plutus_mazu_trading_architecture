import numpy as np
import pandas as pd
import scipy.cluster.hierarchy as sch
import scipy.stats

from itertools import combinations
from scipy.spatial.distance import squareform
from statsmodels.tsa.stattools import adfuller
from statsmodels.tsa.vector_ar.vecm import coint_johansen
from collections import defaultdict
from sklearn.metrics import davies_bouldin_score


class SGXEquitiesCluster:
    """
    Helper class that partitions our trading universe into multiple clusters, allowing us to trade
    securities in groups where they are most similar to each other.

    Scipy's Hierarchical Clustering algorithm is used, followed by flattening the linkage matrix
    produced by the hierarchical clustering to obtain the final clusters that we will use.
    """

    def __init__(self, strategy_config):
        # REDACTED

    def produce_and_test_cluster(self):
        """
        Main method for this class. The clustering process works in 2 steps:
            Step 1: Run a grid search over number of clusters, testing the performance
            of the clustering for a fixed cluster number.
            Step 2: Perform clustering using the optimal number of clusters,
            obtained from stage 1.

        The scoring of performance depends on # DOCUMENTATION REDACTED

        Returns:
            clustered_securities (default_dict {cluster_tag (int): cluster (list)})
                cluster (List [security_symbol(str)]): securities in this cluster tag
        """
    # REDACTED

    def process_data_and_calculate_distance_metrics(self):
        """
        Processes bar data for the trading universe, by calculating correlation between security returns
        as a distance metric, as well as splitting data into a train set and a test set.

        Returns:
            securities_distance_df (pd.DataFrame): used as a metric to measure distance between securities
        """
        # REDACTED

    def get_hierarchical_cluster(self, cluster_number, securities_distance_df):
        """
        Clusters the universe of securities we are trading via a 2 step process:
            Step 1:
                Scipy's hierarchical linkage clustering, documented at:
                "https://docs.scipy.org/doc/scipy/reference/generated/scipy.cluster.hierarchy.linkage.html"
                Method used: Ward variance minimization algorithm
            Step 2:
                Forming flat clusters from the linkage matrix obtained from 1, documented at:
                https://docs.scipy.org/doc/scipy/reference/generated/scipy.cluster.hierarchy.fcluster.html
                Criterion: maxclust (bounds # of clusters to be <= cluster_number)

        Args:
            cluster_number (int): Maximum number of clusters to form
            securities_distance_df (pd.DataFrame): used as a metric to measure distance between securities

        Returns:
            clustered_securities (default_dict {cluster_tag (int): cluster (list)})
                cluster: List [security_symbol(str)]: securities in this cluster tag
        """
        # REDACTED

    def receive_data(self, list_of_data):
        """ Helper function to receive data from universe model.
        """
        # REDACTED
