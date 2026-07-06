[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/)

# 1378. Replace Employee ID With The Unique Identifier

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 6, 2026](https://img.shields.io/badge/Solved%20Jul%206%2C%202026-555555?style=flat-square)

## How I approached it

I need to show the `unique_id` for each employee, and if an employee does not have one, I show `null`. My first idea was to use a subquery, but a `JOIN` is a better fit here because it can handle the missing `unique_id` values directly. I use a `LEFT JOIN` to keep all employees, even if they do not have a `unique_id`.

**How I got there:** I noticed that the problem is about combining two tables based on a common column, which pointed me towards using a `JOIN`. Since not all employees have a `unique_id`, I had to choose a type of `JOIN` that would include those employees.

1. Start with the `employees` table as the base, since I need to show every employee.
2. Use a `LEFT JOIN` to combine `employees` with `employeeUNI` on the `id` column, so each employee is matched with their `unique_id` if it exists.
3. Select `unique_id` from `employeeUNI` and `name` from `employees` to get the desired output columns.

**Pattern to remember:** When combining tables and some rows might not have a match, use a `LEFT JOIN` to include all rows from one table and the matching rows from the other table, if any.

**Watch out for:** Using an `INNER JOIN` instead of `LEFT JOIN` would incorrectly exclude employees without a `unique_id` from the result.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)

```sql
SELECT
    eu.unique_id,
    e.name
FROM employees e
LEFT JOIN employeeUNI eu
ON e.id = eu.id;
```

Source: [1378-replace-employee-id-with-the-unique-identifier.sql](./1378-replace-employee-id-with-the-unique-identifier.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Employees`

```text
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| name          | varchar |
+---------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table contains the id and the name of an employee in a company.
```

Table: `EmployeeUNI`

```text
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| unique_id     | int     |
+---------------+---------+
(id, unique_id) is the primary key (combination of columns with unique values) for this table.
Each row of this table contains the id and the corresponding unique id of an employee in the company.
```

Write a solution to show the **unique ID** of each user, If a user does not have a unique ID replace just show `null`.

Return the result table in **any** order.

The result format is in the following example.

### Example 1

```text
Input:
Employees table:
+----+----------+
| id | name     |
+----+----------+
| 1  | Alice    |
| 7  | Bob      |
| 11 | Meir     |
| 90 | Winston  |
| 3  | Jonathan |
+----+----------+
EmployeeUNI table:
+----+-----------+
| id | unique_id |
+----+-----------+
| 3  | 1         |
| 11 | 2         |
| 90 | 3         |
+----+-----------+
Output:
+-----------+----------+
| unique_id | name     |
+-----------+----------+
| null      | Alice    |
| null      | Bob      |
| 2         | Meir     |
| 3         | Winston  |
| 1         | Jonathan |
+-----------+----------+
Explanation:
Alice and Bob do not have a unique ID, We will show null instead.
The unique ID of Meir is 2.
The unique ID of Winston is 3.
The unique ID of Jonathan is 1.
```

</details>
