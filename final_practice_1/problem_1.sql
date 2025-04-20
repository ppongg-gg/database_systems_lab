SELECT e.empName, e.empID
FROM employee e
WHERE empID IN (
	SELECT i.empID
	FROM invoice i 
	LEFT JOIN invoice_item it
	ON i.invoiceID = it.invoiceID
	LEFT JOIN product p 
	ON it.pID = p.pid
    WHERE p.name LIKE 'iPad%' OR p.name LIKE 'iPhone%'
)
