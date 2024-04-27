from django.db import models


class University(models.Model):
    UniversityID = models.CharField(max_length=255, primary_key=True)
    UniversityName = models.CharField(max_length=255)
    Location = models.CharField(max_length=255)

    class Meta:
        managed = False
        db_table = 'University'
        verbose_name = 'University'
        verbose_name_plural = 'Universities'



class Facilities(models.Model):
    FacilityID = models.CharField(max_length=255, primary_key=True)
    FacilityName = models.CharField(max_length=255)
    FacilityLocation = models.CharField(max_length=255)
    FacilityCapacity = models.IntegerField(null=True, blank=True)
    University = models.ForeignKey(University, on_delete=models.CASCADE, db_column='UniversityID')

    class Meta:
        managed = False
        db_table = 'Facilities'
        verbose_name = 'Facility'
        verbose_name_plural = 'Facilities'



class Team(models.Model):
    TeamID = models.CharField(max_length=255, primary_key=True)
    TeamName = models.CharField(max_length=255)
    Division = models.CharField(max_length=255, blank=True, null=True)
    University = models.ForeignKey(University, on_delete=models.CASCADE, db_column='UniversityID')

    class Meta:
        managed = False
        db_table = 'Team'
        verbose_name = 'Team'
        verbose_name_plural = 'Teams'



class Coach(models.Model):
    CoachID = models.CharField(max_length=255, primary_key=True)
    CoachName = models.CharField(max_length=255)
    CoachRole = models.CharField(max_length=255, blank=True, null=True)
    Team = models.ForeignKey(Team, on_delete=models.CASCADE, db_column='TeamID')

    class Meta:
        managed = False
        db_table = 'Coach'
        verbose_name = 'Coach'
        verbose_name_plural = 'Coaches'



class Player(models.Model):
    PlayerID = models.CharField(max_length=255, primary_key=True)
    PlayerName = models.CharField(max_length=255)
    Major = models.CharField(max_length=255, blank=True, null=True)
    DOB = models.DateField()
    YearInSchool = models.IntegerField()
    Team = models.ForeignKey(Team, on_delete=models.CASCADE, db_column='TeamID')
    PlayerPosition = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'Player'
        verbose_name = 'Player'
        verbose_name_plural = 'Players'



class Game(models.Model):
    GameID = models.CharField(max_length=255, primary_key=True)
    GameDate = models.DateTimeField()
    Facility = models.ForeignKey(Facilities, on_delete=models.CASCADE, db_column='FacilityID')
    HomeTeam = models.ForeignKey(Team, on_delete=models.CASCADE, related_name='home_games', db_column='HomeTeamID')
    AwayTeam = models.ForeignKey(Team, on_delete=models.CASCADE, related_name='away_games', db_column='AwayTeamID')
    Scores = models.CharField(max_length=255, blank=True, null=True)
    WinningTeam = models.ForeignKey(Team, on_delete=models.SET_NULL, null=True, blank=True, related_name='won_games', db_column='WinningTeamID')

    class Meta:
        managed = False
        db_table = 'Game'
        verbose_name = 'Game'
        verbose_name_plural = 'Games'



class Practices(models.Model):
    PracticeID = models.CharField(max_length=255, primary_key=True)
    PracticeDate = models.DateTimeField()
    Team = models.ForeignKey(Team, on_delete=models.CASCADE, db_column='TeamID')
    PracticeDuration = models.CharField(max_length=255, blank=True, null=True)
    FocusArea = models.CharField(max_length=255, blank=True, null=True)
    Facility = models.ForeignKey(Facilities, on_delete=models.CASCADE, db_column='FacilityID')

    class Meta:
        managed = False
        db_table = 'Practices'
        verbose_name = 'Practice'
        verbose_name_plural = 'Practices'


#VIEW Models

class GameData(models.Model):
    GameID = models.CharField(max_length=255, primary_key=True, db_column='GameID')
    GameDate = models.DateTimeField(db_column='GameDate')
    GameLocation = models.CharField(max_length=255, db_column='GameLocation')
    HomeTeam = models.CharField(max_length=255, db_column='HomeTeam')
    AwayTeam = models.CharField(max_length=255, db_column='AwayTeam')
    Scores = models.CharField(max_length=255, db_column='Scores')
    WinningTeamID = models.CharField(max_length=255, blank=True, null=True, db_column='WinningTeamID')

    class Meta:
        managed = False
        db_table = 'GameData'


class PlayerGameSchedule(models.Model):
    PlayerID = models.CharField(max_length=50, primary_key=True)
    GameID = models.CharField(max_length=50)
    GameDate = models.DateTimeField()
    GameLocation = models.CharField(max_length=255, db_column='GameLocation')
    TeamID = models.CharField(max_length=255)

    class Meta:
        managed = False
        db_table = 'PlayerGameSchedule'


class PlayerPracticeSchedule(models.Model):
    PlayerID = models.CharField(max_length=50, primary_key=True, db_column='PlayerID')
    PracticeID = models.CharField(max_length=50, db_column='PracticeID')
    PracticeDate = models.DateTimeField(db_column='PracticeDate')
    FacilityName = models.CharField(max_length=255, db_column='FacilityName')
    FocusArea = models.CharField(max_length=255, db_column='FocusArea')

    class Meta:
        managed = False
        db_table = 'PlayerPracticeSchedule'


class UniversityTeams(models.Model):
    teamname = models.CharField(max_length=255, primary_key=True)
    universityid = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'UniversityTeams'



