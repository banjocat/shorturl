from rest_framework.generics import ListCreateAPIView
from rest_framework.serializers import ModelSerializer

from short.models import ShortUrl


class ShortUrlSerializer(ModelSerializer):

    class Meta:
        model = ShortUrl
        fields = ['url', 'endpoint']


class ShortUrlView(ListCreateAPIView):
    queryset = ShortUrl.objects.all()
    serializer_class = ShortUrlSerializer


