SELECT
  LOWER(item_name) AS items,
  LOWER(color) AS color
FROM winter_clothing
WHERE LOWER(item_name) LIKE '%sweater%';
