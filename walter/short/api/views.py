from rest_framework.generics import CreateAPIView
from rest_framework.serializers import ModelSerializer

from short.models import ShortUrl


class ShortUrlSerializer(ModelSerializer):

    def create(self, validated_data):
        try:
            instance = ShortUrl.objects.get(url=validated_data['url'])
            return instance
        except ShortUrl.DoesNotExist:
            return super().create(validated_data)

    class Meta:
        model = ShortUrl
        fields = ['url', 'endpoint']


class ShortUrlView(CreateAPIView):
    queryset = ShortUrl.objects.all()
    serializer_class = ShortUrlSerializer

