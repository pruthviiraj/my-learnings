WITH annual_snowfall AS (
  SELECT
    resort_id,
    resort_name,
    SUM(snowfall_inches) AS total_snowfall
  FROM resort_monthly_snowfall
  GROUP BY resort_id, resort_name
)
SELECT
  resort_id,
  resort_name,
  total_snowfall,
  NTILE(4) OVER(ORDER BY total_snowfall) AS qua_snowfall
FROM annual_snowfall
