CREATE OR REPLACE VIEW PlayerGameSchedule AS
SELECT 
    p.PlayerID,
    g.GameID, 
    g.GameDate,
    f.FacilityName AS GameLocation, -- Using FacilityName as the game location
    p.TeamID
FROM 
    Player p
JOIN 
    Game g ON (g.HomeTeamID = p.TeamID OR g.AwayTeamID = p.TeamID)
JOIN 
    Facilities f ON g.FacilityID = f.FacilityID; -- Joining the Facilities table to get the name of the facility


select * from PlayerGameSchedule;