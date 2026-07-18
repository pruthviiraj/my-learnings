[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/user-activity-for-the-past-30-days-i/)

# 1141. User Activity for the Past 30 Days I

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 18, 2026](https://img.shields.io/badge/Solved%20Jul%2018%2C%202026-555555?style=flat-square)

## How I approached it

I need to count how many users were active each day, and any activity makes a user active. My first idea was to count all activities, but that counts the same user multiple times if they do more than one thing in a day. I use `COUNT(DISTINCT user_id)` to count each user only once per day.

**How I got there:** I noticed the problem only cares about days with at least one active user, so I do not need to worry about days with no activity. I also saw that the `activity_date` column already has the date I need, so I can group by that.

1. Go through the `activity` table and filter out rows where `activity_date` is not in the last 30 days, using `BETWEEN '2019-06-26' AND '2019-07-27'`.
2. Group the remaining rows by `activity_date` so I can count active users for each day.
3. Count `DISTINCT user_id` for each group, which gives me the number of active users for that day.

**Pattern to remember:** When counting things that can appear more than once, use `COUNT(DISTINCT ...)` to avoid double counting.

**Watch out for:** Forgetting the `DISTINCT` keyword would count the same user multiple times if they have multiple activities in a day.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 487 ms (beats 75.3%)](https://img.shields.io/badge/Runtime-487%20ms%20(beats%2075.3%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
SELECT
    activity_date AS day,
    COUNT(DISTINCT user_id) AS active_users
FROM activity
WHERE
    activity_date BETWEEN '2019-06-28' AND '2019-07-27'
GROUP BY activity_date;
```

Source: [1141-user-activity-for-the-past-30-days-i.sql](./1141-user-activity-for-the-past-30-days-i.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Activity`

```text
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| session_id    | int     |
| activity_date | date    |
| activity_type | enum    |
+---------------+---------+
This table may have duplicate rows.
The activity_type column is an ENUM (category) of type ('open_session', 'end_session', 'scroll_down', 'send_message').
The table shows the user activities for a social media website.
Note that each session belongs to exactly one user.
```

Write a solution to find the daily active user count for a period of `30` days ending `2019-07-27` inclusively. A user was active on someday if they made at least one activity on that day.

Return the result table in **any order**.

The result format is in the following example.

Note: **Any** activity from (`'open_session'`, `'end_session'`, `'scroll_down'`, `'send_message'`) will be considered valid activity for a user to be considered active on a day.

### Example 1

```text
Input:
Activity table:
+---------+------------+---------------+---------------+
| user_id | session_id | activity_date | activity_type |
+---------+------------+---------------+---------------+
| 1       | 1          | 2019-07-20    | open_session  |
| 1       | 1          | 2019-07-20    | scroll_down   |
| 1       | 1          | 2019-07-20    | end_session   |
| 2       | 4          | 2019-07-20    | open_session  |
| 2       | 4          | 2019-07-21    | send_message  |
| 2       | 4          | 2019-07-21    | end_session   |
| 3       | 2          | 2019-07-21    | open_session  |
| 3       | 2          | 2019-07-21    | send_message  |
| 3       | 2          | 2019-07-21    | end_session   |
| 4       | 3          | 2019-06-25    | open_session  |
| 4       | 3          | 2019-06-25    | end_session   |
+---------+------------+---------------+---------------+
Output:
+------------+--------------+
| day        | active_users |
+------------+--------------+
| 2019-07-20 | 2            |
| 2019-07-21 | 2            |
+------------+--------------+
Explanation: Note that we do not care about days with zero active users.
```

</details>
