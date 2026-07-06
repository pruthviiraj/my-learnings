[← Python solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/big-countries/)

# 595. Big Countries

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![Python3](https://img.shields.io/badge/Python3-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 6, 2026](https://img.shields.io/badge/Solved%20Jul%206%2C%202026-555555?style=flat-square)

## How I approached it

I filter the `World` table for rows where a country is **big**, meaning it has a large `area` or `population`. My first idea was to use multiple `if` statements, but using the `|` operator to combine conditions is more straightforward. I use this condition to select the right rows and then pick the columns I need.

**How I got there:** I noticed that a country is **big** if it meets either of two conditions, so I asked how to express that in code. The `|` operator lets me combine the two conditions into one, which I can use to filter the `World` table.

1. Create a condition `is_big` that checks if a country's `area` is at least three million or its `population` is at least twenty-five million.
2. Use this condition to filter the `World` table, keeping only the rows where `is_big` is true.
3. Select only the `name`, `population`, and `area` columns from the filtered table.

**Pattern to remember:** When filtering data based on multiple conditions, use the `|` operator to combine them into one condition.

**Watch out for:** Forgetting to use the `|` operator and instead using `&` would return no results because a country's `area` and `population` would need to both meet the conditions.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)

```python
import pandas as pd

def big_countries(world: pd.DataFrame) -> pd.DataFrame:
    # Filtering the data
    is_big = (world['area']>=3000000) | (world['population']>=25000000)

    # Selecting/Returning ['name','population','area']
    return world[is_big][['name', 'population', 'area']]
```

Source: [0595-big-countries.py](./0595-big-countries.py)

<details>
<summary><b>Problem statement</b></summary>

Table: `World`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| name        | varchar |
| continent   | varchar |
| area        | int     |
| population  | int     |
| gdp         | bigint  |
+-------------+---------+
name is the primary key (column with unique values) for this table.
Each row of this table gives information about the name of a country, the continent to which it belongs, its area, the population, and its GDP value.
```

A country is **big** if:

- it has an area of at least three million (i.e., `3000000 km^2`), or
- it has a population of at least twenty-five million (i.e., `25000000`).

Write a solution to find the name, population, and area of the **big countries**.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
World table:
+-------------+-----------+---------+------------+--------------+
| name        | continent | area    | population | gdp          |
+-------------+-----------+---------+------------+--------------+
| Afghanistan | Asia      | 652230  | 25500100   | 20343000000  |
| Albania     | Europe    | 28748   | 2831741    | 12960000000  |
| Algeria     | Africa    | 2381741 | 37100000   | 188681000000 |
| Andorra     | Europe    | 468     | 78115      | 3712000000   |
| Angola      | Africa    | 1246700 | 20609294   | 100990000000 |
+-------------+-----------+---------+------------+--------------+
Output:
+-------------+------------+---------+
| name        | population | area    |
+-------------+------------+---------+
| Afghanistan | 25500100   | 652230  |
| Algeria     | 37100000   | 2381741 |
+-------------+------------+---------+
```

</details>
