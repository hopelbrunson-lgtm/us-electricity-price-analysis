-- state price ranking, 2025
WITH state_price AS (
  SELECT 
    state,
    ROUND(SUM(revenue_thousand_usd) * 100/SUM(mwh), 2) AS residential_price_cents_kwh,
  FROM `eia-electricity-analysis.electricity.retail_sales`
  WHERE sector = 'Residential'
  AND year = 2025
  GROUP BY state
)

SELECT 
  state,
  residential_price_cents_kwh,
  RANK() OVER (ORDER BY residential_price_cents_kwh DESC) AS price_rank
FROM state_price
ORDER BY price_rank 

