[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/product-sales-analysis-i/)

# 1068. Product Sales Analysis I

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 6, 2026](https://img.shields.io/badge/Solved%20Jul%206%2C%202026-555555?style=flat-square)

## How I approached it

I need to report the product name, year, and price for each sale, so I join the Sales table with the Product table on the product_id. My first idea was to use a subquery, but a join is a better fit because it lets me access columns from both tables directly. I use a LEFT JOIN to include all sales, even if there is no matching product.

**How I got there:** I noticed that the product_id in the Sales table matches the product_id in the Product table, so a join is the way to go. I thought about using an INNER JOIN, but that would leave out any sales without a matching product, so I chose a LEFT JOIN instead.

1. Join the Sales table with the Product table on the product_id using a LEFT JOIN.
2. Select the product_name from the Product table, and the year and price from the Sales table.
3. Return all rows from the joined tables, with the product_name, year, and price for each sale.

**Pattern to remember:** When I need to combine data from two tables based on a common column, I use a JOIN to link them together.

**Watch out for:** Using an INNER JOIN instead of a LEFT JOIN would exclude any sales without a matching product, which is not what I want.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)

```sql
SELECT
    p.product_name,
    s.year,
    s.price
FROM sales s
LEFT JOIN product p ON
s.product_id = p.product_id;
```

Source: [1068-product-sales-analysis-i.sql](./1068-product-sales-analysis-i.sql)

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
product_id is a foreign key (reference column) to Product table.
Each row of this table shows a sale on the product product_id in a certain year.
Note that the price is per unit.
```

Table: `Product`

```text
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| product_id   | int     |
| product_name | varchar |
+--------------+---------+
product_id is the primary key (column with unique values) of this table.
Each row of this table indicates the product name of each product.
```

Write a solution to report the `product_name`, `year`, and `price` for each `sale_id` in the `Sales` table.

Return the resulting table in **any order**.

The result format is in the following example.

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
Product table:
+------------+--------------+
| product_id | product_name |
+------------+--------------+
| 100        | Nokia        |
| 200        | Apple        |
| 300        | Samsung      |
+------------+--------------+
Output:
+--------------+-------+-------+
| product_name | year  | price |
+--------------+-------+-------+
| Nokia        | 2008  | 5000  |
| Nokia        | 2009  | 5000  |
| Apple        | 2011  | 9000  |
+--------------+-------+-------+
Explanation:
From sale_id = 1, we can conclude that Nokia was sold for 5000 in the year 2008.
From sale_id = 2, we can conclude that Nokia was sold for 5000 in the year 2009.
From sale_id = 7, we can conclude that Apple was sold for 9000 in the year 2011.
```

</details>
