from django import forms
from django.forms import widgets


class SchedulePracticeForm(forms.Form):
    TeamID = forms.CharField(label='Team ID', max_length=255)
    PracticeDate = forms.DateTimeField(label='Practice Date',
                                       widget=widgets.DateTimeInput(attrs={'type': 'datetime-local'}))
    PracticeDuration = forms.CharField(label='Practice Duration', max_length=255)
    FocusArea = forms.CharField(label='Focus Area', max_length=255)
    UniversityID = forms.CharField(label='University ID', max_length=255)
    FacilityID = forms.CharField(label='Facility ID', max_length=255)
