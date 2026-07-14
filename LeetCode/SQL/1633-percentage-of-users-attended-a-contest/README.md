[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/percentage-of-users-attended-a-contest/)

# 1633. Percentage of Users Attended a Contest

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 13, 2026](https://img.shields.io/badge/Solved%20Jul%2013%2C%202026-555555?style=flat-square)

## How I approached it

I want to find the percentage of users who registered for each contest, so I need to count the users for each contest and divide by the total number of users. My first idea was to use a subquery to get the total number of users, and then use that in my main query. This way fits because it is simple and easy to understand.

**How I got there:** I noticed that I need to get the total number of users, and I can do that with a subquery. I also need to group the register table by contest_id, so I can get the count of users for each contest.

1. Select the contest_id from the register table.
2. Count the user_id for each contest_id and multiply by 100.0 to get the percentage.
3. Divide the count by the total number of users, which I get with a subquery on the users table.
4. Round the percentage to 2 decimal places with the ROUND function.
5. Group the results by contest_id and order by percentage in descending order, and then by contest_id in ascending order.

**Pattern to remember:** Use a subquery to get a total count, and then use that in the main query to calculate a percentage.

**Watch out for:** Forgetting to multiply by 100.0 would give a percentage that is too small.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 1067 ms (beats 35.3%)](https://img.shields.io/badge/Runtime-1067%20ms%20(beats%2035.3%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
SELECT
    contest_id,
    ROUND(COUNT(user_id) * 100.0 / (SELECT COUNT(user_id) FROM users), 2) AS percentage
FROM register
GROUP BY contest_id
ORDER BY percentage DESC, contest_id;
```

Source: [1633-percentage-of-users-attended-a-contest.sql](./1633-percentage-of-users-attended-a-contest.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Users`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| user_id     | int     |
| user_name   | varchar |
+-------------+---------+
user_id is the primary key (column with unique values) for this table.
Each row of this table contains the name and the id of a user.
```

Table: `Register`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| contest_id  | int     |
| user_id     | int     |
+-------------+---------+
(contest_id, user_id) is the primary key (combination of columns with unique values) for this table.
Each row of this table contains the id of a user and the contest they registered into.
```

Write a solution to find the percentage of the users registered in each contest rounded to **two decimals**.

Return the result table ordered by `percentage` in **descending order**. In case of a tie, order it by `contest_id` in ** ascending order**.

The result format is in the following example.

### Example 1

```text
Input:
Users table:
+---------+-----------+
| user_id | user_name |
+---------+-----------+
| 6       | Alice     |
| 2       | Bob       |
| 7       | Alex      |
+---------+-----------+
Register table:
+------------+---------+
| contest_id | user_id |
+------------+---------+
| 215        | 6       |
| 209        | 2       |
| 208        | 2       |
| 210        | 6       |
| 208        | 6       |
| 209        | 7       |
| 209        | 6       |
| 215        | 7       |
| 208        | 7       |
| 210        | 2       |
| 207        | 2       |
| 210        | 7       |
+------------+---------+
Output:
+------------+------------+
| contest_id | percentage |
+------------+------------+
| 208        | 100.0      |
| 209        | 100.0      |
| 210        | 100.0      |
| 215        | 66.67      |
| 207        | 33.33      |
+------------+------------+
Explanation:
All the users registered in contests 208, 209, and 210. The percentage is 100% and we sort them in the answer table by contest_id in ascending order.
Alice and Alex registered in contest 215 and the percentage is ((2/3) * 100) = 66.67%
Bob registered in contest 207 and the percentage is ((1/3) * 100) = 33.33%
```

</details>
