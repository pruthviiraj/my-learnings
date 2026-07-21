[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/product-sales-analysis-iii/)

# 1070. Product Sales Analysis III

![Medium](https://img.shields.io/badge/Medium-ffc01e?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 21, 2026](https://img.shields.io/badge/Solved%20Jul%2021%2C%202026-555555?style=flat-square)

## How I approached it

I want to find the first year each product was sold, so I need to identify the earliest year for each product_id. My first idea was to just sort the sales by year, but that does not directly give me the first year for each product, and a subquery with `MIN(year)` does.

**How I got there:** I noticed that each product may have multiple sales entries in the same year, so I need to find the minimum year for each product_id. I thought about using a `GROUP BY` to get the minimum year for each product, then using that result to filter the sales table.

1. Group the sales table by `product_id` to get the minimum year for each product.
2. Use a subquery to find the minimum year for each `product_id`.
3. Filter the sales table to include only the rows where the `product_id` and `year` match the results of the subquery.
4. Select the `product_id`, `year` as `first_year`, `quantity`, and `price` from the filtered sales table.

**Pattern to remember:** When I need to find a specific value for each group, like the first year a product was sold, I use a subquery with `MIN` or `MAX` and `GROUP BY` to get that value, then filter the original table with the subquery results.

**Watch out for:** If I use `MIN(year)` without `GROUP BY product_id`, I get the minimum year across all products, not the minimum year for each product.

## Solution

![Time: O(n log n)](https://img.shields.io/badge/Time-O(n%20log%20n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 885 ms (beats 13.8%)](https://img.shields.io/badge/Runtime-885%20ms%20(beats%2013.8%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
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
----- Alternate approach 
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
```

Source: [1070-product-sales-analysis-iii.sql](./1070-product-sales-analysis-iii.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Sales`

```text
+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| sale_id     | int   |
| product_id  | int   |
| year        | int   |
| quantity    | int   |
| price       | int   |
+-------------+-------+
(sale_id, year) is the primary key (combination of columns with unique values) of this table.
Each row records a sale of a product in a given year.
A product may have multiple sales entries in the same year.
Note that the per-unit price.
```

Write a solution to find all sales that occurred in the **first year** each product was sold.

- For each `product_id`, identify the earliest `year` it appears in the `Sales` table.
- Return **all** sales entries for that product in that year.

Return a table with the following columns: **product_id**, ** first_year**, ** quantity,** and ** price**.
Return the result in any order.

### Example 1

```text
Input:
Sales table:
+---------+------------+------+----------+-------+
| sale_id | product_id | year | quantity | price |
+---------+------------+------+----------+-------+
| 1       | 100        | 2008 | 10       | 5000  |
| 2       | 100        | 2009 | 12       | 5000  |
| 7       | 200        | 2011 | 15       | 9000  |
+---------+------------+------+----------+-------+

Output:
+------------+------------+----------+-------+
| product_id | first_year | quantity | price |
+------------+------------+----------+-------+
| 100        | 2008       | 10       | 5000  |
| 200        | 2011       | 15       | 9000  |
+------------+------------+----------+-------+
```

</details>
