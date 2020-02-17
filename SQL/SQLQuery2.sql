USE Northwind
GO
SELECT * FROM Employees
SELECT * FROM Customers
SELECT * FROM Orders
SELECT * FROM [Order Details]
SELECT * FROM Products
SELECT * FROM Categories

--PROJECTION

SELECT CustomerId,CompanyName,ContactName,City,Country
FROM Customers

--Projected columns can contain alias names

SELECT CustomerID as ID
,CompanyName as 'Company'
,ContactName as 'Contact'
FROM Customers

--literal columns into the output

SELECT CompanyName 'Company', 'IS BASED IN', City FROM Customers

--Computed columns are also allowed here

SELECT
CompanyName 'Company'
,'USES 10 TOKEN IN'
,City + '-' + Country AS 'Location'
FROM Customers

SELECT ProductId
,ProductName
,UnitPrice
,UnitsInStock
,(UnitsInStock * UnitPrice) AS 'stockValue'
FROM Products

--Restriction 
--limit the output rows using "WHERE" clause

SELECT CustomerId, CompanyName, ContactName, Country
FROM Customers
WHERE City='London'
--relatio operator =>  =,!=,<>,<,>,>=,<=,LIKE, BETWEEN, IN, OR, AND, NOT, IS

--List all customer in USA 
SELECT CustomerId, CompanyName, ContactName, Country
FROM Customers
WHERE Country='USA'

--List all Customer who not in London
SELECT CustomerId, CompanyName, ContactName, Country
FROM Customers
WHERE City !='London'

--List all products Where stock is less than 10
SELECT ProductId, ProductName, UnitPrice, UnitsInStock
FROM Products
WHERE UnitsInStock < 10

--List all products Where stock is Greater than 10
SELECT ProductId, ProductName, UnitPrice, UnitsInStock
FROM Products
WHERE UnitsInStock > 10

--List all the products where the price is not less than 20
SELECT ProductId, ProductName, UnitPrice, UnitsInStock
FROM Products
WHERE UnitPrice >= 20

--List all the orders placed after '19970101' -- use order table
SELECT OrderID, OrderDate
FROM Orders
WHERE OrderDate > '19970101'


select * from Orders

--List all the orders placed on or after '19980101' -- use order table
SELECT OrderID, OrderDate
FROM Orders
WHERE OrderDate >= '19980101'

--List all the customers who have not provided FAX numbers
SELECT CustomerID,CompanyName,Fax FROM Customers WHERE FAX= NULL --always fails

SELECT CustomerID,CompanyName,Fax FROM Customers WHERE FAX IS NULL

SELECT CustomerID,CompanyName,Fax FROM Customers WHERE FAX IS NOT NULL

--BETWEEN - Range of values
SELECT ProductID,ProductName,UnitPrice, UnitsInStock
FROM Products
WHERE UnitPrice BETWEEN 10.00 AND 20.00

--lIST ALL THE ORDERS PLACED IN THE FIRST HALF OF 19970101 TO 19970630
SELECT OrderID, OrderDate
FROM Orders
WHERE OrderDate BETWEEN '1997/01/01' AND '06/30/1997' --OR 1997-06-30

--LIKE OPERATOR--PATTERN MATCHING -> WILDCARDS % - ANY NUMBER OF LETTERS, _ FOR A SINGLE LETTER
SELECT CustomerID,CompanyName,ContactName
FROM Customers
WHERE CompanyName LIKE 'A%'

--List all the Companies whose name ends with 'es'
SELECT CustomerID,CompanyName,ContactName
FROM Customers
WHERE CompanyName LIKE '%es'

--List all the Companies whose name cantains  'th'
SELECT CustomerID,CompanyName,ContactName
FROM Customers
WHERE CompanyName LIKE '%th%'

--List all the Companies whose name cantains  'd' in the third last place
SELECT CustomerID,CompanyName,ContactName
FROM Customers
WHERE CompanyName LIKE '%__d'

--Multiple Condition use OR,AND, use parantheses for complex condtions
SELECT CustomerID, CompanyName,City,Country
FROM Customers
WHERE City='London' OR Country='USA'

SELECT CustomerID, CompanyName,City,Country
FROM Customers
WHERE City='Portland' AND Country='USA'

/*
Analysys-->OLAP,SSAS
Reporting-->SSRS
Integration-->SSISu
Transation-->OLTP
*/

--List all the Customers from Who have provided fax numbers
SELECT CustomerID, CompanyName,City,Country,Fax
FROM Customers
WHERE Country='USA' AND Fax IS NOT NULL

--List all the Customers from Who have provided fax numbers
SELECT CustomerID, CompanyName,City,Country,Fax
FROM Customers
WHERE (Country='USA' OR Country='UK') AND Fax IS NULL


SELECT ProductID, CategoryID
FROM Products
WHERE CategoryID IN (1,3,5)

--List all the products names bigins with A having unit price <10
--and stock level is not less than 20 belonging to categories 1,2 or 7.
SELECT ProductName, ProductID, CategoryID,UnitPrice,UnitsInStock
FROM Products
WHERE (CategoryID IN (1,2,7) AND 
ProductName LIKE 'A%' 
AND UnitPrice <10 
AND UnitsInStock > 20)

SELECT ProductName, ProductID, CategoryID,UnitPrice,UnitsInStock
FROM Products
WHERE (CategoryID IN (1,2,7) 
AND ProductName LIKE '[A-P]%' 
AND UnitPrice >10 
AND UnitsInStock >= 20)

