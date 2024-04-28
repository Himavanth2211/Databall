--UserStory2
CREATE SEQUENCE Practices_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE PROCEDURE SchedulePractice(
    p_TeamID VARCHAR2,
    p_PracticeDate TIMESTAMP,
    p_PracticeDuration VARCHAR2,
    p_FocusArea VARCHAR2,
    p_FacilityID VARCHAR2,
    p_Message OUT VARCHAR2
) AS
    v_count NUMBER;
BEGIN
    -- Check for existing bookings within the desired timeframe
    SELECT COUNT(*)
    INTO v_count
    FROM Practices
    WHERE FacilityID = p_FacilityID
    AND (p_PracticeDate BETWEEN PracticeDate AND PracticeDate + INTERVAL '1' HOUR * TO_NUMBER(p_PracticeDuration));

    -- If the facility is booked, set an error message
    IF v_count > 0 THEN
        p_Message := 'The facility is already booked for the given time.';
    ELSE
        BEGIN
            -- Insert the new practice session
            INSERT INTO Practices (
                PracticeID,
                PracticeDate,
                TeamID,
                PracticeDuration,
                FocusArea,
                FacilityID
            ) VALUES (
                'PR' || TO_CHAR(Practices_seq.NEXTVAL, 'FM0000'),
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
/

