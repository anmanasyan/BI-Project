MERGE {db_dim}.{schema_dim}.{table_dim} AS DST -- destination
USING {db_rel}.{schema_rel}.{table_rel} AS SRC -- source
ON ( SRC.ProductID = DST.ProductID_NK )
WHEN NOT MATCHED THEN -- there are IDs in the source table that are not in the destination table
  INSERT (ProductID_NK,
          ProductName,
          SupplierID,
          CategoryID,
          QuantityPerUnit,
          UnitPrice,
          UnitsInStock,
          UnitsOnOrder,
          ReorderLevel,
          Discontinued)
  VALUES (SRC.ProductID,
          SRC.ProductName,
          SRC.SupplierID,
          SRC.CategoryID,
          SRC.QuantityPerUnit,
          SRC.UnitPrice,
          SRC.UnitsInStock,
          SRC.UnitsOnOrder,
          SRC.ReorderLevel,
          SRC.Discontinued)
WHEN MATCHED AND  (
  Isnull(DST.ProductName, '') <> Isnull(SRC.ProductName, '')  OR
  Isnull(DST.SupplierID, '') <> Isnull(SRC.SupplierID, '')  OR
  Isnull(DST.CategoryID, '') <> Isnull(SRC.CategoryID, '')  OR
  Isnull(DST.QuantityPerUnit, '') <> Isnull(SRC.QuantityPerUnit, '')  OR
  Isnull(DST.UnitPrice, '') <> Isnull(SRC.UnitPrice, '')  OR
  Isnull(DST.UnitsInStock, '') <> Isnull(SRC.UnitsInStock, '')  OR
  Isnull(DST.UnitsOnOrder, '') <> Isnull(SRC.UnitsOnOrder, '')  OR
  Isnull(DST.ReorderLevel, '') <> Isnull(SRC.ReorderLevel, '')  OR
  Isnull(DST.Discontinued, '') <> Isnull(SRC.Discontinued, ''))
	THEN
		UPDATE SET DST.ProductName = SRC.ProductName,
             DST.SupplierID = SRC.SupplierID,
             DST.CategoryID = SRC.CategoryID,
             DST.QuantityPerUnit = SRC.QuantityPerUnit,
             DST.UnitPrice = SRC.UnitPrice,
             DST.UnitsInStock = SRC.UnitsInStock,
             DST.UnitsOnOrder = SRC.UnitsOnOrder,
             DST.ReorderLevel = SRC.ReorderLevel,
             DST.Discontinued = SRC.Discontinued

OUTPUT $action, 
DELETED.ProductID_NK AS TargetProductID, 
DELETED.ProductName AS TargetProductName, 
DELETED.SupplierID AS TargetSupplierID, 
DELETED.CategoryID AS TargetCategoryID, 
DELETED.QuantityPerUnit AS TargetQuantityPerUnit, 
DELETED.UnitPrice AS TargetUnitPrice, 
DELETED.UnitsInStock AS TargetUnitsInStock, 
DELETED.UnitsOnOrder AS TargetUnitsOnOrder,
DELETED.ReorderLevel AS TargetReorderLevel, 
DELETED.Discontinued AS TargetDiscontinued,
INSERTED.ProductID_NK AS SourceProductID, 
INSERTED.ProductName AS SourceProductName, 
INSERTED.SupplierID AS SourceSupplierID, 
INSERTED.CategoryID AS SourceCategoryID, 
INSERTED.QuantityPerUnit AS SourceQuantityPerUnit, 
INSERTED.UnitPrice AS SourceUnitPrice, 
INSERTED.UnitsInStock AS SourceUnitsInStock, 
INSERTED.UnitsOnOrder AS SourceUnitsOnOrder,
INSERTED.ReorderLevel AS SourceReorderLevel, 
INSERTED.Discontinued AS TargetDiscontinued; 