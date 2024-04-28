CREATE OR REPLACE PROCEDURE UpdateGameDetails(
    game_id IN VARCHAR2,
    winning_team_id IN VARCHAR2,
    scores IN VARCHAR2,
    p_message OUT VARCHAR2
)
AS
    v_HomeTeamID VARCHAR2(255);
    v_AwayTeamID VARCHAR2(255);
BEGIN
    SELECT HomeTeamID, AwayTeamID INTO v_HomeTeamID, v_AwayTeamID
    FROM Game
    WHERE GameID = game_id;

    -- Validate the winning team ID
    IF winning_team_id IS NOT NULL AND winning_team_id NOT IN (v_HomeTeamID, v_AwayTeamID) THEN
        p_message := 'Error: Winning team must be either the home team or the away team.';
        RETURN;
    END IF;
    
    -- Update the Game table with the provided details
    UPDATE Game
    SET WinningTeamID = winning_team_id,
        Scores = scores
    WHERE GameID = game_id;

    -- Commit the transaction
    COMMIT;

    -- Set success message
    p_message := 'Game details updated successfully.';
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_message := 'Game not found.';
    WHEN OTHERS THEN
        p_message := 'An error occurred while updating game details.';
END;
