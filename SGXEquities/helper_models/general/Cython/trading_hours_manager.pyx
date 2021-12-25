import pandas as pd

from cpython.datetime cimport time, datetime, timedelta


cdef class TradingHoursManager:
    # REDACTED

    cpdef assert_during_trading_hours(self, datetime current_time):

        """Function that checks if the current time is within the trading hours for a particular security.

        In order to reduce the frequency of running the entire function, a check is placed to run the function
        once every 5 minutes.

        The logic is as follows: if it is during trading hours now, then it will also be during trading hours for all
        times within the 5 minute interval containing this current time.
        """
        # REDACTED

    cpdef assert_time_to_check_within_weekend_threshold(self, datetime time_to_check, timedelta weekend_threshold, datetime current_time):
        """Helper function to check if there is some threshold before the weekends
        """
        # REDACTED

    cpdef assert_time_to_check_is_intervals_before_and_after_each_close(self, datetime time_to_check, timedelta time_interval_before, timedelta time_interval_after):
        """Helper function to check if we have some time before exchange closes or after exchange opens
        """
        # REDACTED
