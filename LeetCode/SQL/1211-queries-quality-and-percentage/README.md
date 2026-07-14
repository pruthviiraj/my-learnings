[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/queries-quality-and-percentage/)

# 1211. Queries Quality and Percentage

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 14, 2026](https://img.shields.io/badge/Solved%20Jul%2014%2C%202026-555555?style=flat-square)

## How I approached it

I calculate `quality` as the average of `rating` divided by `position`, and `poor_query_percentage` as the percentage of rows with `rating` less than 3. My first idea was to use separate `SUM` and `COUNT` calculations, but I can do it all in one pass with `AVG` and a `CASE` statement.

**How I got there:** I noticed that `quality` involves both `rating` and `position`, so I looked for a way to combine them in a single calculation, which led me to use `AVG` with a division inside it. For `poor_query_percentage`, I realized I could use a `CASE` statement to count the poor queries without needing a separate `COUNT`.

1. Group the `queries` table by `query_name` so each query is calculated separately.
2. Calculate `quality` by taking the average of `rating` divided by `position` for each group, using `AVG(rating/position)`.
3. Calculate `poor_query_percentage` by using a `CASE` statement to count rows with `rating` less than 3, then multiplying by 100 and averaging, with `AVG(CASE WHEN rating < 3 THEN 1 ELSE 0 END) * 100.0`.
4. Round both `quality` and `poor_query_percentage` to 2 decimal places with `ROUND`.

**Pattern to remember:** Using `AVG` with a calculation inside it can simplify queries that involve ratios or percentages.

**Watch out for:** Forgetting to multiply by 100.0 when calculating `poor_query_percentage` would result in a percentage that is too small.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)

```sql
SELECT
    query_name,
    ROUND(AVG(rating/position),2) AS quality,
    ROUND((COUNT(rating)<=3)*100.0/COUNT(rating),2) AS poor_query_percentage
FROM queries
GROUP BY query_name;
```

Source: [1211-queries-quality-and-percentage.sql](./1211-queries-quality-and-percentage.sql)

<details>
<summary><b>Problem statement</b></summary>

Table: `Queries`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| query_name  | varchar |
| result      | varchar |
| position    | int     |
| rating      | int     |
+-------------+---------+
This table may have duplicate rows.
This table contains information collected from some queries on a database.
The position column has a value from 1 to 500.
The rating column has a value from 1 to 5. Query with rating less than 3 is a poor query.
```

We define query `quality` as:

The average of the ratio between query rating and its position.

We also define `poor query percentage` as:

The percentage of all queries with rating less than 3.

Write a solution to find each `query_name`, the `quality` and `poor_query_percentage`.

Both `quality` and `poor_query_percentage` should be **rounded to 2 decimal places**.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Queries table:
+------------+-------------------+----------+--------+
| query_name | result            | position | rating |
+------------+-------------------+----------+--------+
| Dog        | Golden Retriever  | 1        | 5      |
| Dog        | German Shepherd   | 2        | 5      |
| Dog        | Mule              | 200      | 1      |
| Cat        | Shirazi           | 5        | 2      |
| Cat        | Siamese           | 3        | 3      |
| Cat        | Sphynx            | 7        | 4      |
+------------+-------------------+----------+--------+
Output:
+------------+---------+-----------------------+
| query_name | quality | poor_query_percentage |
+------------+---------+-----------------------+
| Dog        | 2.50    | 33.33                 |
| Cat        | 0.66    | 33.33                 |
+------------+---------+-----------------------+
Explanation:
Dog queries quality is ((5 / 1) + (5 / 2) + (1 / 200)) / 3 = 2.50
Dog queries poor_ query_percentage is (1 / 3) * 100 = 33.33

Cat queries quality equals ((2 / 5) + (3 / 3) + (4 / 7)) / 3 = 0.66
Cat queries poor_ query_percentage is (1 / 3) * 100 = 33.33
```

</details>
