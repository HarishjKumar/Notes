USE master
GO

IF(EXISTS(SELECT * FROM sys.databases WHERE NAME='Application'))
DROP DATABASE Application
GO

CREATE DATABASE Application ON PRIMARY
(
NAME='Application',
FILENAME='D:\Example\Application.mdf',
SIZE = 10MB,
FILEGROWTH = 5MB
)
GO

SELECT * FROM SYS.databases WHERE NAME='Application'
GO

USE Application
GO

IF(EXISTS(SELECT * FROM SYS.tables WHERE NAME='Customer'))
DROP TABLE Customer
GO

CREATE TABLE Customer
(
CustomerID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
CustomerName VARCHAR(50) NOT NULL,
CustomerNumber BIGINT,
CustomerEmail VARCHAR(50),
CustomerState VARCHAR(20),
CustomerCity VARCHAR(20)
)
GO

SELECT * FROM SYS.tables WHERE NAME='Customer'
GO

INSERT INTO Customer (CustomerName,CustomerNumber,CustomerEmail,CustomerState,CustomerCity) VALUES('Harish',9945796278,'harish.sachin26@gmail.com','Karnataka','Bangalore')
GO
SELECT * FROM Customer
GO
--DELETE Customer
--GO

IF(EXISTS(SELECT * FROM SYS.tables WHERE NAME='Product'))
DROP TABLE Product
GO

CREATE TABLE Product
(
ProductID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
ProductName VARCHAR(50) NOT NULL,
UnitsInStock INT NOT NULL,
UnitPrice INT NOT NULL
)
GO

SELECT * FROM SYS.tables WHERE NAME='Product'
GO

INSERT INTO Product (ProductName,UnitsInStock,UnitPrice) VALUES('Cycle',25,2000)
GO
SELECT * FROM Product
GO
--DELETE Product
--GO


IF(EXISTS(SELECT * FROM SYS.tables WHERE NAME='States'))
DROP TABLE States
GO
CREATE TABLE States
(
StateID INT NOT NULL IDENTITY(1,1)
PRIMARY KEY,
StateName VARCHAR(20) UNIQUE
)
GO

IF(EXISTS(SELECT * FROM SYS.tables WHERE NAME='City'))
DROP TABLE City
GO
CREATE TABLE City
(
CityID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
CityName VARCHAR(20) UNIQUE,
StateID INT NOT NULL,
FOREIGN KEY (StateID) REFERENCES States(StateID)
ON UPDATE CASCADE
ON DELETE CASCADE
)
GO


INSERT INTO States (StateName) VALUES('KARNATAKA'),('TAMILNADU'),('TELANGANA'),('MAHARASHTRA');
GO

SELECT * FROM States
GO

--DELETE States WHERE StateID = 4
--GO

INSERT INTO City (CityName,StateID) 
VALUES ('Bengaluru',1),('Mysore',1),('Mandya',1),('Madikeri',1),('Chikkamagaluru',1),
('Chennai',2),('Madurai',2),('Kovai',2),('Kanyakumari',2),('Thirunalveli',2),
('Hyderabad',3),('Seconderabad',3),
('Mumbai',4),('Pune',4);
GO


SELECT * FROM City
GO

--DELETE City  --After Deleting also next value will be added from where the last seed existed
--GO

--TRUNCATE TABLE City --After truncate option seed is resetted
--GO

SELECT * FROM City WHERE StateID=1
GO

IF(EXISTS(SELECT * FROM sys.tables WHERE NAME='Orders'))
DROP TABLE Orders
GO

CREATE TABLE Orders
(
OrderID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
ProductID INT NOT NULL CONSTRAINT FK_PRODUCTID FOREIGN KEY REFERENCES Product(ProductID),
CustomerID INT NOT NULL CONSTRAINT FK_CUSTOMERID FOREIGN KEY REFERENCES Customer(CustomerID),
OrderQuantity INT NOT NULL,
TotalPrice BIGINT NOT NULL
)
GO


IF(EXISTS( SELECT * FROM sys.procedures WHERE NAME='sp_States'))
DROP PROCEDURE sp_States
GO

CREATE PROCEDURE sp_States
AS BEGIN
SELECT StateID, StateName FROM
States
ORDER BY StateID
END
GO

EXEC sp_States
GO

IF(EXISTS( SELECT * FROM sys.procedures WHERE NAME='sp_StateCityByStateID'))
DROP PROCEDURE sp_StateCityByStateID
GO

CREATE PROCEDURE sp_StateCityByStateID
(
@stateID INT
)
AS BEGIN
SELECT States.StateID as StateID, States.StateName as StateName,City.CityID as CityID,City.CityName as CityName FROM
States
FULL JOIN City ON States.StateID = City.StateID
WHERE States.StateID = @stateID
order by states.StateID
END
GO

EXEC sp_StateCityByStateID 1


IF(EXISTS( SELECT * FROM sys.procedures WHERE NAME='sp_StateCityByStateCityID'))
DROP PROCEDURE sp_StateCityByStateCityID
GO
CREATE PROCEDURE sp_StateCityByStateCityID
(
@stateID INT, @cityID INT
)
AS BEGIN
SELECT States.StateID as StateID, States.StateName as StateName,City.CityID as CityID,City.CityName as CityName FROM
States
FULL JOIN City ON States.StateID = City.StateID
WHERE States.StateID = @stateID AND City.CityID=@cityID
order by states.StateID
END
GO

EXEC sp_StateCityByStateCityID 1,1