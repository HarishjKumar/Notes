insert into Roots values('Clark',null,'2,3,4,5'),('Deker','1','3,4,5'),('Earl','1,2','5'),('Andrew','1,2',null),('Barney','1,2,3',null)
insert into Roots Values('C',null,null)



truncate table Roots
select * from Roots
create table Temp (ID int)
go


create proc sp_Child_to
(
@new_name varchar(20)
,@root_name varchar(20)
)
as begin
if(not Exists(select * from Roots where Roots.Name=@new_name))
begin
insert into Roots values(@new_name,null,null)
end
if(Exists((select * from Roots where Roots.Name=@new_name)))
begin
begin 
declare @Parentid varchar(10)
set @Parentid=(select id from Roots where Name=@root_name)
set @Parentid=(select CONCAT(@Parentid,','))
declare @Other_Parents varchar(10)
set @Other_Parents=(select child_to from Roots where Name=@root_name)
declare @Child_To varchar(20)
set @Child_To=(select CONCAT(@Parentid,@Other_Parents)) 
update Roots set Child_To=@Child_To where Roots.Name=@new_name
end
begin
declare @Parents varchar(20)
declare @Child_id varchar(10)
set @Child_id=(Select id from Roots Where Roots.Name=@new_name)
set @Parents=(select Child_To from Roots Where Name=@new_name)
begin
insert into Temp select value from string_split(@Parents,',')
end
declare @Count int
declare @Tempid int
declare @Tempdata varchar(20)
set @Count=(select COUNT(*) from Temp)
while(@Count!=0)
begin
set @Tempid=(select top (1) id from Temp);
set @Tempdata=(select Parent_To from Roots where Roots.Id=@Tempid);
set @Tempdata=(select concat(@Tempdata,@Child_id));
update Roots set Parent_To=@Tempdata where Id=@Tempid;
delete top (1) from Temp; 
set @Count=(@Count-1); 
end
end
end
end



exec sp_Child_to 'B','E'


select * from Roots
select * from Temp
declare @a varchar(12)
set @a=(select Child_To from Roots where id=2)
select value from string_split(@a,',')
print @a


create proc sp_child_Display
(
@Name varchar(20)
)
as begin
if(Exists(Select Name from Roots where Name=@Name))
begin
declare @Childid varchar(20)
set @Childid=(Select Parent_To from Roots where Name=@Name)
insert into Temp select value from string_split(@Childid,',')
delete top (1) from Temp
select Name,Roots.id from Roots inner join Temp on Roots.Id=Temp.ID 
end
end


create proc sp_Parent_Display
(
@Name varchar(20)
)
as begin
if(Exists(Select Name from Roots where Name=@Name))
begin
declare @Parentid varchar(20)
set @Parentid=(Select Child_To from Roots where Name=@Name)
truncate table Temp
insert into Temp select value from string_split(@Parentid,',')
select Name,Roots.id from Roots inner join Temp on Roots.Id=Temp.ID 
truncate table Temp
end
end
GO


exec sp_Parent_Display 'A'
exec sp_child_Display 'E'


insert into Temp select value from string_split('2,3,5,',',')
delete top (1) from Temp
select * from Temp
truncate table Temp
select * from Roots


select Name,Roots.id from Roots inner join Temp on Roots.Id=Temp.ID


create proc sp_Display_all
as begin
Select Name,ID from Roots order by Name ASC
end


exec sp_Display_all


select * from Contact_Management


select First_Name from Contact_Management inner join Auth on Contact_Management.contact_id=Auth.id


select * from Auth
update Contact_Management set contact_id=10 where contact_id=8 
drop table Auth


create table Auth (Id int foreign key references Contact_Management(contact_id) on delete cascade,name varchar(29))
 insert into Auth values(8,'jkdshf')
 update Auth set id=10 where id=8
 delete  Contact_Management where contact_id=9 

