--String Functions
DECLARE @str varchar(100)
SET @str = SPACE(10) + 'Hello World' + SPACE(10)
SELECT @str as 'Original'
,LEN(@str) as 'Length'
,UPPER(@str) AS 'Upper'
,LOWER(@str) AS 'Lower'
,LEFT(@str,15) 'Left 15'
,RIGHT(@str,15) 'Right 15'
,REVERSE(@str) 'Reverse'
,'[' + LTRIM(@str) + ']' 'Trim Left'
,'[' + RTRIM(@str) + ']' 'Trim Right'
,REPLACE(@str,'l','ZZ')'Replace "1" with "ZZ"'
,SUBSTRING(@str,11,8) 'Substring 11 to 19'

--Date time Functions
--GETDATE, YEAR, MONTH, DAY, DATEPART, DATENAME, DATEADD, DATEDIFF

DECLARE @today DATETIME
SET @today = GETDATE() --return the server date time
SELECT @today as 'Today'
, YEAR(@today) 'Month'
, DAY(@today) 'Day'
,DATEPART(HOUR,@today) 'Hour'
,DATEPART(WEEK,@today) 'Week #'
,DATEPART(WEEKDAY,@today) 'Week Day'
,DATENAME(MONTH,@today) 'Month Name'
,DATENAME(WEEKDAY,@today) 'Day Name'
,DATENAME(QUARTER,@today) 'Quarter of Year'
,DATEADD(HOUR,24,@today) 'Today + 24 Hours'
,DATEADD(MILLISECOND,500000,@today) 'Today + 5L ms'
,DATEDIFF(MONTH,@today,DATEADD(DAY,180,@today)) 'Diff today-next'
,DATEDIFF(DAY,@today,DATEADD(YEAR,1,@today)) 'Diff today-next'

--14. List all the orders placed in june 1996
SELECT OrderID,OrderDate 
FROM Orders
WHERE MONTH(OrderDate)=7 AND YEAR(OrderDate)=1996
--WHERE Orederdate BETWEEN '19960601 and '19960630

--15.List all the orders placed in the last quarter of 1996
SELECT OrderID,OrderDate 
FROM Orders
WHERE YEAR(OrderDate)=1996 AND DATEPART(QUARTER,OrderDate)=4

--16. List all the orders placed on monday in 1997

SELECT OrderID,OrderDate 
FROM Orders
WHERE YEAR(OrderDate)=1997 AND DATENAME(WEEKDAY,OrderDate)='Monday'

--17. List all the orders placed first half of 1997

SELECT OrderID,OrderDate 
FROM Orders
WHERE YEAR(OrderDate)=1997 AND DATEPART(QUARTER,OrderDate)<3

--18.List all the orders placed on weekends(saturday and sunday) in 1998

SELECT OrderID,OrderDate 
FROM Orders
WHERE YEAR(OrderDate)=1998 AND DATEPART(WEEKDAY,OrderDate) IN (1,7)
/*
SELECT OrderID,OrderDate 
FROM Orders
WHERE YEAR(OrderDate)=1998 AND DATEPART(DAY,OrderDate)=1 AND DATEPART(DAY,OrderDate)=7 */

--19.List all the oreeders shipped within 3 days of order date.

SELECT OrderID,OrderDate 
FROM Orders
WHERE DATEDIFF(DAY,OrderDate,ShippedDate)<4

--20. List all the orders shipped after 3 days of order in 1997

SELECT OrderID,OrderDate 
FROM Orders
WHERE DATEDIFF(DAY,OrderDate,ShippedDate)>3 AND YEAR(OrderDate) = 1997

--21. List all the orders shipped to germany during the first 15 days of each month 0f 1997

SELECT OrderID,OrderDate,ShipCountry
FROM Orders
WHERE ShipCountry='Germany' AND YEAR(ShippedDate) = 1997  AND DATEPART(DAY,ShippedDate) <=15


--Database and Object Functions
--Object_ID- returns the id of the specified object
--OBJECT_NAME - gives the name of the Object whose object id is specified
--DB_ID - returns the database id of the specified database name
-- DB_NAME - returns the name of the dtabase whose id is specified.

DECLARE @OID INT, @DBID INT
SET @OID = OBJECT_ID('Customers')
SELECT @DBID = DB_ID('Northwind')
SELECT @OID 'Object Id'
,OBJECT_NAME(@OID) 'Object name'
,@DBID 'DB ID'
,DB_NAME(@DBID) 'Daabase Name'

--AGGREGATE FUNCTIONS
--works on aggregation or totals or summaries
--SUM,AVG,MIN,MAX,COUNT

SELECT COUNT(*) AS 'Total Rows'
,SUM(UnitPrice * UnitsInStock) AS 'Stock Value'
,AVG(UnitPrice * UnitsInStock) AS 'Average Value'
,MIN(UnitPrice * UnitsInStock) AS 'Minimum Value'
,MAX(UnitPrice * UnitsInStock) AS 'Maximum Value'
FROM Products

--Count Function -> Count(*) counts all the rows including null also
				-- ->Count(columnname) Count only valid rows excludes null values

SELECT COUNT(*) 'Total Rows', COUNT(FAX) 'With FAX' 
FROM Customers

SELECT Country, COUNT(CustomerId) AS 'Customer count' 
FROM Customers
GROUP BY Country

--22. List the category-wise stock value for products

SELECT CategoryID
,SUM(UnitPrice * UnitsInStock) 'Stock value '
FROM Products
GROUP BY CategoryID

