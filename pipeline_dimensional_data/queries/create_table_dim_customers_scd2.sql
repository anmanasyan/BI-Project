-- Create Table: Customers
CREATE TABLE {db}.{schema}.Dim_Customers_SCD2 (
    CustomerID_PK_SK INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID_NK VARCHAR(5),
    CompanyName VARCHAR(255) NOT NULL,
    ContactName VARCHAR(255),
    ContactTitle VARCHAR(255),
    [Address] VARCHAR(255),
    City VARCHAR(255),
    Region VARCHAR(255),
    PostalCode VARCHAR(20),
    Country VARCHAR(255),
    Phone VARCHAR(50),
    Fax VARCHAR(50), 
    ValidFrom INT NULL,
	ValidTo INT NULL,
	IsCurrent BIT NULL
);