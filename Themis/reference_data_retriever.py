import mysql.connector
import pandas as pd

from influxdb import InfluxDBClient

class ReferenceDataRetriever:
    """Helper class to query reference database and retrieve relevant data
    """
    def __init__(self):
        # REDACTED
        
    def get_net_liquidity_value(self, strategy_id: int) -> float:
        """
        Queries for latest net liquidity value in SGD, via a 3 step process:
            Step 1: mySQL query to obtain latest net liquidity in USD
            Step 2: influxDB query to obtain latest USDSGD conversion rate
            Step 3: convert net liquidity from USD to SGD

        Args:
            strategy_id (int): id for the strategy, used for mySQL querying

        Returns:
            latest_net_liquidity_in_sgd (float): latest net liquidity for the strategy, in SGD
        """
        # REDACTED
    
    def get_historical_net_liquidity(self, strategy_name, strategy_id, start_date, last_closing_time):
        """ Query portfolio value table to retrieve historical cash balances from start date.
        """
        # REDACTED
