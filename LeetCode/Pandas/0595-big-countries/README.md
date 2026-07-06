[← Pandas solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/big-countries/)

# 595. Big Countries

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![Pandas](https://img.shields.io/badge/Pandas-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 6, 2026](https://img.shields.io/badge/Solved%20Jul%206%2C%202026-555555?style=flat-square)

## How I approached it

I need to find countries that are big based on their area or population, so I filter the data to get only the rows where the area is at least three million or the population is at least twenty-five million. My first idea was to use multiple `if` statements, but using a single filter with `or` is more efficient. I use this filter to select the `name`, `population`, and `area` columns from the `world` table.

**How I got there:** I looked at the conditions for a country to be big and saw that it's either a big area or a big population, so I thought of using an `or` condition to filter the data. I used the `pandas` library to work with the data, which makes it easy to filter and select columns.

1. Filter the data to get only the rows where the area is at least three million or the population is at least twenty-five million using the condition `world['area']>=3000000` or `world['population']>=25000000`.
2. Use this filter to select the rows from the `world` table where the condition is true.
3. Select only the `name`, `population`, and `area` columns from the filtered data.

**Pattern to remember:** When filtering data based on multiple conditions, use a single filter with `or` instead of multiple `if` statements.

**Watch out for:** Not using parentheses around the conditions in the filter can lead to incorrect results due to operator precedence.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 257 ms (beats 82.5%)](https://img.shields.io/badge/Runtime-257%20ms%20(beats%2082.5%25)-2cbb5d?style=flat-square)
![Memory: 68.6 MB (beats 85.5%)](https://img.shields.io/badge/Memory-68.6%20MB%20(beats%2085.5%25)-2f81f7?style=flat-square)

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
