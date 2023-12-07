-- Foreign Key Constraints

-- Employees table
ALTER TABLE Employees
ADD CONSTRAINT FK_Employees_ReportsTo
FOREIGN KEY (ReportsTo) REFERENCES Employees(EmployeeID);

-- OrderDetails table
ALTER TABLE OrderDetails
ADD CONSTRAINT FK_OrderDetails_OrderID
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID);

ALTER TABLE OrderDetails
ADD CONSTRAINT FK_OrderDetails_ProductID
FOREIGN KEY (ProductID) REFERENCES Products(ProductID);

-- Orders table
ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_CustomerID
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID);

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_EmployeeID
FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID);

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_ShipVia
FOREIGN KEY (ShipVia) REFERENCES Shippers(ShipperID);

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_TerritoryID
FOREIGN KEY (TerritoryID) REFERENCES Territories(TerritoryID);

-- Products table
ALTER TABLE Products
ADD CONSTRAINT FK_Products_CategoryID
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);

ALTER TABLE Products
ADD CONSTRAINT FK_Products_SupplierID
FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID);

-- Territories table
ALTER TABLE Territories
ADD CONSTRAINT FK_Territories_RegionID
FOREIGN KEY (RegionID) REFERENCES Region(RegionID);
