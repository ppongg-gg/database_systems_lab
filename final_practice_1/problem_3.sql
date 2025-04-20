DELIMITER $$ 
CREATE FUNCTION calculate_cost(n varchar(150))
RETURNS double DETERMINISTIC 
BEGIN 
	DECLARE result double; 
    SET result = (
		SELECT SUM(salePrice - discount)
        FROM invoice_item 
        WHERE invoiceID IN (
			SELECT invoiceID
            FROM invoice
            WHERE empID =  (
				SELECT empID
                FROM Employee
                WHERE empName = n
            )
        )
    );
    IF result IS NULL THEN
	SET result = 0;
    END IF;
    RETURN result; 
END $$ 
DELIMITER ;
