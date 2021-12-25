import numpy as np
import pandas as pd
import yfinance as yf
import logging

from os import system
from time import sleep
from datetime import datetime, time, timedelta
from reference_data_retriever import ReferenceDataRetriever

class PlutusMazuThemis:
    """DOCUMENTATION REDACTED
    """
    def __init__(self):
        # REDACTED

    def on_start(self):
        """
        Called at the start of the strategy, performs initial calculations for firm equity, daily returns
        for each strategy, optimal leverage to assign to each strategy as well as instructions provided
        from Themis' sword.
        """
        # REDACTED

    def on_running(self):
        """
        Main method, periodically check for new instructions received from sword and latest firm equity.
        At the end of each day, Themis also recalculates daily returns for each strategy and optimal leverage
        to assign to each strategy.
        """
        # REDACTED

    def get_instructions_from_sword(self):
        """
        Reads instructions from Themis' sword and update mute, kill, position and market value constraints for each strategy.

        Returns:
            NESTED DATA STRUCTURE
            instructions (Dict {constraint_type (str): strategies_and_constraints (Dict)}): Double layered dictionary

                constraint_type: Mute, Kill, Position Constraints, Market Value Constraints
                strategies_and_constraints (Dict {strategy_name (str): constraint (List/Dict)})

                    strategy_name: SGXEquities, HKEXEquities etc.
                    constraint: List [security_symbol] for mute/kill, Dict {security_symbol: constraint_value} for position/market_value
        """
        # REDACTED

    def get_strategy_net_liquidity(self):
        """
        Calls data retriever model to obtain cash balances for each strategy. Before running any strategy live,
        we should first insert cash balance and portfolio value data (from backtest) into reference database

        Returns:
            strategies_and_cash_balances (Dict {strategy_name (str): cash_balance(float)})
        """
        # REDACTED

    def get_strategy_daily_returns_over_past_year(self):
        """
        Calls data retriever to read in historical portfolio values for each strategy, and
        calculate daily returns based on the historical cash balances.

        Returns:
            strategies_and_daily_returns (Dict{strategy_name (str): daily_returns (pd.Series)})
        """
        # REDACTED

    def calculate_optimal_leverage(self, strategies_and_daily_returns):
        """
        Calculates optimal leverage to assign to each strategy, using Kelly's formula scaled by a constant multiplier.
        According to Kelly's formula, the vector of optimal leverages to assign to each strategy satisfies the
        following equation:
                                                        F = C^{-1}.M, where
                                                        F := vector of optimal leverage
                                                        C := covariance matrix of strategy returns
                                                        M := mean excess returns of each strategy

        However, since real world situations are vastly different from that of Kelly's model assumptions (normality
        of returns), we take a safer side and use (self.kelly_multiplier * F) as our optimal leverage vector.

        Args:
            strategies_and_daily_returns (Dict{strategy_name (str): daily_returns (pd.Series)})

        Internal variables modified:
            self.strategies_and_optimal_leverage (Dict{strategy_name (str): optimal_leverage(float)})
        """
        # REDACTED

    def calculate_optimal_assigned_market_value(self, strategies_and_cash_balances):
        """
        Calculates the optimal market value to assign to each strategy, which is given by:

                                        MV_{i} = F_{i} * CB_{i}, where
                                        MV_{i} := market value (pre-constrained) for strategy i,
                                        F_{i} := optimal leverage for strategy i,
                                        CB_{i} := cash balance for strategy i

        Args:
            self.strategies_and_optimal_leverage (Dict{strategy_name (str): optimal_leverage(float)})
            strategies_and_cash_balances (Dict {strategy_name (str): cash_balance(float)})

        Class variables modified:
            self.strategies_and_theoretical_optimal_market_value (Dict{strategy_name (str): market_value (float)}):
                Optimal market values without any constraints from Themis' sword.
        """
        # REDACTED

    def apply_market_value_constraints(self, instructions):
        """
        Applies constraints obtained from Themis' sword to market values assigned to our strategies.

        Args:
            instructions (Dict {constraint_type (str): strategies_and_constraints (Dict)})

        Class variables modified:
            self.strategies_and_constrained_optimal_market_value (Dict{strategy_name (str): market_value (float)}):
                Optimal market values after imposing constraints from Themis' sword.
        """
        # REDACTED

    def write_to_scales(self, instructions):
        """
        Updates Themis' scales with the latest information. Any new instructions from sword,
        and changes to cash balance for any strategy will be saved to scales.

        Args:
            instructions (Dict {constraint_type (str): strategies_and_constraints (Dict)})
        """
        # REDACTED

    def get_risk_free_rate_series(self):
        """
        Helper method to retrieve risk free rate by using the BIL ETF as a surrogate.

        Returns:
            risk_free_rate_series (pd.Series): Series of BIL ETF daily adjusted close.
        """
        # REDACTED

    def get_strategies_and_positions(self):
        pass

    def get_total_positions_daily_returns(self):
        pass

    def get_risk_exposures(self):
        pass

strategy = PlutusMazuThemis()
strategy.on_start()
strategy.on_running()
