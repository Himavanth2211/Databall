from django.contrib import admin
from .models import University, Facilities, Team, Coach, Player, Game, Practices, GameData, PlayerGameSchedule, PlayerPracticeSchedule, UniversityTeams

class UniversityAdmin(admin.ModelAdmin):
    list_display = ('UniversityID', 'UniversityName', 'Location')
    search_fields = ('UniversityID', 'UniversityName')

class FacilitiesAdmin(admin.ModelAdmin):
    list_display = ('FacilityID', 'FacilityName', 'FacilityLocation', 'FacilityCapacity', 'University')
    search_fields = ('FacilityID', 'FacilityName')

class TeamAdmin(admin.ModelAdmin):
    list_display = ('TeamID', 'TeamName', 'Division', 'University')
    search_fields = ('TeamID', 'TeamName')

class CoachAdmin(admin.ModelAdmin):
    list_display = ('CoachID', 'CoachName', 'CoachRole', 'Team')


class PlayerAdmin(admin.ModelAdmin):
    list_display = ('PlayerID', 'PlayerName', 'Major', 'DOB', 'YearInSchool', 'Team', 'PlayerPosition')

class GameAdmin(admin.ModelAdmin):
    list_display = ('GameID', 'GameDate', 'HomeTeam', 'AwayTeam', 'Scores', 'WinningTeam')
    readonly_fields = ('GameID', 'GameDate')


class PracticesAdmin(admin.ModelAdmin):
    list_display = ('PracticeID', 'PracticeDate', 'Team', 'PracticeDuration', 'FocusArea', 'Facility')

class GameDataAdmin(admin.ModelAdmin):
    list_display = ('GameID', 'GameDate', 'GameLocation', 'HomeTeam', 'AwayTeam', 'Scores', 'WinningTeamID')
    readonly_fields = ('GameID', 'GameDate', 'GameLocation')
    def get_model_perms(self, request):
        return {}

class PlayerGameScheduleAdmin(admin.ModelAdmin):
    list_display = ('PlayerID', 'GameID', 'GameDate', 'GameLocation', 'TeamID')
    readonly_fields = ('PlayerID', 'GameID', 'GameDate', 'GameLocation', 'TeamID')
    def get_model_perms(self, request):
        return {}
class PlayerPracticeScheduleAdmin(admin.ModelAdmin):
    list_display = ['PlayerID', 'PracticeID', 'PracticeDate', 'FacilityName', 'FocusArea']
    readonly_fields = ['PlayerID', 'PracticeID', 'PracticeDate', 'FacilityName', 'FocusArea']
    def get_model_perms(self, request):
        return {}

class UniversityTeamsAdmin(admin.ModelAdmin):
    list_display = ['teamname', 'universityid']
    readonly_fields = ['teamname', 'universityid']
    def get_model_perms(self, request):
        return {}


admin.site.register(University, UniversityAdmin)
admin.site.register(Facilities, FacilitiesAdmin)
admin.site.register(Team, TeamAdmin)
admin.site.register(Coach, CoachAdmin)
admin.site.register(Player, PlayerAdmin)
admin.site.register(Game, GameAdmin)
admin.site.register(Practices, PracticesAdmin)
admin.site.register(GameData, GameDataAdmin)
admin.site.register(PlayerGameSchedule, PlayerGameScheduleAdmin)
admin.site.register(PlayerPracticeSchedule, PlayerPracticeScheduleAdmin)
admin.site.register(UniversityTeams, UniversityTeamsAdmin)
