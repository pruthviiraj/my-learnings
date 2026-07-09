[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/rising-temperature/)

# 197. Rising Temperature

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 9, 2026](https://img.shields.io/badge/Solved%20Jul%209%2C%202026-555555?style=flat-square)

## How I approached it

I need to compare each day's temperature to the previous day's, which means I have to line up rows for each day with rows for the day before. My first idea was to use a `GROUP BY` but it didn't fit, so I used a `JOIN` to pair up the rows. I compare `temperature` values between these paired rows, looking for the ones where today is higher than yesterday.

**How I got there:** I noticed that the `recordDate` in one row needs to be one day ahead of the `recordDate` in the row I am comparing it to, which told me to use `DATE_ADD` to add one day to yesterday's date and match it with today's date. The `JOIN` lets me access both rows at the same time, so I can compare their `temperature` values.

1. Join the `weather` table to itself on the condition that `recordDate` in one row is one day ahead of `recordDate` in the other row, using `DATE_ADD` to add one day.
2. Use the `WHERE` clause to filter these paired rows and only keep the ones where today's `temperature` is higher than yesterday's `temperature`.
3. Select the `id` from the rows that pass this filter, which are the days with higher temperatures than the day before.

**Pattern to remember:** When comparing rows that are related by a time interval, use a `JOIN` with a date function like `DATE_ADD` to line up the rows.

**Watch out for:** Forgetting to use `DATE_ADD` to adjust the date in the `JOIN` condition would match rows with the same date instead of consecutive dates.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 388 ms (beats 93.7%)](https://img.shields.io/badge/Runtime-388%20ms%20(beats%2093.7%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
SELECT w1.id
FROM weather w1
JOIN weather w2
ON w1.recordDate = DATE_ADD(w2.recordDate, INTERVAL 1 DAY)
WHERE w1.temperature > w2.temperature
```

Source: [0197-rising-temperature.sql](./0197-rising-temperature.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Weather`

```text
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the column with unique values for this table.
There are no different rows with the same recordDate.
This table contains information about the temperature on a certain day.
```

Write a solution to find all dates' `id` with higher temperatures compared to its previous dates (yesterday).

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Weather table:
+----+------------+-------------+
| id | recordDate | temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+
Output:
+----+
| id |
+----+
| 2  |
| 4  |
+----+
Explanation:
In 2015-01-02, the temperature was higher than the previous day (10 -> 25).
In 2015-01-04, the temperature was higher than the previous day (20 -> 30).
```

</details>
