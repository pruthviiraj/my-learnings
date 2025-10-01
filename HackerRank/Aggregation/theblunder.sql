SELECT
  CEIL(AVG(salary) - AVG(CAST(NULLIF(REPLACE(CAST(salary AS CHAR), '0', ''), '') AS UNSIGNED))) AS error
FROM 
  employees;
