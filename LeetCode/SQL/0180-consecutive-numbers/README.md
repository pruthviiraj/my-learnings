[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/consecutive-numbers/)

# 180. Consecutive Numbers

![Medium](https://img.shields.io/badge/Medium-ffc01e?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Aug 6, 2026](https://img.shields.io/badge/Solved%20Aug%206%2C%202026-555555?style=flat-square)

## How I approached it

I need to find numbers that appear at least three times in a row, so I use `LAG` and `LEAD` to look at the numbers before and after each one. My first idea was to compare each number to the next one, but that only finds pairs, not sequences of three. I use `LAG` and `LEAD` to check all three numbers at once.

**How I got there:** I started by thinking about how to compare each number to its neighbors, and I noticed that `LAG` and `LEAD` can look at the numbers before and after each row. That told me to use these functions to check if a number is the same as the ones before and after it.

1. Use `LAG` to get the number before each row, and `LEAD` to get the number after each row.
2. Compare each number to the ones before and after it using `LAG` and `LEAD`.
3. Select the numbers where all three are the same, which means they appear at least three times in a row.

**Pattern to remember:** When I need to compare a value to its neighbors, I can use `LAG` and `LEAD` to look at the values before and after each row.

**Watch out for:** Not using `DISTINCT` would return duplicate numbers if they appear in multiple sequences of three.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 535 ms (beats 90.7%)](https://img.shields.io/badge/Runtime-535%20ms%20(beats%2090.7%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
SELECT DISTINCT num AS ConsecutiveNums
FROM (
    SELECT
        num,
        LAG(num)  OVER (ORDER BY id) AS prev_num,
        LEAD(num) OVER (ORDER BY id) AS next_num
    FROM Logs
) t
WHERE num = prev_num
  AND num = next_num;
```

Source: [0180-consecutive-numbers.sql](./0180-consecutive-numbers.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Logs`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
In SQL, id is the primary key for this table.
id is an autoincrement column starting from 1.
```

Find all numbers that appear at least three times consecutively.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Logs table:
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+
Output:
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
Explanation: 1 is the only number that appears consecutively for at least three times.
```

</details>
