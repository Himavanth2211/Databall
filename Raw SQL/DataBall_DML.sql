-- Insert data into University
INSERT INTO University (UniversityID, UniversityName, Location) VALUES ('U1001', 'Villanova University', 'Villanova');
INSERT INTO University (UniversityID, UniversityName, Location) VALUES ('U1002', 'Drexel University', 'Philadelphia');
INSERT INTO University (UniversityID, UniversityName, Location) VALUES ('U1003', 'University of Pennsylvania', 'Philadelphia');
INSERT INTO University (UniversityID, UniversityName, Location) VALUES ('U1004', 'Temple University', 'Philadelphia');
INSERT INTO University (UniversityID, UniversityName, Location) VALUES ('U1005', 'University of Delaware', 'Newark');
INSERT INTO university (UNIVERSITYID, UNIVERSITYNAME, LOCATION) 
VALUES ('U1006', 'University of Connecticut', 'Storrs');
INSERT INTO university (UNIVERSITYID, UNIVERSITYNAME, LOCATION) 
VALUES ('U1007', 'Purdue University', 'West Lafayette');
INSERT INTO university (UNIVERSITYID, UNIVERSITYNAME, LOCATION) 
VALUES ('U1008', 'University of Houston', 'Houston');
INSERT INTO university (UNIVERSITYID, UNIVERSITYNAME, LOCATION) 
VALUES ('U1009', 'Arizona State University', 'Phoenix');
INSERT INTO university (UNIVERSITYID, UNIVERSITYNAME, LOCATION) 
VALUES ('U1010', 'Clemson University', 'Clemson');

-- Insert data into Facilities
INSERT INTO Facilities (FacilityID, FacilityName, FacilityLocation, FacilityCapacity, UniversityID) VALUES ('F01', 'Villanova Stadium', 'Campus', 6000, 'U1001');
INSERT INTO Facilities (FacilityID, FacilityName, FacilityLocation, FacilityCapacity, UniversityID) VALUES ('F02', 'Drexel Field', 'Campus', 3500, 'U1002');
INSERT INTO Facilities (FacilityID, FacilityName, FacilityLocation, FacilityCapacity, UniversityID) VALUES ('F03', 'Penn Arena', 'Campus', 2500, 'U1003');
INSERT INTO Facilities (FacilityID, FacilityName, FacilityLocation, FacilityCapacity, UniversityID) VALUES ('F04', 'Temple Track', 'Campus', 1200, 'U1004');
INSERT INTO Facilities (FacilityID, FacilityName, FacilityLocation, FacilityCapacity, UniversityID) VALUES ('F05', 'Delaware Gym', 'Campus', 1800, 'U1005');
INSERT INTO facilities (FACILITYID, FACILITYNAME, FACILITYLOCATION, FACILITYCAPACITY, UNIVERSITYID) 
VALUES ('F06', 'Harry A. Gampel Pavilion', 'Campus', 10300, 'U1006');
INSERT INTO facilities (FACILITYID, FACILITYNAME, FACILITYLOCATION, FACILITYCAPACITY, UNIVERSITYID) 
VALUES ('F07', 'Mackey Complex', 'Campus', 14876, 'U1007');
INSERT INTO facilities (FACILITYID, FACILITYNAME, FACILITYLOCATION, FACILITYCAPACITY, UNIVERSITYID) 
VALUES ('F08', 'Fertitta Center', 'Campus', 7100, 'U1008');
INSERT INTO facilities (FACILITYID, FACILITYNAME, FACILITYLOCATION, FACILITYCAPACITY, UNIVERSITYID) 
VALUES ('F09', 'Desert Financial Arena', 'Campus', 14198, 'U1009');
INSERT INTO facilities (FACILITYID, FACILITYNAME, FACILITYLOCATION, FACILITYCAPACITY, UNIVERSITYID) 
VALUES ('F10', 'Littlejohn Coliseum', 'Campus', 9000, 'U1010');

/*
ALTER TABLE Facilities
ADD FacilityLocation VARCHAR(10);
*/

