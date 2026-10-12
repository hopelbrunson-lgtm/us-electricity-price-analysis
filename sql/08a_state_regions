-- 08a: lookup table of US Census regions (50 states + DC)
CREATE OR REPLACE TABLE `eia-electricity-analysis.electricity.state_regions` AS
SELECT * FROM UNNEST([
  -- Northeast (9)
  STRUCT('CT' AS state, 'Northeast' AS region),
  ('ME', 'Northeast'), ('MA', 'Northeast'), ('NH', 'Northeast'),
  ('RI', 'Northeast'), ('VT', 'Northeast'), ('NJ', 'Northeast'),
  ('NY', 'Northeast'), ('PA', 'Northeast'),
  -- Midwest (12)
  ('IL', 'Midwest'), ('IN', 'Midwest'), ('MI', 'Midwest'), ('OH', 'Midwest'),
  ('WI', 'Midwest'), ('IA', 'Midwest'), ('KS', 'Midwest'), ('MN', 'Midwest'),
  ('MO', 'Midwest'), ('NE', 'Midwest'), ('ND', 'Midwest'), ('SD', 'Midwest'),
  -- South (17)
  ('DE', 'South'), ('DC', 'South'), ('FL', 'South'), ('GA', 'South'),
  ('MD', 'South'), ('NC', 'South'), ('SC', 'South'), ('VA', 'South'),
  ('WV', 'South'), ('AL', 'South'), ('KY', 'South'), ('MS', 'South'),
  ('TN', 'South'), ('AR', 'South'), ('LA', 'South'), ('OK', 'South'),
  ('TX', 'South'),
  -- West (13)
  ('AZ', 'West'), ('CO', 'West'), ('ID', 'West'), ('MT', 'West'),
  ('NV', 'West'), ('NM', 'West'), ('UT', 'West'), ('WY', 'West'),
  ('AK', 'West'), ('CA', 'West'), ('HI', 'West'), ('OR', 'West'),
  ('WA', 'West')
]);
