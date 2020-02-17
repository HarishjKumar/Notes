USE master
GO

IF(EXISTS(SELECT * FROM sys.databases WHERE NAME='Test'))
DROP DATABASE Test
GO

CREATE DATABASE Test ON PRIMARY
(
NAME = 'Test',
FILENAME='D:\Test\Test.mdf',
SIZE = 10MB,
FILEGROWTH = 5MB
)
GO

USE Test
GO

IF(EXISTS(SELECT * FROM sys.tables WHERE NAME='UserDetails'))
DROP TABLE UserDetails
GO

CREATE TABLE UserDetails
(
ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
Name VARCHAR(50) NOT NULL,
Email VARCHAR(50) NOT NULL UNIQUE,
Password VARCHAR(50) NOT NULL,
Phone_Number BIGINT UNIQUE
)
GO

SELECT * FROM UserDetails
