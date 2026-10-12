--data validation
SELECT 
  sector, 
  COUNT (*) AS total_rows, 
  COUNT (price_cents_kwh) AS rows_with_price, 
  COUNT(*) - COUNT(price_cents_kwh) AS null_prices, 
  MIN(month_date) AS first_month, 
  MAX(month_date) AS last_month
FROM `eia-electricity-analysis.electricity.retail_sales`
GROUP BY sector