-- Insert data into Team
INSERT INTO Team (TeamID, TeamName, Division, UniversityID) VALUES ('T01', 'Villanova Wildcats', 'Division A', 'U1001');
INSERT INTO Team (TeamID, TeamName, Division, UniversityID) VALUES ('T02', 'Drexel Dragons', 'Division B', 'U1002');
INSERT INTO Team (TeamID, TeamName, Division, UniversityID) VALUES ('T03', 'Penn Quakers', 'Division C', 'U1003');
INSERT INTO Team (TeamID, TeamName, Division, UniversityID) VALUES ('T04', 'Temple Owls', 'Division D', 'U1004');
INSERT INTO Team (TeamID, TeamName, Division, UniversityID) VALUES ('T05', 'Delaware Fightin� Blue Hens', 'Division E', 'U1005');
INSERT INTO Team (TEAMID, TEAMNAME, DIVISION, UNIVERSITYID) VALUES ('T06', 'UConn Huskies', 'Division A', 'U1006');
INSERT INTO Team (TEAMID, TEAMNAME, DIVISION, UNIVERSITYID) VALUES ('T07', 'Purdue Boilermakers', 'Division B', 'U1007');
INSERT INTO Team (TEAMID, TEAMNAME, DIVISION, UNIVERSITYID) VALUES ('T08', 'Houston Cougars', 'Division C', 'U1008');
INSERT INTO Team (TEAMID, TEAMNAME, DIVISION, UNIVERSITYID) VALUES ('T09', 'Arizona State Sun Devils', 'Division D', 'U1009');
INSERT INTO Team (TEAMID, TEAMNAME, DIVISION, UNIVERSITYID) VALUES ('T10', 'Clemson Tigers', 'Division E', 'U1010');

/*
UPDATE Team
SET Division = 'Division A'
WHERE TeamID = 'T02';

*/
-- Insert data into Coach
INSERT INTO Coach (CoachID, CoachName, CoachRole, TeamID) VALUES ('C01', 'John Doe', 'Head Coach', 'T01');
INSERT INTO Coach (CoachID, CoachName, CoachRole, TeamID) VALUES ('C02', 'Jane Smith', 'Assistant Coach', 'T02');
INSERT INTO Coach (CoachID, CoachName, CoachRole, TeamID) VALUES ('C03', 'Mike Johnson', 'Head Coach', 'T03');
INSERT INTO Coach (CoachID, CoachName, CoachRole, TeamID) VALUES ('C04', 'Emily Davis', 'Assistant Coach', 'T04');
INSERT INTO Coach (CoachID, CoachName, CoachRole, TeamID) VALUES ('C05', 'Alex Taylor', 'Head Coach', 'T05');
INSERT INTO Coach (COACHID, COACHNAME, COACHROLE, TEAMID) VALUES ('C06', 'Dan Hurley', 'Head Coach', 'T06');
INSERT INTO Coach (COACHID, COACHNAME, COACHROLE, TEAMID) VALUES ('C07', 'Matt Painter', 'Head Coach', 'T07');
INSERT INTO Coach (COACHID, COACHNAME, COACHROLE, TEAMID) VALUES ('C08', 'Kelvin Sampson', 'Head Coach', 'T08');
INSERT INTO Coach (COACHID, COACHNAME, COACHROLE, TEAMID) VALUES ('C09', 'Bobby Hurley', 'Head Coach', 'T09');
INSERT INTO Coach (COACHID, COACHNAME, COACHROLE, TEAMID) VALUES ('C10', 'Brad Brownell', 'Head Coach', 'T10');

