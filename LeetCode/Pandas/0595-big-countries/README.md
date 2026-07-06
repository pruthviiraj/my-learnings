[← Pandas solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/big-countries/)

# 595. Big Countries

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![Pandas](https://img.shields.io/badge/Pandas-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 6, 2026](https://img.shields.io/badge/Solved%20Jul%206%2C%202026-555555?style=flat-square)

## How I approached it

I filter the `World` table to find **big countries** based on `area` or `population`. My first idea was to use multiple `if` statements, but using a `pandas` filter is faster and cleaner. I use the `or` operator to check both conditions.

**How I got there:** I noticed that a country is **big** if it meets one of two conditions, so I asked how to combine these conditions in a filter. I used the `|` operator to combine the two conditions, which is like an `or` statement.

1. Import the `pandas` library to work with the `World` table.
2. Create a filter `is_big` that checks if `area` is at least 3000000 or `population` is at least 25000000.
3. Use this filter to select the rows from the `World` table that meet the condition.
4. Return a new table with only the `name`, `population`, and `area` columns from the filtered rows.

**Pattern to remember:** Use a filter to select rows from a table based on multiple conditions, and then select specific columns from the filtered rows.

**Watch out for:** Forgetting to use the `|` operator to combine the conditions will result in incorrect filtering.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 259 ms (beats 78.9%)](https://img.shields.io/badge/Runtime-259%20ms%20(beats%2078.9%25)-2cbb5d?style=flat-square)
![Memory: 69.1 MB (beats 20.6%)](https://img.shields.io/badge/Memory-69.1%20MB%20(beats%2020.6%25)-2f81f7?style=flat-square)

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
