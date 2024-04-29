-- Create University Table
CREATE TABLE University (
    UniversityID VARCHAR2(255) PRIMARY KEY,
    UniversityName VARCHAR2(255) NOT NULL,
    Location VARCHAR2(255) NOT NULL
);

-- Create Facilities Table
CREATE TABLE Facilities (
    FacilityID VARCHAR2(255) PRIMARY KEY,
    FacilityName VARCHAR2(255) NOT NULL,
    FacilityLocation VARCHAR2(255) NOT NULL,
    FacilityCapacity NUMBER,
    UniversityID VARCHAR2(255) NOT NULL,
    CONSTRAINT fk_Facilities_University FOREIGN KEY (UniversityID)
      REFERENCES University (UniversityID)
);

-- Create Team Table
CREATE TABLE Team (
    TeamID VARCHAR2(255) PRIMARY KEY,
    TeamName VARCHAR2(255) NOT NULL,
    Division VARCHAR2(255),
    UniversityID VARCHAR2(255) NOT NULL,
    CONSTRAINT fk_Team_University FOREIGN KEY (UniversityID)
      REFERENCES University (UniversityID)
);

-- Create Coach Table
CREATE TABLE Coach (
    CoachID VARCHAR2(255) PRIMARY KEY,
    CoachName VARCHAR2(255) NOT NULL,
    CoachRole VARCHAR2(255),
    TeamID VARCHAR2(255) NOT NULL,
    CONSTRAINT fk_Coach_Team FOREIGN KEY (TeamID)
      REFERENCES Team (TeamID)
);

-- Create Player Table
CREATE TABLE Player (
    PlayerID VARCHAR2(255) PRIMARY KEY,
    PlayerName VARCHAR2(255) NOT NULL,
    Major VARCHAR2(255),
    DOB DATE,
    YearInSchool NUMBER,
    TeamID VARCHAR2(255) NOT NULL,
    PlayerPosition VARCHAR2(255),
    CONSTRAINT fk_Player_Team FOREIGN KEY (TeamID)
      REFERENCES Team (TeamID)
);

-- Create Game Table
CREATE TABLE Game (
    GameID VARCHAR2(255) PRIMARY KEY,
    GameDate TIMESTAMP NOT NULL,
    FacilityID VARCHAR2(255) NOT NULL,
    HomeTeamID VARCHAR2(255) NOT NULL,
    AwayTeamID VARCHAR2(255) NOT NULL,
    Scores VARCHAR2(255), -- '3-4' 3 is home team score, 4 is away team score
    WinningTeamID VARCHAR2(255),
    CONSTRAINT fk_Game_HomeTeam FOREIGN KEY (HomeTeamID)
      REFERENCES Team (TeamID),
    CONSTRAINT fk_Game_AwayTeam FOREIGN KEY (AwayTeamID)
      REFERENCES Team (TeamID),
    CONSTRAINT fk_Game_Facility FOREIGN KEY (FacilityID)
      REFERENCES Facilities (FacilityID),
    CONSTRAINT fk_Game_WinningTeam FOREIGN KEY (WinningTeamID)
      REFERENCES Team (TeamID)
);

-- Create Practices Table
CREATE TABLE Practices (
    PracticeID VARCHAR2(255) PRIMARY KEY,
    PracticeDate TIMESTAMP NOT NULL,
    TeamID VARCHAR2(255) NOT NULL,
    PracticeDuration NUMBER,
    FocusArea VARCHAR2(255),
    FacilityID VARCHAR2(255) NOT NULL,
    CONSTRAINT fk_Practices_Team FOREIGN KEY (TeamID)
      REFERENCES Team (TeamID),
    CONSTRAINT fk_Practices_Facility FOREIGN KEY (FacilityID)
      REFERENCES Facilities (FacilityID)
);


