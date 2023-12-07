-- Create Table: OrderDetails
CREATE TABLE OrderDetails (
    OrderID INT PRIMARY KEY,
    ProductID INT PRIMARY KEY,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    Quantity INT NOT NULL,
    Discount DECIMAL(4, 15) DEFAULT 0.0
);
