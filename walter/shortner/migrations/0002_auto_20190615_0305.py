# Generated by Django 2.2.2 on 2019-06-15 03:05

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('shortner', '0001_initial'),
    ]

    operations = [
        migrations.RenameModel(
            old_name='BasicShortURL',
            new_name='ShortURL',
        ),
        migrations.AlterModelTable(
            name='shorturl',
            table='short_url',
        ),
    ]
