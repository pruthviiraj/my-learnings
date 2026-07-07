[← Python · Pandas](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/customers-who-never-order/)

# 183. Customers Who Never Order

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![Python](https://img.shields.io/badge/Python-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 7, 2026](https://img.shields.io/badge/Solved%20Jul%207%2C%202026-555555?style=flat-square)

## How I approached it

I want to find customers who have no orders, so I look for rows in the `Customers` table where there is no match in the `Orders` table. My first idea was to use a `NOT IN` query, but a `LEFT JOIN` is a better fit here because it makes it easy to see which customers have no orders. I use a `LEFT JOIN` to combine the two tables, then filter for rows where the order data is missing.

**How I got there:** I noticed that the `Customers` table and the `Orders` table can be connected by the `id` and `customerId` columns, so I thought about how to use that connection to find customers with no orders. I realized that if I join the tables and then look for rows where the order data is missing, I will find the customers who have no orders.

1. Join the `Customers` and `Orders` tables with a `LEFT JOIN` on the `id` and `customerId` columns.
2. Filter the joined table for rows where the order data is missing, which means the `customerId` column is `NaN`.
3. Select only the `name` column from the filtered table and rename it to `Customers`.

**Pattern to remember:** Use a `LEFT JOIN` to find rows in one table that have no match in another table.

**Watch out for:** Forgetting to use `how='left'` in the `merge` function would cause the query to only return customers who have orders.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 287 ms (beats 50.1%)](https://img.shields.io/badge/Runtime-287%20ms%20(beats%2050.1%25)-2cbb5d?style=flat-square)
![Memory: 67.9 MB (beats 35.4%)](https://img.shields.io/badge/Memory-67.9%20MB%20(beats%2035.4%25)-2f81f7?style=flat-square)

```python
import pandas as pd

def find_customers(customers: pd.DataFrame, orders: pd.DataFrame) -> pd.DataFrame:

    # Join tables
    df_merge = customers.merge(orders, how='left', left_on='id', right_on='customerId')

    # Filter for rows where the order data is missing (NaN)
    df_missing_orders = df_merge[df_merge['customerId'].isna()]

    df_result = df_missing_orders[['name']].rename(columns={'name':'Customers'})

    return df_result
```

Source: [0183-customers-who-never-order.py](./0183-customers-who-never-order.py)

<details>
<summary><b>Problem statement</b></summary>

Table: `Customers`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the ID and name of a customer.
```

Table: `Orders`

```text
+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| customerId  | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
customerId is a foreign key (reference columns) of the ID from the Customers table.
Each row of this table indicates the ID of an order and the ID of the customer who ordered it.
```

Write a solution to find all customers who never order anything.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Customers table:
+----+-------+
| id | name  |
+----+-------+
| 1  | Joe   |
| 2  | Henry |
| 3  | Sam   |
| 4  | Max   |
+----+-------+
Orders table:
+----+------------+
| id | customerId |
+----+------------+
| 1  | 3          |
| 2  | 1          |
+----+------------+
Output:
+-----------+
| Customers |
+-----------+
| Henry     |
| Max       |
+-----------+
```

</details>
