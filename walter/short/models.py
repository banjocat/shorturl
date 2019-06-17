from django.db import models

# Valid path chars used to convert to decimal to base_html
base_html = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~:/?[]@!$&'()*+,;="


def calculate_endpoint(url_id):
    quotient = url_id
    radix = len(base_html)
    result = ''
    while quotient > 0:
        remainder = quotient % radix
        quotient = quotient // radix
        result = base_html[remainder] + result
    return result


class ShortUrl(models.Model):
    url = models.URLField(max_length=40000)
    url_id = models.AutoField(primary_key=True)

    @property
    def endpoint(self):
        return calculate_endpoint(self.url_id)

    def __str__(self):
        return f'{self.endpoint} {self.url}'

    class Meta:

        constraints = [
            models.constraints.UniqueConstraint(fields=['url'], name='unique_url')
        ]

        db_table = 'short_url'

