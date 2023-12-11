DECLARE  @Territories_SCD4 TABLE
(
    TerritoryID_NK INT,
    TerritoryDescription VARCHAR(50), 
    RegionID INT, 
	RegionID_SK INT, 
	[ValidFrom] [datetime] NULL,
	[MergeAction] [varchar](10) NULL

) 

-- Merge statement
MERGE INTO {db_dim}.{schema_dim}.{table_dim}  AS DST 
USING (SELECT p.*, b.RegionID_PK_SK FROM
		 {db_rel}.{schema_rel}.{table_rel} p
		 LEFT JOIN {db_dim}.{schema_dim}.{dim_region_scd1} b ON p.RegionID = b.RegionID_NK
		 ) AS SRC -- source
ON	(SRC.TerritoryID = DST.TerritoryID_NK)

WHEN NOT MATCHED THEN

INSERT (TerritoryID_NK, TerritoryDescription, RegionID, RegionID_SK, ValidFrom)
VALUES (SRC.TerritoryID, SRC.TerritoryDescription, SRC.RegionID, SRC.RegionID_PK_SK, GETDATE())


WHEN MATCHED 
AND	(
	 ISNULL(DST.TerritoryDescription,'') <> ISNULL(SRC.TerritoryDescription,'')
	 OR ISNULL(DST.RegionID_SK,'') <> ISNULL(SRC.RegionID_PK_SK,'') 
	 OR ISNULL(DST.RegionID,'') <> ISNULL(SRC.RegionID,''))

THEN UPDATE 

SET			 
	 DST.TerritoryDescription = SRC.TerritoryDescription
	 ,DST.RegionID = SRC.RegionID
	 ,DST.RegionID_SK = SRC.RegionID_PK_SK
	 ,DST.ValidFrom = GETDATE()

OUTPUT DELETED.TerritoryID_NK, DELETED.TerritoryDescription, DELETED.RegionID,  DELETED.RegionID_SK, DELETED.ValidFrom, $Action AS MergeAction
INTO @Territories_SCD4 (TerritoryID_NK, TerritoryDescription, RegionID, RegionID_SK, ValidFrom, MergeAction)
OUTPUT $Action AS MergeAction, DELETED.TerritoryID_NK, DELETED.TerritoryDescription, DELETED.RegionID, DELETED.RegionID_SK, DELETED.ValidFrom, 
INSERTED.TerritoryID_NK, INSERTED.TerritoryDescription, INSERTED.RegionID, INSERTED.RegionID_SK, INSERTED.ValidFrom
;

-- Update history table to set final date and current flag

UPDATE		TP4

SET			TP4.ValidTo = DATEADD(day, -1, GETDATE())

FROM		{db_dim}.{schema_dim}.{table_hist} TP4
			INNER JOIN @Territories_SCD4 TMP
			ON TP4.TerritoryID_NK = TMP.TerritoryID_NK

WHERE		TP4.ValidTo IS NULL


-- Add latest history records to history table
INSERT INTO {db_dim}.{schema_dim}.{table_hist} (TerritoryID_NK, TerritoryDescription, RegionID,  RegionID_SK, ValidFrom, ValidTo)
SELECT TerritoryID_NK, TerritoryDescription, RegionID, RegionID_SK, ValidFrom, DATEADD(DAY, -1, GETDATE())
FROM @Territories_SCD4
WHERE TerritoryID_NK IS NOT NULL
;