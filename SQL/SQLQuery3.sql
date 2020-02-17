--use master
--GO
/*
IF(EXISTS(SELECT * FROM sys.databases WHERE NAME = 'CanarysManagement'))
DROP DATABASE CanarysManagement
GO

CREATE DATABASE CanarysManagement ON PRIMARY
(
NAME = 'CanarysManagement'
, FILENAME = 'D:\ContactManagement\Canarys.ManagementADO\CanarysManagement.mdf'
, SIZE = 10MB
, FILEGROWTH = 5MB
)
GO
*/

--SELECT * FROM sys.databases
--GO

--USE CanarysManagement
--GO

/*																						CREATE CONTACT TABLE
IF(EXISTS( SELECT * FROM sys.tables WHERE NAME='ContactManagement'))
DROP TABLE ContactManagement
GO
CREATE TABLE ContactManagement
(
ContactId INT IDENTITY(100,1) NOT NULL
,FirstName VARCHAR(50) NOT NULL
,MiddleName VARCHAR(50) 
,LastName VARCHAR(50) 
,BirthDate DATE
,EmailId VARCHAR(50) 
,PhoneNo BIGINT
,WorkLocation VARCHAR(50)
,HomeLocation VARCHAR(50)
,Is_Active BIT DEFAULT(1)
PRIMARY KEY(ContactId)
)
GO
*/


-- GET ALL THE DETAILS OF ALL CONTACT
/*
IF(EXISTS( SELECT * FROM sys.procedures WHERE NAME='sp_GETALLCONTACT'))
DROP PROCEDURE sp_GETALLCONTACT
GO

CREATE PROCEDURE sp_GETALLCONTACT
AS BEGIN
SELECT ContactId   
,FirstName 
,MiddleName  
,LastName   
,BirthDate   
,EmailId
,PhoneNo   
,WorkLocation
,HomeLocation  
FROM ContactManagement 
WHERE Is_Active = 1
END
*/
-- GET DETAILS OF CONTACT BY ID

/*																						GET CONTACT
IF(EXISTS( SELECT * FROM sys.procedures WHERE NAME='sp_GETCONTACT'))
DROP PROCEDURE sp_GETCONTACT
GO

CREATE PROCEDURE sp_GETCONTACT
(
@ContactId INT
)
AS BEGIN
SELECT ContactId   
,FirstName 
,MiddleName  
,LastName   
,BirthDate   
,EmailId
,PhoneNo   
,WorkLocation
,HomeLocation  
FROM ContactManagement 
WHERE ContactId = @ContactId AND Is_Active = 1
END
*/

/*
-- ADD CONTACT

IF(EXISTS( SELECT * FROM sys.procedures WHERE NAME='sp_INSERTCONTACT'))
DROP PROCEDURE sp_INSERTCONTACT
GO
																				INSERT CONTACT
CREATE PROCEDURE sp_INSERTCONTACT
(
@FirstName VARCHAR(50) 
,@MiddleName VARCHAR(50) 
,@LastName VARCHAR(50) 
,@BirthDate DATE 
,@EmailId VARCHAR(50) 
,@PhoneNo BIGINT 
,@WorkLocation VARCHAR(50)
,@HomeLocation VARCHAR(50)
,@Is_Active BIT
)
AS BEGIN
INSERT INTO ContactManagement (
FirstName
,MiddleName
,LastName
,BirthDate
,EmailId 
,PhoneNo
,WorkLocation
,HomeLocation
,Is_Active
) 
VALUES(
@FirstName 
,@MiddleName  
,@LastName 
,@BirthDate
,@EmailId  
,@PhoneNo
,@WorkLocation
,@HomeLocation
,@Is_Active
)
END
*/


/*
																		UPDATE CONTACT
-- UPDATE CONTACT

IF(EXISTS( SELECT * FROM sys.procedures WHERE NAME='sp_UPDATECONTACT'))
DROP PROCEDURE sp_UPDATECONTACT
GO

EXEC sp_UPDATECONTACT 9,'hari','','','','',9945796278,'Noupdate',''
																						UPDATE CONTACT
CREATE PROCEDURE sp_UPDATECONTACT
(
@ContactId INT
,@FirstName VARCHAR(50)
,@MiddleName VARCHAR(50) 
,@LastName VARCHAR(50)
,@BirthDate DATE 
,@EmailId VARCHAR(50) 
,@PhoneNo BIGINT 
,@WorkLocation VARCHAR(50)
,@HomeLocation VARCHAR(50)
)
AS BEGIN
UPDATE  ContactManagement SET 
FirstName = CASE WHEN @FirstName != '' OR @FirstName != NULL THEN @FirstName ELSE FirstName END,
MiddleName = CASE WHEN @MiddleName != '' OR @MiddleName != NULL THEN @MiddleName ELSE MiddleName END,
LastName = CASE WHEN @LastName != '' OR @LastName != NULL THEN @LastName ELSE LastName END,
BirthDate = CASE WHEN @BirthDate != '01-01-1753' OR @BirthDate != NULL THEN @BirthDate ELSE BirthDate END,
EmailId = CASE WHEN @EmailId != '' OR @EmailId != NULL THEN @EmailId ELSE EmailId END,
PhoneNo = CASE WHEN @PhoneNo != '' OR @PhoneNo != NULL THEN @PhoneNo ELSE PhoneNo END,
WorkLocation = CASE WHEN @WorkLocation != '' OR @WorkLocation != NULL THEN @WorkLocation ELSE WorkLocation END,
HomeLocation = CASE WHEN @HomeLocation != '' OR @HomeLocation != NULL THEN @HomeLocation ELSE HomeLocation END
WHERE ContactId = @ContactId AND Is_Active = 1
END
*/




/*																		DELETE CONTACT
-- DELETE CONTACT
IF(EXISTS( SELECT * FROM sys.procedures WHERE NAME='sp_DELETECONTACT'))
DROP PROCEDURE sp_DELETECONTACT
GO
*/
/*																						DELETE CONTACT
CREATE PROCEDURE sp_DELETECONTACT
(
@ContactId INT
)
AS BEGIN
UPDATE  ContactManagement SET 
Is_Active = 0
WHERE ContactId = @ContactId AND Is_Active = 1
END
*/

/*																				Retrive
IF(EXISTS( SELECT * FROM sys.procedures WHERE NAME='sp_RETRIVECONTACT'))
DROP PROCEDURE sp_RETRIVECONTACT
GO

CREATE PROCEDURE sp_RETRIVECONTACT
(
@ContactId INT
)
AS BEGIN
IF (@ContactId = 0)
BEGIN
UPDATE  ContactManagement SET 
Is_Active = 1
END
ELSE 
BEGIN
UPDATE  ContactManagement SET 
Is_Active = 1
WHERE ContactId = @ContactId
END
END
*/

 --exec sp_GETCONTACT 0
 
 /*
 INSERT INTO ContactManagement VALUES(6, 'hari','j','k','19961226','sample',987645864,'8465565','8645312',1)

 SELECT * FROM ContactManagement

 exec sp_RETRIVECONTACT 0
 */
 EXEC sp_INSERTCONTACT 'chiinna','s','a','19970708','chinna@gmaail.com',987645864,'Pavagada','Bengaluru',1

  EXEC sp_UPDATECONTACT 100,'hari','j','k','01-01-0001','email',987645864,'Bengaluru','Bengaluru'

 select * from ContactManagement

 --TRUNCATE Table ContactManagement -- starts from beginning
 --DELETE ContactManagement -- starts from where the last entry found

 --EXEC sp_RETRIVECONTACT 0
