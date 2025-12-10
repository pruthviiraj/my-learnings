SELECT
  oven_id,
  ROUND(AVG(baking_time_minutes),1) AS avg_baking_time
FROM cookie_batches
GROUP BY oven_id;
