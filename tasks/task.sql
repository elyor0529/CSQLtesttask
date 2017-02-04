/*
			------------------------------------------------	
      |				VARIABLE DECLARATIONS	              		|
			------------------------------------------------
*/
DECLARE @company AS INT;
DECLARE @customer AS INT;

/*
			------------------------------------------------	
			|				SET ONE TIME VALUES	              			|
			------------------------------------------------
*/
SET @company = 1;
SET @customer = 1;

/*
			------------------------------------------------	
			|				POPULATE THE TABLE			              	|
			------------------------------------------------	
*/
--1) Find all customers of the specified company.
SELECT  c.FullName AS [Customer]
FROM    dbo.Customer AS c
        INNER JOIN dbo.ServiceInCustomer AS sc ON sc.CustomerId = c.Id
        INNER JOIN dbo.Service AS s ON s.Id = sc.ServiceId
        INNER JOIN dbo.Company AS cp ON cp.Id = s.CompanyId
WHERE   cp.Id = @company
ORDER BY c.FullName ASC;

--2) Find all companies that provide services to the specified customer.
SELECT  cp.Name AS [Company]
FROM    dbo.Company AS cp
        INNER JOIN dbo.Service AS s ON s.CompanyId = cp.Id
        INNER JOIN dbo.ServiceInCustomer AS sc ON sc.ServiceId = s.Id
        INNER JOIN dbo.Customer AS c ON c.Id = sc.CustomerId
WHERE   c.Id = @customer
ORDER BY cp.Name ASC;

--3) For the giving customer find all services and companies that provide them.
SELECT  cp.Name AS [Company] ,
        s.Name AS [Service]
FROM    dbo.Service AS s
        INNER JOIN dbo.Company AS cp ON cp.Id = s.CompanyId
        INNER JOIN dbo.ServiceInCustomer AS sc ON sc.ServiceId = s.Id
        INNER JOIN dbo.Customer AS c ON c.Id = sc.CustomerId
WHERE   c.Id = @customer
ORDER BY cp.Name ,
        s.Name ASC;

--4) Find clients that do not consume any service.
SELECT  c.FullName AS [Customer]
FROM    dbo.Customer AS c
        INNER JOIN dbo.ServiceInCustomer AS sc ON sc.CustomerId = c.Id
WHERE   sc.ServiceId IS NULL;

--5) Find all clients that consume S ​1​ or S ​2​ services.
SELECT  c.FullName AS [Customer]
FROM    dbo.Customer AS c
WHERE   c.Id IN ( SELECT    sc.CustomerId
                  FROM      dbo.ServiceInCustomer AS sc
                            INNER JOIN dbo.Service AS s ON s.Id = sc.ServiceId
                  WHERE     s.Name = 'S1'
                            OR s.Name = 'S2'
                  GROUP BY  sc.CustomerId )
ORDER BY c.FullName ASC; 

--6) Find all clients that consume S ​1​ ​and​ ​S ​2​ services. 
SELECT  c.FullName AS [Customer]
FROM    dbo.Customer AS c
WHERE   c.Id IN ( SELECT    sc.CustomerId
                  FROM      dbo.ServiceInCustomer AS sc
                            INNER JOIN dbo.Service AS s ON s.Id = sc.ServiceId
                  WHERE     s.Name = 'S1'
                  GROUP BY  sc.CustomerId )
        OR c.Id IN ( SELECT sc.CustomerId
                     FROM   dbo.ServiceInCustomer AS sc
                            INNER JOIN dbo.Service AS s ON s.Id = sc.ServiceId
                     WHERE  s.Name = 'S2'
                     GROUP BY sc.CustomerId )
ORDER BY c.FullName ASC; 

--7) Find all clients that consume only S ​1​ ​and​ ​S ​2​ services.
SELECT  c.FullName AS [Customer]
FROM    dbo.Customer AS c
WHERE   c.Id IN ( SELECT    sc.CustomerId
                  FROM      dbo.ServiceInCustomer AS sc
                            INNER JOIN ( SELECT *
                                         FROM   dbo.Service AS s
                                         WHERE  s.Name IN ( 'S1', 'S2' )
                                       ) AS s ON s.Id = sc.ServiceId
                  GROUP BY  sc.CustomerId )
ORDER BY c.FullName ASC; 

--8) Find all clients that do not consume S ​1 ​service.
SELECT  c.FullName AS [Customer]
FROM    dbo.Customer AS c
WHERE   c.Id IN ( SELECT    sc.CustomerId
                  FROM      dbo.ServiceInCustomer AS sc
                            INNER JOIN ( SELECT *
                                         FROM   dbo.Service AS s
                                         WHERE  s.Name <> 'S1'
                                       ) AS s ON s.Id = sc.ServiceId
                  GROUP BY  sc.CustomerId )
ORDER BY c.FullName ASC; 

--9) Find all clients that consume S ​1​ service but do not consume S ​2 ​service.
SELECT  c.FullName AS [Customer]
FROM    dbo.Customer AS c
WHERE   c.Id IN ( SELECT    sc.CustomerId
                  FROM      dbo.ServiceInCustomer AS sc
                            INNER JOIN ( SELECT *
                                         FROM   dbo.Service AS s
                                         WHERE  s.Name <> 'S2'
                                       ) AS s ON s.Id = sc.ServiceId
                  WHERE     s.Name = 'S1'
                  GROUP BY  sc.CustomerId )
ORDER BY c.FullName ASC; 

--10) Find all clients of the specified company who consume the same services of the 
--	company (but may use different services of other companies) 
SELECT  c.FullName AS [Customer]
FROM    dbo.Customer AS c
WHERE   c.Id IN (
        SELECT  sc.CustomerId
        FROM    dbo.ServiceInCustomer AS sc
                INNER JOIN dbo.Service AS s ON s.Id = sc.ServiceId
                INNER JOIN dbo.Company AS cp ON cp.Id = s.CompanyId
        GROUP BY sc.CustomerId ,
                s.CompanyId
        HAVING  COUNT(*) <= 1 )
ORDER BY c.FullName ASC;  

--11) Find all clients who consume services provided only by one arbitrary company.
SELECT  c.FullName AS [Customer]
FROM    dbo.Customer AS c
WHERE   c.Id IN (
        SELECT  sc.CustomerId
        FROM    dbo.ServiceInCustomer AS sc
                INNER JOIN dbo.Service AS s ON s.Id = sc.ServiceId
                INNER JOIN dbo.Company AS cp ON cp.Id = s.CompanyId
        WHERE   cp.Id IN ( SELECT TOP 1
                                    t.Id
                           FROM     dbo.Company AS t
                           ORDER BY NEWID() )
        GROUP BY sc.CustomerId )
ORDER BY c.FullName ASC;  

--12) Find all clients who consume services provided by only two different companies.
SELECT  c.FullName AS [Customer]
FROM    dbo.Customer AS c
WHERE   c.Id IN (
        SELECT  sc.CustomerId
        FROM    dbo.ServiceInCustomer AS sc
                INNER JOIN dbo.Service AS s ON s.Id = sc.ServiceId
                INNER JOIN dbo.Company AS cp ON cp.Id = s.CompanyId
        GROUP BY sc.CustomerId ,
                s.CompanyId
        HAVING  COUNT(*) > 1 )
ORDER BY c.FullName ASC;  