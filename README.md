# SqlServer-Spatial-Query
 A Stored procedure for selecting data base  on a Polygon 


do  a spatial query  on sql server  by using Views that created  by  arcgis sde  
 at first  you  have to register you layers to generate  sde.''evw  views..  please  pay attention to  sde  user 
 
 after that  you have to generate  you own view  by  using above  Views 
 
 yu can use this stucture  for  creating  your own views 
 
 SELECT        ISNULL(CAST(OBJECTID AS int), 0) AS OBJECTID, 

--  -your column names
FROM            (SELECT        OBJECTID, 

--your column names
                           FROM           
 sde.''_evw) AS viewWithPrimaryKey
 
 
 now  run the   PROCEDURE
 
 and  execute it..
 
 
 the PROCEDURE  wil be return  OBJECTSIDs  and Table names
