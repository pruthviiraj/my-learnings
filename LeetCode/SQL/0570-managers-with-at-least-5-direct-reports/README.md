[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/managers-with-at-least-5-direct-reports/)

# 570. Managers with at Least 5 Direct Reports

![Medium](https://img.shields.io/badge/Medium-ffc01e?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 10, 2026](https://img.shields.io/badge/Solved%20Jul%2010%2C%202026-555555?style=flat-square)

## How I approached it

I need to find managers with at least five direct reports, so I join the `Employee` table to itself on the `managerId` and `id` columns. My first idea was to count all employees and then filter, but that does not work because I need to count the direct reports for each manager separately. I use a `GROUP BY` to count the direct reports for each manager.

**How I got there:** I noticed that the `managerId` column can be used to link an employee to their manager, so I joined the table to itself on this column. I then realized that I needed to count the number of employees for each manager, which led me to use a `GROUP BY` and `COUNT`. I asked what I was counting, and it was the `id` of each employee, which is what I want.

1. Join the `Employee` table to itself on the `managerId` and `id` columns, so each employee is linked to their manager.
2. Group the joined table by `mgr.id` and `mgr.name`, so each manager is counted separately.
3. Count the number of employees for each manager using `COUNT(emp.id)`.
4. Use `HAVING COUNT(emp.id) >= 5` to filter the results and only include managers with at least five direct reports.

**Pattern to remember:** When counting items in a group, use a `GROUP BY` and `COUNT` together, and filter the results with `HAVING`.

**Watch out for:** Using `WHERE` instead of `HAVING` to filter the results would not work, because `WHERE` filters the rows before grouping, while `HAVING` filters the groups after counting.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 321 ms (beats 99.4%)](https://img.shields.io/badge/Runtime-321%20ms%20(beats%2099.4%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
SELECT mgr.name
FROM employee emp
JOIN employee mgr
    ON mgr.id = emp.managerId
GROUP BY mgr.id, mgr.name
HAVING COUNT(emp.id) >= 5;
```

Source: [0570-managers-with-at-least-5-direct-reports.sql](./0570-managers-with-at-least-5-direct-reports.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Employee`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| department  | varchar |
| managerId   | int     |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the name of an employee, their department, and the id of their manager.
If managerId is null, then the employee does not have a manager.
No employee will be the manager of themself.
```

Write a solution to find managers with at least **five direct reports**.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Employee table:
+-----+-------+------------+-----------+
| id  | name  | department | managerId |
+-----+-------+------------+-----------+
| 101 | John  | A          | null      |
| 102 | Dan   | A          | 101       |
| 103 | James | A          | 101       |
| 104 | Amy   | A          | 101       |
| 105 | Anne  | A          | 101       |
| 106 | Ron   | B          | 101       |
+-----+-------+------------+-----------+
Output:
+------+
| name |
+------+
| John |
+------+
```

</details>
