CREATE TABLE {db}.{schema}.Dim_Shippers_SCD1 (
    ShipperID_PK_SK INT IDENTITY(1, 1) PRIMARY KEY,
    ShipperID_NK INT,
    CompanyName VARCHAR(50) NOT NULL, 
    Phone VARCHAR (20)
);
