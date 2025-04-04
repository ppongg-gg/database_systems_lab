DELIMITER $$ 
CREATE FUNCTION fn_currency(input_number FLOAT, exchange_rate FLOAT, currency_name VARCHAR(50))
RETURNS varchar(50) DETERMINISTIC 
BEGIN 
	DECLARE result varchar(50); 
    SET result = CONCAT(input_number / exchange_rate, ' ', currency_name); 
    RETURN result; 
END $$ 
DELIMITER ;