[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/article-views-i/)

# 1148. Article Views I

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 6, 2026](https://img.shields.io/badge/Solved%20Jul%206%2C%202026-555555?style=flat-square)

## How I approached it

I need to find authors who viewed their own articles, so I look for rows where `author_id` equals `viewer_id`. My first idea was to use a subquery, but a simple `WHERE` clause does the job. I use `DISTINCT` to avoid counting duplicate views.

**How I got there:** I noticed that the same author can have multiple rows, so I had to think about how to get each author only once. I realized that `DISTINCT` can remove duplicates after I filter for authors who viewed their own articles.

1. Select all rows from the `views` table where `author_id` equals `viewer_id`.
2. Use `DISTINCT` to remove duplicate `author_id` values, so each author is only counted once.
3. Return each unique `author_id` as `id` and order the result by `id` in ascending order.

**Pattern to remember:** When looking for unique values after a filter, use `DISTINCT` to remove duplicates.

**Watch out for:** Not using `DISTINCT` would result in duplicate authors in the output if they viewed their own articles multiple times.

## Solution

![Time: O(n log n)](https://img.shields.io/badge/Time-O(n%20log%20n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 568 ms (beats 8.5%)](https://img.shields.io/badge/Runtime-568%20ms%20(beats%208.5%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
SELECT DISTINCT author_id AS id
FROM views
WHERE author_id = viewer_id
ORDER BY author_id;
```

Source: [1148-article-views-i.sql](./1148-article-views-i.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Views`

```text
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| article_id    | int     |
| author_id     | int     |
| viewer_id     | int     |
| view_date     | date    |
+---------------+---------+
There is no primary key (column with unique values) for this table, the table may have duplicate rows.
Each row of this table indicates that some viewer viewed an article (written by some author) on some date.
Note that equal author_id and viewer_id indicate the same person.
```

Write a solution to find all the authors that viewed at least one of their own articles.

Return the result table sorted by `id` in ascending order.

The result format is in the following example.

### Example 1

```text
Input:
Views table:
+------------+-----------+-----------+------------+
| article_id | author_id | viewer_id | view_date  |
+------------+-----------+-----------+------------+
| 1          | 3         | 5         | 2019-08-01 |
| 1          | 3         | 6         | 2019-08-02 |
| 2          | 7         | 7         | 2019-08-01 |
| 2          | 7         | 6         | 2019-08-02 |
| 4          | 7         | 1         | 2019-07-22 |
| 3          | 4         | 4         | 2019-07-21 |
| 3          | 4         | 4         | 2019-07-21 |
+------------+-----------+-----------+------------+
Output:
+------+
| id   |
+------+
| 4    |
| 7    |
+------+
```

</details>
