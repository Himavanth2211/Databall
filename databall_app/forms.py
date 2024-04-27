from django import forms
from .models import Team, Facilities

class SchedulePracticeForm(forms.Form):
    TeamID = forms.ModelChoiceField(queryset=Team.objects.all(), label="Select Team: ")
    PracticeDate = forms.DateField(widget=forms.widgets.DateInput(attrs={'type': 'date'}), label="Practice Date: ")
    PracticeDuration = forms.IntegerField(min_value=1, label="Duration in hours: ")
    FocusArea = forms.CharField(max_length=100, label="Focus Area:")
    FacilityID = forms.ModelChoiceField(queryset=Facilities.objects.all(), label="Select Facility: ")



class ScheduleGameForm(forms.Form):
    HomeTeamID = forms.ModelChoiceField(queryset=Team.objects.all(), label="Select Home Team:")
    AwayTeamID = forms.ModelChoiceField(queryset=Team.objects.all(), label="Select Away Team:")
    GameDate = forms.DateField(widget=forms.widgets.DateInput(attrs={'type': 'date'}), label="Game Date:")
    GameDuration = forms.IntegerField(min_value=1, label="Duration in hours:")
    FacilityID = forms.ModelChoiceField(queryset=Facilities.objects.all(), label="Select Facility:")
    #Optional
    Scores = forms.CharField(max_length=100, required=False, label="Scores (optional):")
    WinningTeamID = forms.ModelChoiceField(queryset=Team.objects.all(), required=False, label="Select Winning Team (optional):")