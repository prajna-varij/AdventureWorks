SELECT 
      substring (CAST ([OrderDateKey] AS  char),1,6) as [OrderDateKey]
      ,[SalesOrderNumber]
      ,[OrderDate]
	  ,T2.SalesTerritoryCountry 
  FROM [AdventureWorksDW2022].[dbo].[FactInternetSales] T1

  JOIN [AdventureWorksDW2022].[dbo].DimSalesTerritory T2 
  ON T1. SalesTerritoryKey = T2.SalesTerritoryKey
  WHERE SalesTerritoryCountry IN ('Australia', 'United States')
  AND substring (CAST ([OrderDateKey] AS  char),1,4) = '2012'
