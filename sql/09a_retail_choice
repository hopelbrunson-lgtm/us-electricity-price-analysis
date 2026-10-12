-- 09a: lookup table of states with active residential retail choice
CREATE OR REPLACE TABLE `eia-electricity-analysis.electricity.retail_choice` AS
SELECT * FROM UNNEST([
    -- Deregulated
  STRUCT('CT' AS state, 'Deregulated' AS choice),
  ('DE', 'Deregulated'), ('DC', 'Deregulated'), ('NH', 'Deregulated'), ('NJ', 'Deregulated'), ('OH', 'Deregulated'), 
  ('IL', 'Deregulated'), ('ME', 'Deregulated'), ('MD', 'Deregulated'), ('MA', 'Deregulated'), ('NY', 'Deregulated'), ('PA', 'Deregulated'),
  ('RI', 'Deregulated'), ('TX', 'Deregulated')
]);
