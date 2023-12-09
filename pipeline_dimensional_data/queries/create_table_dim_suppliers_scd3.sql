-- Create Table: Suppliers
CREATE TABLE {db}.{schema}.Dim_Suppliers_SCD3 (
    SupplierID_PK_SK INT IDENTITY(1,1) PRIMARY KEY,
    SupplierID_NK INT,
    CompanyName VARCHAR(255) NOT NULL,
    ContactName VARCHAR(255),
    ContactName_Prev varchar(255) DEFAULT NULL,
	ContactName_Prev_ValidTo [char] (8) NULL,
    ContactTitle VARCHAR(255),
    [Address] VARCHAR(255),
    City VARCHAR(255),
    Region VARCHAR(255),
    PostalCode VARCHAR(20),
    Country VARCHAR(255),
    Phone VARCHAR(20),
    Fax VARCHAR(20),
    HomePage VARCHAR(MAX)
);