--23. List the order value for each order from "Order Details"
--Table:[Order Details],Columns:OrderID,UNITPRICE,QUANTITY,OV:SUM(UNITPRICE * Quantity)

SELECT OrderID,SUM(UNITPRICE * Quantity) AS 'Order Value'
FROM [Order Details]
GROUP BY OrderID

--24. List the number of times each product is ordered from order details

SELECT COUNT(ProductID) as 'Product name'
FROM Products
GROUP BY ProductID

--25. List all the number of orders placed by each customers from orders

SELECT COUNT(OrderID)
FROM Orders
GROUP BY CustomerID

--26. Display the average values of orders a product is ordered from order details

SELECT ProductId
,COUNT(ProductId) as 'Times Order'
,SUM(UnitPrice*Quantity) AS 'Order value'
,AVG(UnitPrice*Quantity) AS 'Average ordr value'
FROM [Order Details]
--GROUP BY ProductID ORDER BY ProductID
GROUP BY 'Average ordr value'

/*Query Execution
FROM<table_list|JOINS|SUBQUERIES>
WHERE <CONDITION|SUBQUERIES> //extracting from physical table
GROUP BY<GROUPING LIST>
HAVING BY<CRITERIA>
SELECT <PROJECTIO LIST|SUBQUERIES>
ORDER BY<SORT CRITERIA>
*/

--27. list all the average order value for query #23

SELECT OrderID
,SUM(UNITPRICE * Quantity) AS 'Order Value'
,AVG(UNITPRICE * Quantity) AS 'AVG Order Value'
FROM [Order Details]
GROUP BY OrderID
ORDER BY 'AVG Order Value' DESC

--28. Extend #27 and Display the orders with the highest average value

SELECT TOP 1 OrderID --SELECT TOP 10 PERCENT OrderID
,SUM(UNITPRICE * Quantity) AS 'Order Value'
,AVG(UNITPRICE * Quantity) AS 'AVG Order Value'
FROM [Order Details]
GROUP BY OrderID
ORDER BY 'AVG Order Value' DESC

--29. List all the orders where the avg order value > 5000

/*SELECT OrderID
,SUM(UNITPRICE * Quantity) AS 'Order Value'
,AVG(UNITPRICE * Quantity) AS 'AVG Order Value'
FROM [Order Details]
WHERE AVG(UNITPRICE * Quantity) > 5000
GROUP BY OrderID
WHERE AVG(UNITPRICE * Quantity) > 5000  //cannot use where clause to aggregate functions(While extracting from physical table0
ORDER BY 'AVG Order Value' DESC
*/

SELECT OrderID
,SUM(UNITPRICE * Quantity) AS 'Order Value'
,AVG(UNITPRICE * Quantity) AS 'AVG Order Value'
FROM [Order Details]
GROUP BY OrderID
HAVING AVG(UNITPRICE * Quantity) > 5000 --Instead of where we use having for aggregate function and after extrzcting and group by from physical table
ORDER BY 'AVG Order Value' DESC

--30. List all the customers who have placed 10 or more orders

SELECT CustomerID
,COUNT(OrderID)
FROM Orders
GROUP BY CustomerID
HAVING COUNT(OrderID) > 9

--31. List the Customer who placed the Highest number of orders

SELECT TOP 1 CustomerID
,COUNT(OrderID) as 'Order no'
FROM Orders
GROUP BY CustomerID
ORDER BY 'Order no' DESC

--32 In which month of 1997 where the highest number of order placed

SELECT DATENAME(MONTH,OrderDate) 'month name'
,COUNT(OrderID) as 'count'
FROM Orders
WHERE YEAR(OrderDate)=1997
GROUP BY DATENAME(MONTH,OrderDate)
ORDER BY 'count' DESC

--=> FROM-WHERE-GROUP BY-HAVING-SELECT-ORDER BY-TOP

--SUB queries
--nested queries which execites before the main query executes
--sub-queries can be defined at column-level,table=level and the restriction clause
--at column level - should return a single value
--at Restriction level - should return a single value
--at Table-level- should return multiple values[multiple rows and,columns]

SELECT
(SELECT COUNT(*) FROM Products) AS 'Product count'
,(SELECT COUNT(*) FROM Customers) AS 'Customer count'
,(SELECT COUNT(*) FROM Orders) AS 'Orders count'
,(SELECT COUNT(*) FROM [Order Details]) AS 'details count'
,(SELECT COUNT(*) FROM Categories) AS 'Categories count'
,(SELECT COUNT(*) /*, SUM(EmployeeId)*/ FROM Employees) AS 'Employee count'

--At the table level, subquery return tabular data.
SELECT AVG(ordercount),SUM(ordercount),COUNT(ordercount),MAX(ordercount),
MIN(ordercount)
FROM(
SELECT CustomerID,COUNT(OrderId) 'ordercount'
FROM Orders
GROUP BY CustomerID) AS tb1--table name alias

--At restriction level
--List all the orders which are twice greater than avg order value

SELECT /*OrderID,*/COUNT(OrderID) AS 'Orders' 
,SUM(UnitPrice * Quantity) AS'Order Value'
,AVG(UnitPrice * Quantity) AS'AVG Order Value'
FROM [Order Details]
GROUP BY OrderID


SELECT OrderId, [Order Value] 
FROM (
SELECT OrderId,SUM(UnitPrice * Quantity) AS 'Order Value'
FROM[Order Details]
GROUP BY OrderID) AS tb1
WHERE[Order Value] > 2 * (
SELECT AVG(OrderValue) FROM
(
SELECT OrderId,SUM(UnitPrice * Quantity) AS OrderValue
FROM[Order Details]
GROUP BY OrderID
) tb
)



