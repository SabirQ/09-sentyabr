use Northwind

go

ALTER FUNCTION PhoneCheck(
    @name nvarchar(40),
    @phone nvarchar(24)
)
RETURNS nvarchar(40)
AS 
BEGIN
if (Len(@phone) >=12)

    RETURN @name;
END;

go

create Trigger ChangeFormat on Shippers
 instead of insert
 as
 begin
 DECLARE @Name AS VARCHAR(100)
 DECLARE @Number AS VARCHAR(100)
 set @Name=(select CompanyName from INSERTED)
 set @Number=(select Phone from INSERTED)
 
 EXEC  PhoneCheck @Name,@Number

 end;

 insert into Shippers values('azs','453543')