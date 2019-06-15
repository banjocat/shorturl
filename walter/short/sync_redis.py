import logging

from django_redis import get_redis_connection

from .models import ShortUrl

log = logging.getLogger(__name__)


def full_short_sync():
    shorts = ShortUrl.objects.all()
    redis = get_redis_connection("short")
    for short in shorts:
        log.debug(f"endpoint={short.endpoint} url={short.url}")
        redis.set(short.endpoint, short.url)
