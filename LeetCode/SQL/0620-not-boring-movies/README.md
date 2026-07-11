[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/not-boring-movies/)

# 620. Not Boring Movies

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 11, 2026](https://img.shields.io/badge/Solved%20Jul%2011%2C%202026-555555?style=flat-square)

## How I approached it

I need to filter the `Cinema` table for movies with odd `id` values and descriptions that are not `'boring'`. My first idea was to use a `WHERE` clause with two conditions, which works because `id` and `description` are the key fields. I also want to sort the results by `rating` in descending order.

**How I got there:** I looked at the conditions given in the problem and saw that I need to check if the `id` is odd and the `description` is not `'boring'`. I realized I can use the modulus operator (`%`) to check for odd numbers and a simple string comparison for the description.

1. Select all columns (`*`) from the `Cinema` table.
2. Use a `WHERE` clause to filter the rows where `id` is odd (`id % 2 != 0`) and `description` is not `'boring'`.
3. Order the results by `rating` in descending order (`ORDER BY rating DESC`).

**Pattern to remember:** When filtering data based on multiple conditions, use the `AND` operator in the `WHERE` clause to combine the conditions.

**Watch out for:** Forgetting to use the `!=` operator for the description check would incorrectly filter out all rows.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 245 ms (beats 98.7%)](https://img.shields.io/badge/Runtime-245%20ms%20(beats%2098.7%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
SELECT *
FROM cinema
WHERE
    id % 2 != 0
    AND description != 'boring'
ORDER BY rating DESC;
```

Source: [0620-not-boring-movies.sql](./0620-not-boring-movies.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Cinema`

```text
+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| id             | int      |
| movie          | varchar  |
| description    | varchar  |
| rating         | float    |
+----------------+----------+
id is the primary key (column with unique values) for this table.
Each row contains information about the name of a movie, its genre, and its rating.
rating is a 2 decimal places float in the range [0, 10]
```

Write a solution to report the movies with an odd-numbered ID and a description that is not `"boring"`.

Return the result table ordered by `rating` **in descending order**.

The result format is in the following example.

### Example 1

```text
Input:
Cinema table:
+----+------------+-------------+--------+
| id | movie      | description | rating |
+----+------------+-------------+--------+
| 1  | War        | great 3D    | 8.9    |
| 2  | Science    | fiction     | 8.5    |
| 3  | irish      | boring      | 6.2    |
| 4  | Ice song   | Fantacy     | 8.6    |
| 5  | House card | Interesting | 9.1    |
+----+------------+-------------+--------+
Output:
+----+------------+-------------+--------+
| id | movie      | description | rating |
+----+------------+-------------+--------+
| 5  | House card | Interesting | 9.1    |
| 1  | War        | great 3D    | 8.9    |
+----+------------+-------------+--------+
Explanation:
We have three movies with odd-numbered IDs: 1, 3, and 5. The movie with ID = 3 is boring so we do not include it in the answer.
```

</details>
