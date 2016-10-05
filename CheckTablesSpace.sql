
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--
--	Database admin
--
--	2016-09-22
--
--	Check table space used and unused per table in a database.
--
--	João Perdigão
--
----------------------------------------------------------------------------------------------------------------------------------------------------------------------

--USE [db_name];

SELECT		t.NAME																	AS [Table Name]
		,s.Name																	AS [Schema Name]
		,p.rows																	AS [# Rows]
		,CONVERT(DECIMAL(14,4), (SUM(CONVERT(DECIMAL(14,4),a.total_pages)) * 8) / 1000)								AS [Total Space (Mb)]
		,CONVERT(DECIMAL(14,4), (SUM(CONVERT(DECIMAL(14,4),a.used_pages)) * 8) / 1000)								AS [Used Space (Mb)]
		,CONVERT(DECIMAL(14,4),((SUM(CONVERT(DECIMAL(14,4),a.total_pages)) - SUM(CONVERT(DECIMAL(14,4),a.used_pages))) * 8) / 1000)		AS [Unused Space (Mb)]

FROM		sys.tables t

INNER JOIN	sys.indexes i 
ON		t.OBJECT_ID = i.object_id

INNER JOIN  	sys.partitions p 
ON		i.object_id = p.OBJECT_ID 
AND		i.index_id = p.index_id

INNER JOIN  	sys.allocation_units a 
ON		p.partition_id = a.container_id

LEFT JOIN   	sys.schemas s 
ON		t.schema_id = s.schema_id

WHERE		1=1
AND		t.NAME NOT LIKE 'dt%' 
AND		t.is_ms_shipped = 0
AND		i.OBJECT_ID > 255 
GROUP BY    	t.Name
		,s.Name
		,p.Rows
ORDER BY    	[Used Space (Mb)] desc ;

----------------------------------------------------------------------------END---------------------------------------------------------------------------------------
