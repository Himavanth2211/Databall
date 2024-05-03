CREATE OR REPLACE FUNCTION IsTeamAvailable(
    team_id VARCHAR2,
    desired_date TIMESTAMP,
    duration NUMBER
) RETURN BOOLEAN AS
    count_result NUMBER;
BEGIN
    -- Check for overlaps in both Practices and Games tables where the team is involved
    SELECT COUNT(*)
    INTO count_result
    FROM (
        SELECT PracticeDate AS EventDate, PracticeDuration AS Duration
        FROM Practices
        WHERE TeamID = team_id
        UNION ALL
        SELECT GameDate AS EventDate, 2 AS Duration -- Fixed Constraint - game lasts for 2 hours only
        FROM Game
        WHERE HomeTeamID = team_id OR AwayTeamID = team_id
    )
    WHERE (desired_date BETWEEN EventDate AND EventDate + INTERVAL '1' HOUR * TO_NUMBER(Duration))
    OR (EventDate BETWEEN desired_date AND desired_date + INTERVAL '1' HOUR * TO_NUMBER(duration));

    RETURN (count_result = 0);
END;
