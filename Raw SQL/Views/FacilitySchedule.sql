CREATE OR REPLACE VIEW FacilitySchedule AS
SELECT * FROM 
(
SELECT
    FacilityID,
    'Practice' AS EventType,
    PracticeDate AS EventStart,
    PracticeDate + INTERVAL '1' HOUR * (PracticeDuration + 1) AS EventEnd
    
FROM Practices
UNION ALL
SELECT
    FacilityID,
    'Game' AS EventType,
    GameDate AS EventStart,
    GameDate + INTERVAL '1' HOUR * (2 + 1) AS EventEnd  -- Assuming each game lasts 2 hours
FROM Game) ORDER BY FACILITYID, EVENTSTART;