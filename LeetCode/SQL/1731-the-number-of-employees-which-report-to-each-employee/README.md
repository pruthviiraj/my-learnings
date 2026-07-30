[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/)

# 1731. The Number of Employees Which Report to Each Employee

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 30, 2026](https://img.shields.io/badge/Solved%20Jul%2030%2C%202026-555555?style=flat-square)

## How I approached it

I need to find all the managers and count how many people report to them, and also find the average age of those reports. A `JOIN` can match each employee with their manager, and then I can group by manager to get the counts and averages.

**How I got there:** My first thought was to use a subquery to find all the managers, but then I realized I could just join the table to itself, using `reports_to` to match employees with their managers. That way I can count and average in one step.

1. Join the `employees` table to itself on the `reports_to` column, so each employee is matched with their manager.
2. Group the joined table by `employee_id` and `name` of the manager, so I can count and average for each manager.
3. Count the number of employees reporting to each manager with `COUNT(emp.employee_id)` and calculate the average age with `ROUND(AVG(emp.age))`.
4. Order the result by `employee_id` to get the managers in the right order.

**Pattern to remember:** When I need to match each item with another item in the same table, a self-join can be the answer, using a column like `reports_to` to define the match.

**Watch out for:** Forgetting to group by both `employee_id` and `name` would cause an error if two managers had the same `employee_id` but different names, which is not possible here because `employee_id` is unique but could be a problem in other tables.

## Solution

![Time: O(n log n)](https://img.shields.io/badge/Time-O(n%20log%20n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)

```sql
SELECT
    mgr.employee_id,
    mgr.name,
    COUNT(emp.employee_id) AS reports_count,
    ROUND(AVG(emp.age)) AS average_age
FROM employees emp
JOIN employees mgr
    ON emp.reports_to = mgr.employee_id
GROUP BY mgr.employee_id, mgr.name
ORDER BY mgr.employee_id;
```

Source: [1731-the-number-of-employees-which-report-to-each-employee.sql](./1731-the-number-of-employees-which-report-to-each-employee.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Employees`

```text
+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| employee_id | int      |
| name        | varchar  |
| reports_to  | int      |
| age         | int      |
+-------------+----------+
employee_id is the column with unique values for this table.
This table contains information about the employees and the id of the manager they report to. Some employees do not report to anyone (reports_to is null).
```

For this problem, we will consider a **manager** an employee who has at least 1 other employee reporting to them.

Write a solution to report the ids and the names of all **managers**, the number of employees who report ** directly** to them, and the average age of the reports rounded to the nearest integer.

Return the result table ordered by `employee_id`.

The result format is in the following example.

### Example 1

```text
Input:
Employees table:
+-------------+---------+------------+-----+
| employee_id | name    | reports_to | age |
+-------------+---------+------------+-----+
| 9           | Hercy   | null       | 43  |
| 6           | Alice   | 9          | 41  |
| 4           | Bob     | 9          | 36  |
| 2           | Winston | null       | 37  |
+-------------+---------+------------+-----+
Output:
+-------------+-------+---------------+-------------+
| employee_id | name  | reports_count | average_age |
+-------------+-------+---------------+-------------+
| 9           | Hercy | 2             | 39          |
+-------------+-------+---------------+-------------+
Explanation: Hercy has 2 people report directly to him, Alice and Bob. Their average age is (41+36)/2 = 38.5, which is 39 after rounding it to the nearest integer.
```

### Example 2

```text
Input:
Employees table:
+-------------+---------+------------+-----+
| employee_id | name    | reports_to | age |
|-------------|---------|------------|-----|
| 1           | Michael | null       | 45  |
| 2           | Alice   | 1          | 38  |
| 3           | Bob     | 1          | 42  |
| 4           | Charlie | 2          | 34  |
| 5           | David   | 2          | 40  |
| 6           | Eve     | 3          | 37  |
| 7           | Frank   | null       | 50  |
| 8           | Grace   | null       | 48  |
+-------------+---------+------------+-----+
Output:
+-------------+---------+---------------+-------------+
| employee_id | name    | reports_count | average_age |
| ----------- | ------- | ------------- | ----------- |
| 1           | Michael | 2             | 40          |
| 2           | Alice   | 2             | 37          |
| 3           | Bob     | 1             | 37          |
+-------------+---------+---------------+-------------+
```

</details>
