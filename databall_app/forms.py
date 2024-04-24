from django import forms
from .models import Team, University, Facilities  # Adjust these imports according to your models

class SchedulePracticeForm(forms.Form):
    TeamID = forms.ModelChoiceField(queryset=Team.objects.all(), label="Select Team: ")
    PracticeDate = forms.DateField(widget=forms.widgets.DateInput(attrs={'type': 'date'}), label="Practice Date: ")
    PracticeDuration = forms.IntegerField(min_value=1, label="Duration in hours: ")
    FocusArea = forms.CharField(max_length=100, label="Focus Area:")
    UniversityID = forms.ModelChoiceField(queryset=University.objects.all(), label="Select University: ")
    FacilityID = forms.ModelChoiceField(queryset=Facilities.objects.all(), label="Select Facility: ")
