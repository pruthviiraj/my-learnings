[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/students-and-examinations/)

# 1280. Students and Examinations

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 10, 2026](https://img.shields.io/badge/Solved%20Jul%2010%2C%202026-555555?style=flat-square)

## How I approached it

I need to count how many times each student attended each exam, and my first idea was to just join the tables, but that would not include students who did not attend any exams. I use a `CROSS JOIN` to get all possible combinations of students and subjects, then I use a `LEFT JOIN` to add the exam attendance counts, and I group by `student_id` and `subject_name` to get the counts per student per subject.

**How I got there:** I noticed that the `Examinations` table can have duplicate rows for the same student and subject, so I need to use `COUNT` to get the number of times each student attended each exam. I also need to include all students and all subjects in the result, even if they did not attend any exams, so I use a `CROSS JOIN` to get all possible combinations.

1. Use a `CROSS JOIN` to get all possible combinations of students and subjects.
2. Use a `LEFT JOIN` to add the exam attendance counts from the `Examinations` table, joining on `student_id` and `subject_name`.
3. Use `COUNT` to get the number of times each student attended each exam, and group by `student_id` and `subject_name` to get the counts per student per subject.
4. Order the result by `student_id` and `subject_name` to get the desired output format.

**Pattern to remember:** When I need to get all possible combinations of two tables, I use a `CROSS JOIN`, and when I need to include all rows from one table even if there are no matches in another table, I use a `LEFT JOIN`.

**Watch out for:** If I use an `INNER JOIN` instead of a `LEFT JOIN`, I will miss students who did not attend any exams.

## Solution

![Time: O(n*m)](https://img.shields.io/badge/Time-O(n*m)-8250df?style=flat-square)
![Space: O(n*m)](https://img.shields.io/badge/Space-O(n*m)-d29922?style=flat-square)
![Runtime: 1159 ms (beats 25.1%)](https://img.shields.io/badge/Runtime-1159%20ms%20(beats%2025.1%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
SELECT
    s.student_id,
    s.student_name,
    sub.subject_name,
    COUNT(exm.student_id) AS attended_exams
FROM students s
CROSS JOIN subjects sub
LEFT JOIN examinations exm
    ON s.student_id = exm.student_id
    AND sub.subject_name = exm.subject_name
GROUP BY s.student_id, sub.subject_name
ORDER BY s.student_id, sub.subject_name;
```

Source: [1280-students-and-examinations.sql](./1280-students-and-examinations.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Students`

```text
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| student_id    | int     |
| student_name  | varchar |
+---------------+---------+
student_id is the primary key (column with unique values) for this table.
Each row of this table contains the ID and the name of one student in the school.
```

Table: `Subjects`

```text
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| subject_name | varchar |
+--------------+---------+
subject_name is the primary key (column with unique values) for this table.
Each row of this table contains the name of one subject in the school.
```

Table: `Examinations`

```text
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| student_id   | int     |
| subject_name | varchar |
+--------------+---------+
There is no primary key (column with unique values) for this table. It may contain duplicates.
Each student from the Students table takes every course from the Subjects table.
Each row of this table indicates that a student with ID student_id attended the exam of subject_name.
```

Write a solution to find the number of times each student attended each exam.

Return the result table ordered by `student_id` and `subject_name`.

The result format is in the following example.

### Example 1

```text
Input:
Students table:
+------------+--------------+
| student_id | student_name |
+------------+--------------+
| 1          | Alice        |
| 2          | Bob          |
| 13         | John         |
| 6          | Alex         |
+------------+--------------+
Subjects table:
+--------------+
| subject_name |
+--------------+
| Math         |
| Physics      |
| Programming  |
+--------------+
Examinations table:
+------------+--------------+
| student_id | subject_name |
+------------+--------------+
| 1          | Math         |
| 1          | Physics      |
| 1          | Programming  |
| 2          | Programming  |
| 1          | Physics      |
| 1          | Math         |
| 13         | Math         |
| 13         | Programming  |
| 13         | Physics      |
| 2          | Math         |
| 1          | Math         |
+------------+--------------+
Output:
+------------+--------------+--------------+----------------+
| student_id | student_name | subject_name | attended_exams |
+------------+--------------+--------------+----------------+
| 1          | Alice        | Math         | 3              |
| 1          | Alice        | Physics      | 2              |
| 1          | Alice        | Programming  | 1              |
| 2          | Bob          | Math         | 1              |
| 2          | Bob          | Physics      | 0              |
| 2          | Bob          | Programming  | 1              |
| 6          | Alex         | Math         | 0              |
| 6          | Alex         | Physics      | 0              |
| 6          | Alex         | Programming  | 0              |
| 13         | John         | Math         | 1              |
| 13         | John         | Physics      | 1              |
| 13         | John         | Programming  | 1              |
+------------+--------------+--------------+----------------+
Explanation:
The result table should contain all students and all subjects.
Alice attended the Math exam 3 times, the Physics exam 2 times, and the Programming exam 1 time.
Bob attended the Math exam 1 time, the Programming exam 1 time, and did not attend the Physics exam.
Alex did not attend any exams.
John attended the Math exam 1 time, the Physics exam 1 time, and the Programming exam 1 time.
```

</details>
