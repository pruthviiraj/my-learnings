[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/classes-with-at-least-5-students/)

# 596. Classes With at Least 5 Students

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 22, 2026](https://img.shields.io/badge/Solved%20Jul%2022%2C%202026-555555?style=flat-square)

## How I approached it

I need to find classes with at least five students, so I group the `Courses` table by `class` and count the `student` rows in each group. My first idea was to count all students and then filter, but that does not work because I have to filter after counting. I use `GROUP BY` and `HAVING` to do that.

**How I got there:** I noticed that each row is one student in one class, so I can count rows to get the number of students per class. I also saw that I need to filter after counting, because I want classes with at least five students, not students in classes with at least five students.

1. Group the `Courses` table by `class` so each class is counted on its own.
2. Count the `student` rows in each group with `COUNT(student)`.
3. Filter the results to only include classes with at least five students using `HAVING COUNT(student) >= 5`.

**Pattern to remember:** When I need to filter after counting, I use `GROUP BY` and `HAVING` instead of `WHERE`.

**Watch out for:** Using `WHERE` instead of `HAVING` would try to filter before counting, which does not work.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 408 ms (beats 11.6%)](https://img.shields.io/badge/Runtime-408%20ms%20(beats%2011.6%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
SELECT
    class
FROM courses
GROUP BY class
HAVING COUNT(student) >= 5;
```

Source: [0596-classes-with-at-least-5-students.sql](./0596-classes-with-at-least-5-students.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Courses`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| student     | varchar |
| class       | varchar |
+-------------+---------+
(student, class) is the primary key (combination of columns with unique values) for this table.
Each row of this table indicates the name of a student and the class in which they are enrolled.
```

Write a solution to find all the classes that have **at least five students**.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Courses table:
+---------+----------+
| student | class    |
+---------+----------+
| A       | Math     |
| B       | English  |
| C       | Math     |
| D       | Biology  |
| E       | Math     |
| F       | Computer |
| G       | Math     |
| H       | Math     |
| I       | Math     |
+---------+----------+
Output:
+---------+
| class   |
+---------+
| Math    |
+---------+
Explanation:
- Math has 6 students, so we include it.
- English has 1 student, so we do not include it.
- Biology has 1 student, so we do not include it.
- Computer has 1 student, so we do not include it.
```

</details>
