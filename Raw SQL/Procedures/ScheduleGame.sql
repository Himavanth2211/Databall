CREATE SEQUENCE Game_seq
    START WITH 1
    INCREMENT BY 1
    NOMAXVALUE;

create or replace PROCEDURE ScheduleGame(
    p_HomeTeamID VARCHAR2,
    p_AwayTeamID VARCHAR2,
    p_GameDate TIMESTAMP,
    p_FacilityID VARCHAR2,
    p_Scores VARCHAR2 DEFAULT NULL,  
    p_WinningTeamID VARCHAR2 DEFAULT NULL,  
    p_Message OUT VARCHAR2
) AS
    facility_available BOOLEAN;
BEGIN
    IF p_HomeTeamID = p_AwayTeamID THEN
        p_Message := 'Error: Home team and away team cannot be the same.';
        RETURN;
    END IF;
    
    IF p_WinningTeamID IS NOT NULL AND p_WinningTeamID NOT IN (p_HomeTeamID, p_AwayTeamID) THEN
        p_Message := 'Error: Winning team must be either the home team or the away team.';
        RETURN;
    END IF;

    IF NOT IsTeamAvailable(p_HomeTeamID, p_GameDate, 2) OR NOT IsTeamAvailable(p_AwayTeamID, p_GameDate, 2) THEN
        p_Message := 'One of the teams is already booked for another game or practice at this time.';
        RETURN;
    END IF;
    
    facility_available := CheckFacilityAvailability(p_FacilityID, p_GameDate, 2);
    
    IF NOT facility_available THEN
        p_Message := 'The facility is already booked for the given time! Please check facility schedules for exisitng bookings.';
    ELSE

        INSERT INTO Game (
            GameID,
            GameDate,
            HomeTeamID,
            AwayTeamID,
            FacilityID,
            Scores,
            WinningTeamID
        ) VALUES (
            'G' || TO_CHAR(Game_seq.NEXTVAL, 'FM0000'),
            p_GameDate,
            p_HomeTeamID,
            p_AwayTeamID,
            p_FacilityID,
            p_Scores, 
            p_WinningTeamID  
        );
        p_Message := 'Game scheduled successfully.';
    END IF;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        p_Message := 'Error: ' || SQLERRM;
        ROLLBACK;
END;
