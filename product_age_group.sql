WITH CTE_MAIN AS 
(
SELECT T4.EnglishProductName,
		T5.EnglishProductSubcategoryName,
	DATEDIFF(MONTH, BirthDate, ORDERDATE)/12 AS AGE,
	SalesOrderNumber
  FROM [AdventureWorksDW2022].[dbo].[FactInternetSales] T1
  JOIN AdventureWorksDW2022.DBO.DimCustomer T2
  ON T1.CustomerKey = T2.CustomerKey
  JOIN AdventureWorksDW2022.DBO.DimGeography T3
  ON T2.GeographyKey = T3.GeographyKey
  JOIN AdventureWorksDW2022.DBO.DimProduct T4
  ON T1.ProductKey = T4.ProductKey
  JOIN [AdventureWorksDW2022].[dbo].[DimProductSubcategory] T5
  ON T4.ProductSubcategoryKey = T5.ProductSubCategoryKey
  )



  SELECT  EnglishProductSubcategoryName AS Product_type,
	CASE WHEN AGE < 30 THEN 'A: UNDER 30'
		WHEN AGE between  30 and 40  THEN 'B: 30 - 40'
		WHEN AGE between  40 and 50  THEN 'C: 40 - 50'
		WHEN AGE between  50 and 60  THEN 'D: 50 - 60'
		WHEN AGE > 60 THEN 'E: Over 60'
		ELSE 'Other'
		END AS age_group,
		COUNT(SalesOrderNumber) as SALES
		

  FROM CTE_MAIN
  GROUP BY EnglishProductSubcategoryName, 
  CASE WHEN AGE < 30 THEN 'A: UNDER 30'
		WHEN AGE between  30 and 40  THEN 'B: 30 - 40'
		WHEN AGE between  40 and 50  THEN 'C: 40 - 50'
		WHEN AGE between  50 and 60  THEN 'D: 50 - 60'
		WHEN AGE > 60 THEN 'E: Over 60'
		ELSE 'Other'
		END 
		ORDER BY Product_type , age_group
