-- View
CREATE OR REPLACE VIEW PlayerCoachView AS
SELECT 
    'Player' AS Type,
    p.PlayerID,
    p.Name AS PlayerName,
    p.Major,
    p.DOB,
    p.YearInSchool,
    p.Position,
    t.TeamName AS TeamName,
    u.UniversityName AS UniversityName
FROM 
    Player p
    JOIN Team t ON p.TeamID = t.TeamID
    JOIN University u ON p.UniversityID = u.UniversityID
UNION ALL
SELECT 
    'Coach' AS Type,
    c.CoachID,
    c.Name AS CoachName,
    c.Role,
    NULL AS DOB,
    NULL AS YearInSchool,
    NULL AS Position,
    t.TeamName AS TeamName,
    u.UniversityName AS UniversityName
FROM 
    Coach c
    JOIN Team t ON c.TeamID = t.TeamID
    JOIN University u ON c.UniversityID = u.UniversityID;

select * from playercoachview;