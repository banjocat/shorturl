from django.urls import path

from short.api.views import ShortUrlView

urlpatterns = [
    path('', ShortUrlView.as_view())
]