-- Insert data into University
INSERT INTO University (UniversityID, UniversityName, Location) VALUES ('U1001', 'Villanova University', 'Villanova');
INSERT INTO University (UniversityID, UniversityName, Location) VALUES ('U1002', 'Drexel University', 'Philadelphia');
INSERT INTO University (UniversityID, UniversityName, Location) VALUES ('U1003', 'University of Pennsylvania', 'Philadelphia');
INSERT INTO University (UniversityID, UniversityName, Location) VALUES ('U1004', 'Temple University', 'Philadelphia');
INSERT INTO University (UniversityID, UniversityName, Location) VALUES ('U1005', 'University of Delaware', 'Newark');

-- Insert data into Facilities
INSERT INTO Facilities (FacilityID, FacilityName, FacilityLocation, FacilityCapacity, UniversityID) VALUES ('F01', 'Villanova Stadium', 'Campus', 6000, 'U1001');
INSERT INTO Facilities (FacilityID, FacilityName, FacilityLocation, FacilityCapacity, UniversityID) VALUES ('F02', 'Drexel Field', 'Campus', 3500, 'U1002');
INSERT INTO Facilities (FacilityID, FacilityName, FacilityLocation, FacilityCapacity, UniversityID) VALUES ('F03', 'Penn Arena', 'Campus', 2500, 'U1003');
INSERT INTO Facilities (FacilityID, FacilityName, FacilityLocation, FacilityCapacity, UniversityID) VALUES ('F04', 'Temple Track', 'Campus', 1200, 'U1004');
INSERT INTO Facilities (FacilityID, FacilityName, FacilityLocation, FacilityCapacity, UniversityID) VALUES ('F05', 'Delaware Gym', 'Campus', 1800, 'U1005');

-- Insert data into Team
INSERT INTO Team (TeamID, TeamName, Division, UniversityID) VALUES ('T01', 'Villanova Wildcats', 'Division A', 'U1001');
INSERT INTO Team (TeamID, TeamName, Division, UniversityID) VALUES ('T02', 'Drexel Dragons', 'Division B', 'U1002');
INSERT INTO Team (TeamID, TeamName, Division, UniversityID) VALUES ('T03', 'Penn Quakers', 'Division C', 'U1003');
INSERT INTO Team (TeamID, TeamName, Division, UniversityID) VALUES ('T04', 'Temple Owls', 'Division D', 'U1004');
INSERT INTO Team (TeamID, TeamName, Division, UniversityID) VALUES ('T05', 'Delaware Fightin’ Blue Hens', 'Division E', 'U1005');

-- Insert data into Coach
INSERT INTO Coach (CoachID, CoachName, CoachRole, TeamID) VALUES ('C01', 'John Doe', 'Head Coach', 'T01');
INSERT INTO Coach (CoachID, CoachName, CoachRole, TeamID) VALUES ('C02', 'Jane Smith', 'Assistant Coach', 'T02');
INSERT INTO Coach (CoachID, CoachName, CoachRole, TeamID) VALUES ('C03', 'Mike Johnson', 'Head Coach', 'T03');
INSERT INTO Coach (CoachID, CoachName, CoachRole, TeamID) VALUES ('C04', 'Emily Davis', 'Assistant Coach', 'T04');
INSERT INTO Coach (CoachID, CoachName, CoachRole, TeamID) VALUES ('C05', 'Alex Taylor', 'Head Coach', 'T05');

