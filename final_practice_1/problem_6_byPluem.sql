SELECT DISTINCT
    e.empID
FROM
    employee e
        JOIN
    invoice i ON e.empID = i.empID
        JOIN
    invoice_item it ON i.invoiceID = it.invoiceID
WHERE
    1 < (SELECT 
            COUNT(*)
        FROM
            invoice i2
        WHERE
            i2.empID = i.empID)
GROUP BY it.invoiceID , e.empID
HAVING COUNT(DISTINCT it.itemNO) > 3;