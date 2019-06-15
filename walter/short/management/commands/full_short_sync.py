from django.core.management.base import BaseCommand

from short.sync_redis import full_short_sync


class Command(BaseCommand):
    help = 'Does a full redis sync of all the shorts'

    def handle (self, *args, **options):
        full_short_sync()