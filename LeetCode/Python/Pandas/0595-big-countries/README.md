[← Python · Pandas](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/big-countries/)

# 595. Big Countries

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![Python](https://img.shields.io/badge/Python-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 6, 2026](https://img.shields.io/badge/Solved%20Jul%206%2C%202026-555555?style=flat-square)

## How I approached it

I need to find countries that are big based on their area or population, so I use a filter to pick the rows that meet either condition. My first idea was to use separate filters for area and population, but I can combine them with `or`. I want the `name`, `population`, and `area` of these big countries.

**How I got there:** I started by looking at the conditions for a country to be big, and I saw that it's either a big area or a big population. That told me to use a filter that checks both conditions. I used the `or` operator to combine the two conditions into one filter.

1. Create a filter `is_big` that checks if a country's `area` is at least 3000000 or its `population` is at least 25000000.
2. Use this filter to select the rows from the `world` table where the country is big.
3. Select only the `name`, `population`, and `area` columns from the filtered rows.

**Pattern to remember:** When filtering data based on multiple conditions, use the `or` operator to combine the conditions into one filter.

**Watch out for:** Using `and` instead of `or` would return only countries that are big in both area and population, which is not what the problem asks for.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 275 ms (beats 44.5%)](https://img.shields.io/badge/Runtime-275%20ms%20(beats%2044.5%25)-2cbb5d?style=flat-square)
![Memory: 68.7 MB (beats 68.3%)](https://img.shields.io/badge/Memory-68.7%20MB%20(beats%2068.3%25)-2f81f7?style=flat-square)

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
