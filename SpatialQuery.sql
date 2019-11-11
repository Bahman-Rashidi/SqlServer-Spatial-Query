

USE ['your geospatial DB']
GO
/****** Object:  StoredProcedure [sde].[Abfa_Identfiy_SP]    Script Date: 11/11/2019 3:59:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 ALTER  PROCEDURE [sde].[Identfiy_SP]
 (
@ListOFTables as VARCHAR(MAX),
@PolygonStr as VARCHAR(MAX),
@SRID as int
)

 AS
 BEGIN
   DECLARE @SEPERATOR as VARCHAR(1)
   DECLARE @SP INT
   DECLARE @VALUE VARCHAR(1000)
   SET @SEPERATOR = ','
   CREATE TABLE #tempTab (id nvarchar(50) not null)

   WHILE PATINDEX('%' + @SEPERATOR + '%', @ListOFTables ) <> 0
    BEGIN
       SELECT  @SP = PATINDEX('%' + @SEPERATOR + '%',@ListOFTables)
       SELECT  @VALUE = LEFT(@ListOFTables , @SP - 1)
       SELECT  @ListOFTables = STUFF(@ListOFTables, 1, @SP, '')
       INSERT INTO #tempTab (id) VALUES (@VALUE)
    END
   CREATE TABLE #temp (objectid int not null,TableName nvarchar(50))
   declare @COUNTER int
   declare @COUNTERWhile int
   set @COUNTERWhile=0;
   select @COUNTER=(select COUNT(*) from #tempTab)
   declare @TableName nvarchar(100)
   DECLARE @g geometry;  
   DECLARE @sql_param_def nvarchar(MAX)
   DECLARE @query NVARCHAR(MAX)='';
   --SET @g = geometry::STGeomFromText(@PolygonStr, 32639);  
   SET @g = geometry::STGeomFromText(@PolygonStr, @SRID);  


   while @COUNTERWhile<@COUNTER
      begin
             set @TableName=(select  id from  #tempTab  order by id  desc OFFSET     @COUNTERWhile ROWS  FETCH NEXT 1 ROWS ONLY)
             
             --select  @COUNTERWhile
             --select @TableName
             if @COUNTERWhile<@COUNTER-1
                SET @query = @query+'SELECT objectid,'''+@TableName+''' as TableName FROM '+@TableName+'  WHERE @geobb.STIntersects(SHAPE)=1 union '
             else
                SET @query = @query+'SELECT objectid, '''+@TableName+''' as TableName FROM '+@TableName+'  WHERE @geobb.STIntersects(SHAPE)=1 '
             
             set @COUNTERWhile=@COUNTERWhile+1
      end
   set @query='insert into #temp ' + @query
   SET @sql_param_def = '@geobb geometry';
   EXEC sp_executesql @query,@sql_param_def, @geobb=@g
 
select * from #temp
    --select 111
    RETURN
   DROP TABLE #tempTab
   DROP TABLE #temp
 END
