SELECT
  builder_id,
  builder_name,
  COUNT(DISTINCT(candy_type)) AS candy_count
FROM gingerbread_designs
GROUP BY builder_id, builder_name
HAVING COUNT(DISTINCT(candy_type)) >= 4;
