--CHANGE DATABASE USING THIS COMMAND
USE	master
GO --BATCH TERMINATOR
-- BATCH TERMINATOR IS A SET OF STATEMENTS,WHICH ARE PROCESSED IN A SINGLE  TRANSACTION.

--to create database we always should be in master database
CREATE DATABASE TestDb ON PRIMARY
(Name='Test_Data' /* logical name for physical file */
, FILENAME ='C:\Databases\Test_Data.mdf' /* physical file*/
,SIZE=10MB /*INITIAL SIZE OF THE DB*/
,FILEGROWTH=5MB /*CAN BE FIXED SIZES OR IN TERMS OF % AS 10% */
)
LOG ON
(Name='Test_log' /* logical name for physical file */
, FILENAME ='C:\Databases\Test_log.ldf' /* physical file*/
,SIZE=10MB /*INITIAL SIZE OF THE DB*/
,FILEGROWTH=5MB /*CAN BE FIXED SIZES OR IN TERMS OF % AS 10%*/
)
GO
--creates physical folder in C:\ called "DATABASE"

--LIST ALL THE DATA BASES ON THE SERVER
SELECT * FROM sys.databases  ---sql server view
GO
--change the working database

USE TestDb
GO


/* TO CREATE TABLES , WE NEED TO DEFINE COLUMNS.
-- EACH COLUMNS SHOULD HAVE a name as associated data types.
--data types in sql server
1.Integral types -> tinyint(1 byte),smallint(2),int(4),bigint(8)
2.Real Numbers -> float(4),double(8), Numeric(scale,presision)
3.Char types (ASCII values only)-> char(8000 fixed allocates fully),varchar(8000 max stores how much we used),text(CLOB, cahracter large object, 2gb(2^31)),varchar(max (2gb))
4.National Char (UNICODE any language)->nchar(4000 each charater requires 2 byte of data),nvarchar,ntext,nvarchar(max)
5.DateTime types ->smalldatetime(4),datetime(8),datetime2(8),date,time
6.Monetary types ->smallmoney, money
7.Binary types ->binary(8000),varbinary(8000),image,varinary(max)
8.Miscelleneous types -> bit,xml,unique identifier(GUID XXXXXXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXX 32 bit),cursor,table
*/

CREATE TABLE Employees
(
EmpId INT NOT NULL,
EmpName VARCHAR(50) NOT NULL,
BirthDate dATE NOT NULL,
Address VARCHAR(100),
Gender CHAR(1) NOT NULL CONSTRAINT def_Emp_Gender DEFAULT 'M',
Salary MONEY,
CONSTRAINT pk_Employees_EmpID PRIMARY KEY(EmpId),
CONSTRAINT uq_Employees_EmpName UNIQUE(EmpName),
CONSTRAINT ck_Employees_Gender CHECK(Gender IN('m','M','F','f')),
CONSTRAINT ck_Employees_Salry CHECK(Salary >1000)
)
GO


SELECT * FROM INFORMATION_SCHEMA.TABLES   ---USING ANSI VIEW
SELECT * FROM sys.tables ---using sql views
SELECT * FROM sys.sysconstraints WHERE id=OBJECT_ID('Employees')
SELECT object_name(constid) FROM sys.sysconstraints WHERE id=OBJECT_ID('Employees')
--check for the columns
SELECT name FROM sys.columns WHERE object_id=OBJECT_ID('Employees')
GO
--get complete description of the table
sp_help 'Employees'




/* CONSTRAINTS
--> COLUMN-LEVEL CONSTRAINTS => NOT NULL,DEFAULT,IDENTITY
-->TABLE/COLUMN LEVEL CONSTRAINT => UNIQUE,PRIMARY KEY,CHECK,FOREIGN KEY,
*/
--INSERT STATEMENT
INSERT INTO Employees(EmpId,EmpName,BirthDate,Address,Gender,Salary) values(1,'Harish','19961226','vajarahalli','m',10000)
GO
INSERT INTO Employees(EmpId,EmpName,BirthDate,Address,Gender,Salary) 
values(2,'Hari','19961226','vajarahalli','m',10000)

GO

INSERT INTO Employees(EmpId,EmpName,BirthDate,Address,Gender,Salary) 
values(3,'chinna','19961226','vajarahalli','m',10000)
,(4,'abhi','19941026','vajarahalli','m',15000)
,(5,'akshay','19961202','vajarahalli','m',10900)
,(6,'chethan','19961126','vajarahalli','m',12000)
,(7,'harish kumar','19961226','vajarahalli','m',13000)
GO
SELECT * FROM Employees
GO -- batch terminator
--change row values UPDATE

UPDATE Employees SET EmpName = 'HarishJK' WHERE EmpId=1
UPDATE Employees SET Salary=Salary+(Salary*0.10)
GO
-- remove select rows
DELETE FROM Employees WHERE EmpId = 7 --DELETE SINGLE ROW
GO
DELETE FROM Employees -- DELETES ALL THE ROW
GO

/* STORES DATA IN LINKED LIST FORMAT*/
/* TRUNCATE WILL INVALIDATE THE START POINT HENCE IT CANNOT BE RECOVERED*/
/* DELETE WILL MARK IT AS DELETED FOR EACH ROW SOMEHOW IT CAN BE RETRIVED*/

--TRUNCATE TABLE
TRUNCATE TABLE Employees
GO
SELECT * FROM Employees
GO

--ADD NEW COLUMN

ALTER TABLE Employees 
ADD City varchar(50)
GO

sp_help 'Employees'
SELECT * FROM Employees


--DROP FROM TABLE

ALTER TABLE Employees
DROP CONSTRAINT DF__Employees__City__29572725, COLUMN City
GO

ALTER TABLE Employees 
ADD City varchar(50) DEFAULT 'BENGALURU'
GO

UPDATE Employees SET City = 'Bengaluru'

--DROP TABLE

DROP TABLE Employees
GO

USE master
GO
DROP DATABASE TestDb
GO

DROP DATABASE abc
GO
SELECT * FROM sys.databases

