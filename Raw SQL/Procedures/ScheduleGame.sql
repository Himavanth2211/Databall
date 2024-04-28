CREATE SEQUENCE Game_seq
    START WITH 1
    INCREMENT BY 1
    NOMAXVALUE;

CREATE OR REPLACE PROCEDURE ScheduleGame(
    p_HomeTeamID VARCHAR2,
    p_AwayTeamID VARCHAR2,
    p_GameDate TIMESTAMP,
    p_GameDuration NUMBER,
    p_FacilityID VARCHAR2,
    p_Scores VARCHAR2 DEFAULT NULL,  
    p_WinningTeamID VARCHAR2 DEFAULT NULL,  
    p_Message OUT VARCHAR2
) AS
    v_count NUMBER;
BEGIN
    IF p_WinningTeamID IS NOT NULL AND p_WinningTeamID NOT IN (p_HomeTeamID, p_AwayTeamID) THEN
        p_Message := 'Error: Winning team must be either the home team or the away team.';
        RETURN;
    END IF;
    
    IF p_HomeTeamID = p_AwayTeamID THEN
        p_Message := 'Error: Home team and away team cannot be the same.';
        RETURN;
    END IF;
    
    SELECT COUNT(*)
    INTO v_count
    FROM Game
    WHERE FacilityID = p_FacilityID
    AND (p_GameDate BETWEEN GameDate AND GameDate + INTERVAL '1' HOUR * p_GameDuration);

    IF v_count > 0 THEN
        p_Message := 'The facility is already booked for the given time.';
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
/

