--national price trend
WITH yearly_price AS(
  SELECT 
    year,
    ROUND(SUM(revenue_thousand_usd) * 100/SUM(mwh), 2) AS residential_price_cents_kwh
  FROM `eia-electricity-analysis.electricity.retail_sales`
  WHERE sector = 'Residential'
  AND year <= 2025 --excl 2026, partial
  GROUP BY year
)

SELECT 
  year, 
  residential_price_cents_kwh,
  LAG(residential_price_cents_kwh) OVER (ORDER BY year) AS prev_year_price,
  ROUND ((residential_price_cents_kwh - LAG(residential_price_cents_kwh) OVER (ORDER BY year)) /  LAG(residential_price_cents_kwh) OVER (ORDER BY year) * 100, 1) AS pct_change
FROM yearly_price
ORDER BY year 
