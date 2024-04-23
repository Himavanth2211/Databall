CREATE OR REPLACE VIEW PlayerPracticeSchedule AS
SELECT 
    p.PlayerID,
    pr.PracticeID, 
    pr.PracticeDate, 
    f.FACILITYNAME AS FacilityName, 
    pr.FocusArea,
    p.TeamID
FROM 
    Player p
JOIN 
    Practices pr ON p.TeamID = pr.TeamID
JOIN 
    Facilities f ON pr.FacilityID = f.FacilityID;
    
select * from PlayerPracticeSchedule;
