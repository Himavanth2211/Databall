--UserStory2
CREATE SEQUENCE Practices_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE PROCEDURE SchedulePractice(
    p_TeamID VARCHAR2,
    p_PracticeDate TIMESTAMP,
    p_PracticeDuration VARCHAR2,
    p_FocusArea VARCHAR2,
    p_UniversityID VARCHAR2,
    p_FacilityID VARCHAR2,
    p_Message OUT VARCHAR2
) AS
    v_count NUMBER;
BEGIN

    SELECT COUNT(*)
    INTO v_count
    FROM Practices
    WHERE FacilityID = p_FacilityID
    AND (p_PracticeDate BETWEEN PracticeDate AND PracticeDate + INTERVAL '1' HOUR * TO_NUMBER(p_PracticeDuration));

    
    IF v_count > 0 THEN
        p_Message := 'The facility is already booked for the given time.';
    ELSE
        BEGIN
            INSERT INTO Practices (
                PracticeID,
                PracticeDate,
                TeamID,
                PracticeDuration,
                FocusArea,
                UniversityID,
                FacilityID
            ) VALUES (
                'PR' || TO_CHAR(Practices_seq.NEXTVAL, 'FM0000'),
                p_PracticeDate,
                p_TeamID,
                p_PracticeDuration,
                p_FocusArea,
                p_UniversityID,
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
/



SET SERVEROUTPUT ON;
--Execute
BEGIN
    SchedulePractice(
        'T01',
        TO_TIMESTAMP('2024-03-15 09:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        '2',
        'Offense',
        'U1001',
        'F01',
    );
END;

