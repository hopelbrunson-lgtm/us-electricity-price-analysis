-- residential price and usage by month, 2021-2025
WITH monthly_price AS(
SELECT
  month,
  ROUND(SUM(revenue_thousand_usd) * 100/SUM(mwh), 2) AS residential_price_cents_kwh,
  ROUND(SUM(mwh) / 5 / 1000000, 1) AS residential_million_mwh
FROM `eia-electricity-analysis.electricity.retail_sales`
WHERE year BETWEEN 2021 AND 2025
AND sector = 'Residential'
GROUP BY month
)

SELECT
  month,
  residential_price_cents_kwh,
  residential_million_mwh,
  ROUND(AVG(residential_price_cents_kwh) OVER (), 2) AS avg_price,
  ROUND((residential_price_cents_kwh - AVG(residential_price_cents_kwh) OVER ())
  / AVG(residential_price_cents_kwh) OVER () * 100, 1) AS pct_vs_avg
FROM monthly_price
ORDER BY month



