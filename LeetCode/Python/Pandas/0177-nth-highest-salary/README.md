[← Python · Pandas](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/nth-highest-salary/)

# 177. Nth Highest Salary

![Medium](https://img.shields.io/badge/Medium-ffc01e?style=flat-square)
![Python](https://img.shields.io/badge/Python-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 9, 2026](https://img.shields.io/badge/Solved%20Jul%209%2C%202026-555555?style=flat-square)

## How I approached it

I need to find the nth highest distinct salary from the Employee table, so I drop duplicates and sort the salaries in descending order. My first idea was to sort all salaries, but that would be slow and I only need distinct ones. I use a `DataFrame` to get the distinct salaries and then check if n is valid.

**How I got there:** I noticed that the problem asks for distinct salaries, so I thought about how to remove duplicates. I saw that pandas has a `drop_duplicates` function, which does exactly that. Then I thought about how to get the nth highest salary, and sorting the salaries in descending order seemed like the obvious choice.

1. Drop duplicates from the `salary` column to get the unique salaries.
2. Sort the unique salaries in descending order so the highest salary is first.
3. Check if n is valid by comparing it to the number of unique salaries, and return null if it's not.
4. If n is valid, return the nth highest salary by indexing into the sorted list of unique salaries.
5. Put the result into a new `DataFrame` with the correct column name.

**Pattern to remember:** When dealing with duplicates, use `drop_duplicates` to remove them, and when getting the nth item, use indexing after sorting.

**Watch out for:** Not checking if n is valid before trying to get the nth salary can cause an error if there are less than n distinct salaries.

## Solution

![Time: O(n log n)](https://img.shields.io/badge/Time-O(n%20log%20n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 279 ms (beats 46.0%)](https://img.shields.io/badge/Runtime-279%20ms%20(beats%2046.0%25)-2cbb5d?style=flat-square)
![Memory: 66.7 MB (beats 83.0%)](https://img.shields.io/badge/Memory-66.7%20MB%20(beats%2083.0%25)-2f81f7?style=flat-square)

```python
import pandas as pd

def nth_highest_salary(employee: pd.DataFrame, N: int) -> pd.DataFrame:

    # Find the nth distinct salary
    unique_salaries = employee['salary'].drop_duplicates().sort_values(ascending=False)

    # Check if N is valid and not out of bound
    if N > len(unique_salaries) or N <= 0:
        result = None
    else:
        result =  unique_salaries.iloc[N-1]

    # Return the result datafram
    return pd.DataFrame({f'getNthHighestSalary({N})':[result]})
```

Source: [0177-nth-highest-salary.py](./0177-nth-highest-salary.py)

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

Write a solution to find the `n^th` highest **distinct** salary from the `Employee` table. If there are less than `n` distinct salaries, return `null`.

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
n = 2
Output:
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| 200                    |
+------------------------+
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
n = 2
Output:
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| null                   |
+------------------------+
```

</details>
