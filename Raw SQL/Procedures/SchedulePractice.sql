CREATE SEQUENCE Practices_seq START WITH 21 INCREMENT BY 1 NOMAXVALUE;

create or replace PROCEDURE SchedulePractice(
    p_TeamID VARCHAR2,
    p_PracticeDate TIMESTAMP,
    p_PracticeDuration VARCHAR2,
    p_FocusArea VARCHAR2,
    p_FacilityID VARCHAR2,
    p_Message OUT VARCHAR2
) AS
    facility_available BOOLEAN;
BEGIN
    facility_available := CheckFacilityAvailability(p_FacilityID, p_PracticeDate, TO_NUMBER(p_PracticeDuration));

    -- If the facility is booked
    IF NOT facility_available THEN
        p_Message := 'The facility is already booked for the given time!';
    ELSE
        BEGIN
            -- Insert
            INSERT INTO Practices (
                PracticeDate,
                TeamID,
                PracticeDuration,
                FocusArea,
                FacilityID
            ) VALUES (
                p_PracticeDate,
                p_TeamID,
                p_PracticeDuration,
                p_FocusArea,
                p_FacilityID
            );
            p_Message := 'Practice scheduled successfully.';
        EXCEPTION
            WHEN OTHERS THEN
                p_Message := 'Database error: ' || SQLERRM;
        END;
    END IF;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        p_Message := 'Transaction error: ' || SQLERRM;
        ROLLBACK;
END;


