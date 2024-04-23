from django.urls import path
from .views import schedule_practice_view, game_data_view, player_practice_schedule_view, player_game_schedule_view, university_teams_view

urlpatterns = [
    path('schedule_practice_view/', schedule_practice_view, name='schedule_practice_view'),
    path('game_data_view/', game_data_view, name='game_data_view'),
    path('player_game_schedule_view/', player_game_schedule_view, name='player_game_schedule_view'),
    path('player_practice_schedule_view/', player_practice_schedule_view, name='player_practice_schedule_view'),
    path('university_teams_view/', university_teams_view, name='university_teams_view'),
]
