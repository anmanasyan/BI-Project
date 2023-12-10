CREATE TABLE {db}.{schema}.Dim_Region_SCD1 (
    RegionID_PK_SK INT IDENTITY(1, 1) PRIMARY KEY,
    RegionID_NK INT,
    RegionDescription VARCHAR(50) NOT NULL, 
    [ValidFrom] [datetime] NULL
);
