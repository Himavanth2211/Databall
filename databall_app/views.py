import cx_Oracle
from django.shortcuts import render
from django.http import HttpResponse
from django.urls import reverse
from .forms import SchedulePracticeForm
from django.db import connection


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
                    form.cleaned_data['UniversityID'],
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
    return render(request, "schedule_practice.html", {"form": form})
