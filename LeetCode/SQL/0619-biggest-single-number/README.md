[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/biggest-single-number/)

# 619. Biggest Single Number

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 22, 2026](https://img.shields.io/badge/Solved%20Jul%2022%2C%202026-555555?style=flat-square)

## How I approached it

I want the largest number that shows up only once in the table, so I need to find all numbers that appear once and pick the biggest one. My first idea was to count each number and then filter, but using `GROUP BY` and `HAVING` is a better fit. I use `MAX` to get the largest single number.

**How I got there:** I noticed that the problem asks for the largest single number, which means I need to find numbers that appear only once, so I started thinking about how to count each number. I realized I could use `GROUP BY` to group numbers together and then use `HAVING` to filter groups with only one number.

1. Group the table by `num` so each number is counted on its own.
2. Use `HAVING COUNT(num) = 1` to filter groups with only one number, which are the single numbers.
3. Use a subquery to get all single numbers and then use `MAX` to get the largest one.

**Pattern to remember:** When looking for the largest or smallest item that meets a condition, use `MAX` or `MIN` with a subquery that filters items based on that condition.

**Watch out for:** If no single numbers exist, the subquery will return no rows and `MAX` will return `null`, which is the correct result.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 433 ms (beats 65.4%)](https://img.shields.io/badge/Runtime-433%20ms%20(beats%2065.4%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
SELECT
    MAX(num) AS num
FROM(
    SELECT
        num
    FROM mynumbers
    GROUP BY num
    HAVING COUNT(num) = 1
) AS single_number;
```

Source: [0619-biggest-single-number.sql](./0619-biggest-single-number.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `MyNumbers`

```text
+-------------+------+
| Column Name | Type |
+-------------+------+
| num         | int  |
+-------------+------+
This table may contain duplicates (In other words, there is no primary key for this table in SQL).
Each row of this table contains an integer.
```

A **single number** is a number that appeared only once in the `MyNumbers` table.

Find the largest **single number**. If there is no ** single number**, report `null`.

The result format is in the following example.

### Example 1

```text
Input:
MyNumbers table:
+-----+
| num |
+-----+
| 8   |
| 8   |
| 3   |
| 3   |
| 1   |
| 4   |
| 5   |
| 6   |
+-----+
Output:
+-----+
| num |
+-----+
| 6   |
+-----+
Explanation: The single numbers are 1, 4, 5, and 6.
Since 6 is the largest single number, we return it.
```

### Example 2

```text
Input:
MyNumbers table:
+-----+
| num |
+-----+
| 8   |
| 8   |
| 7   |
| 7   |
| 3   |
| 3   |
| 3   |
+-----+
Output:
+------+
| num  |
+------+
| null |
+------+
Explanation: There are no single numbers in the input table so we return null.
```

</details>
