 
 WITH first_purchase AS 
 (
 SELECT [CustomerKey] ,[SalesAmount],[OrderDate],
      ROW_NUMBER() OVER (PARTITION BY [CustomerKey] ORDER BY [OrderDate]) AS PURCHASE_NUMBER
  FROM [AdventureWorksDW2022].[dbo].[FactInternetSales]
  ),
   
   last_purchase AS 
   (
  SELECT [CustomerKey] ,[SalesAmount],[OrderDate],
      ROW_NUMBER() OVER (PARTITION BY [CustomerKey] ORDER BY [OrderDate] DESC) AS PURCHASE_NUMBER
  FROM [AdventureWorksDW2022].[dbo].[FactInternetSales]

  )
  SELECT customerkey, sum(first_purchase_value) as first_purchase_value, sum(last_purchase_value) last_purchase_value, (sum(last_purchase_value) - sum(first_purchase_value)) AS DIFFERENCE 
  FROM
  ( SELECT CustomerKey, SalesAmount AS  first_purchase_value, null as last_purchase_value
  FROM first_purchase 
  WHERE PURCHASE_NUMBER = 1
  UNION all 
  SELECT CustomerKey, null AS  first_purchase_value, SalesAmount as last_purchase_value 
  FROM last_purchase 
  WHERE PURCHASE_NUMBER = 1) main_sq
  GROUP BY CustomerKey
  ORDER BY CustomerKey