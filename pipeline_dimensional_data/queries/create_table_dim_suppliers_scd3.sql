CREATE TABLE [dbo].[DimEmployee_SCD3] (
	Employee_SK int IDENTITY(1,1),
	EmployeeID int NOT NULL,
	FirstName varchar(20) DEFAULT NULL,
	LastName varchar(25) DEFAULT NULL,
	Education varchar(25) DEFAULT NULL,
	Position varchar(25) DEFAULT NULL,
	Position_Prev1 varchar(25) DEFAULT NULL,
	Position_Prev1_ValidTo [char] (8) NULL,
	Position_Prev2 varchar(25) DEFAULT NULL,
	Position_Prev2_ValidTo [char] (8) NULL,
	YearlyIncome  int DEFAULT NULL,
	ReportsTo int DEFAULT NULL,
	DepartmentID int DEFAULT NULL,
	HireDate datetime DEFAULT NULL,
		PRIMARY KEY (Employee_SK)
	);
-- Create Table: Suppliers
CREATE TABLE {db}.{schema}.Dim_Suppliers_SCD3 (
    SupplierID_PK_SK INT IDENTITY(1,1)
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
