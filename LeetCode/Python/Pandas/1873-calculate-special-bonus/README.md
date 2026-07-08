[← Python · Pandas](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/calculate-special-bonus/)

# 1873. Calculate Special Bonus

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![Python](https://img.shields.io/badge/Python-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 8, 2026](https://img.shields.io/badge/Solved%20Jul%208%2C%202026-555555?style=flat-square)

## How I approached it

I want to give a bonus to employees with an odd `employee_id` and a name that does not start with 'M', so I use a mask to pick those rows. My first idea was to use if statements, but a mask is faster and cleaner. I use the mask to multiply the `salary` by 1 or 0, which gives the bonus.

**How I got there:** I noticed the problem has two conditions for a bonus, so I asked how to combine them in one step. Once I saw that `&` can combine two conditions, the fix was to make a mask with both conditions and use it to calculate the `bonus`.

1. Create a mask `gets_bonus` that is true for rows where `employee_id` is odd and `name` does not start with 'M'.
2. Make a new column `bonus` by multiplying `salary` by the `gets_bonus` mask, which gives 0 for false and the `salary` for true.
3. Select the `employee_id` and `bonus` columns and sort by `employee_id`.

**Pattern to remember:** When a condition has two parts, combine them with `&` to make a mask.

**Watch out for:** Forgetting the parentheses around each condition when using `&` can give the wrong result.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 286 ms (beats 96.0%)](https://img.shields.io/badge/Runtime-286%20ms%20(beats%2096.0%25)-2cbb5d?style=flat-square)
![Memory: 67.9 MB (beats 54.5%)](https://img.shields.io/badge/Memory-67.9%20MB%20(beats%2054.5%25)-2f81f7?style=flat-square)

```python
import pandas as pd

def calculate_special_bonus(employees: pd.DataFrame) -> pd.DataFrame:

    # Create the combined mask for odd emp_id & name not start with 'M'
    gets_bonus = (employees['employee_id'] % 2 !=0) & (employees['name'].str.match(r'^[^M]'))

    # Create new column 'bonus' to calculate the employee bonus
    employees['bonus'] = employees['salary'] * gets_bonus
    
    # Select the bonus column and sorting by employee_id
    result = employees[['employee_id', 'bonus']].sort_values(by='employee_id')

    return result
```

Source: [1873-calculate-special-bonus.py](./1873-calculate-special-bonus.py)

<details>
<summary><b>Problem statement</b></summary>

Table: `Employees`

```text
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| employee_id | int     |
| name        | varchar |
| salary      | int     |
+-------------+---------+
employee_id is the primary key (column with unique values) for this table.
Each row of this table indicates the employee ID, employee name, and salary.
```

Write a solution to calculate the bonus of each employee. The bonus of an employee is `100%` of their salary if the ID of the employee is **an odd number** and ** the employee's name does not start with the character** `'M'`. The bonus of an employee is `0` otherwise.

Return the result table ordered by `employee_id`.

The result format is in the following example.

### Example 1

```text
Input:
Employees table:
+-------------+---------+--------+
| employee_id | name    | salary |
+-------------+---------+--------+
| 2           | Meir    | 3000   |
| 3           | Michael | 3800   |
| 7           | Addilyn | 7400   |
| 8           | Juan    | 6100   |
| 9           | Kannon  | 7700   |
+-------------+---------+--------+
Output:
+-------------+-------+
| employee_id | bonus |
+-------------+-------+
| 2           | 0     |
| 3           | 0     |
| 7           | 7400  |
| 8           | 0     |
| 9           | 7700  |
+-------------+-------+
Explanation:
The employees with IDs 2 and 8 get 0 bonus because they have an even employee_id.
The employee with ID 3 gets 0 bonus because their name starts with 'M'.
The rest of the employees get a 100% bonus.
```

</details>
