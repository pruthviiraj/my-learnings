[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/)

# 1581. Customer Who Visited but Did Not Make Any Transactions

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 6, 2026](https://img.shields.io/badge/Solved%20Jul%206%2C%202026-555555?style=flat-square)

## How I approached it

I need to find customers who visited without making any transactions, so I look for visits with no matching transaction. My first idea was to find all visits and then filter out the ones with transactions, but a `LEFT JOIN` does that in one step. I use a `LEFT JOIN` to get all visits and the transactions that go with them, if any.

**How I got there:** I noticed that a visit with no transaction will have a `NULL` in the transaction columns after the join, so I can use that to filter out visits with transactions. I also need to count how many times each customer had this kind of visit, which a `GROUP BY` and `COUNT` can do.

1. Join the `Visits` table with the `Transactions` table on `visit_id` using a `LEFT JOIN` so I get all visits and any matching transactions.
2. Filter out visits that have transactions by checking for `NULL` in the `transaction_id` column.
3. Group the remaining visits by `customer_id` so I can count visits for each customer.
4. Count the number of visits for each customer with no transactions using `COUNT(v.visit_id)`.

**Pattern to remember:** Use a `LEFT JOIN` to find rows in one table with no match in another, and `WHERE` to filter out the ones that do have a match.

**Watch out for:** Forgetting the `LEFT` keyword in the join would give me only visits with transactions, which is the opposite of what I want.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)

```sql
SELECT
    v.customer_id,
    COUNT(v.visit_id) count_no_trans
FROM visits v
LEFT JOIN transactions t ON
v.visit_id = t.visit_id
WHERE t.transaction_id IS NULL
GROUP BY v.customer_id;
```

Source: [1581-customer-who-visited-but-did-not-make-any-transactions.sql](./1581-customer-who-visited-but-did-not-make-any-transactions.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Visits`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| visit_id    | int     |
| customer_id | int     |
+-------------+---------+
visit_id is the column with unique values for this table.
This table contains information about the customers who visited the mall.
```

Table: `Transactions`

```text
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| transaction_id | int     |
| visit_id       | int     |
| amount         | int     |
+----------------+---------+
transaction_id is column with unique values for this table.
This table contains information about the transactions made during the visit_id.
```

Write a solution to find the IDs of the users who visited without making any transactions and the number of times they made these types of visits.

Return the result table sorted in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Visits
+----------+-------------+
| visit_id | customer_id |
+----------+-------------+
| 1        | 23          |
| 2        | 9           |
| 4        | 30          |
| 5        | 54          |
| 6        | 96          |
| 7        | 54          |
| 8        | 54          |
+----------+-------------+
Transactions
+----------------+----------+--------+
| transaction_id | visit_id | amount |
+----------------+----------+--------+
| 2              | 5        | 310    |
| 3              | 5        | 300    |
| 9              | 5        | 200    |
| 12             | 1        | 910    |
| 13             | 2        | 970    |
+----------------+----------+--------+
Output:
+-------------+----------------+
| customer_id | count_no_trans |
+-------------+----------------+
| 54          | 2              |
| 30          | 1              |
| 96          | 1              |
+-------------+----------------+
Explanation:
Customer with id = 23 visited the mall once and made one transaction during the visit with id = 12.
Customer with id = 9 visited the mall once and made one transaction during the visit with id = 13.
Customer with id = 30 visited the mall once and did not make any transactions.
Customer with id = 54 visited the mall three times. During 2 visits they did not make any transactions, and during one visit they made 3 transactions.
Customer with id = 96 visited the mall once and did not make any transactions.
As we can see, users with IDs 30 and 96 visited the mall one time without making any transactions. Also, user 54 visited the mall twice and did not make any transactions.
```

</details>
