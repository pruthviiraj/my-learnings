[← Python · Pandas](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/second-highest-salary/)

# 176. Second Highest Salary

![Medium](https://img.shields.io/badge/Medium-ffc01e?style=flat-square)
![Python](https://img.shields.io/badge/Python-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 9, 2026](https://img.shields.io/badge/Solved%20Jul%209%2C%202026-555555?style=flat-square)

## How I approached it

I need the second highest salary from the Employee table, and I want it to be distinct, so I drop duplicates first. My first idea was to sort all salaries, but that would be slow if the table is big, so I sort only the unique salaries instead. This way is faster because it has fewer items to sort.

**How I got there:** I noticed that the problem asks for the second highest distinct salary, so I asked what would happen if there are duplicate salaries, and I saw that I need to get rid of them before I sort. I also thought about what would happen if there is no second highest salary, so I added a check for that.

1. Drop duplicates from the `salary` column so each salary is only counted once.
2. Sort the unique salaries in descending order, from highest to lowest, so the highest is first.
3. Check if there are at least 2 unique salaries, because if not, there is no second highest salary.
4. If there are at least 2, return the second one, which is at index 1 because indexing starts at 0.
5. If there is only one unique salary, return `None` because there is no second highest salary.

**Pattern to remember:** When a problem asks for a second or third something, and the data has duplicates, drop duplicates before sorting or counting, and check if there are enough items after that.

**Watch out for:** Forgetting to check if there are at least 2 unique salaries before trying to return the second one would cause an error if there is only one.

## Solution

![Time: O(n log n)](https://img.shields.io/badge/Time-O(n%20log%20n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 273 ms (beats 34.4%)](https://img.shields.io/badge/Runtime-273%20ms%20(beats%2034.4%25)-2cbb5d?style=flat-square)
![Memory: 67.3 MB (beats 43.9%)](https://img.shields.io/badge/Memory-67.3%20MB%20(beats%2043.9%25)-2f81f7?style=flat-square)

```python
import pandas as pd

def second_highest_salary(employee: pd.DataFrame) -> pd.DataFrame:

    # Drop duplicates and sort highest to lowest (Descending)
    unique_salaries = employee['salary'].drop_duplicates().sort_values(ascending=False)

    # Check if there are at least 2 unique salaries
    if len(unique_salaries) >= 2:
        #Index 1 is the 2nd highest(0-indexed)
        result = unique_salaries.iloc[1]
    else:
        result = None

    return pd.DataFrame({'SecondHighestSalary': [result]})
```

Source: [0176-second-highest-salary.py](./0176-second-highest-salary.py)

<details>
<summary><b>Problem statement</b></summary>

Table: `Employee`

```text
+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
Each row of this table contains information about the salary of an employee.
```

Write a solution to find the second highest **distinct** salary from the `Employee` table. If there is no second highest salary, return `null (return None in Pandas)`.

The result format is in the following example.

### Example 1

```text
Input:
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
Output:
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
```

### Example 2

```text
Input:
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
Output:
+---------------------+
| SecondHighestSalary |
+---------------------+
| null                |
+---------------------+
```

</details>