CREATE TABLE SetA (ID INT, Name VARCHAR(20))
GO
CREATE TABLE SetB(ID INT,Name VARCHAR(20), AID INT)
GO
INSERT INTO SetA(ID,Name) VALUES(111,'Karnataka'),(222,'Tamil Nadu'),(333,'Andhra')
GO
INSERT INTO SetB(ID,Name,AID) VALUES (12345,'Bengaluru',111)
,(12346,'Mysore',111)
,(12347,'Chennai',222)
,(12348,'Madurai',222)
,(12349,'Mumbai',NULL)
,(12350,'Hyderabad',NULL)
GO
SELECT * FROM SetA
GO
SELECT * FROM SetB
GO

SELECT A.ID,A.Name,B.ID,B.Name,B.AID
FROM SetA A INNER JOIN SetB B ON A.ID=B.AID --CAN WRITE AS =>JOIN

SELECT A.ID,A.Name,B.ID,B.Name,B.AID
FROM SetA A LEFT OUTER JOIN SetB B ON A.ID=B.AID --CAN WRITE AS LEFT JOIN

SELECT A.ID,A.Name,B.ID,B.Name,B.AID
FROM SetA A RIGHT OUTER JOIN SetB B ON A.ID=B.AID

SELECT A.ID,A.Name,B.ID,B.Name,B.AID
FROM SetA A FULL OUTER JOIN SetB B ON A.ID=B.AID

SELECT A.ID,A.Name,B.ID,B.Name,B.AID
FROM SetA A CROSS JOIN SetB B


--33. Display the company name for each order
--[orders(CustomerId)=Customers(customerId)] output orderid,orderdate,customerid, company name

SELECT O.OrderID,O.OrderDate,C.CustomerID,C.CompanyName
FROM Orders O INNER JOIN Customers C ON O.CustomerID=C.CustomerID

