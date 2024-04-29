CREATE OR REPLACE PROCEDURE UpdateGameDetails(
    game_id IN VARCHAR2,
    winning_team_id IN VARCHAR2,
    p_scores IN VARCHAR2,
    p_message OUT VARCHAR2
)

AS
    validWinningTeam BOOLEAN;
BEGIN
    validWinningTeam := ValidateWinningTeam(game_id, winning_team_id);
    -- Validate the winning team ID
    IF NOT validWinningTeam THEN
        p_message := 'Error: Winning team must be either the home team or the away team.';
        RETURN;
    END IF;

    UPDATE Game
    SET WinningTeamID= winning_team_id,
    Scores = p_scores
    WHERE GameID = game_id;
    COMMIT;


    p_message := 'Game details updated successfully.';
END;
