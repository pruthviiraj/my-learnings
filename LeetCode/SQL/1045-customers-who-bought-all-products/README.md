[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/customers-who-bought-all-products/)

# 1045. Customers Who Bought All Products

![Medium](https://img.shields.io/badge/Medium-ffc01e?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 24, 2026](https://img.shields.io/badge/Solved%20Jul%2024%2C%202026-555555?style=flat-square)

## How I approached it

I need to find customers who bought every product, so I count the distinct products each customer bought and compare that to the total number of products. My first idea was to join the tables, but that gets complicated with duplicates in the Customer table. Using `COUNT(DISTINCT product_key)` and comparing it to the total products works because it ignores duplicates.

**How I got there:** I noticed the problem lets me use a subquery to get the total number of products, which is a fixed number I can compare each customer to. I also saw that using `DISTINCT` inside the count would remove the duplicate purchases, giving me the unique products per customer.

1. Group the Customer table by `customer_id` so each customer is counted on their own.
2. Count `DISTINCT product_key` inside each group to get the unique products each customer bought.
3. Use a subquery to get the total number of products from the Product table.
4. Compare the count of distinct products for each customer to the total number of products using `HAVING`.
5. Return the `customer_id` of customers where these two counts are equal.

**Pattern to remember:** When comparing a count from one table to a total from another, use a subquery to get the total and compare inside the `HAVING` clause.

**Watch out for:** Forgetting `DISTINCT` in the count would incorrectly count duplicate purchases, leading to incorrect results.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 569 ms (beats 70.3%)](https://img.shields.io/badge/Runtime-569%20ms%20(beats%2070.3%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
SELECT customer_id
FROM customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(*) FROM Product);
```

Source: [1045-customers-who-bought-all-products.sql](./1045-customers-who-bought-all-products.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Customer`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| customer_id | int     |
| product_key | int     |
+-------------+---------+
This table may contain duplicates rows.
customer_id is not NULL.
product_key is a foreign key (reference column) to Product table.
```

Table: `Product`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_key | int     |
+-------------+---------+
product_key is the primary key (column with unique values) for this table.
```

Write a solution to report the customer ids from the `Customer` table that bought all the products in the `Product` table.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Customer table:
+-------------+-------------+
| customer_id | product_key |
+-------------+-------------+
| 1           | 5           |
| 2           | 6           |
| 3           | 5           |
| 3           | 6           |
| 1           | 6           |
+-------------+-------------+
Product table:
+-------------+
| product_key |
+-------------+
| 5           |
| 6           |
+-------------+
Output:
+-------------+
| customer_id |
+-------------+
| 1           |
| 3           |
+-------------+
Explanation:
The customers who bought all the products (5 and 6) are customers with IDs 1 and 3.
```

</details>
