DELIMITER $$

CREATE PROCEDURE Proc_cal_professor_update()
DETERMINISTIC
BEGIN
    DECLARE sub30k_prof_exists BOOLEAN;

    CREATE TEMPORARY TABLE IF NOT EXISTS sub30k_profs AS 
    SELECT DISTINCT pid, salary, credit_limit FROM Professor p LEFT JOIN Faculty_insurance f ON p.pid = f.ref_id WHERE salary < 30000;

    SELECT EXISTS (SELECT 1 FROM sub30k_profs) INTO sub30k_prof_exists;

    IF sub30k_prof_exists THEN
		
        UPDATE Professor 
        SET salary = 1.1 * salary 
        WHERE pid IN (SELECT pid FROM sub30k_profs);

        UPDATE Faculty_insurance f
        JOIN Professor p ON f.ref_id = p.pid
        SET credit_limit = 4 * p.salary
        WHERE ref_id IN (SELECT pid FROM sub30k_profs);

        INSERT INTO system_log (user_log, remark, timestamp) 
        SELECT pid, CONCAT('Old Salary: ',salary,' New Salary: ',1.1 * salary,' Old Credit Limit: ',credit_limit,' New Credit Limit: ',4 * salary), NOW() 
        FROM sub30k_profs;

        SELECT p.pname, s.salary AS old_salary, 1.1 * s.salary AS new_salary, s.credit_limit AS old_credit_limit, 4 * s.salary AS new_credit_limit
		FROM sub30k_profs s
        LEFT JOIN Professor p
        ON s.pid = p.pid;
    ELSE
        SELECT 'No professor earns less than 30,000';
    END IF;

    -- Drop the temporary table
    DROP TEMPORARY TABLE IF EXISTS sub30k_profs;
END $$

DELIMITER ;
