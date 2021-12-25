from datetime import timedelta
from cpython.datetime cimport datetime

cdef class Signal:
    cdef:
       # REDACTED

    def __init__(# REDACTED):
        # REDACTED

    def __add__(self, Signal other):
        # REDACTED

    cpdef Signal add(self, Signal other):
        """Overloaded addition operator that linearly aggregates signal weights.
        """
        # REDACTED

    cpdef apply_decay(self, datetime current_time):
        """
        Piecewise Linear Version:
        Decays confidence and weight harshly at first, then gentler after halflife percentage period
        """
        # REDACTED

    cpdef set_weight(self, double new_weight):
        """Helper function to update weight of the Signal
        """
        # REDACTED

    cpdef set_expected_value(self, double new_expected_value):
        """Helper function to update expected value of the Signal
        """
        # REDACTED

    cpdef Signal copy(self):
        """Helper method that returns a deep copy of itself
        """
        # REDACTED

    cpdef Signal normalize_weight_by_normalization_factor(self, double normalization_factor):
        """Class method to safely normalize weights
        """
        # REDACTED

    def __str__(self):
        """Displays signal information when printed
        """
        # REDACTED
