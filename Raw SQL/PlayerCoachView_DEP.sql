-- View
CREATE OR REPLACE VIEW PlayerCoachView AS
SELECT 
    'Player' AS Type,
    p.PlayerID,
    p.PlayerName AS "Player Name",
    p.Major,
    p.DOB,
    p.YearInSchool,
    p.PlayerPosition,
    t.TeamName AS "Team Name",
    u.UniversityName AS "University Name"
FROM 
    Player p
    JOIN Team t ON p.TeamID = t.TeamID
    JOIN University u ON p.UniversityID = u.UniversityID
UNION ALL
SELECT 
    'Coach' AS Type,
    c.CoachID,
    c.CoachName AS "Coach Name",
    c.CoachRole AS "Coach Role",
    NULL AS DOB,
    NULL AS "Year In School",
    NULL AS "Coach Position",
    t.TeamName AS "Team Name",
    u.UniversityName AS "University Name"
FROM 
    Coach c
    JOIN Team t ON c.TeamID = t.TeamID
    JOIN University u ON c.UniversityID = u.UniversityID;

select * from playercoachview;