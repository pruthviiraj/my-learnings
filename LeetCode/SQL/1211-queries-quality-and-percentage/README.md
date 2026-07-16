[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/queries-quality-and-percentage/)

# 1211. Queries Quality and Percentage

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 14, 2026](https://img.shields.io/badge/Solved%20Jul%2014%2C%202026-555555?style=flat-square)

## How I approached it

I need to calculate `quality` as the average of the ratio between query `rating` and its `position`, and `poor_query_percentage` as the percentage of all queries with `rating` less than 3. My first idea was to calculate the sum of the ratios and then divide by the count of queries, but I can do this directly with `AVG`.

**How I got there:** I noticed that the `quality` can be calculated directly with `AVG` of `rating/position`, and for `poor_query_percentage` I can use a `CASE` statement inside `AVG` to count the number of poor queries. This way I can calculate both values in a single query.

1. Group the table by `query_name` so each query is counted on its own.
2. Calculate `quality` by taking the `AVG` of `rating/position` for each group.
3. Calculate `poor_query_percentage` by using a `CASE` statement inside `AVG` to count the number of poor queries, then multiply by 100.0 and divide by the total count of queries.

**Pattern to remember:** When calculating averages and percentages, use `AVG` with conditional statements to simplify the query.

**Watch out for:** Not multiplying by 100.0 when calculating `poor_query_percentage` would result in a value without decimal places.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 492 ms (beats 9.0%)](https://img.shields.io/badge/Runtime-492%20ms%20(beats%209.0%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
-- query quality = avg(rating/position)
-- poor query percentage = (COUNT(rating)<3)*100.0/COUNT(rating)
SELECT
    query_name,
    ROUND(AVG(rating/position),2) AS quality,
    ROUND(AVG(CASE WHEN rating < 3 THEN 1 ELSE 0 END) * 100.0,2) AS poor_query_percentage
FROM queries
GROUP BY query_name
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
