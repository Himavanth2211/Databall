CREATE OR REPLACE PROCEDURE IncreaseFacilityCapacity(
    facility_id IN VARCHAR2,
    increase_amount IN NUMBER,
    p_Message OUT VARCHAR2
)
AS
    current_capacity NUMBER;
BEGIN
    -- Retrieve the current capacity of the facility
    SELECT FacilityCapacity INTO current_capacity
    FROM Facilities
    WHERE FacilityID = facility_id;

    -- Increase the capacity by the given amount
    current_capacity := current_capacity + increase_amount;

    -- Update the facility with the new capacity
    UPDATE Facilities
    SET FacilityCapacity = current_capacity
    WHERE FacilityID = facility_id;

    -- Commit the transaction
    COMMIT;

    -- Output success message
    p_Message := 'Facility capacity increased successfully.';

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_Message := 'Facility not found.';
        ROLLBACK; -- Optional rollback if you decide to maintain transaction integrity on failure
    WHEN OTHERS THEN
        p_Message := 'An error occurred while increasing facility capacity: ' || SQLERRM;
        ROLLBACK;
END;
