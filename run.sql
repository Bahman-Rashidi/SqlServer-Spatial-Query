

USE ['']
GO
--vwCustomer,vwPipe,vwSewerMain,vwTap,vwtransmission,
DECLARE	@return_value int

EXEC	@return_value = [sde].[Identfiy_SP]
		@ListOFTables = N'name of  youe  vies ,',
    --  such as @ListOFTables = N'sde.vw'',sde.vw'',sde.vwS'',',
    
		@PolygonStr = N'POLYGON ((274112.579984229 3462888.03379739,274767.836374252 3462939.05270186,274742.41717639 3462516.47054352,274112.579984229 3462888.03379739 ))',
		@SRID = 32639

SELECT	'Return Value' = @return_value

GO
