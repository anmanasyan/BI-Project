CREATE TABLE {db}.{schema}.Dim_Territories_SCD1 (
    TerritoryID_PK_SK INT IDENTITY(1, 1) PRIMARY KEY,
    TerritoryID_NK INT,
    TerritoryDescription VARCHAR(50) NOT NULL, 
    RegionID INT, 
    [ValidFrom] [datetime] NULL
);
