[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/find-followers-count/)

# 1729. Find Followers Count

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 22, 2026](https://img.shields.io/badge/Solved%20Jul%2022%2C%202026-555555?style=flat-square)

## How I approached it

I need to count how many followers each user has, and my first idea was to just count the rows, but I need to be careful because one user can have many followers. I can use a `GROUP BY` to count the followers for each user. This way I get the count per user, not just a total count.

**How I got there:** I looked at the table and saw that each row is one follower of one user, so I need to group these rows by `user_id` to get the count of followers per user. I noticed that if I just count all rows, I get the total number of followers, but not the count per user.

1. Go through the table and group the rows by `user_id` so each user is counted separately.
2. Count the `follower_id` for each group, which gives the number of followers for each user.
3. Order the result by `user_id` so the users are listed in order.

**Pattern to remember:** When I need to count something for each item in a group, I use a `GROUP BY` with a `COUNT`.

**Watch out for:** If I forget the `GROUP BY`, I get one total count for all users, not a count per user.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 761 ms (beats 8.4%)](https://img.shields.io/badge/Runtime-761%20ms%20(beats%208.4%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
SELECT
    user_id,
    COUNT(follower_id) AS followers_count
FROM followers
GROUP BY user_id
ORDER BY user_id;
```

Source: [1729-find-followers-count.sql](./1729-find-followers-count.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Followers`

```text
+-------------+------+
| Column Name | Type |
+-------------+------+
| user_id     | int  |
| follower_id | int  |
+-------------+------+
(user_id, follower_id) is the primary key (combination of columns with unique values) for this table.
This table contains the IDs of a user and a follower in a social media app where the follower follows the user.
```

Write a solution that will, for each user, return the number of followers.

Return the result table ordered by `user_id` in ascending order.

The result format is in the following example.

### Example 1

```text
Input:
Followers table:
+---------+-------------+
| user_id | follower_id |
+---------+-------------+
| 0       | 1           |
| 1       | 0           |
| 2       | 0           |
| 2       | 1           |
+---------+-------------+
Output:
+---------+----------------+
| user_id | followers_count|
+---------+----------------+
| 0       | 1              |
| 1       | 1              |
| 2       | 2              |
+---------+----------------+
Explanation:
The followers of 0 are {1}
The followers of 1 are {0}
The followers of 2 are {0,1}
```

</details>
