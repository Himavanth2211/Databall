CREATE OR REPLACE VIEW GameData AS
SELECT 
    G.GameID, 
    G.GameDate, 
    G.GameLocation,
    HT.TeamName AS HomeTeam, 
    AT.TeamName AS AwayTeam,
    G.Scores, 
    G.WinningTeamID,
    CASE 
        WHEN G.WinningTeamID IS NOT NULL THEN CAST(G.WinningTeamID AS VARCHAR(255))
        ELSE 'No winning team determined yet.'
    END AS WinningStatus
FROM 
    Game G
INNER JOIN 
    Team HT ON G.HomeTeamID = HT.TeamID
INNER JOIN 
    Team AT ON G.AwayTeamID = AT.TeamID;
    
select * from GameData;
