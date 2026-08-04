[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/triangle-judgement/)

# 610. Triangle Judgement

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Aug 4, 2026](https://img.shields.io/badge/Solved%20Aug%204%2C%202026-555555?style=flat-square)

## How I approached it

I check if three line segments can form a triangle by making sure the sum of the lengths of any two sides is greater than the length of the third side. My first idea was to sort the sides and compare the two smallest with the largest, but that is not necessary. I can just compare all three pairs of sides.

**How I got there:** I noticed that the triangle inequality says the sum of any two sides of a triangle must be greater than the third side, so I applied that to all three sides. The `x+y>z` part checks if the first two sides can reach around the third side, and the other two conditions do the same for the other pairs.

1. Select all columns `x`, `y`, `z` from the `Triangle` table.
2. Use a `CASE` statement to check the three conditions: `x+y>z`, `x+z>y`, and `y+z>x`.
3. If all conditions are true, return 'Yes' for the `triangle` column, otherwise return 'No'.

**Pattern to remember:** When checking if something can be formed from parts, check all possible combinations of parts against the conditions for being a valid whole.

**Watch out for:** Forgetting one of the three conditions, like `x+z>y`, would cause the query to return 'Yes' for some invalid triangles.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 300 ms (beats 61.6%)](https://img.shields.io/badge/Runtime-300%20ms%20(beats%2061.6%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
SELECT
    x,y,z,
    CASE
        WHEN x+y>z AND x+z>y AND y+z>x THEN 'Yes'
        ELSE 'No'
    END AS triangle
FROM Triangle;
```

Source: [0610-triangle-judgement.sql](./0610-triangle-judgement.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Triangle`

```text
+-------------+------+
| Column Name | Type |
+-------------+------+
| x           | int  |
| y           | int  |
| z           | int  |
+-------------+------+
In SQL, (x, y, z) is the primary key column for this table.
Each row of this table contains the lengths of three line segments.
```

Report for every three line segments whether they can form a triangle.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Triangle table:
+----+----+----+
| x  | y  | z  |
+----+----+----+
| 13 | 15 | 30 |
| 10 | 20 | 15 |
+----+----+----+
Output:
+----+----+----+----------+
| x  | y  | z  | triangle |
+----+----+----+----------+
| 13 | 15 | 30 | No       |
| 10 | 20 | 15 | Yes      |
+----+----+----+----------+
```

</details>
