[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/queries-quality-and-percentage/)

# 1211. Queries Quality and Percentage

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 14, 2026](https://img.shields.io/badge/Solved%20Jul%2014%2C%202026-555555?style=flat-square)

## How I approached it

I need to calculate the average of `rating/position` for each query to find the `quality`, and then figure out the percentage of queries with a rating less than 3 to find the `poor_query_percentage`. I use the `AVG()` function to do these calculations after grouping by `query_name`. I need to round the final answers to two decimal places.

**How I got there:** I started by thinking about how to find the average rating per position. Then I realized I needed to calculate the proportion of queries with a rating less than 3. This involves a `CASE` statement to assign 1 if the rating is less than 3, and 0 otherwise, before calculating the average percentage.

1. Group the rows by `query_name` so I can calculate the average for each query.
2. Calculate the average of `rating / position` for each group. This gives me the query quality.
3. Calculate the percentage of queries with a rating less than 3 for each group. I use a `CASE` statement within an `AVG()` function to achieve this.
4. Round both the `quality` and `poor_query_percentage` to two decimal places using the `ROUND()` function.
5. Select the `query_name`, calculated `quality`, and `poor_query_percentage`.

**Pattern to remember:** Use `AVG()` with a `CASE` statement to calculate percentages based on conditions within the data.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(1)](https://img.shields.io/badge/Space-O(1)-d29922?style=flat-square)
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
