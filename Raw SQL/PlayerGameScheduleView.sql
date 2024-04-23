CREATE OR REPLACE VIEW PlayerGameSchedule AS
SELECT 
    p.PlayerID,
    g.GameID, 
    g.GameDate, 
    g.GameLocation,
    p.TeamID
FROM 
    Player p
JOIN 
    Game g ON (g.HomeTeamID = p.TeamID OR g.AwayTeamID = p.TeamID);

select * from PlayerGameSchedule;