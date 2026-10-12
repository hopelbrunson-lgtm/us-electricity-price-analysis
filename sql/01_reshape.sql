--table reshape & data validation
CREATE OR REPLACE TABLE `eia-electricity-analysis.electricity.retail_sales` AS 
  SELECT DATE(year,month,1) AS month_date, year, month, state, data_status, sector, revenue_thousand_usd, mwh, customers, 
    NULLIF(price_cents_kwh, 0) AS price_cents_kwh --no sales (0) is treated as missing to avoid bringing averages down
FROM `eia-electricity-analysis.electricity.retail_sales_wide`
  UNPIVOT ((revenue_thousand_usd, mwh, customers, price_cents_kwh)
    FOR sector IN (
    (res_revenue, res_mwh, res_customers, res_price) AS 'Residential',
    (com_revenue, com_mwh, com_customers, com_price) AS 'Commercial',
    (ind_revenue, ind_mwh, ind_customers, ind_price) AS 'Industrial',
    (trn_revenue, trn_mwh, trn_customers, trn_price) AS 'Transportation',
    (tot_revenue, tot_mwh, tot_customers, tot_price) AS 'All sectors'
  )
);
