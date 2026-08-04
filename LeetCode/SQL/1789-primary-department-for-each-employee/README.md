[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/primary-department-for-each-employee/)

# 1789. Primary Department for Each Employee

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Aug 4, 2026](https://img.shields.io/badge/Solved%20Aug%204%2C%202026-555555?style=flat-square)

## How I approached it

I need to find each employee's primary department, and I can do this by looking for the `primary_flag` set to 'Y', but I also need to handle employees with only one department. I keep all employees with a 'Y' flag and add employees with only one department, even if it's marked 'N'. This way fits because it covers both cases clearly.

**How I got there:** My first thought was to only look at the `primary_flag`, but then I saw that employees with one department have it marked 'N', so I had to find a way to include those. I noticed the problem statement said employees with one department should be included, even if not marked 'Y', and that led me to think about counting departments per employee.

1. Select all rows from the `Employee` table where `primary_flag` is 'Y' to get the clearly marked primary departments.
2. Use `UNION` to combine this with another select that finds employees with only one department, by grouping the table by `employee_id` and using `HAVING COUNT(*) = 1`.
3. In the second select, I only need `employee_id` and `department_id` because the problem only asks for these two columns.

**Pattern to remember:** When a condition has an exception, like primary departments being 'Y' but single departments being 'N', use `UNION` to combine two separate queries that handle each case.

**Watch out for:** Forgetting the `UNION` and trying to do it all in one query could lead to missing either the 'Y' flagged departments or the single 'N' departments.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 722 ms (beats 14.2%)](https://img.shields.io/badge/Runtime-722%20ms%20(beats%2014.2%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
SELECT employee_id, department_id
FROM Employee
WHERE primary_flag = 'Y'

UNION

SELECT employee_id, department_id
FROM Employee
GROUP BY employee_id
HAVING COUNT(*) = 1;
```

Source: [1789-primary-department-for-each-employee.sql](./1789-primary-department-for-each-employee.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Employee`

```text
+---------------+---------+
| Column Name   |  Type   |
+---------------+---------+
| employee_id   | int     |
| department_id | int     |
| primary_flag  | varchar |
+---------------+---------+
(employee_id, department_id) is the primary key (combination of columns with unique values) for this table.
employee_id is the id of the employee.
department_id is the id of the department to which the employee belongs.
primary_flag is an ENUM (category) of type ('Y', 'N'). If the flag is 'Y', the department is the primary department for the employee. If the flag is 'N', the department is not the primary.
```

Employees can belong to multiple departments. When the employee joins other departments, they need to decide which department is their primary department. Note that when an employee belongs to only one department, their primary column is `'N'`.

Write a solution to report all the employees with their primary department. For employees who belong to one department, report their only department.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Employee table:
+-------------+---------------+--------------+
| employee_id | department_id | primary_flag |
+-------------+---------------+--------------+
| 1           | 1             | N            |
| 2           | 1             | Y            |
| 2           | 2             | N            |
| 3           | 3             | N            |
| 4           | 2             | N            |
| 4           | 3             | Y            |
| 4           | 4             | N            |
+-------------+---------------+--------------+
Output:
+-------------+---------------+
| employee_id | department_id |
+-------------+---------------+
| 1           | 1             |
| 2           | 1             |
| 3           | 3             |
| 4           | 3             |
+-------------+---------------+
Explanation:
- The Primary department for employee 1 is 1.
- The Primary department for employee 2 is 1.
- The Primary department for employee 3 is 3.
- The Primary department for employee 4 is 3.
```

</details>
