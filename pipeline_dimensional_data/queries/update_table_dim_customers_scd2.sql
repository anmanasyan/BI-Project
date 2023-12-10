-- Define the dates used in validity - assume whole 24-hour cycles
DECLARE @Yesterday INT =  --20210412 = 2021 * 10000 + 4 * 100 + 12
(
   YEAR(DATEADD(dd, -1, GETDATE())) * 10000
)
+ (MONTH(DATEADD(dd, -1, GETDATE())) * 100) + DAY(DATEADD(dd, -1, GETDATE())) 
DECLARE @Today INT = --20210413 = 2021 * 10000 + 4 * 100 + 13
(
   YEAR(GETDATE()) * 10000
)
+ (MONTH(GETDATE()) * 100) + DAY(GETDATE()) 
-- Outer insert - the updated records are added to the SCD2 table
DECLARE @dim_customers_SCD2 TABLE (
    CustomerID VARCHAR(5),
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
    [ValidFrom] INT,
    [ValidTo] INT,
    [IsCurrent] BIT
)

-- Merge statement
MERGE INTO {db_dim}.{schema_dim}.{table_dim}  AS DST 
USING {db_rel}.{schema_rel}.{table_rel} AS SRC
ON (SRC.CustomerID = DST.CustomerID_NK) 

-- New records inserted
WHEN NOT MATCHED THEN
    INSERT (CustomerID_NK, CompanyName, ContactName, ContactTitle, [Address], City, Region, PostalCode, Country, Phone, Fax, ValidFrom, IsCurrent) 
    VALUES (SRC.CustomerID, SRC.CompanyName, SRC.ContactName, SRC.ContactTitle, SRC.[Address], SRC.City, SRC.Region, SRC.PostalCode, SRC.Country, SRC.Phone, SRC.Fax, @Today, 1)
    
-- Existing records updated if data changes
WHEN MATCHED AND IsCurrent = 1 AND
    (
        ISNULL(DST.CompanyName, '') <> ISNULL(SRC.CompanyName, '') OR
        ISNULL(DST.ContactName, '') <> ISNULL(SRC.ContactName, '') OR
        ISNULL(DST.ContactTitle, '') <> ISNULL(SRC.ContactTitle, '') OR
        ISNULL(DST.[Address], '') <> ISNULL(SRC.[Address], '') OR
        ISNULL(DST.City, '') <> ISNULL(SRC.City, '') OR
        ISNULL(DST.Region, '') <> ISNULL(SRC.Region, '') OR
        ISNULL(DST.PostalCode, '') <> ISNULL(SRC.PostalCode, '') OR
        ISNULL(DST.Country, '') <> ISNULL(SRC.Country, '') OR
        ISNULL(DST.Phone, '') <> ISNULL(SRC.Phone, '') OR
        ISNULL(DST.Fax, '') <> ISNULL(SRC.Fax, '')
    )
THEN
    UPDATE
    SET DST.IsCurrent = 0, DST.ValidTo = @Yesterday 
OUTPUT $Action AS MergeAction, DELETED.CustomerID_NK, DELETED.CompanyName, DELETED.ContactName, DELETED.ContactTitle, DELETED.[Address], DELETED.City, DELETED.Region, DELETED.PostalCode, DELETED.Country, DELETED.Phone, DELETED.Fax,
INSERTED.CustomerID_NK, INSERTED.CompanyName, INSERTED.ContactName, INSERTED.ContactTitle, INSERTED.[Address], INSERTED.City, INSERTED.Region, INSERTED.PostalCode, INSERTED.Country, INSERTED.Phone, INSERTED.Fax;

-- Insert into the SCD2 table
INSERT INTO {db_dim}.{schema_dim}.{table_dim} (CustomerID_NK, CompanyName, ContactName, ContactTitle, [Address], City, Region, PostalCode, Country, Phone, Fax, ValidFrom, ValidTo, IsCurrent)
SELECT CustomerID, CompanyName, ContactName, ContactTitle, [Address], City, Region, PostalCode, Country, Phone, Fax, ValidFrom, ValidTo, IsCurrent
FROM @dim_customers_SCD2;

