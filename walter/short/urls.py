from django.urls import path
from django.views.generic import TemplateView

from short.api.views import ShortUrlView

urlpatterns = [
    path('api/v1/short', ShortUrlView.as_view()),
    path('', TemplateView.as_view(template_name='short/index.html'))
]