from django import forms
from django.core.exceptions import ValidationError

from .models import Team, Facilities, Game

class SchedulePracticeForm(forms.Form):
    PracticeID = forms.CharField(
        initial='<Automatically generated>',
        required=False,
        disabled=True,
        label='Practice ID:',
        help_text='This ID is generated automatically when the practice is scheduled.'
    )
    TeamID = forms.ModelChoiceField(queryset=Team.objects.all(), label="Select Team: ")
    PracticeDate = forms.DateTimeField(
        widget=forms.widgets.DateTimeInput(attrs={'type': 'datetime-local'}),
        label="Practice Date: "
    )
    PracticeDuration = forms.IntegerField(min_value=1, label="Duration in hours: ")
    FocusArea = forms.CharField(max_length=100, label="Focus Area:")
    FacilityID = forms.ModelChoiceField(queryset=Facilities.objects.all(), label="Select Facility: ")



class ScheduleGameForm(forms.Form):
    HomeTeamID = forms.ModelChoiceField(queryset=Team.objects.all(), label="Select Home Team:")
    AwayTeamID = forms.ModelChoiceField(queryset=Team.objects.all(), label="Select Away Team:")
    GameDate = forms.DateTimeField(
        widget=forms.widgets.DateTimeInput(attrs={'type': 'datetime-local'}),
        label="Game Date: "
    )
    FacilityID = forms.ModelChoiceField(queryset=Facilities.objects.all(), label="Select Facility:")
    #Optional
    Scores = forms.CharField(max_length=100, required=False, label="Scores (optional):")
    WinningTeamID = forms.ModelChoiceField(queryset=Team.objects.all(), required=False, label="Select Winning Team (optional):")

    def clean(self):
        cleaned_data = super().clean()
        scores = cleaned_data.get('Scores')
        winning_team_id = cleaned_data.get('WinningTeamID')

        # Check if either scores or winning_team_id is provided, then both must be provided
        if (scores and not winning_team_id) or (winning_team_id and not scores):
            raise ValidationError(
                "Both Scores and Winning Team ID must be provided together, or neither should be entered.")

        return cleaned_data
class UpdateGameDetailsForm(forms.Form):
    GameID = forms.ModelChoiceField(queryset=Game.objects.all().select_related('HomeTeam', 'AwayTeam'), label="Select Game: ")
    WinningTeamID = forms.ModelChoiceField(required=True, queryset=Team.objects.all(), label="Select Winning Team: ")
    Scores = forms.CharField(required=True, max_length=100, label="Enter Scores: ", help_text="Ex: '2-3' i.e HomeTeamScore - AwayTeamScore")

class IncreaseFacilityCapacityForm(forms.Form):
    FacilityID = forms.ModelChoiceField(
        queryset=Facilities.objects.all(),
        label="Select Facility:"
    )
    IncreaseAmount = forms.IntegerField(
        min_value=1,
        label="Increased Amount:",
        help_text="Specify the total new capacity!"
    )