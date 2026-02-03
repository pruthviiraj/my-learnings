# Day 6 – The Report

**Category:** SQL – Basic Join / Non-Equi Joins

**Platform:** HackerRank

**Difficulty:** Medium

## Problem Statement

You are given two tables: `Students` (ID, Name, Marks) and `Grades` (Grade, Min_Mark, Max_Mark). The task is to generate a report with three columns: `Name`, `Grade`, and `Mark`.

The report must follow these specific business rules:

* **Data Masking:** If a student's grade is lower than 8, their name must be replaced with "NULL".
* **Sorting Tier 1:** Sort by `Grade` in descending order.
* **Sorting Tier 2 (Grades 8-10):** For students with these grades, order them alphabetically by `Name`.
* **Sorting Tier 3 (Grades 1-7):** For students with these grades, order them by `Marks` in ascending order.

## Key Concept

The primary challenge is that there is **no matching ID** between the two tables. This requires a **Non-Equi Join**, where tables are linked using a range condition (`BETWEEN`) rather than an equality operator.

## Approach

1. **Perform a Non-Equi Join:** Use the `BETWEEN` operator to join the tables where a student's `Marks` fall within the `Min_Mark` and `Max_Mark` range of the `Grades` table.
2. **Apply Conditional Logic:** Use a `CASE` statement to check the `Grade`. If it is less than 8, return `NULL`; otherwise, return the student's `Name`.
3. **Implement Multi-Level Sorting:** Create an `ORDER BY` clause that prioritizes `Grade` (DESC), then `Name` (ASC), and finally `Marks` (ASC) to satisfy the specific requirements for different grade tiers.

## SQL Functions Used

* **`JOIN ... ON ... BETWEEN`** – To link tables based on a numerical range.
* **`CASE WHEN`** – To handle the conditional display of student names.
* **`ORDER BY`** – To manage the complex three-tiered sorting logic.

## SQL Solution

```sql
SELECT 
    CASE 
        WHEN g.grade < 8 THEN NULL 
        ELSE s.name 
    END AS Name, 
    g.grade, 
    s.marks
FROM students s
JOIN grades g 
    ON s.marks BETWEEN g.min_mark AND g.max_mark
ORDER BY 
    g.grade DESC, 
    s.name ASC, 
    s.marks ASC;

```

## Output Example

```text
Maria 10 99
Jane 9 81
Julia 9 88 
Scarlet 8 78
NULL 7 63
NULL 7 68

```
