[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/find-customer-referee/)

# 584. Find Customer Referee

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 5, 2026](https://img.shields.io/badge/Solved%20Jul%205%2C%202026-555555?style=flat-square)

## How I approached it

I need to find customers who were referred by someone other than the customer with id 2, or who were not referred by anyone. My first idea was to use a subquery, but a simple `WHERE` clause can do the job. I use `OR` to cover both cases.

**How I got there:** I looked at the conditions and saw they can both be checked with a `WHERE` clause, no need for a subquery or join. The `referee_id` column is the key, and I can use `!= 2` and `IS NULL` to cover both cases.

1. Select the `name` column from the `customer` table.
2. Use `WHERE` to filter rows where `referee_id` is not 2, or where `referee_id` is `NULL`, meaning no one referred them.
3. Return all rows that pass this test, which gives me the names I want.

**Pattern to remember:** When checking multiple conditions in a `WHERE` clause, use `OR` to combine them into one clause.

**Watch out for:** Forgetting the `IS NULL` check would miss customers who were not referred by anyone.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(1)](https://img.shields.io/badge/Space-O(1)-d29922?style=flat-square)
![Runtime: 524 ms (beats 34.0%)](https://img.shields.io/badge/Runtime-524%20ms%20(beats%2034.0%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
SELECT name
FROM customer
WHERE referee_id !=2 OR referee_id IS NULL;
```

Source: [0584-find-customer-referee.sql](./0584-find-customer-referee.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Customer`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| referee_id  | int     |
+-------------+---------+
In SQL, id is the primary key column for this table.
Each row of this table indicates the id of a customer, their name, and the id of the customer who referred them.
```

Find the names of the customer that are either:

1. **referred by** any customer with `id != 2`.
2. **not referred by** any customer.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Customer table:
+----+------+------------+
| id | name | referee_id |
+----+------+------------+
| 1  | Will | null       |
| 2  | Jane | null       |
| 3  | Alex | 2          |
| 4  | Bill | null       |
| 5  | Zack | 1          |
| 6  | Mark | 2          |
+----+------+------------+
Output:
+------+
| name |
+------+
| Will |
| Jane |
| Bill |
| Zack |
+------+
```

</details>
