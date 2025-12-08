SELECT
  COUNT(DISTINCT(flake_type)) AS unique_snowflakes
FROM snowfall_log
WHERE
  fall_time::date= '2025-12-24';
