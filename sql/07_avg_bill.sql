--average monthly residential bill by state, 2025
WITH state_bill AS(
SELECT 
  state,
  (SUM(revenue_thousand_usd) * 100 / SUM(mwh)) AS price_cents_kwh,
  (SUM(mwh) * 1000 / SUM(customers)) AS household_usage
FROM `eia-electricity-analysis.electricity.retail_sales`
WHERE year = 2025
AND sector = 'Residential'
GROUP BY state
)

SELECT 
  state,
  ROUND(price_cents_kwh, 2) AS price_cents_kwh,
  ROUND(household_usage, 0) AS household_usage,
  ROUND(household_usage * price_cents_kwh / 100, 2) AS avg_monthly_bill,
  RANK() OVER (ORDER BY household_usage * price_cents_kwh DESC) AS bill_rank
FROM state_bill
ORDER BY bill_rank
