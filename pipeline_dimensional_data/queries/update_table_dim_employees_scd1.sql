MERGE INTO {db_dim}.{schema_dim}.{table_dim}  AS TARGET
USING {db_rel}.{schema_rel}.{table_rel} AS SOURCE-- source
ON (TARGET.EmployeeID_NK = SOURCE.EmployeeID) 
--When records are matched, update the records if there is any change
WHEN MATCHED AND (
  Isnull(TARGET.LastName, '') <> Isnull(SOURCE.LastName, '')  OR
  Isnull(TARGET.FirstName, '') <> Isnull(SOURCE.FirstName, '') OR
  Isnull(TARGET.Title, '') <> Isnull(SOURCE.Title, '')  OR
  Isnull(TARGET.TitleOfCourtesy, '') <> Isnull(SOURCE.TitleOfCourtesy, '')  OR
  Isnull(TARGET.BirthDate, '') <> Isnull(SOURCE.Birthdate, '') OR
  Isnull(TARGET.HireDate, '') <> Isnull(SOURCE.HireDate, '')  OR
  Isnull(TARGET.[Address], '') <> Isnull(SOURCE.[Address], '') OR
  Isnull(TARGET.City, '') <> Isnull(SOURCE.City, '')  OR
  Isnull(TARGET.Region, '') <> Isnull(SOURCE.Region, '')  OR
  Isnull(TARGET.PostalCode, '') <> Isnull(SOURCE.PostalCode, '') OR
  Isnull(TARGET.Country, '') <> Isnull(SOURCE.Country, '')  OR
  Isnull(TARGET.HomePhone, '') <> Isnull(SOURCE.HomePhone, '')  OR
  Isnull(TARGET.Extension, '') <> Isnull(SOURCE.Extension, '')  OR
  Isnull(TARGET.ReportsTo, '') <> Isnull(SOURCE.ReportsTo, '') OR
 -- Isnull(TARGET.ReportsTo_SK, '') <> Isnull(SOURCE.CategoryName, '')  OR
  Isnull(TARGET.PhotoPath, '') <> Isnull(SOURCE.PhotoPath, '')
  )

THEN UPDATE 

SET			 
	TARGET.LastName = SOURCE.LastName,
	TARGET.FirstName = SOURCE.FirstName,
	TARGET.Title = SOURCE.Title,
	TARGET.TitleOfCourtesy = SOURCE.TitleOfCourtesy,
	TARGET.BirthDate = SOURCE.Birthdate,
	TARGET.HireDate = SOURCE.HireDate,
	TARGET.[Address] = SOURCE.[Address],
	TARGET.City = SOURCE.City,
	TARGET.Region = SOURCE.Region,
	TARGET.PostalCode = SOURCE.PostalCode,
	TARGET.Country = SOURCE.Country,
	TARGET.HomePhone = SOURCE.HomePhone,
	TARGET.Extension = SOURCE.Extension,
	TARGET.ReportsTo = SOURCE.ReportsTo,
	TARGET.PhotoPath = SOURCE.PhotoPath
--When no records are matched, insert the incoming records from source table to target table
WHEN NOT MATCHED BY TARGET 
THEN INSERT (EmployeeID_NK,	LastName,	FirstName,	Title,	TitleOfCourtesy, BirthDate,	HireDate,	[Address],	City,	Region,	PostalCode,	Country,	HomePhone,	Extension,	Notes,	ReportsTo,	PhotoPath) 
VALUES (
	SOURCE.EmployeeID,
	SOURCE.LastName,
	SOURCE.FirstName,
	SOURCE.Title,
	SOURCE.TitleOfCourtesy,
	SOURCE.BirthDate,
	SOURCE.HireDate,
	SOURCE.[Address],
	SOURCE.City,
	SOURCE.Region,
	SOURCE.PostalCode,
	SOURCE.Country,
	SOURCE.HomePhone,
	SOURCE.Extension,
	SOURCE.Notes,
	SOURCE.ReportsTo,
	SOURCE.PhotoPath
	)
--When there is a row that exists in target and same record does not exist in source then delete this record target
WHEN NOT MATCHED BY SOURCE 
THEN DELETE 
--$action specifies a column of type nvarchar(10) in the OUTPUT clause that returns 
--one of three values for each row: 'INSERT', 'UPDATE', or 'DELETE' according to the action that was performed on that row
OUTPUT $action, 
DELETED.EmployeeID_NK,	
DELETED.LastName,	
DELETED.FirstName,	
DELETED.Title,	
DELETED.TitleOfCourtesy, 
DELETED.BirthDate,	
DELETED.HireDate,	
DELETED.[Address],	
DELETED.City,	
DELETED.Region,	
DELETED.PostalCode,	
DELETED.Country,	
DELETED.HomePhone,	
DELETED.Extension,	
DELETED.Notes,	
DELETED.ReportsTo,	
DELETED.PhotoPath,
INSERTED.EmployeeID_NK, 
INSERTED.LastName, 
INSERTED.FirstName, 
INSERTED.Title, 
INSERTED.TitleOfCourtesy, 
INSERTED.BirthDate, 
INSERTED.HireDate, 
INSERTED.[Address], 
INSERTED.City, 
INSERTED.Region, 
INSERTED.PostalCode, 
INSERTED.Country, 
INSERTED.HomePhone, 
INSERTED.Extension, 
INSERTED.Notes, 
INSERTED.ReportsTo, 
INSERTED.PhotoPath;

-- updating ReportTo_SK

UPDATE e1
SET e1.ReportsTo_SK = e2.EmployeeID_NK
FROM {db_dim}.{schema_dim}.{table_dim} e1
JOIN {db_dim}.{schema_dim}.{table_dim} e2 ON e1.ReportsTo = e2.EmployeeID_NK;
