"""
This module contains the DownstreamModelManager which is responsible for passing
fitted downstream models to factors that need metalabelling.
"""
import os
from datetime import datetime
import pandas as pd
from metalabel_models.metalabelling.models.downstream_models import (
    EquitiesSerialCointegrationLgSpreadPairDownstreamRegressor,
    EquitiesCrossSectionalClusterReturnsDownstreamRegressor
)


class DownstreamModelManager:
    def __init__(self, strategy_config):
        """Constructor for DownstreamModelManager
        """
        # REDACTED


    @staticmethod
    def latest_datetime_filepath(dir_path: str):
        """Assuming all files in directory path specified are
        .joblib files and have the datetime_format as specified in the constructor,
        retrives the filename with the most recent date

        Args:
            dir_path (str): Path to directory with .joblib files only and all filenames follow the
                            same datetime_format as specified in constructor

        Returns:
            str:
                Filename with most recent datetime
        """
        # REDACTED

    def pass_initial_model_to_factors_on_start(self, factor: str):
        """Instantiate the .joblib file with most recent datetime filename

        Args:
            factor (str): Name of the factor for a specific downstream model

        Returns:
            Downstream model for specific factor
        """
        # REDACTED


    def refit_updated_factor_specific_model(self, factor: str):
        """Refits the factor model for a specific factor

        Args:
            factor (str): Name of the factor for a specific downstream model
        """
        # REDACTED


    def pass_updated_model_to_factors_every_week(self, factor: str):
        """Pass the updated model to the factors after it is updated

        Args:
            factor (str): Name of the factor for a specific downstream model

        Returns:
            Downstream model for specific factor
        """
        # REDACTED