[← pythondata solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/big-countries/)

# 595. Big Countries

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![pythondata](https://img.shields.io/badge/pythondata-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 6, 2026](https://img.shields.io/badge/Solved%20Jul%206%2C%202026-555555?style=flat-square)

## How I approached it

I need to find countries that are big, which means they have a large `area` or a large `population`. My first idea was to use separate queries for each condition, but I realized I can use a single query with an `OR` condition to filter the results.

**How I got there:** I looked at the conditions for a country to be big and saw that it's either a large `area` or a large `population`, so I tried to combine these conditions into one query. I noticed that I can use the `OR` operator to include both conditions in the `WHERE` clause.

1. Select the `name`, `population`, and `area` columns from the `world` table.
2. Use a `WHERE` clause to filter the results based on the conditions for a big country.
3. Apply the `OR` condition to include countries with an `area` of at least 3000000 or a `population` of at least 25000000.

**Pattern to remember:** When filtering data based on multiple conditions, use the `OR` operator to combine the conditions in a single query.

**Watch out for:** Forgetting to use the `OR` operator and using `AND` instead would return incorrect results, as it would only include countries that meet both conditions.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(1)](https://img.shields.io/badge/Space-O(1)-d29922?style=flat-square)
![Runtime: 286 ms (beats 27.4%)](https://img.shields.io/badge/Runtime-286%20ms%20(beats%2027.4%25)-2cbb5d?style=flat-square)
![Memory: 68.6 MB (beats 77.3%)](https://img.shields.io/badge/Memory-68.6%20MB%20(beats%2077.3%25)-2f81f7?style=flat-square)

```pythondata
import pandas as pd

def big_countries(world: pd.DataFrame) -> pd.DataFrame:

    # Filtering the data
    is_big = (world['area']>=3000000) | (world['population']>=25000000)
    
    # Selecting/Returning ['name','population','area']
    return world[is_big][['name', 'population', 'area']]
```

Source: [0595-big-countries.txt](./0595-big-countries.txt)

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
