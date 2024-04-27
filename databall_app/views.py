import cx_Oracle
from django.shortcuts import render
from django.http import HttpResponse
from django.urls import reverse
from .forms import SchedulePracticeForm
from django.db import connection
from .models import GameData, PlayerGameSchedule, PlayerPracticeSchedule, UniversityTeams


def schedule_practice_view(request):
    form_url = reverse('schedule_practice_view')
    if request.method == 'POST':
        form = SchedulePracticeForm(request.POST)
        if form.is_valid():
            try:
                conn = connection.cursor().connection
                cursor = conn.cursor()
                message = cursor.var(cx_Oracle.DB_TYPE_VARCHAR)

                cursor.callproc("SchedulePractice", [
                    form.cleaned_data['TeamID'],
                    form.cleaned_data['PracticeDate'],
                    form.cleaned_data['PracticeDuration'],
                    form.cleaned_data['FocusArea'],
                    form.cleaned_data['FacilityID'],
                    message
                ])

                alert_message = message.getvalue()
                cursor.close()
                return HttpResponse(f"<script>alert('{alert_message}'); window.location.href='{form_url}';</script>")
            except Exception as e:
                alert_message = str(e)
                return HttpResponse(f"<script>alert('{alert_message}'); window.location.href='{form_url}';</script>")
        else:
            alert_message = "Invalid form submission."
            return HttpResponse(f"<script>alert('{alert_message}'); window.location.href='{form_url}';</script>")
    else:
        form = SchedulePracticeForm()
    return render(request, "admin/schedule_practice.html", {"form": form})

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
