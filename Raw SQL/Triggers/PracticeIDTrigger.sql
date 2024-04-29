CREATE OR REPLACE TRIGGER Practices_Before_Insert
BEFORE INSERT ON Practices
FOR EACH ROW
BEGIN
    :NEW.PracticeID := 'PR' || TO_CHAR(Practices_seq.NEXTVAL);
END;
