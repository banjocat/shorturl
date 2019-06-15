from django.test import TestCase

from .models import calculate_endpoint


class ShortTestCase(TestCase):

    def test_simple(self):
        self.assertEqual(calculate_endpoint(1), 'B')
        self.assertEqual(calculate_endpoint(20), 'U')
        self.assertEqual(calculate_endpoint(26), 'a')

    def test_larger(self):
        self.assertEqual(calculate_endpoint(134), 'By')
        self.assertEqual(calculate_endpoint(1023041), 'B8=F')
        self.assertEqual(calculate_endpoint(102304113112), 'Ym#-Uo')

