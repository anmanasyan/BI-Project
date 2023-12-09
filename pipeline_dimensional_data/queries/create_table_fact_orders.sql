-- Create Table: Orders
CREATE TABLE {db}.{schema}.Fact_Orders (
    OrderID_SK_PK INT IDENTITY(1, 1) PRIMARY KEY,
    OrderID_NK INT,
    CustomerID VARCHAR(5),
    EmployeeID INT,
    OrderDate DATE,
    RequiredDate DATE,
    ShippedDate DATE,
    ShipVia INT,
    Freight DECIMAL(10, 2),
    ShipName VARCHAR(255),
    ShipAddress VARCHAR(255),
    ShipCity VARCHAR(255),
    ShipRegion VARCHAR(255),
    ShipPostalCode VARCHAR(20),
    ShipCountry VARCHAR(255),
    TerritoryID INT
);
