# U.S. Electricity Price Analysis (SQL)

An analysis of U.S. electricity prices, usage, and bills by state from 2010 through mid-2026, using monthly EIA data and SQL in BigQuery. The project looks at how residential prices have changed, why price and bill rankings tell different stories, how deregulated and regulated states compare, and where commercial demand (including data centers) is growing fastest.

## Key Findings

- **Residential prices are up 33% since 2019.** The national average rose from 13.01¢ to 17.30¢ per kWh, with the largest single-year jump in 2022 (+10.1%).
- **Prices vary more than 3x by state.** In 2025, Hawaii averaged 40.59¢/kWh and North Dakota 11.81¢. New England holds 5 of the 10 most expensive spots.
- **A high price does not mean a high bill.** Alabama has the 3rd highest average bill ($185/month) at only 16.1¢/kWh because households use 1,152 kWh a month, more than double Hawaii's 511 kWh.
- **The South pays the least per kWh but has the highest bills.** Southern households averaged $164/month at 14.9¢, while the Northeast paid 24.3¢ but used about 40% less electricity.
- **Prices rose faster in deregulated states.** States with residential retail choice averaged 19.47¢ in 2025 vs. 16.25¢ in regulated states, and rose 37.5% since 2020 vs. 28.2%.
- **Commercial demand is surging in Virginia.** Commercial usage grew by 30.1 million MWh (+56%) from 2020 to 2025, the largest increase of any state and consistent with data center expansion. Nationally, commercial usage grew 16%.
- **Prices don't peak in summer.** Usage peaks in July and August, but the average price is lowest in January (6.8% below average) and highest in September and October (about 4% above).

## Data

- **Source:** U.S. Energy Information Administration, [Form EIA-861M](https://www.eia.gov/electricity/data/eia861m/), "Sales and revenue" file (Monthly-States sheet)
- **Coverage:** January 2010 to July 2026, 50 states + DC, 5 sectors (Residential, Commercial, Industrial, Transportation, All sectors)
- **Lookup tables (built in SQL):** U.S. Census regions, and states with active residential retail choice (based on EIA's description of retail choice programs)

## Methods

- Reshaped the source file from wide format (one column set per sector) to long format (one row per state, month, and sector).
- Validated row counts, missing values, and date coverage before analysis.
- Calculated prices as **weighted averages** (total revenue ÷ total kWh) rather than averaging state prices, so larger states carry more weight.
- Calculated average monthly bills as total revenue ÷ total customer-months.
- Techniques used: CTEs, window functions (LAG, RANK, AVG OVER), conditional aggregation (CASE WHEN), UNPIVOT, INNER and LEFT JOINs, COALESCE.

## Data Dictionary (`retail_sales` table)

| Column | Description | Unit |
|---|---|---|
| month_date | First day of the month | Date |
| year, month | Calendar year and month | Integer |
| state | Two-letter state code | Text |
| data_status | Final or Preliminary (subject to revision) | Text |
| sector | Residential, Commercial, Industrial, Transportation, or All sectors | Text |
| revenue_thousand_usd | Total amount billed to customers | Thousand dollars |
| mwh | Electricity sold | Megawatthours |
| customers | Number of customer accounts | Count |
| price_cents_kwh | Average all-in price (revenue ÷ kWh), including energy, delivery, and fixed charges | Cents per kWh |

## Query Index

| File | Description |
|---|---|
| 01_reshape.sql | Reshapes the raw EIA file into one row per state, month, and sector |
| 02_validation.sql | Checks row counts, missing prices, and date coverage |
| 03_national_price_trend.sql | National residential price by year with year-over-year change |
| 04_state_price_rank.sql | Ranks states by 2025 residential price |
| 05_state_price_change.sql | Residential price change by state, 2020 vs. 2025 |
| 06_seasonality.sql | Residential price and usage by month, 2021 to 2025 |
| 07_avg_bill.sql | Average monthly residential bill by state, 2025 |
| 08a_state_regions.sql | Creates the Census region lookup table |
| 08_regional_comparison.sql | Price, usage, and bill by region, 2025 |
| 09a_retail_choice.sql | Creates the retail choice lookup table |
| 09_retail_choice.sql | Deregulated vs. regulated states, 2020 vs. 2025 |
| 10_commercial_growth.sql | Commercial electricity usage growth by state, 2020 vs. 2025 |

## Limitations

- 2025 and 2026 data are **preliminary** and may be revised by EIA.
- In states with retail choice, part of the residential sales is **estimated** by EIA rather than reported directly.
- Prices are average effective rates (revenue ÷ kWh), not tariff rates.
- The retail choice comparison shows a **correlation, not a cause**. Many deregulated states are in the high-cost Northeast.
- Commercial sector data cannot isolate data centers from other commercial customers.

## Next Steps

- Add utility-level data (annual EIA-861) to analyze specific utilities and service areas, such as commercial growth in Northern Virginia.
- Control for region when comparing deregulated and regulated states.

## Tools

Google BigQuery (GoogleSQL), Google Sheets for initial file cleanup
