-- Create Table: Dim Categories
CREATE TABLE {db}.{schema}.Dim_Categories_SCD1 (
    CategoryID_PK_SK INT IDENTITY(1,1) PRIMARY KEY, 
    CategoryID_NK INT,
    CategoryName VARCHAR(255) NOT NULL,
    [Description] VARCHAR(MAX)
);
