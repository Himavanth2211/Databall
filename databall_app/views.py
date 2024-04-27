import cx_Oracle
from .forms import SchedulePracticeForm, ScheduleGameForm
from django.db import connection
from .models import GameData, PlayerGameSchedule, PlayerPracticeSchedule, UniversityTeams


def schedule_practice_view(request):
    if request.method == 'POST':
        form = SchedulePracticeForm(request.POST)
        if form.is_valid():
            try:
                conn = connection.cursor().connection
                cursor = conn.cursor()
                message = cursor.var(cx_Oracle.DB_TYPE_VARCHAR)

                team_id = form.cleaned_data['TeamID'].TeamID
                facility_id = form.cleaned_data['FacilityID'].FacilityID
                cursor.callproc("SchedulePractice", [
                    team_id,
                    form.cleaned_data['PracticeDate'],
                    form.cleaned_data['PracticeDuration'],
                    form.cleaned_data['FocusArea'],
                    facility_id,
                    message
                ])

                messages.success(request, message.getvalue())
                return redirect('schedule_practice_view')
            except Exception as e:
                messages.error(request, str(e))
                return render(request, "admin/schedule_practice.html", {"form": form})
        else:
            messages.error(request, "Invalid form submission.")
            return render(request, "admin/schedule_practice.html", {"form": form})
    else:
        form = SchedulePracticeForm()
        return render(request, "admin/schedule_practice.html", {"form": form})


from django.shortcuts import render, redirect
from django.contrib import messages


def schedule_game_view(request):
    if request.method == 'POST':
        form = ScheduleGameForm(request.POST)
        if form.is_valid():
            try:
                conn = connection.cursor().connection
                cursor = conn.cursor()
                home_team_id = form.cleaned_data['HomeTeamID'].TeamID
                away_team_id = form.cleaned_data['AwayTeamID'].TeamID
                facility_id = form.cleaned_data['FacilityID'].FacilityID
                game_date = form.cleaned_data['GameDate']
                game_duration = form.cleaned_data['GameDuration']
                scores = form.cleaned_data.get('Scores', None)

                winning_team = form.cleaned_data.get('WinningTeamID', None)
                winning_team_id = winning_team.TeamID if winning_team else None

                message = cursor.var(cx_Oracle.DB_TYPE_VARCHAR)

                cursor.callproc("ScheduleGame", [
                    home_team_id,
                    away_team_id,
                    game_date,
                    game_duration,
                    facility_id,
                    scores,
                    winning_team_id,
                    message
                ])
                if message.getvalue() == 'Error: Home team and away team cannot be the same.':
                    messages.error(request, message.getvalue())
                if message.getvalue() == 'Error: Winning team must be either the home team or the away team.':
                    messages.error(request, message.getvalue())
                else:
                    messages.success(request, message.getvalue())
                return redirect('schedule_game_view')
            except Exception as e:
                messages.error(request, str(e))
                return render(request, "admin/schedule_game.html", {"form": form})
        else:
            messages.error(request, "Invalid form submission.")
            return render(request, "admin/schedule_game.html", {"form": form})
    else:
        form = ScheduleGameForm()
        return render(request, "admin/schedule_game.html", {"form": form})


def game_data_view(request):
    data = GameData.objects.all()
    return render(request, 'admin/view_game_data.html', {'data': data})


def player_game_schedule_view(request):
    schedule = PlayerGameSchedule.objects.all()
    return render(request, 'admin/view_player_game_schedule.html', {'schedule': schedule})


def player_practice_schedule_view(request):
    schedule = PlayerPracticeSchedule.objects.all()
    return render(request, 'admin/view_player_practice_schedule.html', {'schedule': schedule})


def university_teams_view(request):
    teams = UniversityTeams.objects.all()
    return render(request, 'admin/view_university_teams.html', {'teams': teams})
