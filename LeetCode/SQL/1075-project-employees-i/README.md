[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/project-employees-i/)

# 1075. Project Employees I

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 12, 2026](https://img.shields.io/badge/Solved%20Jul%2012%2C%202026-555555?style=flat-square)

## How I approached it

I want the average experience years for each project, so I join the `Project` and `Employee` tables on `employee_id` to get the experience years for each project. My first idea was to calculate the sum of experience years and then divide by the count of employees, but using `AVG` is simpler. I use `ROUND` to get the result to 2 decimal places.

**How I got there:** I noticed that I need to combine the `Project` and `Employee` tables to get the experience years for each project, and a `JOIN` is the way to do that. Once I had all the experience years for each project, I could use `AVG` to calculate the average.

1. Join the `Project` and `Employee` tables on `employee_id` so I can get the experience years for each project.
2. Use `AVG` to calculate the average experience years for each project.
3. Use `ROUND` to round the average to 2 decimal places.
4. Group the results by `project_id` so I get one row per project.
5. Select `project_id` and the rounded average experience years for each project.

**Pattern to remember:** When I need to calculate an average for groups of rows, I can use `AVG` with `GROUP BY` to get the result.

**Watch out for:** Forgetting to `ROUND` the average can give a result with too many decimal places.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 461 ms (beats 99.7%)](https://img.shields.io/badge/Runtime-461%20ms%20(beats%2099.7%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
SELECT
    p.project_id,
    ROUND(AVG(e.experience_years), 2) AS average_years
FROM project p
JOIN employee e
    ON p.employee_id = e.employee_id
GROUP BY p.project_id;
```

Source: [1075-project-employees-i.sql](./1075-project-employees-i.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Project`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| project_id  | int     |
| employee_id | int     |
+-------------+---------+
(project_id, employee_id) is the primary key of this table.
employee_id is a foreign key to Employee table.
Each row of this table indicates that the employee with employee_id is working on the project with project_id.
```

Table: `Employee`

```text
+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| employee_id      | int     |
| name             | varchar |
| experience_years | int     |
+------------------+---------+
employee_id is the primary key of this table. It's guaranteed that experience_years is not NULL.
Each row of this table contains information about one employee.
```

Write an SQL query that reports the **average** experience years of all the employees for each project, ** rounded to 2 digits**.

Return the result table in **any order**.

The query result format is in the following example.

### Example 1

```text
Input:
Project table:
+-------------+-------------+
| project_id  | employee_id |
+-------------+-------------+
| 1           | 1           |
| 1           | 2           |
| 1           | 3           |
| 2           | 1           |
| 2           | 4           |
+-------------+-------------+
Employee table:
+-------------+--------+------------------+
| employee_id | name   | experience_years |
+-------------+--------+------------------+
| 1           | Khaled | 3                |
| 2           | Ali    | 2                |
| 3           | John   | 1                |
| 4           | Doe    | 2                |
+-------------+--------+------------------+
Output:
+-------------+---------------+
| project_id  | average_years |
+-------------+---------------+
| 1           | 2.00          |
| 2           | 2.50          |
+-------------+---------------+
Explanation: The average experience years for the first project is (3 + 2 + 1) / 3 = 2.00 and for the second project is (3 + 2) / 2 = 2.50
```

</details>
