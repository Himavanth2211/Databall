--UserStory2
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

    -- If the facility is booked, set an error message
    IF NOT facility_available THEN
        p_Message := 'The facility is already booked for the given time!';
    ELSE
        BEGIN
            -- Insert the new practice session
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
            -- Handle any exceptions during the insert operation
            WHEN OTHERS THEN
                p_Message := 'Database error: ' || SQLERRM;
        END;
    END IF;

    -- Commit the transaction if all goes well
    COMMIT;
EXCEPTION
    -- Rollback and report any errors during the transaction
    WHEN OTHERS THEN
        p_Message := 'Transaction error: ' || SQLERRM;
        ROLLBACK;
END;


