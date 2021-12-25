import pandas as pd

from helper_models.general.exception_handler import ExceptionHandler
from helper_models.general.sampler import Sampler
from helper_models.slice.child_order_manager import ChildOrderManager
from helper_models.slice.sgx_equities_vwap import SGXEquitiesVwap
from helper_models.data.historical_downloader_new import HistoricalDownloader
from tqdm import tqdm
exception_handler = ExceptionHandler()
INTEGER_MAX = 2147483600


class SGXEquitiesExecutionModel:
    """
    Execution model is responsible for executing orders emitted from Portfolio model.

    The goal is to use non-naive execution strategies to minimise signalling, and to do that
    a vwap model is used to slice our order into child orders and a child order manager
    is responsible for executing the child orders.
    """
    def __init__(self, strategy_config):
        # REDACTED

    def initialise_data_and_models(self, time_now):
        """
        Initialises all data structures and models required for execution model to function.
        This is called each time universe reset.

        Args:
            time_now (datetime.datetime): used to download historical data before time_now
        """
        # REDACTED

    def initialise_data_structures(self):
        """ Initialises order vector, daily tick and daily trade data.
        """
        # REDACTED

    @exception_handler.except_initialise_vwap_model
    def initialise_vwap_model(self, time_now):
        """
        Initialises Vwap by downloading historical trade data. Vwap will preprocess volume from trade data to calculate 5 minute
        and 30 second buckets, in order to determine how to slice orders. The downloading and updating is done dynamically (one day at a time)
        to reduce RAM usage.

        Args:
            time_now (datetime.datetime): used to download historical data before time_now
        """
        # REDACTED

    @exception_handler.except_initialise_child_order_manager
    def initialise_child_order_manager(self, time_now):
        """
        Initialises Child order manager by downloading historical tick data. COM will preprocess the tick data to calculate metrics
        such as volatility, price spread widths, frequency of ticks etc. which will be used to determine child order execution logic.
        The downloading and updating is done dynamically (one day at a time) to reduce RAM usage.

        Args:
            time_now (datetime.datetime): used to download historical data before time_now
        """
        # REDACTED

    def recalculate_new_metrics_for_vwap_and_com(self, time_now):
        """DOCUMENTATION REDACTED
        """
        # REDACTED

    @exception_handler.except_slice_order
    def slice_order(self, order_vector):
        """DOCUMENTATION REDACTED
        """
        # REDACTED

    def execute_new_order_vectors(self, child_orders):
        """
        Main logic for executing orders. Every 30 seconds, a new child order will be executed, by adding the child order
        to the partial order vector. Within this 30 seconds interval, child order manager will determine how to further
        split the child order based on its calculated metrics on market conditions.
        Checks and ensures that we are at least keeping up to a TWAP schedule, sending MO to catch up if needed.

        Args:
            child_orders Dict({order_number (int): order (Dict)}): NESTED DATA STRUCTURE

                order Dict({equity_symbol (str): position (int)})

            ### if no order vector is emitted from Portfolio Model, child_orders will be None instead.
        """
        # REDACTED

    def reschedule_order_vectors(self, child_orders):
        """
        This is called after loading a pickled strategy. We will create a new schedule to execute
        any remaining orders

        Args:
            child_orders Dict({order_number (int): order (Dict)}): NESTED DATA STRUCTURE

                order Dict({equity_symbol (str): position (int)})

            ### if no order vector is input from the user, child_orders will be None instead.
        """
        # REDACTED

    def create_pending_order(self, order):
        """
        Creates a pending order (Algotrader order object) from a dictionary emitted from
        Child order manager. Pending orders will be appended to a list (queue) and will be sent
        one at a time.

        Args:
            order Dict({order_metrics: values}): various information for the order (side, quantity, security_id etc.)
        """
        # REDACTED

    def chasing(self):
        """
        This function will be called when we
        Called when we reached the last child order. Send market orders to clear remaining quantity required.
        """
       # REDACTED

    def send_pending_orders(self):
        """DOCUMENTATION REDACTED
        """
        # REDACTED

    def receive_order_status_and_update(self, order_status):
        """Helper function to receive order status.
        """
        # REDACTED

    def clear_all_order_data_structures(self):
        """DOCUMENTATION REDACTED
        """
        # REDACTED

    def receive_subscribed_universe(self, data):
        """Receive subscribed equity and currencies from universe model
        """
        # REDACTED

    def receive_data_from_data_model(self, data):
        """ Receive latest data from data model, every tick and bar
        """
        # REDACTED
