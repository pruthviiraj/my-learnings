[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/confirmation-rate/)

# 1934. Confirmation Rate

![Medium](https://img.shields.io/badge/Medium-ffc01e?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 10, 2026](https://img.shields.io/badge/Solved%20Jul%2010%2C%202026-555555?style=flat-square)

## How I approached it

I need to calculate the confirmation rate for each user, which is the number of 'confirmed' messages divided by the total number of requested confirmation messages. My first idea was to count the messages separately, but using `AVG` with a `CASE` statement is a more straightforward way to get the rate in one step. I also need to account for users with no confirmation messages, so I use a `LEFT JOIN`.

**How I got there:** I started by looking at the `Confirmations` table and saw that each row represents a confirmation request, so I can use `CASE` to mark the 'confirmed' ones. Then I realized I could use `AVG` to calculate the rate, since it ignores `NULL` values and will give 0 for users with no requests. I also noticed that I need to join the `Signups` table to include users with no confirmation requests.

1. Join the `Signups` table with the `Confirmations` table on `user_id` using a `LEFT JOIN`, so I include users with no confirmation requests.
2. Use a `CASE` statement inside `AVG` to mark 'confirmed' messages as 1 and 'timeout' messages as 0.
3. Group the results by `user_id` to get one rate per user.
4. Use `ROUND` to limit the confirmation rate to two decimal places.

**Pattern to remember:** Using `AVG` with a `CASE` statement can simplify calculations that involve counting specific types of rows.

**Watch out for:** Forgetting the `LEFT JOIN` would exclude users with no confirmation requests, resulting in incorrect results.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 623 ms (beats 97.5%)](https://img.shields.io/badge/Runtime-623%20ms%20(beats%2097.5%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
SELECT
    s.user_id,
    ROUND(AVG(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END), 2)AS confirmation_rate
FROM signups s
LEFT JOIN confirmations c
    ON s.user_id = c.user_id
GROUP BY s.user_id;
```

Source: [1934-confirmation-rate.sql](./1934-confirmation-rate.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Signups`

```text
+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
+----------------+----------+
user_id is the column of unique values for this table.
Each row contains information about the signup time for the user with ID user_id.
```

Table: `Confirmations`

```text
+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
| action         | ENUM     |
+----------------+----------+
(user_id, time_stamp) is the primary key (combination of columns with unique values) for this table.
user_id is a foreign key (reference column) to the Signups table.
action is an ENUM (category) of the type ('confirmed', 'timeout')
Each row of this table indicates that the user with ID user_id requested a confirmation message at time_stamp and that confirmation message was either confirmed ('confirmed') or expired without confirming ('timeout').
```

The **confirmation rate** of a user is the number of `'confirmed'` messages divided by the total number of requested confirmation messages. The confirmation rate of a user that did not request any confirmation messages is `0`. Round the confirmation rate to ** two decimal** places.

Write a solution to find the **confirmation rate** of each user.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Signups table:
+---------+---------------------+
| user_id | time_stamp          |
+---------+---------------------+
| 3       | 2020-03-21 10:16:13 |
| 7       | 2020-01-04 13:57:59 |
| 2       | 2020-07-29 23:09:44 |
| 6       | 2020-12-09 10:39:37 |
+---------+---------------------+
Confirmations table:
+---------+---------------------+-----------+
| user_id | time_stamp          | action    |
+---------+---------------------+-----------+
| 3       | 2021-01-06 03:30:46 | timeout   |
| 3       | 2021-07-14 14:00:00 | timeout   |
| 7       | 2021-06-12 11:57:29 | confirmed |
| 7       | 2021-06-13 12:58:28 | confirmed |
| 7       | 2021-06-14 13:59:27 | confirmed |
| 2       | 2021-01-22 00:00:00 | confirmed |
| 2       | 2021-02-28 23:59:59 | timeout   |
+---------+---------------------+-----------+
Output:
+---------+-------------------+
| user_id | confirmation_rate |
+---------+-------------------+
| 6       | 0.00              |
| 3       | 0.00              |
| 7       | 1.00              |
| 2       | 0.50              |
+---------+-------------------+
Explanation:
User 6 did not request any confirmation messages. The confirmation rate is 0.
User 3 made 2 requests and both timed out. The confirmation rate is 0.
User 7 made 3 requests and all were confirmed. The confirmation rate is 1.
User 2 made 2 requests where one was confirmed and the other timed out. The confirmation rate is 1 / 2 = 0.5.
```

</details>
