[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/number-of-unique-subjects-taught-by-each-teacher/)

# 2356. Number of Unique Subjects Taught by Each Teacher

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 17, 2026](https://img.shields.io/badge/Solved%20Jul%2017%2C%202026-555555?style=flat-square)

## How I approached it

I need to count how many different subjects each teacher teaches, and a `COUNT(DISTINCT subject_id)` can do that. My first idea was to count all rows per teacher, but that counts the same subject multiple times if it is taught in different departments. I use `COUNT(DISTINCT subject_id)` to count each subject only once per teacher.

**How I got there:** I noticed that the same `subject_id` can appear in multiple rows for the same `teacher_id` if it is taught in different departments. That told me I need to count each subject only once per teacher, and `COUNT(DISTINCT subject_id)` does that.

1. Group the `teacher` table by `teacher_id` so each teacher is counted on their own.
2. Count `DISTINCT subject_id` inside each group. The `DISTINCT` is what turns a subject taught in multiple departments into one.
3. Return one row per teacher with that count.

**Pattern to remember:** When a count comes out too high, drop the duplicates inside the count with `DISTINCT` instead of filtering rows first.

**Watch out for:** `COUNT(subject_id)` without `DISTINCT` passes the sample data but breaks once a teacher repeats a subject across departments.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 566 ms (beats 30.4%)](https://img.shields.io/badge/Runtime-566%20ms%20(beats%2030.4%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
SELECT
    teacher_id,
    COUNT(DISTINCT subject_id) AS cnt
FROM teacher
GROUP BY teacher_id;
```

Source: [2356-number-of-unique-subjects-taught-by-each-teacher.sql](./2356-number-of-unique-subjects-taught-by-each-teacher.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Teacher`

```text
+-------------+------+
| Column Name | Type |
+-------------+------+
| teacher_id  | int  |
| subject_id  | int  |
| dept_id     | int  |
+-------------+------+
(subject_id, dept_id) is the primary key (combinations of columns with unique values) of this table.
Each row in this table indicates that the teacher with teacher_id teaches the subject subject_id in the department dept_id.
```

Write a solution to calculate the number of unique subjects each teacher teaches in the university.

Return the result table in **any order**.

The result format is shown in the following example.

### Example 1

```text
Input:
Teacher table:
+------------+------------+---------+
| teacher_id | subject_id | dept_id |
+------------+------------+---------+
| 1          | 2          | 3       |
| 1          | 2          | 4       |
| 1          | 3          | 3       |
| 2          | 1          | 1       |
| 2          | 2          | 1       |
| 2          | 3          | 1       |
| 2          | 4          | 1       |
+------------+------------+---------+
Output:
+------------+-----+
| teacher_id | cnt |
+------------+-----+
| 1          | 2   |
| 2          | 4   |
+------------+-----+
Explanation:
Teacher 1:
- They teach subject 2 in departments 3 and 4.
- They teach subject 3 in department 3.
Teacher 2:
- They teach subject 1 in department 1.
- They teach subject 2 in department 1.
- They teach subject 3 in department 1.
- They teach subject 4 in department 1.
```

</details>
