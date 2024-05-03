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


