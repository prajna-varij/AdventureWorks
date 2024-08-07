SELECT 
	OrderDateKey,
	OrderDate,
	SalesOrderNumber,
	SalesAmount,
	BirthDate,
	YearlyIncome,
	TotalChildren,
	EnglishCountryRegionName,
	EnglishProductName,
	EnglishProductSubcategoryName

  FROM [AdventureWorksDW2022].[dbo].[FactInternetSales] T1
  join dbo.DimCustomer t2
  on t1.CustomerKey = t2.CustomerKey
  join dbo.DimGeography t3
  on t2.GeographyKey = t3.GeographyKey
  join dbo.DimProduct t4
  on t1.ProductKey = t4.ProductKey
  join dbo.DimProductSubcategory t5
  on t4.ProductSubcategoryKey = t5.ProductSubcategoryKey
  where OrderDate between '20130101' and '20131231'