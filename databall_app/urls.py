from django.urls import path
from .views import schedule_practice_view

urlpatterns = [
    path('schedule_practice_view/', schedule_practice_view, name='schedule_practice_view'),
]