-- Insert data into Player
INSERT INTO Player (PlayerID, PlayerName, Major, DOB, YearInSchool, TeamID, PlayerPosition) VALUES ('P01', 'Alice Brown', 'Computer Science', TO_DATE('2000-01-01', 'YYYY-MM-DD'), 3, 'T01', 'Forward');
INSERT INTO Player (PlayerID, PlayerName, Major, DOB, YearInSchool, TeamID, PlayerPosition) VALUES ('P02', 'Bob White', 'Mechanical Engineering', TO_DATE('2001-02-02', 'YYYY-MM-DD'), 2, 'T02', 'Goalkeeper');
INSERT INTO Player (PlayerID, PlayerName, Major, DOB, YearInSchool, TeamID, PlayerPosition) VALUES ('P03', 'Carol Green', 'Business', TO_DATE('1999-03-03', 'YYYY-MM-DD'), 4, 'T03', 'Midfielder');
INSERT INTO Player (PlayerID, PlayerName, Major, DOB, YearInSchool, TeamID, PlayerPosition) VALUES ('P04', 'David Black', 'Mathematics', TO_DATE('2002-04-04', 'YYYY-MM-DD'), 1, 'T04', 'Defender');
INSERT INTO Player (PlayerID, PlayerName, Major, DOB, YearInSchool, TeamID, PlayerPosition) VALUES ('P05', 'Eve Gray', 'Physics', TO_DATE('1998-05-05', 'YYYY-MM-DD'), 5, 'T05', 'Striker');
INSERT INTO Player (PLAYERID, PLAYERNAME, MAJOR, DOB, YEARINSCHOOL, TEAMID, PLAYERPOSITION) 
VALUES ('P06', 'Solomon Ball', 'Business Administration', '12-MAR-02', '3', 'T06', 'Gaurd');
INSERT INTO Player (PLAYERID, PLAYERNAME, MAJOR, DOB, YEARINSCHOOL, TEAMID, PLAYERPOSITION) 
VALUES ('P07', 'Mason Gillis', 'MBA', '24-NOV-00', '4', 'T07', 'Forward');
INSERT INTO Player (PLAYERID, PLAYERNAME, MAJOR, DOB, YEARINSCHOOL, TEAMID, PLAYERPOSITION)
VALUES ('P08', 'Jamal Shead', 'Health Science', '24-JUL-02', '4', 'T08', 'Gaurd');
INSERT INTO Player (PLAYERID, PLAYERNAME, MAJOR, DOB, YEARINSCHOOL, TEAMID, PLAYERPOSITION) 
VALUES ('P09', 'Kamari Lands', 'Sport Administration', '22-MAY-03', '2', 'T09', 'Forward');
INSERT INTO Player (PLAYERID, PLAYERNAME, MAJOR, DOB, YEARINSCHOOL, TEAMID, PLAYERPOSITION) 
VALUES ('P10', 'Josh Beadle', 'Sport Administration', '24-JUL-02', '2', 'T10', 'Gaurd');

