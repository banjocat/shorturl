from django.db import models


base_html = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~:/?#[]@!$&'()*+,;="


def calculate_endpoint(url_id):
    quotient = url_id
    radix = len(base_html)
    result = ''
    while quotient > 0:
        remainder = quotient % radix
        quotient = quotient // radix
        result = base_html[remainder] + result
    return result


class ShortA(models.Model):
    url = models.URLField()
    url_id = models.AutoField(primary_key=True)

    @property
    def endpoint(self):
        return calculate_endpoint(self.url_id)

    class Meta:

        constraints = [
            models.constraints.UniqueConstraint(fields=['url'], name='unique_url')
        ]

        db_table = 'short_a'