--34. Display the following details: OrderId,ProductId,ProductName
--[order details(ProductId) and Products(ProductId]

SELECT OD.OrderID,OD.ProductID,P.ProductName,P.ProductID
FROM [Order Details] OD INNER JOIN Products P ON OD.ProductID=P.ProductID

--35. Display the Category details for each product as :Productid,product name,categoryid,categoryname
--[Products(categoryID) and categories(categoryID)]

SELECT P.ProductID, P.ProductName, C.CategoryID, C.CategoryName
FROM Products P INNER JOIN Categories C ON P.CategoryID=C.CategoryID

--36. Display the order and employee details as follows OrdeID,Orderdate,EmployeeId,Firstname,Lasttname
--[Orders(EmployeeID) and Employee(EmployeeID)

SELECT O.OrderID, O.OrderDate, E.EmployeeID, E.FirstName, E.LastName
FROM Orders O INNER JOIN Employees E ON O.EmployeeID=E.EmployeeID

--35.Display the reporting manager for each employee:
--OUTPUT: E.employeeId, E.Firstname, E.Lastname, MGR.EmployeeId, MGR.Firstname, MGR.Lastname
--[Employees (reportto) as E = Employees(EmployeeId) as MGR]

SELECT E.EmployeeID 'Employee Id'
,E.FirstName + ' ' + E.LastName 'Employee Name'
,M.EmployeeID 'Manager Id'
,M.FirstName + ' ' + M.LastName 'Manager Name'
FROM Employees E INNER JOIN Employees M ON E.ReportsTo = M.EmployeeID

SELECT E.EmployeeID 'Employee Id'
,E.FirstName + ' ' + E.LastName 'Employee Name'
,M.EmployeeID 'Manager Id'
,M.FirstName + ' ' + M.LastName 'Manager Name'
FROM Employees E LEFT JOIN Employees M ON E.ReportsTo = M.EmployeeID

SELECT E.EmployeeID 'Employee Id'
,E.FirstName + ' ' + E.LastName 'Employee Name'
,M.EmployeeID 'Manager Id'
,M.FirstName + ' ' + M.LastName 'Manager Name'
FROM Employees E RIGHT JOIN Employees M ON E.ReportsTo = M.EmployeeID

--36. Display the orders and the order values : orderId, Order value, 
--[orders(orderId) = Order Details(orderId)] Ordervalue=SUM(OD.Unitprice * OD.Quantity)
SELECT O.OrderID
,O.OrderDate
--,C.CustomerID
--,C.CompanyName
, SUM(OD.UnitPrice * OD.Quantity) AS 'OrderValue'
FROM Orders O 
INNER JOIN [Order Details] OD ON O.OrderID=OD.OrderID
--INNER JOIN Customers C ON O.CustomerID=C.CustomerID
GROUP BY O.OrderID,O.OrderDate--,C.CustomerID,C.CompanyName
ORDER BY OrderValue DESC

--37. On which date was the order with the hghest order value
SELECT TOP 1 O.OrderID
,O.OrderDate
--,C.CustomerID
--,C.CompanyName
, SUM(OD.UnitPrice * OD.Quantity) AS 'OrderValue'
FROM Orders O 
INNER JOIN [Order Details] OD ON O.OrderID=OD.OrderID
--INNER JOIN Customers C ON O.CustomerID=C.CustomerID
GROUP BY O.OrderID,O.OrderDate--,C.CustomerID,C.CompanyName
ORDER BY OrderValue DESC

--38.Who placed the order for query #37 above[Display the Customer Detail]

SELECT TOP 1 O.OrderID
,O.OrderDate
,C.CustomerID
,C.CompanyName
, SUM(OD.UnitPrice * OD.Quantity) AS 'OrderValue'
FROM Orders O 
INNER JOIN [Order Details] OD ON O.OrderID=OD.OrderID
INNER JOIN Customers C ON O.CustomerID=C.CustomerID
GROUP BY O.OrderID,O.OrderDate,C.CustomerID,C.CompanyName
ORDER BY OrderValue DESC

--39. Display the employee who booked this order

SELECT TOP 1 O.OrderID
,O.OrderDate
,C.CustomerID
,C.CompanyName
,E.FirstName + ' ' + E.LastName 'Employee Name'
, SUM(OD.UnitPrice * OD.Quantity) AS 'OrderValue'
FROM Orders O 
INNER JOIN [Order Details] OD ON O.OrderID=OD.OrderID
INNER JOIN Customers C ON O.CustomerID=C.CustomerID
INNER JOIN Employees E ON E.EmployeeID=O.EmployeeID
GROUP BY O.OrderID,O.OrderDate,C.CustomerID,C.CompanyName, E.FirstName,E.LastName
ORDER BY OrderValue DESC

--40. display "orderid, order value,productid, productname,categoryid,categoryname"
--[Order Details,Products, Categories]

SELECT OD.OrderID, SUM(OD.UnitPrice*OD.Quantity) as 'ordervalue' ,OD.ProductID, P.ProductName, C.CategoryID, C.CategoryName
FROM [Order Details] OD
INNER JOIN Products P ON P.ProductID=OD.ProductID
INNER JOIN Categories C ON C.CategoryID=P.CategoryID
GROUP BY OD.OrderID,OD.ProductID, P.ProductName, C.CategoryID, C.CategoryName

--41. Which category of products is ordered the most number of times

SELECT C.CategoryID,C.CategoryName,COUNT(C.CategoryID) AS 'Count'
FROM Categories C
INNER JOIN Products P ON C.CategoryID=P.CategoryID
INNER JOIN [Order Details] OD ON P.ProductID=OD.ProductID
GROUP BY C.CategoryID,C.CategoryName
ORDER BY 'count' DESC



SELECT * FROM Categories
SELECT * FROM Products
SELECT * FROM [Order Details]
SELECT * FROM Orders
SELECT * FROM Customers



--42. Which is the most ordered category by customers residing in USA

SELECT TOP 1 C.CategoryID,C.CategoryName,CU.Country,COUNT(C.CategoryID) AS 'count'
FROM Categories C
INNER JOIN Products P ON C.CategoryID=P.CategoryID
INNER JOIN [Order Details] OD ON OD.ProductID=P.ProductID
INNER JOIN Orders O ON O.OrderID= OD.OrderID
INNER JOIN Customers CU ON CU.CustomerID=O.CustomerID
WHERE CU.Country='USA'
GROUP BY C.CategoryID,C.CategoryName,CU.Country
ORDER BY 'count' DESC



--VIEWS 
--complex query can be into the server
--views are objects
--objects which do not hold any values or data, holds the definition for getting data
--abstract or hide the underlying table(base table)
--restrction can be applied on the abstraction (view)
--views can be updateable(insert,update,delete) or non-updateable(query)
--views are updeatable if 
	--they match exactly one underlying(base) table (constraints)
	--should not contain aggregate columns and group by clauses.
--create a view using "CREATE VIEW <view name> AS <view definition>"



CREATE VIEW vw_USAustomers 
AS 
SELECT TOP 1 C.CategoryID,C.CategoryName,CU.Country,COUNT(C.CategoryID) AS 'count'
FROM Categories C
INNER JOIN Products P ON C.CategoryID=P.CategoryID
INNER JOIN [Order Details] OD ON OD.ProductID=P.ProductID
INNER JOIN Orders O ON O.OrderID= OD.OrderID
INNER JOIN Customers CU ON CU.CustomerID=O.CustomerID
WHERE CU.Country='USA'
GROUP BY C.CategoryID,C.CategoryName,CU.Country
ORDER BY 'count' DESC
GO 
SELECT * FROM vw_USAustomers
--IF TOP IS used in the definition, then the ordr by clause should also be used.
--List the view in the database
SELECT * FROM sys.views
--get the text using "sys.syscomments" system view
SELECT text FROM sys.syscomments WHERE id=OBJECT_ID('vw_USAustomers')

--updatable view 
CREATE VIEW vw_Customers AS
SELECT CustomerID,CompanyName,ContactName,City,Country
FROM Customers
GO

SELECT * FROM vw_Customers
INSERT INTO vw_Customers(CustomerID,CompanyName,ContactName,City,Country)
VALUES ('AAAAA','All as associates','alfred alvin','almora','algeria')
GO
SELECT * FROM vw_Customers WHERE CustomerID LIKE 'A%'
DELETE FROM vw_Customers WHERE CustomerID='AAAAA'
GO

--HIDE THE VIEW DEFINITION BY ENCRYPTING THE DEFINITION
ALTER VIEW vw_Customers WITH ENCRYPTION AS
SELECT CustomerID,CompanyName,ContactName,City,Country FROM dbo.Customers
GO

SELECT text FROM sys.syscomments WHERE id=OBJECT_ID('vw_Customers')

--DROP THE VIEW
DROP VIEW vw_Customers
GO

SELECT * FROM sys.views
SELECT text FROM sys.syscomments WHERE id=OBJECT_ID('vw_Customers')




-- Programming SQL server with T-SQL
-- sql server executes a batch of statements as one unit of work(transaction)

-- Query execution steps
--(Query Engine)
	-- Syntax check - Parser which pasrses the query
	-- Object Resolution - Resolves all objects used in the query, access rights on the specified objects
	-- optimization plan - Execution plan -cheapest way to execute the query
		-- Merge-Seek Operation -- Index
		-- Scan Operation
	-- Compile the Query
	-- Executes the compiled code

-- (Storage engine)- delas with the storage of data
	-- Thread Manager
	-- Memory manager
	-- File manager
	-- I/O manager
	--Transaction manager(unit of work ID)

--SQL server stores a data into pages, each page is 8kb in size.
	--data pages which are used to store data
	--index pages were indexes (B-tree)
	--GAM(Global Application Map)Pages -- pages and their occupied(used) space
	--IAM(Index Allocation Mab)
	--LOB Pages-- used to store LOB(varchar(max),text,image,variable(max),xml
	--PageFreeSpace Pages-- lists all the free spaces in the pages allocated to tables

	--IN Physical files , SQL server reads or write an extent-8page-64ksegment

	--one data page can contain one or more rows.
	--one Extent will have 8 pages

-- variable
-- local variable and global variables
-- local
	-- scoped to the executing batch
	-- user-defined variables
	-- begin with "@" symbol
-- Global
	--Scoped to the server
	--server-defined, cannot be defined by the user
	--defined with "@@" symbol
	
SELECT @@LANGUAGE,@@CONNECTIONS,@@SERVERNAME,@@NESTLEVEL,@@ERROR


--DECLARE @<identifier> <datatypes>[,@<identifiers><datatype>,...n]
--Initialize the variables using SET
--SET <identifier> = <initial value>
--SET is also used to assign values to variables at any point in a batch


--Display the output
--Print <identifiers>|<expression> ==> return a message -- Message tab
--SELECT <identifiers>,<expression> ==>return a TDS [Tabular Data Stream] --Result tab

DECLARE @i int
SET @i = 10
--PRINT 'The number is' + @i
PRINT 2 + @i

--SELECT @i

--convert to another type
--CAST, CONVERT, are two conversion functions
DECLARE @num INT
SET @num = 500
PRINT 'The number is ' + CAST(@num AS VARCHAR)
PRINT 'The number is ' + CONVERT(VARCHAR,@num /* ,102*/) -- convert function supports FORMATS
PRINT CONVERT (VARCHAR, GETDATE(),103)
PRINT CONVERT (VARCHAR, GETDATE(),101)
PRINT CONVERT (VARCHAR, GETDATE(),102)
PRINT CONVERT (VARCHAR, GETDATE(),107)
PRINT CONVERT (VARCHAR, GETDATE(),111)
PRINT CONVERT (VARCHAR, GETDATE(),112)
PRINT CONVERT (VARCHAR, GETDATE(),120)
PRINT CONVERT (VARCHAR, GETDATE(),121)


/* Program Constructs
1.IF(condition )
		--statement
2.IF(condition)
		--statement
		ELSE
		--statement
3.IF(condition)
		BEGIN
			--statement
		END
4.IF(condition)
		BEGIN
			--statement
		END
		ELSE
		BEGIN
			--statement
		END
5.IF(condition)
		BEGIN
			IF(condition)
			BEGIN
				--statement
			END
		END
6.Switch Case
6a. CASE 
		WHEN<Condition> THEN statement
		WHEN<condition> THEN statement
		ELSE statement
	END
6b. CASE <condition|expression>
		WHEN<value> THEN statement
		WHEN<value2> THEN statement
		ELSE statement
	END
7.RETURN
8.WHILE<condition>
		BEGIN
			--statements
		END
*/

--IF condition

DECLARE @number INT
SET @number = 50
IF(@number = 50)
		PRINT 'the number is '+ CAST(@number AS VARCHAR)
ELSE
		PRINT 'the number is not ' + CAST(@number AS VARCHAR)

IF @number = 50
BEGIN
	PRINT 'The number '
	PRINT @number
END

--working with case statements

SELECT ProductID
,ProductName
,'Stock Description' = CASE 
		WHEN UnitsInStock >50 THEN 'Too much Stock'
		WHEN UnitsInStock >60 THEN 'In Stock'
		ELSE 'Low Stock'
	END
FROM Products
GO

--Write a simple batch compares 2 numbers and prints the greatest of two numbers

DECLARE @First INT , @Second INT
SET @First=10
SET @Second=20
IF(@First > @Second)
	PRINT 'The greater number is ' + CAST(@First AS VARCHAR) 
IF(@First < @Second)
	PRINT 'The greater number is ' + CAST(@Second AS VARCHAR)

--Write a simple batch which compares 3 numbers and prints the greatest number of the 3 numbers.
--also print appropriate message if alll 3 number are equal, or any two numbers are equal.

DECLARE @one INT , @two INT , @three INT ,@result INT
SET @one=20
SET @two=40
SET @three=40

IF (@one = @two) AND (@one = @three)
	PRINT 'ALL the three numbers are equal'
ELSE IF(@one = @two) OR (@one = @three) OR (@two = @three)
	BEGIN
		IF(@one = @two)
		PRINT 'one and two are equal'
		IF(@one = @three)
		PRINT 'one and three are equal'
		IF(@three = @two)
		PRINT 'three and two are equal'
	END
ELSE 
	PRINT 'all are different'

IF(@one>@two)
	BEGIN
		IF(@one>@three)
			PRINT 'One is larger number'
		ELSE
			PRINT 'Three is larger number'
	END
ELSE
	BEGIN
		IF(@two>@three)
			PRINT 'Two is larger number'
		ELSE
			PRINT 'Three is larger number'
	END


	
--Write a batch display the first 'n' fibonacci terms where 'n' is between 1 and 40

DECLARE @o INT , @t INT , @next INT ,@terms INT, @counter INT
SET @o = 0
SET @t = 1
SET @terms = 15
SET @counter = 2
PRINT @o
PRINT @t
WHILE(@counter<@terms)
BEGIN
	SET @next = @o + @t
	PRINT @next
	SET @o = @t
	SET @t = @next
	SET @counter = @counter + 1
END
GO


--Stored Procedure
--batches or group of statements that are stored on the server
--parsing, resolving, optimizing, and compiling the batch
--subsequently the batch is executed
--like functions, which do not return value[returns exit status as integer]
--also known as sub-routines or void functions
--stored procedures are executed using 'exec' statement
--stored procedures allow 1024 parameters (input as well as output)
--nested calls are allowed as well as recursive calls allowed upto 32 levels


--CREATE PROCEDURE /*PROC*/  | /*proc_procedurename*/ | /*sp_procedurename*/ //naming convention
CREATE PROCEDURE sp_fibonacci
(
@terms INT
) --if we pass any values only this line useful otherwise can start with as begin

AS BEGIN 
DECLARE @o INT , @t INT , @next INT, @counter INT
SET @o = 0
SET @t = 1
SET @counter = 2
PRINT @o
PRINT @t
WHILE(@counter<@terms)
BEGIN
	SET @next = @o + @t
	PRINT @next
	SET @o = @t
	SET @t = @next
	SET @counter = @counter + 1
END
END
GO

--Executing the stored procedure
DECLARE @terms INT
SET @terms = 10
EXEC sp_fibonacci @terms

ALTER PROCEDURE sp_fibonacci (@terms INT) AS BEGIN
-- BODY
END
GO
DROP PROCEDURE sp_fibonacci
GO


--CRUD (CREATE,RETRIEVE,UPDATE,DELETE) for products
-- Retrieve all products besed on search criteria where productname contains 'str'
CREATE PROCEDURE sp_GetAllProducts
(
	@search varchar(50)
) AS BEGIN

SELECT ProductID ,ProductName, UnitPrice, UnitsInStock,Discontinued,CategoryID
FROM Products
WHERE ProductName LIKE '%' + @search + '%'
END
GO

DECLARE @search VARCHAR(100)
SET @search = 'p'
EXEC sp_GetAllProducts @search
GO

--check existance of procedure

IF(EXISTS (SELECT * FROM sys.procedures WHERE name='sp_GetAllProducts'))
	DROP PROCEDURE sp_GetAllProducts
GO
CREATE PROCEDURE sp_GetAllProducts
(
	@search varchar(50)
) AS BEGIN
IF @search IS NULL OR @search=''
BEGIN
	SELECT ProductID ,ProductName, UnitPrice, UnitsInStock,Discontinued,CategoryID
	FROM Products
END
ELSE
BEGIN
	SELECT ProductID ,ProductName, UnitPrice, UnitsInStock,Discontinued,CategoryID
	FROM Products
	WHERE ProductName LIKE '%' + @search + '%'
END
END
GO

DECLARE @search VARCHAR(100)
SET @search = NULL
--SET @search = 'p'
EXEC sp_GetAllProducts @search
GO



IF(EXISTS (SELECT * FROM sys.procedures WHERE name='sp_GetAllProducts'))
	DROP PROCEDURE sp_GetProductID
GO
CREATE PROCEDURE sp_GetProductID
(
@productid1 INT
) AS BEGIN
IF @productid1 = NULL OR @productid1=''
BEGIN
	RAISERROR('No match found', 18,1)-- message , severity level, state-->google
END
ELSE
BEGIN
	SELECT ProductID ,ProductName, UnitPrice, UnitsInStock,Discontinued,CategoryID
	FROM Products
	WHERE ProductID=@productid1
END
END

DECLARE @productid1 INT
SET @productid1 = 2
EXEC sp_GetProductID @productid1


--CREATE TABLE
IF(EXISTS (SELECT * FROM sys.procedures WHERE name='sp_CreateProduct'))
	DROP PROCEDURE sp_CreateProduct
GO
CREATE PROCEDURE sp_CreateProduct
(
	@productname VARCHAR(50),@unitprice MONEY,@unitinstock SMALLINT,@dicontinued BIT,@categoryid INT
)AS BEGIN
INSERT INTO Products(
ProductName, UnitPrice, UnitsInStock, Discontinued, CategoryID)
VALUES(@productname,@unitprice,@unitinstock,@dicontinued,@categoryid)

SELECT ProductId,ProductName, UnitPrice, UnitsInStock, Discontinued, CategoryID
FROM Products
WHERE ProductName=@productname
END


--CHECK WEather the category id exist . if it doesn't , throw error, else continue .
--CHECK WEather the product id exist . if it does , then update, else throw error.
--UPDATE TABLE
IF(EXISTS (SELECT * FROM sys.procedures WHERE name='sp_UpdateProduct'))
	DROP PROCEDURE sp_UpdateProduct
GO
CREATE PROCEDURE sp_UpdateProduct
(
	@productId INT,@productname VARCHAR(50),@unitprice MONEY,@unitinstock SMALLINT,@dicontinued BIT,@categoryid INT
)AS BEGIN
IF(EXISTS (SELECT * from Products WHERE CategoryID=@categoryid))
BEGIN
	IF(EXISTS (SELECT * from Products WHERE ProductID=@productId))
	BEGIN
		UPDATE Products SET ProductName = @productname
		, UnitPrice = @unitprice
		, UnitsInStock = @unitinstock
		, Discontinued = @dicontinued
		, CategoryID = @categoryid
		WHERE ProductID=@productId
	END
	ELSE
	raiserror('productid not found',18,1)

SELECT ProductId,ProductName, UnitPrice, UnitsInStock, Discontinued, CategoryID
FROM Products
WHERE ProductName=@productname
END
ELSE
raiserror('Categoryid not found',18,1)
END



DECLARE @productId INT, @productname VARCHAR(50),@unitprice MONEY,@unitinstock SMALLINT,@dicontinued BIT,@categoryid INT
SET @productId = 79
SET @productname = 'Productname2'
SET @unitprice = 200
SET @unitinstock = 90
SET @dicontinued = 0
SET @categoryid = 2
--EXEC sp_CreateProduct @productname,@unitprice,@unitinstock,@dicontinued,@categoryid
EXEC sp_UpdateProduct @productId , @productname ,@unitprice ,@unitinstock ,@dicontinued,@categoryid


--Output parameters
IF(EXISTS (SELECT * FROM sys.procedures WHERE name='sp_GetEmployeeFullname'))
	DROP PROCEDURE sp_GetEmployeeFullname
GO
CREATE PROCEDURE sp_GetEmployeeFullname
(
@employeeid INT,
@fullname VARCHAR(100) OUTPUT
)AS BEGIN
SELECT @fullname=FirstName + ' ' + LastName FROM Employees WHERE EmployeeID=@employeeid
END
GO

DECLARE @empid int, @name VARCHAR(100)
SET @empid = 1
EXEC sp_GetEmployeeFullname @empid , @name OUTPUT
PRINT 'Full name of employe ' + @name
GO



select * from sys.procedures

USE Northwind
GO
IF(EXISTS (SELECT * FROM sys.procedures WHERE name='sp_GetAllProducts'))
	DROP PROCEDURE sp_GetAllProducts
	GO

	CREATE PROCEDURE sp_GetAllProducts 
( 
    @search VARCHAR(50)
) AS BEGIN 

    IF @search IS NULL OR @search ='' 
    BEGIN 
        SELECT ProductId, ProductName, UnitPrice, UnitsInStock, Discontinued, CategoryId
        FROM Products 
    END 
    ELSE 
    BEGIN
        SELECT ProductId, ProductName, UnitPrice, UnitsInStock, Discontinued, CategoryId
        FROM Products 
        WHERE ProductName LIKE '%' + @search + '%'
    END
END  -- of procedure sp_GetAllProducts 

IF(EXISTS (SELECT * FROM sys.procedures WHERE name='sp_CreateProduct'))
	DROP PROCEDURE sp_CreateProduct
	GO

	CREATE PROCEDURE sp_CreateProduct 
(
    @productName varchar(100), 
    @unitPrice money, 
    @unitsInStock smallint, 
    @discontinued bit, 
    @categoryId int
) AS BEGIN
    IF(NOT EXISTS(SELECT ProductName from Products WHERE ProductName=@productName)) 
    BEGIN
        INSERT INTO Products (ProductName, UnitPrice, UnitsInStock, Discontinued, CategoryID) 
        VALUES(@productName, @unitPrice, @unitsInStock, @discontinued, @categoryId) 
    END 
    ELSE 
    BEGIN
        Raiserror('This product already exists.', 18, 1) 
    END
END

IF(EXISTS (SELECT * FROM sys.procedures WHERE name='sp_GetProductDetails'))
	DROP PROCEDURE sp_GetProductDetails
	GO

	CREATE PROCEDURE sp_GetProductDetails 
( 
    @productId INT
) AS BEGIN 

    IF (@productId IS NOT NULL OR @productId > 0 ) 
        AND EXISTS(SELECT ProductId FROM Products Where ProductId=@productId)
    BEGIN 
        SELECT  ProductId, ProductName, UnitPrice, UnitsInStock, Discontinued, CategoryId
        FROM Products 
        WHERE ProductID=@productId
    END
    ELSE 
    BEGIN 
        Raiserror('I dont know what is happening', 18, 1) -- message, severity level, state --> GOOGLE
    END 
END

IF(EXISTS (SELECT * FROM sys.procedures WHERE name='sp_UpdateProduct'))
	DROP PROCEDURE sp_UpdateProduct
	GO
	CREATE PROCEDURE sp_UpdateProduct 
(
    @productId INT,
    @productName varchar(100), 
    @unitPrice money, 
    @unitsInStock smallint, 
    @discontinued bit, 
    @categoryId int
) AS BEGIN

    IF (NOT EXISTS(SELECT CategoryID FROM Categories WHERE CategoryID=@categoryId)) 
    BEGIN 
        Raiserror('Specified category does not exist.', 18, 1)
        RETURN
    END
    IF(EXISTS(SELECT ProductId from Products WHERE ProductId=@productId)) 
    BEGIN
        UPDATE Products 
        SET ProductName = @productName, 
        UnitPrice = @unitPrice, 
        UnitsInStock = @unitsInStock, 
        Discontinued = @discontinued, 
        CategoryID =  @categoryId
        WHERE ProductID=@productId
    END 
    ELSE 
    BEGIN
        Raiserror('This product does not exist.', 18, 1) 
    END
END