-- Insert data into Player
INSERT INTO Player (PlayerID, PlayerName, Major, DOB, YearInSchool, TeamID, PlayerPosition) VALUES ('P01', 'Alice Brown', 'Computer Science', TO_DATE('2000-01-01', 'YYYY-MM-DD'), 3, 'T01', 'Forward');
INSERT INTO Player (PlayerID, PlayerName, Major, DOB, YearInSchool, TeamID, PlayerPosition) VALUES ('P02', 'Bob White', 'Mechanical Engineering', TO_DATE('2001-02-02', 'YYYY-MM-DD'), 2, 'T02', 'Goalkeeper');
INSERT INTO Player (PlayerID, PlayerName, Major, DOB, YearInSchool, TeamID, PlayerPosition) VALUES ('P03', 'Carol Green', 'Business', TO_DATE('1999-03-03', 'YYYY-MM-DD'), 4, 'T03', 'Midfielder');
INSERT INTO Player (PlayerID, PlayerName, Major, DOB, YearInSchool, TeamID, PlayerPosition) VALUES ('P04', 'David Black', 'Mathematics', TO_DATE('2002-04-04', 'YYYY-MM-DD'), 1, 'T04', 'Defender');
INSERT INTO Player (PlayerID, PlayerName, Major, DOB, YearInSchool, TeamID, PlayerPosition) VALUES ('P05', 'Eve Gray', 'Physics', TO_DATE('1998-05-05', 'YYYY-MM-DD'), 5, 'T05', 'Striker');

-- Insert data into Game
INSERT INTO Game (GameID, GameDate, FacilityID, HomeTeamID, AwayTeamID, Scores, WinningTeamID) VALUES ('G01', TO_TIMESTAMP('2024-03-20 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'F01', 'T01', 'T02', '2-0', 'T01');
INSERT INTO Game (GameID, GameDate, FacilityID, HomeTeamID, AwayTeamID, Scores, WinningTeamID) VALUES ('G02', TO_TIMESTAMP('2024-03-21 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'F02', 'T02', 'T03', '1-3', 'T03');
INSERT INTO Game (GameID, GameDate, FacilityID, HomeTeamID, AwayTeamID, Scores, WinningTeamID) VALUES ('G03', TO_TIMESTAMP('2024-03-22 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'F03', 'T03', 'T04', '0-0', 'T03'); -- tie but one team is considered
INSERT INTO Game (GameID, GameDate, FacilityID, HomeTeamID, AwayTeamID, Scores, WinningTeamID) VALUES ('G04', TO_TIMESTAMP('2024-03-23 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'F04', 'T04', 'T05', '4-1', 'T04');
INSERT INTO Game (GameID, GameDate, FacilityID, HomeTeamID, AwayTeamID, Scores, WinningTeamID) VALUES ('G05', TO_TIMESTAMP('2024-03-24 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'F05', 'T05', 'T01', '2-2', 'T05');

-- Insert data into Practices
INSERT INTO Practices (PracticeID, PracticeDate, TeamID, PracticeDuration, FocusArea, FacilityID) VALUES ('PR01', TO_TIMESTAMP('2024-03-15 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'T01', 2, 'Offense', 'F01');
INSERT INTO Practices (PracticeID, PracticeDate, TeamID, PracticeDuration, FocusArea, FacilityID) VALUES ('PR02', TO_TIMESTAMP('2024-03-16 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'T02', 1.5, 'Defense', 'F02');
INSERT INTO Practices (PracticeID, PracticeDate, TeamID, PracticeDuration, FocusArea, FacilityID) VALUES ('PR03', TO_TIMESTAMP('2024-03-17 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'T03', 2, 'Tactics', 'F03');
INSERT INTO Practices (PracticeID, PracticeDate, TeamID, PracticeDuration, FocusArea, FacilityID) VALUES ('PR04', TO_TIMESTAMP('2024-03-18 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'T04', 1, 'Strength', 'F04');
INSERT INTO Practices (PracticeID, PracticeDate, TeamID, PracticeDuration, FocusArea, FacilityID) VALUES ('PR05', TO_TIMESTAMP('2024-03-19 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'T05', 2.5, 'Stamina', 'F05');



--Drops
DROP TABLE Practices;
DROP TABLE Game;
DROP TABLE Player;
DROP TABLE Coach;
DROP TABLE Team;
DROP TABLE Facilities;
DROP TABLE University;


--test join
SELECT 
    p.PlayerID,
    p.PlayerName AS PlayerName,
    p.PlayerPosition,
    t.TeamName,
    u.UniversityName
FROM 
    Player p
    JOIN Team t ON p.TeamID = t.TeamID;


