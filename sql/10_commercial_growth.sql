-- commercial electricity usage growth by state, 2020 vs 2025
WITH state_usage AS (
  SELECT
    state,
    SUM(CASE WHEN year = 2020 THEN mwh END) / 1000000 AS mwh_2020_millions,
    SUM(CASE WHEN year = 2025 THEN mwh END) / 1000000 AS mwh_2025_millions
  FROM `eia-electricity-analysis.electricity.retail_sales`
  WHERE sector = 'Commercial'
    AND year IN (2020, 2025)
  GROUP BY state
)

SELECT
  state,
  ROUND(mwh_2020_millions, 1) AS mwh_2020_millions,
  ROUND(mwh_2025_millions, 1) AS mwh_2025_millions,
  ROUND(mwh_2025_millions - mwh_2020_millions, 1) AS change_millions,
  ROUND((mwh_2025_millions - mwh_2020_millions) / mwh_2020_millions * 100, 1) AS pct_change,
  RANK() OVER (ORDER BY mwh_2025_millions - mwh_2020_millions DESC) AS growth_rank
FROM state_usage
ORDER BY growth_rank
