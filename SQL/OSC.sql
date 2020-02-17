USE master
/*--------------------------------------	CREATE DATEBASE	-------------------------------------------*/
IF(EXISTS(SELECT * FROM sys.databases WHERE NAME='OSC'))
DROP DATABASE OSC
GO

CREATE DATABASE OSC ON PRIMARY
(
NAME='OSC',
FILENAME='D:\Projects\OSC\OSC.mdf',
SIZE = 10MB,
FILEGROWTH = 5MB
)
GO

/*--------------------------------------	USE DATEBASE	-------------------------------------------*/
USE OSC
GO

/*--------------------------------------	CREATE TABLE	-------------------------------------------*/
/*--------------------------------------	TABLE Admin_Login		-------------------------------------------*/

IF(EXISTS(SELECT * FROM sys.tables WHERE NAME='tbl_Login'))
DROP TABLE tbl_Login
GO

CREATE TABLE tbl_Login
(
AdminID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
AdminName VARCHAR(50) NOT NULL,
AdminEmail VARCHAR(50) NOT NULL UNIQUE,
AdminPassword VARCHAR(50) NOT NULL,
AdminImage VARBINARY(MAX),
CreatedDate DATETIME
--UNIQUEIDENTIFIER IS FOR INT
)
GO 

/*--------------------------------------	TABLE Product_Category		-------------------------------------------*/

IF(EXISTS(SELECT * FROM sys.tables WHERE NAME='tbl_Category'))
DROP TABLE tbl_Category
GO

CREATE TABLE tbl_Category
(
CategoryID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
CategoryName VARCHAR(50) NOT NULL UNIQUE,
CategoryImage VARBINARY(MAX)
--UNIQUEIDENTIFIER IS FOR INT
)
GO 

/*--------------------------------------	TABLE Product	-------------------------------------------*/

IF(EXISTS(SELECT * FROM sys.tables WHERE NAME='tbl_Product'))
DROP TABLE tbl_Product
GO

CREATE TABLE tbl_Product
(
ProductID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
ProductName VARCHAR(50) NOT NULL UNIQUE,
ProductImage VARBINARY(MAX),
TotalUnits INT NOT NULL,
UnitPrice BIGINT NOT NULL,
CategoryID INT FOREIGN KEY REFERENCES tbl_Category(CategoryID)
ON UPDATE CASCADE
ON DELETE CASCADE
)
GO

/*--------------------------------------	TABLE Customer		-------------------------------------------*/

IF(EXISTS(SELECT * FROM SYS.tables WHERE NAME='tbl_Customer'))
DROP TABLE tbl_Customer
GO

CREATE TABLE tbl_Customer
(
CustomerID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
CustomerName VARCHAR(50) NOT NULL,
CustomerNumber BIGINT,
CustomerEmail VARCHAR(50) NOT NULL UNIQUE,
CustomerPassword VARCHAR(25) NOT NULL ,
CustomerCountry VARCHAR(50) NOT NULL,
CustomerState VARCHAR(20) NOT NULL,
CustomerCity VARCHAR(20) NOT NULL,
CustomerImage VARBINARY(50),
CreatedDate DATETIME,
IsActive BIT
)
GO

/*--------------------------------------	TABLE Country		-------------------------------------------*/

IF(EXISTS(SELECT * FROM SYS.tables WHERE NAME='tbl_Country'))
DROP TABLE tbl_Country
GO

CREATE TABLE tbl_Country
(
CountryID INT NOT NULL IDENTITY(1,1)
PRIMARY KEY,
CountryName VARCHAR(20) NOT NULL UNIQUE
)
GO

/*--------------------------------------	TABLE State		-------------------------------------------*/

IF(EXISTS(SELECT * FROM SYS.tables WHERE NAME='tbl_State'))
DROP TABLE tbl_State
GO
CREATE TABLE tbl_State
(
StateID INT NOT NULL IDENTITY(1,1)
PRIMARY KEY,
StateName VARCHAR(20)NOT NULL UNIQUE,
CountryID INT FOREIGN KEY REFERENCES tbl_Country(CountryID)
ON UPDATE CASCADE
ON DELETE CASCADE
)
GO

/*--------------------------------------	TABLE City		-------------------------------------------*/

IF(EXISTS(SELECT * FROM SYS.tables WHERE NAME='tbl_City'))
DROP TABLE tbl_City
GO

CREATE TABLE tbl_City
(
CityID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
CityName VARCHAR(20) NOT NULL UNIQUE,
StateID INT,
FOREIGN KEY (StateID) REFERENCES tbl_State(StateID)
ON UPDATE CASCADE
ON DELETE CASCADE
)
GO

/*--------------------------------------	TABLE Orders		-------------------------------------------*/

IF(EXISTS(SELECT * FROM sys.tables WHERE NAME='tbl_Orders'))
DROP TABLE tbl_Orders
GO

CREATE TABLE tbl_Orders
(
OrderID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
ProductID INT NOT NULL CONSTRAINT FK_PRODUCTID FOREIGN KEY REFERENCES tbl_Product(ProductID),
CustomerID INT NOT NULL CONSTRAINT FK_CUSTOMERID FOREIGN KEY REFERENCES tbl_Customer(CustomerID),
OrderQuantity INT NOT NULL,
TotalPrice BIGINT NOT NULL,
OrderDate DATETIME NOT NULL
)
GO



/*--------------------------------------	Stored Procedure	-------------------------------------------*/
/*--------------------------------------	TABLE Admin_Login		-------------------------------------------*/


