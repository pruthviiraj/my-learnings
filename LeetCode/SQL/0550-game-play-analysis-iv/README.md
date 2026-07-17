[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/game-play-analysis-iv/)

# 550. Game Play Analysis IV

![Medium](https://img.shields.io/badge/Medium-ffc01e?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 17, 2026](https://img.shields.io/badge/Solved%20Jul%2017%2C%202026-555555?style=flat-square)

## How I approached it

I find the first login date for each player and then check if they logged in the next day. My first idea was to compare each day to the previous one, but that does not work because a player can have gaps in their login days. I use a `LEFT JOIN` to count players who logged in the next day.

**How I got there:** I noticed that the `player_id` and `event_date` make a unique pair, so I can find the first login date for each player by taking the minimum `event_date` for each `player_id`. Then I can join this with the `activity` table to see who logged in the next day.

1. Find the first login date for each player by taking the minimum `event_date` for each `player_id` and store it in a temporary result `first_login`.
2. Join `first_login` with the `activity` table on `player_id` and the date one day after the first login date.
3. Count the number of players who logged in the next day by counting the non-NULL `player_id` in the joined table.
4. Count the total number of players by counting the `player_id` in the `first_login` table.
5. Divide the count of players who logged in the next day by the total count of players and round to 2 decimal places.

**Pattern to remember:** When I need to compare each item to its first occurrence, I can use a subquery to find the first occurrence and then join it with the original table.

**Watch out for:** If I use an `INNER JOIN` instead of a `LEFT JOIN`, I will only count players who logged in the next day and miss the players who did not.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 627 ms (beats 30.9%)](https://img.shields.io/badge/Runtime-627%20ms%20(beats%2030.9%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
WITH first_login AS (
    SELECT 
        player_id, 
        MIN(event_date) AS first_date
    FROM activity
    GROUP BY player_id
)
SELECT 
    -- If a player logged in on Day 2, a.player_id will exist. If not, it will be NULL!
    ROUND(COUNT(a.player_id) / COUNT(fl.player_id), 2) AS fraction
FROM first_login fl
LEFT JOIN activity a
    ON fl.player_id = a.player_id 
    AND a.event_date = DATE_ADD(fl.first_date, INTERVAL 1 DAY);
```

Source: [0550-game-play-analysis-iv.sql](./0550-game-play-analysis-iv.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Activity`

```text
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key (combination of columns with unique values) of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
```

Write a solution to report the **fraction** of players that logged in again on the day after the day they first logged in, ** rounded to 2 decimal places**. In other words, you need to determine the number of players who logged in on the day immediately following their initial login, and divide it by the number of total players.

The result format is in the following example.

### Example 1

```text
Input:
Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-03-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+
Output:
+-----------+
| fraction  |
+-----------+
| 0.33      |
+-----------+
Explanation:
Only the player with id 1 logged back in after the first day he had logged in so the answer is 1/3 = 0.33
```

</details>
