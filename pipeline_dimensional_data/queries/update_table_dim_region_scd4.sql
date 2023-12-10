DECLARE  @Region_SCD4 TABLE
(
    RegionID_NK INT,
    RegionDescription VARCHAR(50), 
    [ValidFrom] [datetime] NULL, 
	[MergeAction] [varchar](10) NULL

) 

-- Merge statement
MERGE INTO {db_dim}.{schema_dim}.{table_dim}  AS DST 
USING {db_rel}.{schema_rel}.{table_rel} AS SRC
ON			(SRC.RegionID = DST.RegionID_NK)

WHEN NOT MATCHED THEN

INSERT (RegionID_NK, RegionDescription, ValidFrom)
VALUES (SRC.RegionID, SRC.RegionDescription, GETDATE())


WHEN MATCHED 
AND		
	 ISNULL(DST.RegionDescription,'') <> ISNULL(SRC.RegionDescription,'')   

THEN UPDATE 

SET			 
	 DST.RegionDescription = SRC.RegionDescription
	 ,DST.ValidFrom = GETDATE()

OUTPUT DELETED.RegionID_NK, DELETED.RegionDescription, DELETED.ValidFrom, $Action AS MergeAction
INTO @Region_SCD4 (RegionID_NK, RegionDescription, ValidFrom, MergeAction)
OUTPUT $Action AS MergeAction, DELETED.RegionID_NK, DELETED.RegionDescription, DELETED.ValidFrom, 
INSERTED.RegionID_NK, INSERTED.RegionDescription, INSERTED.ValidFrom
;

-- Update history table to set final date and current flag

UPDATE		TP4

SET			TP4.ValidTo = DATEADD(day, -1, GETDATE())

FROM		{db_dim}.{schema_dim}.{table_hist} TP4
			INNER JOIN @Region_SCD4 TMP
			ON TP4.RegionID_NK = TMP.RegionID_NK

WHERE		TP4.ValidTo IS NULL


-- Add latest history records to history table
INSERT INTO {db_dim}.{schema_dim}.{table_hist} (RegionID_NK, RegionDescription, ValidFrom, ValidTo)
SELECT RegionID_NK, RegionDescription, ValidFrom, DATEADD(DAY, -1, GETDATE())
FROM @Region_SCD4
WHERE RegionID_NK IS NOT NULL
;