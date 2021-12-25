import pickle
import pandas as pd
import sys
import os

from ast import literal_eval
from glob import glob
from datetime import datetime, timedelta


class SGXEquitiesPersistence:
    """
    Helper class that periodically saves the state of the entire strategy - every primary model,
    helper model, factor model along with their data structures.

    In the event that we have to take down the strategy in an emergency, Persistence provides us with
    the option to restart with a backup state rather than restarting from scratch.
    """

    def __init__(self, strategy_config):
        # REDACTED

    def check_if_ready_to_and_pickle_entire_strategy(self, strategy, time_to_check, force_save=False):
        """
        Main method, pickles the entire strategy periodically. Since the pickling process will take some time,
        we will try to pickle the strategy at times of the day where there is low trading activity. Pickled
        strategies are stored in the persistence file path.

        Args:
            strategy (AlgoTrader StrategyService): the entire strategy to be pickled.
            time_to_check (datetime.datetime): current time, used to check if it is a good time to go ahead with the pickling.
            force_save (bool): used for testing purposes, forcefully saves the strategy.
        """
        # REDACTED

    def load_pickled_strategy(self, time_now=datetime.now(), force_load=False):
        """
        Loads the latest pickled strategy, allowing us to restart from a backed up state. By default,
        this will only be called during live trading, when we have to take down the strategy due to an
        emergency, and need a warm restart with most data structures still in tact.

        When loading a pickled strategy, additional instructions such as which securities to mute, kill,
        and what are the new updated portfolio positions can be input by the user, and Persistence
        will correspondingly make the updates to reflect the real latest state we are in.

        Args:
            time_now (datetime.datetime): current time, used to update primary models with the latest time
            force_load (bool): used for testing purposes, forcefully loads the strategy.

        Returns:
            if we have pickled strategies:
                primary_models (Dict {model_name(str): model (custom primary model object)}): backed up states.
            else:
                None
        """
        # REDACTED

    def check_if_ready_to_pickle(self, time_to_check, force_save):
        """
        Helper function to check if current time is a good time to perform pickling. Note that
        Persistence class will not be called during Backtesting (unless force_save is set to True)

        Args:
            time_to_check (datetime.datetime): current time, used to check if it is a good time to go ahead with the pickling.
            force_save (bool): used for testing purposes, forcefully saves the strategy.

        Returns:
            ready_to_pickle (bool): True if we are ready to do pickling, else False.
        """
        # REDACTED

    def update_mute_and_kill_constraints_to_themis(self, securities_to_mute, securities_to_kill):
        """Helper function to update mute and kill constraints to Themis' sword.
        """
        # REDACTED

    def delete_old_strategies(self):
        """Helper function that deletes older versions of pickled strategies, keeping only the latest 3 backups.
        """
        # REDACTED

    def get_datetime_from_string(self, string):
        """ Helper function to extract datetime from file name of the pickled strategy.
        """
        # REDACTED
