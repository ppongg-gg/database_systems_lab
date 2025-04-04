DELIMITER $$ 
CREATE TRIGGER new_professor_added 
AFTER INSERT ON Professor 
FOR EACH ROW 
BEGIN 
	INSERT INTO Faculty_insurance (ref_id,ins_plan, credit_limit, duedate, s_timestamp, status) 
    VALUES (new.pid, 'Group Insurance for Instructor', 3 * new.salary, DATE_ADD(SYSDATE(), INTERVAL 4 YEAR), SYSDATE(), 'A'); 
    END $$ 
DELIMITER ;