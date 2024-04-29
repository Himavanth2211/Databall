import cx_Oracle
from .forms import SchedulePracticeForm, ScheduleGameForm, UpdateGameDetailsForm
from django.db import connection
from .models import GameData, PlayerGameSchedule, PlayerPracticeSchedule, UniversityTeams
from django.shortcuts import render, redirect
from django.contrib import messages


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
                if 'already' in message.getvalue():
                    messages.error(request, message.getvalue())
                    return redirect('schedule_practice')
                else:
                    messages.success(request, message.getvalue())
                return render(request, "admin/schedule_practice.html", {"form": form})
            except Exception as e:
                messages.error(request, str(e))
                return render(request, "admin/schedule_practice.html", {"form": form})
        else:
            messages.error(request, "Invalid form submission.")
            return render(request, "admin/schedule_practice.html", {"form": form})
    else:
        form = SchedulePracticeForm()
        return render(request, "admin/schedule_practice.html", {"form": form})


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
                scores = form.cleaned_data.get('Scores', None)

                winning_team = form.cleaned_data.get('WinningTeamID', None)
                winning_team_id = winning_team.TeamID if winning_team else None  #PossibleBug

                message = cursor.var(cx_Oracle.DB_TYPE_VARCHAR)

                cursor.callproc("ScheduleGame", [
                    home_team_id,
                    away_team_id,
                    game_date,
                    facility_id,
                    scores,
                    winning_team_id,
                    message
                ])
                if message.getvalue() == 'Error: Home team and away team cannot be the same.':
                    messages.error(request, message.getvalue())
                elif message.getvalue() == 'Error: Winning team must be either the home team or the away team.':
                    messages.error(request, message.getvalue())
                elif message.getvalue() == 'The facility is already booked for the given time!':
                    messages.error(request, message.getvalue())
                else:
                    messages.success(request, message.getvalue())
                    return redirect('schedule_game')
                return render(request, "admin/schedule_game.html", {"form": form})
            except Exception as e:
                messages.error(request, str(e))
                return render(request, "admin/schedule_game.html", {"form": form})
        else:
            messages.error(request, "Invalid form submission.")
            return render(request, "admin/schedule_game.html", {"form": form})
    else:
        form = ScheduleGameForm()
        return render(request, "admin/schedule_game.html", {"form": form})


def update_game_details_view(request):
    if request.method == 'POST':
        form = UpdateGameDetailsForm(request.POST)
        if form.is_valid():
            try:
                conn = connection.cursor().connection
                cursor = conn.cursor()
                message = cursor.var(cx_Oracle.DB_TYPE_VARCHAR)

                game_id = form.cleaned_data['GameID'].GameID
                winning_team_id = form.cleaned_data['WinningTeamID'].TeamID
                scores = form.cleaned_data['Scores']
                import re
                if not re.match(r'^\d+-\d+$', scores):
                    messages.error(request, 'Invalid Scores, Please follow the format')
                else:
                    cursor.callproc("UpdateGameDetails", [
                        game_id,
                        winning_team_id,
                        scores,
                        message
                    ])

                if message.getvalue() == 'Game not found.':
                    messages.error(request, message.getvalue())
                elif message.getvalue() == 'Error: Winning team must be either the home team or the away team.':
                    messages.error(request, message.getvalue())
                else:
                    messages.success(request, message.getvalue())
                return render(request, "admin/update_game_details.html", {"form": form})
            except Exception as e:
                messages.error(request, f'Error updating game details: {str(e)}')
                return render(request, "admin/update_game_details.html", {"form": form})
        else:
            messages.error(request, "Invalid form submission.")
            return render(request, "admin/update_game_details.html", {"form": form})
    else:
        form = UpdateGameDetailsForm()
        return render(request, "admin/update_game_details.html", {"form": form})


from .forms import IncreaseFacilityCapacityForm


def increase_facility_capacity_view(request):
    if request.method == 'POST':
        form = IncreaseFacilityCapacityForm(request.POST)
        if form.is_valid():
            try:
                conn = connection.cursor().connection
                cursor = conn.cursor()
                facility_id = form.cleaned_data['FacilityID'].FacilityID
                increase_amount = form.cleaned_data['IncreaseAmount']

                message = cursor.var(cx_Oracle.DB_TYPE_VARCHAR)

                cursor.callproc("IncreaseFacilityCapacity", [
                    facility_id,
                    increase_amount,
                    message
                ])

                msg_value = message.getvalue()
                if 'successfully' in msg_value:
                    messages.success(request, msg_value)
                else:
                    messages.error(request, msg_value)

                return redirect('increase_facility_capacity_view')
            except Exception as e:
                messages.error(request, str(e))
                return render(request, "admin/increase_facility_capacity.html", {"form": form})
        else:
            messages.error(request, "Invalid form submission.")
            return render(request, "admin/increase_facility_capacity.html", {"form": form})
    else:
        form = IncreaseFacilityCapacityForm()
        return render(request, "admin/increase_facility_capacity.html", {"form": form})


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
