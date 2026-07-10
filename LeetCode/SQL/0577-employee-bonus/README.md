[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/employee-bonus/)

# 577. Employee Bonus

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 10, 2026](https://img.shields.io/badge/Solved%20Jul%2010%2C%202026-555555?style=flat-square)

## How I approached it

I want to find employees who either have a `bonus` less than 1000 or have no `bonus` at all. My first idea was to use a `JOIN` to connect the `Employee` and `Bonus` tables, and then filter the results to get the employees I'm looking for.

**How I got there:** I noticed that some employees might not have a `bonus`, so I needed a way to include them in the results. I realized that a `LEFT JOIN` would let me include employees who don't have a match in the `Bonus` table.

1. Join the `Employee` table with the `Bonus` table using a `LEFT JOIN` on `empId`, so I can include employees who don't have a `bonus`.
2. Select the `name` from the `Employee` table and the `bonus` from the `Bonus` table.
3. Filter the results to include only rows where the `bonus` is less than 1000 or the `bonus` is `NULL`.

**Pattern to remember:** Use a `LEFT JOIN` to include rows from one table that don't have a match in another table, and then filter the results to get the desired data.

**Watch out for:** Using an `INNER JOIN` instead of a `LEFT JOIN` would exclude employees who don't have a `bonus`, which is not what I want.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 1042 ms (beats 44.6%)](https://img.shields.io/badge/Runtime-1042%20ms%20(beats%2044.6%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
SELECT
    e.name,
    b.bonus
FROM employee e
LEFT JOIN bonus b 
    ON e.empId = b.empId
WHERE
    b.bonus < 1000
    OR
    b.bonus IS NULL;
```

Source: [0577-employee-bonus.sql](./0577-employee-bonus.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Employee`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| empId       | int     |
| name        | varchar |
| supervisor  | int     |
| salary      | int     |
+-------------+---------+
empId is the column with unique values for this table.
Each row of this table indicates the name and the ID of an employee in addition to their salary and the id of their manager.
```

Table: `Bonus`

```text
+-------------+------+
| Column Name | Type |
+-------------+------+
| empId       | int  |
| bonus       | int  |
+-------------+------+
empId is the column of unique values for this table.
empId is a foreign key (reference column) to empId from the Employee table.
Each row of this table contains the id of an employee and their respective bonus.
```

Write a solution to report the name and bonus amount of each employee who satisfies either of the following:

- The employee has a bonus **less than** `1000`.
- The employee did not get any bonus.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Employee table:
+-------+--------+------------+--------+
| empId | name   | supervisor | salary |
+-------+--------+------------+--------+
| 3     | Brad   | null       | 4000   |
| 1     | John   | 3          | 1000   |
| 2     | Dan    | 3          | 2000   |
| 4     | Thomas | 3          | 4000   |
+-------+--------+------------+--------+
Bonus table:
+-------+-------+
| empId | bonus |
+-------+-------+
| 2     | 500   |
| 4     | 2000  |
+-------+-------+
Output:
+------+-------+
| name | bonus |
+------+-------+
| Brad | null  |
| John | null  |
| Dan  | 500   |
+------+-------+
```

</details>
