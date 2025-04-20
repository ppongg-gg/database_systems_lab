DELIMITER $$

CREATE PROCEDURE Midyear_point_bonus()
DETERMINISTIC
BEGIN

    CREATE TEMPORARY TABLE IF NOT EXISTS cus_invoice_counts (cusID char(10), invoice_count int);
	
    TRUNCATE TABLE cus_invoice_counts;
    INSERT INTO cus_invoice_counts (cusID, invoice_count)
    SELECT cusID, COUNT(*)
    FROM Invoice
    WHERE cusID IN (SELECT cusID FROM Customer WHERE point < 1000)
    GROUP BY cusID;
    
    UPDATE Customer c
    JOIN cus_invoice_counts cic ON c.cusID = cic.cusID
    SET c.point = c.point + 66 * cic.invoice_count;
    
    INSERT INTO System_log (remark, System_date)
    SELECT CONCAT(c.cusID, 'points increase to ', point), DAY(NOW())
    FROM Customer c
    JOIN cus_invoice_counts cic ON c.cusID = cic.cusID;
	
    DROP TEMPORARY TABLE IF EXISTS cus_invoice_counts;
END $$

DELIMITER ;