SELECT
  toy_production.toy_id,
  toy_production.toy_name
FROM toy_delivery
INNER JOIN toy_production
ON toy_delivery.toy_id = toy_production.toy_id
