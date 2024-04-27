CREATE OR REPLACE VIEW GameData AS
SELECT 
    G.GameID, 
    G.GameDate, 
    F.FacilityName AS GameLocation, -- Using FacilityName to represent the game location
    HT.TeamName AS HomeTeam, 
    AT.TeamName AS AwayTeam,
    G.Scores, 
    G.WinningTeamID,
    CASE 
        WHEN G.WinningTeamID IS NOT NULL THEN (SELECT T.TeamName FROM Team T WHERE T.TeamID = G.WinningTeamID)
        ELSE 'No winning team determined yet.'
    END AS WinningStatus
FROM 
    Game G
INNER JOIN 
    Team HT ON G.HomeTeamID = HT.TeamID
INNER JOIN 
    Team AT ON G.AwayTeamID = AT.TeamID
INNER JOIN
    Facilities F ON G.FacilityID = F.FacilityID;  -- Joining the Facilities table to get the name of the facility as the location

-- To use the view:
SELECT * FROM GameData;
