CREATE OR REPLACE VIEW UniversityTeams AS
SELECT 
    t.teamname, 
    u.universityid
FROM 
    team t
JOIN 
    university u ON t.universityid = u.universityid;

select * from UniversityTeams;