import cx_Oracle
from .forms import SchedulePracticeForm, ScheduleGameForm, UpdateGameDetailsForm, ScheduleFilterForm
from django.db import connection
from .models import GameData, PlayerGameSchedule, PlayerPracticeSchedule, UniversityTeams, FacilitySchedule
from django.shortcuts import render, redirect
from django.contrib import messages


def validate_scores(scores, home_team_id, away_team_id, winning_team_id):
    import re
    match = re.match(r'^(\d+)-(\d+)$', scores)
    if not match:
        return False, "Invalid Scores format. Please use 'HomeTeamScore-AwayTeamScore' format."
    home_score, away_score = int(match.group(1)), int(match.group(2))
    expected_winner_id = home_team_id if home_score > away_score else away_team_id
    if winning_team_id not in [home_team_id, away_team_id]:
        return True, ""  #Handled by procedure
    if winning_team_id != expected_winner_id:
        return False, "Invalid winning team. The scores do not match the winning team."

    return True, ""


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
                if 'is already booked for the' in message.getvalue():
                    messages.error(request, 'The facility is already booked for the given time! Please check facility '
                                            'schedules for existing bookings.')
                    return render(request, "admin/schedule_practice.html", {"form": form})
                elif 'already booked for another game' in message.getvalue():
                    messages.error(request, message.getvalue())
                    return render(request, "admin/schedule_practice.html", {"form": form})
                else:
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
                if scores is not None and winning_team is not None:
                    valid, error_message = validate_scores(scores, home_team_id, away_team_id, winning_team_id)
                    if not valid:
                        messages.error(request, error_message)
                        return render(request, "admin/schedule_game.html", {"form": form})
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
                elif 'The facility is already booked for the given time!' in message.getvalue():
                    messages.error(request, message.getvalue())
                elif 'teams is already booked for another game or practice' in message.getvalue():
                    messages.error(request, message.getvalue())
                else:
                    messages.success(request, message.getvalue())
                    return redirect('schedule_game_view')
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
                cursor.execute("SELECT HomeTeamID, AwayTeamID FROM Game WHERE GameID = :1", [game_id])
                game = cursor.fetchone()
                if not game:
                    messages.error(request, 'Game not found.')
                    return render(request, "admin/update_game_details.html", {"form": form})

                home_team_id, away_team_id = game

                # Validate scores
                valid, error_message = validate_scores(scores, home_team_id, away_team_id, winning_team_id)
                if not valid:
                    messages.error(request, error_message)
                    return render(request, "admin/update_game_details.html", {"form": form})
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
                elif 'Error: Increase amount must be greater than current one.' == msg_value:
                    messages.error(request, msg_value)
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


def facility_schedule_view(request):
    form = ScheduleFilterForm(request.GET or None)
    schedules = FacilitySchedule.objects.all()

    if form.is_valid():
        facility = form.cleaned_data['facility_id']
        if facility:
            schedules = schedules.filter(facility_id=facility.FacilityID)

        event_type = form.cleaned_data['event_type']
        if event_type:
            schedules = schedules.filter(event_type=event_type)

        schedules = schedules.order_by('event_start')
    else:
        schedules = schedules.none()

    return render(request, 'admin/view_facility_schedules.html', {
        'form': form,
        'schedules': schedules
    })
