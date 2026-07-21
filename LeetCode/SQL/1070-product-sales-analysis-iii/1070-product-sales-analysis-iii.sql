SELECT
    product_id,
    year AS first_year,
    quantity,
    price
FROM sales
WHERE (product_id, year) IN (
    SELECT product_id, MIN(year)
    FROM sales
    GROUP BY product_id
);

---------------- Alternate approach ---------------

'''

WITH RankedSales AS (
    SELECT 
        product_id, 
        year AS first_year, 
        quantity, 
        price,
        -- Assign rank 1 to the earliest year, giving ties the same rank!
        DENSE_RANK() OVER(PARTITION BY product_id ORDER BY year ASC) as rnk
    FROM Sales
)
SELECT 
    product_id, 
    first_year, 
    quantity, 
    price
FROM RankedSales
WHERE rnk = 1;

'''
