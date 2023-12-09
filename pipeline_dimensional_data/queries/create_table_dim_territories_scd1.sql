CREATE TABLE {db}.{schema}.Territories (
    TerritoryID_PK_SK INT IDENTITY(1, 1) PRIMARY KEY,
    TerritoryID INT,
    TerritoryDescription VARCHAR(50) NOT NULL, 
    RegionID INT, 
    [ValidFrom] [datetime] NULL
);
