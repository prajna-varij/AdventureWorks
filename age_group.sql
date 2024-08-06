WITH CTE_MAIN AS 
(
SELECT t3.EnglishCountryRegionName,
DATEDIFF(MONTH, BirthDate, ORDERDATE)/12 AS AGE,
SalesOrderNumber
  FROM [AdventureWorksDW2022].[dbo].[FactInternetSales] T1
  JOIN AdventureWorksDW2022.DBO.DimCustomer T2
  ON T1.CustomerKey = T2.CustomerKey
  JOIN AdventureWorksDW2022.DBO.DimGeography T3
  ON T2.GeographyKey = T3.GeographyKey
  )


  SELECT EnglishCountryRegionName,
	CASE WHEN AGE < 30 THEN 'A: UNDER 30'
		WHEN AGE between  30 and 40  THEN 'B: 30 - 40'
		WHEN AGE between  40 and 50  THEN 'C: 40 - 50'
		WHEN AGE between  50 and 60  THEN 'D: 50 - 60'
		WHEN AGE > 60 THEN 'E: Over 60'
		ELSE 'Other'
		END AS age_group,
		count(salesordernumber) as sales 

  FROM CTE_MAIN
  GROUP BY EnglishCountryRegionName,
  CASE WHEN AGE < 30 THEN 'A: UNDER 30'
		WHEN AGE between  30 and 40  THEN 'B: 30 - 40'
		WHEN AGE between  40 and 50  THEN 'C: 40 - 50'
		WHEN AGE between  50 and 60  THEN 'D: 50 - 60'
		WHEN AGE > 60 THEN 'E: Over 60'
		ELSE 'Other'
		END 
		ORDER BY EnglishCountryRegionName, age_group
