CREATE OR REPLACE FUNCTION ValidateWinningTeam(
    game_id IN VARCHAR2,
    winning_team_id IN VARCHAR2
) RETURN BOOLEAN AS
    v_HomeTeamID VARCHAR2(20);
    v_AwayTeamID VARCHAR2(20);
BEGIN
    SELECT HomeTeamID, AwayTeamID INTO v_HomeTeamID, v_AwayTeamID
    FROM Game
    WHERE GameID = game_id;

    IF winning_team_id IS NOT NULL AND winning_team_id IN (v_HomeTeamID, v_AwayTeamID) THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
