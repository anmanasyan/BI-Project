-- Create Table: Products
CREATE TABLE {db}.{schema}.Dim_Products_SCD1 (
    ProductID_PK_SK INT IDENTITY(1, 1) PRIMARY KEY,
    ProductID_NK INT,
    ProductName VARCHAR(255) NOT NULL,
    SupplierID INT,
    CategoryID INT,
    QuantityPerUnit VARCHAR(255),
    UnitPrice DECIMAL(10, 2),
    UnitsInStock INT,
    UnitsOnOrder INT,
    ReorderLevel INT,
    Discontinued BIT
);
