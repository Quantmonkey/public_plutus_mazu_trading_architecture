import numpy as np
from helper_models.factor.talib_features import Talib
from numba import jit, prange


class FeatureGenerator:
    def __init__(self):
        # REDACTED

    def __generate_autoregressive_feature_names(self, autoregressive_terms):
        """Helper method to generate autoregressive feature names
        """
       # REDACTED

    def generate_talib_features_for_multiple_windows(self, feature_window_multipliers, rolling_window, open, high, low, close, volume=None):
        """This function generates all the talib features
        """
        # REDACTED

    def generate_moment_features_for_multiple_windows(self, feature_window_multipliers, rolling_window,
                                                      serieses):
        """This function is exposed to whomever is calling and uses internally defined jitted functions for optimal computations
        Returns a 2-dim array of [(serieses, feature_rolling_window), features] and the feature names for easier mapping
        This is also so that changes can be made here to the features without affecting the external dependers of this class
        """
        # REDACTED

    def generate_autoregressive_features_for_multiple_windows(self, serieses):
        """This function is exposed to whomever is calling and uses internally defined jitted functions for optimal computations
        Returns a 2-dim array of [serieses, features] and the feature names for easier mapping
        This is also so that changes can be made here to the features without affecting the external dependers of this class
        """
        # REDACTED

@jit(nopython=True, parallel=True, fastmath=True)
def jitted_generate_moment_features_for_multiple_windows(feature_window_multipliers, rolling_window, serieses):
    """Parallelised generate features that uses uses memory indexing to ensure that we don't run into problems of
    deadlocks / race conditions.
    """
    # REDACTED

@jit(nopython=True)
def jitted_generate_autoregressive_features(serieses, autoregressive_terms):
    """Generate autoregressive features serially
    """
    # REDACTED

@jit(nopython=True)
def jitted_generate_moment_features_for_specific_series_and_rolling_window(array, feature_rolling_window):
    """Method for safe and serial calculation of moments features
    """
    # REDACTED

@jit(nopython=True)
def jitted_generate_autoregressive_features_for_specific_series(array, autoregressive_terms):
    """Method for safe and serial calculation of autoregressive features
    """
    # REDACTED

@jit(nopython=True)
def jitted_calculate_array_moments(array, feature_rolling_window):
    """Method for safe and serial calculation of moments
    """
    # REDACTED

@jit(nopython=True)
def jitted_calculate_array_autoregressive_terms(array, autoregressive_terms):
    """Helper method to create autoregressive terms for any arrays
    """
    # REDACTED

@jit(nopython=True)
def jitted_array_sum_for_moments(array, feature_rolling_window):
    """Returns a single value of the rolling sum of an array
    """
    # REDACTED

@jit(nopython=True)
def jitted_filter_invalids(array):
    """Used to remove all zeros from an array, as it may cause division by zero errors
    """
    # REDACTED

@jit(nopython=True)
def jitted_rolling_window(array, window):
    """Method for vectorised operation for calculating rolling windows using 1D numpy arrays
    """
    # REDACTED

@jit(nopython=True)
def jitted_array_percentage_change_for_moments(array, feature_rolling_window):
    """Returns a single value of the percentage change of the rolling window of an array
    Used to determine the first degree momentum
    """
    # REDACTED

@jit(nopython=True)
def jitted_vectorised_mean_for_moments(array, feature_rolling_window):
    """Returns an array of means of the rolling windows generated
    """
    # REDACTED

@jit(nopython=True)
def jitted_vectorised_perc_diff_for_autoregressives(array):
    """Returns an array of differences between 2 consecutive values of an array
    """
    # REDACTED

@jit(nopython=True)
def jitted_vectorised_std_for_moments(array, feature_rolling_window):
    """Returns an array of std of the rolling windows generated
    """
    # REDACTED

@jit(nopython=True)
def jitted_vectorised_std_for_autoregressives(array):
    """Returns an array of std for a rolling, consecutive array
    """
    # REDACTED

@jit(nopython=True)
def jitted_vectorised_skew_for_moments(array, feature_rolling_window):
    """Returns an array of skew of the rolling windows generated
    """
    # REDACTED

@jit(nopython=True)
def jitted_vectorised_skew_for_autoregressives(array):
    """Returns an array of skew for a rolling, consecutive array
    """
    # REDACTED

@jit(nopython=True)
def jitted_single_array_skew(array):
    """Calculates the skew of a single array provided
    """
    # REDACTED

@jit(nopython=True)
def jitted_vectorised_kurtosis_for_moments(array, feature_rolling_window):
    """Returns an array of kurtosis of the rolling windows generated
    """
    # REDACTED

@jit(nopython=True)
def jitted_vectorised_kurtosis_for_autoregressives(array):
    """Returns an array of kurtosis for a rolling, consecutive array
    """
    # REDACTED

@jit(nopython=True)
def jitted_single_array_kurtosis(array):
    """Calculates the kurtosis of a single array provided
    """
    # REDACTED

@jit(nopython=True)
def jitted_vectorised_zscore(array, feature_rolling_window):
    """Returns an array of zscore of the rolling windows generated
    """
    # REDACTED

@jit(nopython=True)
def jitted_vectorised_autocorrelation(array, feature_rolling_window, lag):
    """Returns an array of autocorrelation of the rolling windows generated
    """
    # REDACTED

@jit(nopython=True)
def jitted_single_array_autocorrelation(array, lag):
    """Calculates the autocorrelation of a single array provided
    """
    # REDACTED
