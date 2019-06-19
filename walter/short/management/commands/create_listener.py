import json
import logging

from django.conf import settings
from django.core.management.base import BaseCommand
from pgnotify import await_pg_notifications
from django_redis import get_redis_connection

log = logging.getLogger(__name__)


db = settings.DATABASES['default']


class Command(BaseCommand):
    help = 'starts the listener'

    @staticmethod
    def listen():
        for notification in await_pg_notifications(
                f"postgresql://{db['USER']}:{db['PASSWORD']}@{db['HOST']}:{db['PORT']}/{db['NAME']}",
                ['short_url_created']):
            try:
                payload = json.loads(notification.payload)
            except json.JSONDecodeError as e:
                log.error(e)
                continue

            redis = get_redis_connection("short")
            try:
                redis.set(payload['endpoint'], payload['url'])
            except KeyError as e:
                log.error(e)
                continue
            log.debug(f'payload: {payload}')

    def handle(self, *args, **options):
        log.warning("Starting listener")
        self.listen()




