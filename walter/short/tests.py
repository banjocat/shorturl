from django.test import TestCase
from rest_framework.test import APIRequestFactory

from .models import calculate_endpoint
from .api.views import ShortUrlView


class ShortTestCase(TestCase):

    def test_simple(self):
        self.assertEqual(calculate_endpoint(1), 'B')
        self.assertEqual(calculate_endpoint(20), 'U')
        self.assertEqual(calculate_endpoint(26), 'a')

    def test_larger(self):
        self.assertEqual(calculate_endpoint(134), 'Bz')
        self.assertEqual(calculate_endpoint(1023041), 'B~p:')
        self.assertEqual(calculate_endpoint(102304113112), 'Z,2,tE')

    def test_create(self):
        factory = APIRequestFactory()
        request = factory.post('/api/v1/short', {'url': "http://jackmuratore.com"}, format='json')
        response = ShortUrlView.as_view()(request)
        self.assertEqual(response.data['url'], 'http://jackmuratore.com')
        self.assertEqual(response.data['endpoint'], 'B')
        request = factory.post('/api/v1/short', {'url': "http://jackmuratore.com"}, format='json')
        response = ShortUrlView.as_view()(request)
        self.assertEqual(response.data['url'], 'http://jackmuratore.com')
        self.assertEqual(response.data['endpoint'], 'B')



