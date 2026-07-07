[← Python · Pandas](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/recyclable-and-low-fat-products/)

# 1757. Recyclable and Low Fat Products

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![Python](https://img.shields.io/badge/Python-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 7, 2026](https://img.shields.io/badge/Solved%20Jul%207%2C%202026-555555?style=flat-square)

## How I approached it

I filter the `Products` table to find products that are both low fat and recyclable. My first idea was to use a loop, but that would be slow, so I use a `pandas` filter instead. I look for rows where `low_fats` and `recyclable` are both 'Y'.

**How I got there:** I noticed that the `low_fats` and `recyclable` columns are `enums` with only two values, so I can use a simple comparison to filter the table. I thought about how to combine the two conditions, and using the `&` operator makes sense.

1. Create a mask `is_valid` that checks if `low_fats` and `recyclable` are both 'Y'.
2. Use this mask to filter the `products` table.
3. Select only the `product_id` column from the filtered table.
4. Return the result as a new `DataFrame`.

**Pattern to remember:** When filtering a table based on multiple conditions, use the `&` operator to combine the conditions.

**Watch out for:** Forgetting to use the `&` operator and using a single condition would return incorrect results.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 293 ms (beats 59.5%)](https://img.shields.io/badge/Runtime-293%20ms%20(beats%2059.5%25)-2cbb5d?style=flat-square)
![Memory: 67.3 MB (beats 65.0%)](https://img.shields.io/badge/Memory-67.3%20MB%20(beats%2065.0%25)-2f81f7?style=flat-square)

```python
import pandas as pd

def find_products(products: pd.DataFrame) -> pd.DataFrame:

    # Check the condition 'Y' for low_fats and recyclable
    is_valid = (products['low_fats']=='Y') & (products['recyclable']=='Y')

    result_df = products[is_valid][['product_id']]

    return result_df
```

Source: [1757-recyclable-and-low-fat-products.py](./1757-recyclable-and-low-fat-products.py)

<details>
<summary><b>Problem statement</b></summary>

Table: `Products`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_id  | int     |
| low_fats    | enum    |
| recyclable  | enum    |
+-------------+---------+
product_id is the primary key (column with unique values) for this table.
low_fats is an ENUM (category) of type ('Y', 'N') where 'Y' means this product is low fat and 'N' means it is not.
recyclable is an ENUM (category) of types ('Y', 'N') where 'Y' means this product is recyclable and 'N' means it is not.
```

Write a solution to find the ids of products that are both low fat and recyclable.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Products table:
+-------------+----------+------------+
| product_id  | low_fats | recyclable |
+-------------+----------+------------+
| 0           | Y        | N          |
| 1           | Y        | Y          |
| 2           | N        | Y          |
| 3           | Y        | Y          |
| 4           | N        | N          |
+-------------+----------+------------+
Output:
+-------------+
| product_id  |
+-------------+
| 1           |
| 3           |
+-------------+
Explanation: Only products 1 and 3 are both low fat and recyclable.
```

</details>
