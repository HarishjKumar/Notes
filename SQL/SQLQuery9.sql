USE Application
GO

CREATE TABLE tbl_Image
(
ID INT PRIMARY KEY IDENTITY(1,1),
Image VARBINARY(MAX)
)

CREATE PROC sp_Image
(@Image VARBINARY(MAX))
AS
BEGIN
INSERT INTO tbl_Image(Image) VALUES(@Image)
END

select * from tbl_Image where id=1
