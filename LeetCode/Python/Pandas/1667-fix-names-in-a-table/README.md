[← Python · Pandas](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/fix-names-in-a-table/)

# 1667. Fix Names in a Table

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![Python](https://img.shields.io/badge/Python-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 8, 2026](https://img.shields.io/badge/Solved%20Jul%208%2C%202026-555555?style=flat-square)

## How I approached it

I want to fix the names in the table so only the first character is uppercase and the rest are lowercase, which is what the `capitalize()` function does. My first idea was to use separate `upper()` and `lower()` calls, but that would be more work than needed. I can use `capitalize()` to replace the `name` column directly.

**How I got there:** I noticed the `name` column has mixed case, so I looked for a function that can fix that in one step. Once I found `capitalize()`, I knew I could use it to overwrite the `name` column. I also thought about using `apply()` with a lambda function, but `str.capitalize()` is simpler.

1. Use the `capitalize()` function to overwrite the `name` column, which makes the first character uppercase and the rest lowercase.
2. Assign the result back to the `name` column in the `users` DataFrame.
3. Sort the resulting DataFrame by `user_id` to get the output in the right order.

**Pattern to remember:** When I need to fix the case of a string, I can use the `capitalize()` function to make the first character uppercase and the rest lowercase.

**Watch out for:** Not checking if the `name` column exists before trying to overwrite it could cause an error.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 315 ms (beats 25.8%)](https://img.shields.io/badge/Runtime-315%20ms%20(beats%2025.8%25)-2cbb5d?style=flat-square)
![Memory: 68 MB (beats 53.8%)](https://img.shields.io/badge/Memory-68%20MB%20(beats%2053.8%25)-2f81f7?style=flat-square)

```python
import pandas as pd

def fix_names(users: pd.DataFrame) -> pd.DataFrame:

    # Use capitalize() function to overwrite name column
    users['name'] = users['name'].str.capitalize()

    return users.sort_values(by='user_id')
```

Source: [1667-fix-names-in-a-table.py](./1667-fix-names-in-a-table.py)

<details>
<summary><b>Problem statement</b></summary>

Table: `Users`

```text
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| user_id        | int     |
| name           | varchar |
+----------------+---------+
user_id is the primary key (column with unique values) for this table.
This table contains the ID and the name of the user. The name consists of only lowercase and uppercase characters.
```

Write a solution to fix the names so that only the first character is uppercase and the rest are lowercase.

Return the result table ordered by `user_id`.

The result format is in the following example.

### Example 1

```text
Input:
Users table:
+---------+-------+
| user_id | name  |
+---------+-------+
| 1       | aLice |
| 2       | bOB   |
+---------+-------+
Output:
+---------+-------+
| user_id | name  |
+---------+-------+
| 1       | Alice |
| 2       | Bob   |
+---------+-------+
```

</details>
