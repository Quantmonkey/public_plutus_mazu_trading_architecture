import pandas as pd
import numpy as np
import math

from helper_models.general.exception_handler import ExceptionHandler
from helper_models.portfolio.portfolio_optimizer import PortfolioOptimizer
from helper_models.filter.sgx_equities_scraper import SGXEquitiesScraper
from helper_models.general.sampler import Sampler
from helper_models.general.trading_hours_manager import TradingHoursManager
from datetime import timedelta
exception_handler = ExceptionHandler()


class SGXEquitiesPortfolioModel:
    """DOCUMENTATION REDACTED
    """

    def __init__(self, strategy_config):
        # REDACTED

    def update_optimal_portfolio(self, factors_and_dict_of_signals):
        """
        Updates optimal portfolio by checking if there are any new signal updates from alpha model. In the event
        that a new signal is received, we prioritise the new signal and calculate a new order vector. If not,
        portfolio model will take the opportunity to resync theoretical and actual positions.

        Args:
            NESTED DATA STRUCTURE
            factors_and_dict_of_signals (Dict {factor_name (str) dict_of_signals (Dict)}): Double layered dictionary
                factor_name: SGXEquitiesLgSpreadModel etc.
                dict_of_signals (Dict{security_symbol(str): signal (Signal)})

            *** if alpha model does not emit signals, factors_and_dict_of_signals will be None

        Class variables modified:
            self.equities_and_optimal_portfolio (Dict {security_symbol(str): position (int)}) optimal positions for each security
        """
        # REDACTED

    def translate_factor_segregated_signals_to_optimal_portfolio(self, factors_and_dict_of_signals):
        """
        Aggregates signals from every factor via a multi-step process:
            1. # REDACTED
            2. Normalize each signal in each factor according to it's factor's total absolute weight
                This ensures factors are not penalized based on their total weights,
                while preserving the ratio of weights between different securities in each factor
            3. Linearly sums factors, so as to combine signals from different factors in an average-weighted manner while respecting their ratios
            4. Applies kill instructions from Themis, and remove short positions in equities that are not in the cdp pool.
            5. Call portfolio optimizer to optimizer portfolio positions, by # REDACTED
            6. Determine the portfolios "g.c.d", by normalizing all weights by the smallest absolute weight in our portfolio
            7. Calculate optimal portfolio (pre-mute) by scaling it with: allocated optimal market value / minimum position size market value
            8. Apply mute conditions, position constraints and cdp short constraints to obtain the optimal constrained portfolio.

        Args:
            factors_and_dict_of_signals (Dict {factor_name (str) dict_of_signals (Dict)}): Double layered dictionary

        Class variables modified:
            self.equities_and_optimal_portfolio (Dict {security_symbol(str): position (int)}) optimal positions for each security
        """
        # REDACTED

    def get_external_instructions_from_themis(self):
        """ Helper method to read in user-input restrictions/instructions obtained from Themis.
        """
        # REDACTED

    def normalize_factor_weights(self, factors_and_dict_of_signals):
        """
        Normalize each signal in each factor according to it's factor's total absolute weight:
                                    W^{i}_{normalized} = W^{i} / SUM_{j=1}^{n} W^{j}

        Args:
            factors_and_dict_of_signals (Dict {factor_name (str) dict_of_signals (Dict)}): Double layered dictionary

        Returns:
            normalized_factors_and_dict_of_signals (Dict {factor_name (str) dict_of_signals (Dict)}): Double layered dictionary
        """
       # REDACTED
        return normalized_factors_and_dict_of_signals

    def linearly_sum_signals_across_factors(self, normalized_factors_and_dict_of_signals):
        """
        Linearly adds signals across factors

        Args:
            normalized_factors_and_dict_of_signals (Dict {factor_name (str) dict_of_signals (Dict)}): Double layered dictionary

        Returns:
            equities_and_normalized_signals (Dict {security_symbol(str): position (int)})
        """
        # REDACTED

    def apply_kill_and_cdp_pool_constraints(self, equities_and_normalized_signals):
        """
        First constraint
            - removes securities that are killed
            - removes securities that we are shorting, and are not in cdp pool

        Args:
            equities_and_normalized_signals (Dict {security_symbol(str): position (int)})

        Returns:
            equities_and_constrained_signals (Dict {security_symbol(str): position (int)})
        """
        # REDACTED

    @exception_handler.except_calculate_optimal_portfolio_weights
    def calculate_optimal_portfolio_weights(self, equities_and_normalized_signals):
        """DOCUMENTATION REDACTED
        """
        # REDACTED

    def determine_minimum_optimal_portfolio_positions(self, equities_and_optimized_signal_weights):
        """
        Calculates the "greatest common divisor", i.e smallest portfolio that still respects the ratio of weights between securities.

        Class variables modified:
            self.equities_and_optimal_portfolio (Dict {security_symbol(str): position (int)})
        """
        # REDACTED

    def scale_optimal_portfolio_by_optimal_leverage(self, equities_and_minimal_portfolio):
        """ Helper method to scale the minimum optimal portfolio so that we achieve the optimal leverage for this strategy.
        """
        # REDACTED

    def apply_mute_and_position_constraints(self, equities_and_pre_mute_constrained_portfolio):
        # REDACTED

    def update_order_vector(self, recalculating=False):
        """
        Updates order vector to be emitted, by calculating differences between optimal and current portfolio.

        Args:
            recalculating (bool): Forces portfolio model to calculate, which is set to True when:
                1. We need to resync actual positions with theoretical positions
                2. We are loading a pickled strategy and need to update current positions

        Class variables modified:
            self.order_vector (Dict {security_symbol(str): position(str)}): order vector sent to execution model
            self.equities_and_theoretical_positions (Dict {security_symbol(str): position(str)}):
                theoretical portfolio, assuming all our orders are filled.
        """
        # REDACTED

    def emit_order_vector(self, recalculating=False):
        """
        Emits order vector, which will be received by execution model to execute.

        Args:
            recalculating (bool): Forces portfolio model to calculate, which is set to True when:
                1. We need to resync actual positions with theoretical positions
                2. We are loading a pickled strategy and need to update current positions

        Returns:
            self.order_vector (Dict {security_symbol(str): position(str)}): order vector sent to execution model

            *** if alpha model does not emit any new signal changes, and if we are not syncing, returns None
        """
        # REDACTED

    def resync_portfolio(self):
        """DOCUMENTATION REDACTED
        """
        # REDACTED

    def update_latest_killed_instructions(self):
        """DOCUMENTATION REDACTED
        """
        # REDACTED

    def check_latest_instructions(self):
        """DOCUMENTATION REDACTED
        """
        # REDACTED

    def resync_theoretical_and_actual_positions(self):
        """DOCUMENTATION REDACTED
        """
        # REDACTED

    def get_outstanding_orders_from_resync_portfolios(self):
        """Called before weekly reset to get the outstanding securities that are unfulfilled
        """
        # REDACTED

    def update_theoretical_positions_with_real_positions(self, new_current_positions):
        """
        Called when loading a pickled strategy, updates theoretical positions with actual ones
        to account for any orders that may have been filled when the strategy was taken down.

        Args:
            new_current_positions (Dict {security_symbol(str): position(int)}):
                Any securities that have orders filled when the strategy was taken down
        """
        # REDACTED

    def initialise_data_structures(self):
        """Called every universe reset, initialises data structures for portfolio model to function
        """
        # REDACTED

    def scrape_cdp_pool_data(self, force=False):
        """ (Called by main strategy) helper method to call Scraper class to get latest short restrictions from cdp pool

        Args:
            force (bool): Forces scraping cdp data for testing purposes, default: False
        """
        # REDACTED

    def receive_transaction_and_update(self, transaction):
        """Receives transaction details and update actual current positions.
        """
        # REDACTED

    def receive_data_from_data_model(self, data):
        """ Receive latest data from data model, every tick and bar
        """
        # REDACTED

    def receive_subscribed_universe(self, data):
        """Receive subscribed equity and currencies from universe model
        """
        # REDACTED
