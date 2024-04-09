/* LET'S Dig into the open source Chinook Database, the ER diagram can be found in the repo */

SELECT  CUSTOMERID, CITY,
        COUNT(CUSTOMERID) AS CNT
FROM CUSTOMERS
    GROUP BY CITY
    HAVING CNT=2
    ORDER BY CNT DESC;


-- date and time
SELECT 
    EmployeeId,
    FirstName,
    LastName,
    HireDate,
    STRFTIME('%Y',  HireDate) as past,
    STRFTIME('%d', HireDate),
    STRFTIME('%Y', 'now') as present,
    STRFTIME('%Y', 'now') - STRFTIME('%Y',  HireDate) as years
    
FROM 
    Employees
    WHERE years >=15
    ORDER BY 
    LastName ASC;



-- all the invoices from the billing 3 cities and sorting by invoice ID
SELECT BillingCity, invoiceID, TOTAL
FROM 
    Invoices
    WHERE BillingCity = 'Brasília' OR BillingCity = 'Edmonton' OR BillingCity = 'Vancouver'
    ORDER BY invoiceID Desc;



-- concatenating the names and order by the invoiceID
SELECT
    Customers.FirstName || ' ' || Customers.LastName || ' - ' || INVOICES.InvoiceId AS CustomerInvoiceID
FROM
    Customers
INNER JOIN INVOICES ON Customers.CUSTOMERID = INVOICES.CUSTOMERID
ORDER BY
    FirstName,
    LastName,
    InvoiceId;

