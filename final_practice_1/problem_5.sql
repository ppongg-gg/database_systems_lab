DELIMITER $$ 
CREATE TRIGGER update_customer_point 
AFTER INSERT ON invoice 
FOR EACH ROW 
BEGIN 
	IF (SELECT SUM(salePrice) FROM invoice_item WHERE invoiveID = new.invoiceID) > 1500 THEN
		UPDATE Customer c
		JOIN new
		ON c.cusID = new.cusID
		SET c.point = c.point + 10;
	END IF;
    END $$ 
DELIMITER ;
