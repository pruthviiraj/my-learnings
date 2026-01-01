SELECT ROUND(AVG(LAT_N), 4)
FROM (
    SELECT LAT_N, 
           ROW_NUMBER() OVER (ORDER BY LAT_N) as row_num,
           COUNT(*) OVER () as total_rows
    FROM STATION
) as subquery
WHERE row_num IN (FLOOR((total_rows + 1) / 2), CEIL((total_rows + 1) / 2));
