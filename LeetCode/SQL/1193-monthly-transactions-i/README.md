[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/monthly-transactions-i/)

# 1193. Monthly Transactions I

![Medium](https://img.shields.io/badge/Medium-ffc01e?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 14, 2026](https://img.shields.io/badge/Solved%20Jul%2014%2C%202026-555555?style=flat-square)

## How I approached it

I want to know the total transactions and their amount for each month and country, and also the approved transactions and their amount. My first idea was to use separate queries for total and approved transactions, but that can be done in one query with `GROUP BY`. I use `DATE_FORMAT` to get the month from the `trans_date`.

**How I got there:** I noticed that I need to group by both month and country, so I used `GROUP BY` with both `month` and `country`. I also saw that I need to count approved transactions separately, so I used a `CASE` statement inside `SUM`.

1. Extract the month from `trans_date` using `DATE_FORMAT` and group the table by `month` and `country`.
2. Count all transactions with `COUNT(id)` and sum all transaction amounts with `SUM(amount)`.
3. Count approved transactions with `SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END)` and sum approved transaction amounts with `SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END)`.
4. Return one row per group with the calculated values.

**Pattern to remember:** When I need to group by multiple columns and calculate different sums, I use `GROUP BY` with multiple columns and `CASE` statements inside `SUM`.

**Watch out for:** If I forget to use `ELSE 0` in the `CASE` statement, it will return `NULL` instead of 0 for declined transactions.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 671 ms (beats 22.8%)](https://img.shields.io/badge/Runtime-671%20ms%20(beats%2022.8%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
SELECT
    DATE_FORMAT(trans_date, '%Y-%m') AS 'month',
    country,
    COUNT(id) AS trans_count,
    SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM transactions
GROUP BY month, country;
```

Source: [1193-monthly-transactions-i.sql](./1193-monthly-transactions-i.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Transactions`

```text
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| country       | varchar |
| state         | enum    |
| amount        | int     |
| trans_date    | date    |
+---------------+---------+
id is the primary key of this table.
The table has information about incoming transactions.
The state column is an enum of type ["approved", "declined"].
```

Write an SQL query to find for each month and country, the number of transactions and their total amount, the number of approved transactions and their total amount.

Return the result table in **any order**.

The query result format is in the following example.

### Example 1

```text
Input:
Transactions table:
+------+---------+----------+--------+------------+
| id   | country | state    | amount | trans_date |
+------+---------+----------+--------+------------+
| 121  | US      | approved | 1000   | 2018-12-18 |
| 122  | US      | declined | 2000   | 2018-12-19 |
| 123  | US      | approved | 2000   | 2019-01-01 |
| 124  | DE      | approved | 2000   | 2019-01-07 |
+------+---------+----------+--------+------------+
Output:
+----------+---------+-------------+----------------+--------------------+-----------------------+
| month    | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
+----------+---------+-------------+----------------+--------------------+-----------------------+
| 2018-12  | US      | 2           | 1              | 3000               | 1000                  |
| 2019-01  | US      | 1           | 1              | 2000               | 2000                  |
| 2019-01  | DE      | 1           | 1              | 2000               | 2000                  |
+----------+---------+-------------+----------------+--------------------+-----------------------+
```

</details>
