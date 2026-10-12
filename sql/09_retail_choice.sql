-- residential price and bill, retail choice vs. regulated states
WITH market_prices AS (
  SELECT
    COALESCE(rc.choice, 'Regulated') AS market_type,
    SUM(CASE WHEN rs.year = 2020 THEN rs.revenue_thousand_usd END) * 100
      / SUM(CASE WHEN rs.year = 2020 THEN rs.mwh END) AS price_2020,
    SUM(CASE WHEN rs.year = 2025 THEN rs.revenue_thousand_usd END) * 100
      / SUM(CASE WHEN rs.year = 2025 THEN rs.mwh END) AS price_2025,
    SUM(CASE WHEN rs.year = 2025 THEN rs.revenue_thousand_usd END) * 1000
      / SUM(CASE WHEN rs.year = 2025 THEN rs.customers END) AS avg_monthly_bill_2025
  FROM `eia-electricity-analysis.electricity.retail_sales` AS rs
  LEFT JOIN `eia-electricity-analysis.electricity.retail_choice` AS rc
    ON rs.state = rc.state
  WHERE rs.sector = 'Residential'
    AND rs.year IN (2020, 2025)
  GROUP BY COALESCE(rc.choice, 'Regulated')
)

SELECT
  market_type,
  ROUND(price_2020, 2) AS price_2020,
  ROUND(price_2025, 2) AS price_2025,
  ROUND((price_2025 - price_2020) / price_2020 * 100, 1) AS pct_change,
  ROUND(avg_monthly_bill_2025, 2) AS avg_monthly_bill_2025
FROM market_prices
ORDER BY market_type
