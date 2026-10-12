-- state price change, 2020 v 2025
WITH state_price AS (
  SELECT
    state,
    SUM(CASE WHEN year = 2020 THEN revenue_thousand_usd END) * 100
      / SUM(CASE WHEN year = 2020 THEN mwh END) AS price_2020,
    SUM(CASE WHEN year = 2025 THEN revenue_thousand_usd END) * 100
      / SUM(CASE WHEN year = 2025 THEN mwh END) AS price_2025
  FROM `eia-electricity-analysis.electricity.retail_sales`
  WHERE sector = 'Residential'
    AND year IN (2020, 2025)
  GROUP BY state
),

price_change AS (
  SELECT
    state,
    price_2020,
    price_2025,
    (price_2025 - price_2020) / price_2020 * 100 AS pct_change
  FROM state_price
)

SELECT
  state,
  ROUND(price_2020, 2) AS price_2020,
  ROUND(price_2025, 2) AS price_2025,
  ROUND(pct_change, 1) AS pct_change,
  RANK() OVER (ORDER BY pct_change DESC) AS change_rank
FROM price_change
ORDER BY change_rank
