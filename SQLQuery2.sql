use Northwind

go

create FUNCTION PhoneCheck(
    @phone as nvarchar(40)
)
RETURNS nvarchar(40)
AS 
BEGIN
   DECLARE @number AS NVARCHAR(50)
   IF LEN(@phone) = 13
		BEGIN
			SET @number = CONCAT((SUBSTRING(@phone,1,3)),' ','(',(SUBSTRING(@phone,4,3)),')', ' ',(SUBSTRING(@phone,7,3)), ' ',(SUBSTRING(@phone,10,2)), ' ',(SUBSTRING(@phone,12,2)))
		END
	ELSE IF LEN(@phone) = 12
		BEGIN
		    SET @number = CONCAT('+', (SUBSTRING(@phone,1,2)),' '
			,'(',(SUBSTRING(@phone,3,3)),')', ' ',(SUBSTRING(@phone,6,3)), ' ',(SUBSTRING(@phone,9,2)), ' ',(SUBSTRING(@phone,11,2)))
		END
		 IF LEN(@phone) = 11
		BEGIN
		    SET @number = CONCAT('+9', (SUBSTRING(@phone,1,1)),' '
			,'(',(SUBSTRING(@phone,2,3)),')', ' ',(SUBSTRING(@phone,5,3)), ' ',(SUBSTRING(@phone,8,2)), ' ',(SUBSTRING(@phone,10,2)))
		END
	ELSE IF LEN(@phone) = 10
		BEGIN
		    SET @number = CONCAT('+90', ' (', (SUBSTRING(@phone,1,3)),')',' '
			,(SUBSTRING(@phone,4,3)), ' ',(SUBSTRING(@phone,7,2)), ' ',(SUBSTRING(@phone,9,2)))
		END
	ELSE
	BEGIN
	  SET @number='0'
	  END

	 RETURN @number
END

go


create Trigger CheckPhone on Shippers
 instead of insert
 as
 begin
 DECLARE @Number AS VARCHAR(100)
 select @Number = Phone from inserted
 IF dbo.Phonecheck(@Number)='0'
	PRINT 'Number is not valid!'
	ELSE
	INSERT Shippers values((Select CompanyName from inserted),dbo.PhoneCheck(@Number))
	Select 
 end

 select * from Shippers
 insert into Shippers values('azs','9034578')




 