-- Insert data into Game
INSERT INTO Game (GameID, GameDate, FacilityID, HomeTeamID, AwayTeamID, Scores, WinningTeamID) VALUES ('G01', TO_TIMESTAMP('2024-03-20 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'F01', 'T01', 'T02', '2-0', 'T01');
INSERT INTO Game (GameID, GameDate, FacilityID, HomeTeamID, AwayTeamID, Scores, WinningTeamID) VALUES ('G02', TO_TIMESTAMP('2024-03-21 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'F02', 'T02', 'T03', '1-3', 'T03');
INSERT INTO Game (GameID, GameDate, FacilityID, HomeTeamID, AwayTeamID, Scores, WinningTeamID) VALUES ('G03', TO_TIMESTAMP('2024-03-22 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'F03', 'T03', 'T04', '0-0', 'T03'); -- tie but one team is considered
INSERT INTO Game (GameID, GameDate, FacilityID, HomeTeamID, AwayTeamID, Scores, WinningTeamID) VALUES ('G04', TO_TIMESTAMP('2024-03-23 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'F04', 'T04', 'T05', '4-1', 'T04');
INSERT INTO Game (GameID, GameDate, FacilityID, HomeTeamID, AwayTeamID, Scores, WinningTeamID) VALUES ('G05', TO_TIMESTAMP('2024-03-24 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'F05', 'T05', 'T01', '2-2', 'T05');
INSERT INTO Game (GameID, GameDate, facilityid, HomeTeamID, AwayTeamID, Scores, WinningTeamID) 
VALUES ('G06', TO_TIMESTAMP('2024-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'F06', 'T06', 'T07', '95-82', 'T06');
INSERT INTO Game (GameID, GameDate, facilityid, HomeTeamID, AwayTeamID, Scores, WinningTeamID) 
VALUES ('G07', TO_TIMESTAMP('2024-04-02 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'F07', 'T07', 'T08', '91-96', 'T08');
INSERT INTO Game (GameID, GameDate, facilityid, HomeTeamID, AwayTeamID, Scores, WinningTeamID) 
VALUES ('G08', TO_TIMESTAMP('2024-04-03 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'F08', 'T08', 'T09', '80-91', 'T09');
INSERT INTO Game (GameID, GameDate, facilityid, HomeTeamID, AwayTeamID, Scores, WinningTeamID) 
VALUES ('G09', TO_TIMESTAMP('2024-04-04 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'F09', 'T09', 'T10', '93-99', 'T09');
INSERT INTO Game (GameID, GameDate, facilityid, HomeTeamID, AwayTeamID, Scores, WinningTeamID) 
VALUES ('G10', TO_TIMESTAMP('2024-04-05 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'F10', 'T10', 'T06', '91-100', 'T10');
-- Insert data into Practices

INSERT INTO Practices (PracticeID, PracticeDate, TeamID, PracticeDuration, FocusArea, FacilityID) VALUES ('PR01', TO_TIMESTAMP('2024-03-15 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'T01', 2, 'Offense', 'F01');
INSERT INTO Practices (PracticeID, PracticeDate, TeamID, PracticeDuration, FocusArea, FacilityID) VALUES ('PR02', TO_TIMESTAMP('2024-03-16 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'T02', 1.5, 'Defense', 'F02');
INSERT INTO Practices (PracticeID, PracticeDate, TeamID, PracticeDuration, FocusArea, FacilityID) VALUES ('PR03', TO_TIMESTAMP('2024-03-17 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'T03', 2, 'Tactics', 'F03');
INSERT INTO Practices (PracticeID, PracticeDate, TeamID, PracticeDuration, FocusArea, FacilityID) VALUES ('PR04', TO_TIMESTAMP('2024-03-18 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'T04', 1, 'Strength', 'F04');
INSERT INTO Practices (PracticeID, PracticeDate, TeamID, PracticeDuration, FocusArea, FacilityID) VALUES ('PR05', TO_TIMESTAMP('2024-03-19 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'T05', 2.5, 'Stamina', 'F05');
INSERT INTO Practices (PracticeID, PracticeDate, TeamID, PracticeDuration, FocusArea, FacilityID) 
VALUES ('PR06', TO_TIMESTAMP('2024-04-06 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'T06', '2', 'Offense', 'F06');
INSERT INTO Practices (PracticeID, PracticeDate, TeamID, PracticeDuration, FocusArea, FacilityID) 
VALUES ('PR07', TO_TIMESTAMP('2024-04-07 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'T07', '1', 'Defense', 'F07');
INSERT INTO Practices (PracticeID, PracticeDate, TeamID, PracticeDuration, FocusArea, FacilityID) 
VALUES ('PR08', TO_TIMESTAMP('2024-04-08 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'T08', '2', 'Tactics', 'F08');
INSERT INTO Practices (PracticeID, PracticeDate, TeamID, PracticeDuration, FocusArea, FacilityID) 
VALUES ('PR09', TO_TIMESTAMP('2024-04-09 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'T09', '1', 'Strength', 'F09');
INSERT INTO Practices (PracticeID, PracticeDate, TeamID, PracticeDuration, FocusArea, FacilityID) 
VALUES ('PR10', TO_TIMESTAMP('2024-04-10 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'T10', '2', 'Stamina', 'F10');

-- ALTER TABLE Practices MODIFY (PracticeDuration NUMBER);
