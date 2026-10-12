-- residential price, usage, and bill by region, 2025
WITH region_bill AS(
SELECT 
  sr.region,
  (SUM(revenue_thousand_usd) * 100 / SUM(mwh)) AS price_cents_kwh,
  (SUM(mwh) * 1000 / SUM(customers)) AS household_usage
FROM `eia-electricity-analysis.electricity.retail_sales` rs
INNER JOIN `eia-electricity-analysis.electricity.state_regions` sr on sr.state = rs.state
WHERE rs.year = 2025
AND rs.sector = 'Residential'
GROUP BY sr.region
)

SELECT 
  region,
  ROUND(price_cents_kwh, 2) AS price_cents_kwh,
  ROUND(household_usage, 0) AS household_usage,
  ROUND(household_usage * price_cents_kwh / 100, 2) AS avg_monthly_bill,
  RANK() OVER (ORDER BY household_usage * price_cents_kwh DESC) AS bill_rank
FROM region_bill
ORDER BY bill_rank
