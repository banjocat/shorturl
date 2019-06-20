import logging
import json

import maya

from django_redis import get_redis_connection

from .models import ShortUrl

log = logging.getLogger(__name__)


def full_short_sync():
    timestamp = maya.now().epoch
    shorts = ShortUrl.objects.all()
    redis = get_redis_connection("short")
    for short in shorts:
        log.debug(f"endpoint={short.endpoint} url={short.url}")
        with redis.lock('short'):
            fetch = redis.get(short.endpoint)
            if fetch and json.loads(fetch)['timestamp'] > timestamp:
                continue
            data = {
                'url': short.url,
                'timestamp': timestamp
            }
            redis.set(short.endpoint, json.dumps(data))
