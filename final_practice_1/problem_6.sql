SELECT *
FROM employee
WHERE empID IN (
	SELECT empID
    FROM (
		SELECT *
        FROM invoice
        WHERE invoiceID IN (
			SELECT invoiceID
            FROM invoice_item
            GROUP BY invoiceID
            HAVING COUNT(*) > 3
        )
    ) t
    GROUP BY empID
    HAVING COUNT(DISTINCT empID) >= 2
)