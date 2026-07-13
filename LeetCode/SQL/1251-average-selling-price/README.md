[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/average-selling-price/)

# 1251. Average Selling Price

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 12, 2026](https://img.shields.io/badge/Solved%20Jul%2012%2C%202026-555555?style=flat-square)

## How I approached it

I need to find the average selling price for each product, which is the total price of the product divided by the number of products sold. My first idea was to count the number of products sold and the total price separately, but I can do it in one step with a `JOIN` and `GROUP BY`. If a product does not have any sold units, its average selling price is assumed to be 0.

**How I got there:** I noticed that the `UnitsSold` table has a `purchase_date` and the `Prices` table has a `start_date` and `end_date`, so I can join these tables on `product_id` and the date range. This told me to use a `LEFT JOIN` to include products with no sales.

1. Join the `Prices` table and the `UnitsSold` table on `product_id` and the date range, to match each sale with its price.
2. Use a `LEFT JOIN` to include products with no sales, so they will have an average selling price of 0.
3. Group the results by `product_id`, so I can calculate the average selling price for each product.
4. Calculate the average selling price for each product by summing the price times the units sold and dividing by the total units sold, using `ROUND` to round to 2 decimal places.

**Pattern to remember:** When joining two tables on a date range, use `BETWEEN` to match the dates, and use `LEFT JOIN` to include rows with no matches.

**Watch out for:** If I use an `INNER JOIN` instead of a `LEFT JOIN`, products with no sales will be missing from the results.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)

```sql
SELECT
    p.product_id,
    IFNULL(ROUND(SUM(p.price * us.units)/SUM(us.units),2),0) AS average_price
FROM Prices p
LEFT JOIN UnitsSold us
    -- The date join prevents a cross-join
    ON p.product_id = us.product_id
    AND us.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id;
```

Source: [1251-average-selling-price.sql](./1251-average-selling-price.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Prices`

```text
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| start_date    | date    |
| end_date      | date    |
| price         | int     |
+---------------+---------+
(product_id, start_date, end_date) is the primary key (combination of columns with unique values) for this table.
Each row of this table indicates the price of the product_id in the period from start_date to end_date.
For each product_id there will be no two overlapping periods. That means there will be no two intersecting periods for the same product_id.
```

Table: `UnitsSold`

```text
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| purchase_date | date    |
| units         | int     |
+---------------+---------+
This table may contain duplicate rows.
Each row of this table indicates the date, units, and product_id of each product sold.
```

Write a solution to find the average selling price for each product. `average_price` should be **rounded to 2 decimal places**. If a product does not have any sold units, its average selling price is assumed to be 0.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Prices table:
+------------+------------+------------+--------+
| product_id | start_date | end_date   | price  |
+------------+------------+------------+--------+
| 1          | 2019-02-17 | 2019-02-28 | 5      |
| 1          | 2019-03-01 | 2019-03-22 | 20     |
| 2          | 2019-02-01 | 2019-02-20 | 15     |
| 2          | 2019-02-21 | 2019-03-31 | 30     |
+------------+------------+------------+--------+
UnitsSold table:
+------------+---------------+-------+
| product_id | purchase_date | units |
+------------+---------------+-------+
| 1          | 2019-02-25    | 100   |
| 1          | 2019-03-01    | 15    |
| 2          | 2019-02-10    | 200   |
| 2          | 2019-03-22    | 30    |
+------------+---------------+-------+
Output:
+------------+---------------+
| product_id | average_price |
+------------+---------------+
| 1          | 6.96          |
| 2          | 16.96         |
+------------+---------------+
Explanation:
Average selling price = Total Price of Product / Number of products sold.
Average selling price for product 1 = ((100 * 5) + (15 * 20)) / 115 = 6.96
Average selling price for product 2 = ((200 * 15) + (30 * 30)) / 230 = 16.96
```

</details>
