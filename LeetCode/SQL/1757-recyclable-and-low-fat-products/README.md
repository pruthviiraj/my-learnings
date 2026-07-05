[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/recyclable-and-low-fat-products/)

# 1757. Recyclable and Low Fat Products

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 5, 2026](https://img.shields.io/badge/Solved%20Jul%205%2C%202026-555555?style=flat-square)

## How I approached it

I need to find products that are both low fat and recyclable, so I look for rows where `low_fats` is 'Y' and `recyclable` is 'Y'. My first idea was to use multiple queries, but a single `SELECT` with a `WHERE` clause can do this. I use `AND` to combine the two conditions.

**How I got there:** I noticed that the problem asks for products with two specific properties, so I thought about how to filter the table to get only those rows. The `WHERE` clause is what filters rows, and `AND` is what combines conditions.

1. Select the `product_id` column from the `products` table.
2. Use a `WHERE` clause to filter the rows to only those where `low_fats` is 'Y'.
3. Use `AND` to add another condition to the `WHERE` clause, filtering further to only rows where `recyclable` is also 'Y'.
4. Return the resulting table with only the `product_id` of products that meet both conditions.

**Pattern to remember:** When filtering a table based on multiple conditions, use `AND` to combine them in a single `WHERE` clause.

**Watch out for:** Forgetting to use quotes around the 'Y' and 'N' values in the `WHERE` clause could cause a syntax error.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 529 ms (beats 77.8%)](https://img.shields.io/badge/Runtime-529%20ms%20(beats%2077.8%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
SELECT product_id
FROM products
WHERE low_fats = 'Y' AND recyclable = 'Y';
```

Source: [1757-recyclable-and-low-fat-products.sql](./1757-recyclable-and-low-fat-products.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Products`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_id  | int     |
| low_fats    | enum    |
| recyclable  | enum    |
+-------------+---------+
product_id is the primary key (column with unique values) for this table.
low_fats is an ENUM (category) of type ('Y', 'N') where 'Y' means this product is low fat and 'N' means it is not.
recyclable is an ENUM (category) of types ('Y', 'N') where 'Y' means this product is recyclable and 'N' means it is not.
```

Write a solution to find the ids of products that are both low fat and recyclable.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Products table:
+-------------+----------+------------+
| product_id  | low_fats | recyclable |
+-------------+----------+------------+
| 0           | Y        | N          |
| 1           | Y        | Y          |
| 2           | N        | Y          |
| 3           | Y        | Y          |
| 4           | N        | N          |
+-------------+----------+------------+
Output:
+-------------+
| product_id  |
+-------------+
| 1           |
| 3           |
+-------------+
Explanation: Only products 1 and 3 are both low fat and recyclable.
```

</details>
