[← Python · Database](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/patients-with-a-condition/)

# 1527. Patients With a Condition

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![Python](https://img.shields.io/badge/Python-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 8, 2026](https://img.shields.io/badge/Solved%20Jul%208%2C%202026-555555?style=flat-square)

## How I approached it

I need to find patients with Type I Diabetes, which is marked by conditions starting with `DIAB1`. My first idea was to split the conditions and check each one, but using a regular expression is faster. I use `str.contains()` with a word boundary to match `DIAB1` at the start of a condition.

**How I got there:** I noticed that the conditions are separated by spaces, so I could split them, but that seemed slow. Then I thought about using a regular expression to match `DIAB1` at the start of a word, which led me to use `str.contains()` with a word boundary.

1. Import the `pandas` library to work with DataFrames.
2. Use `str.contains()` on the `conditions` column to find rows where a condition starts with `DIAB1`, using a word boundary regex to avoid matching conditions that contain `DIAB1` in the middle.
3. Return a new DataFrame with only the rows where a condition matches `DIAB1`.

**Pattern to remember:** When searching for a specific prefix in a string column, use `str.contains()` with a word boundary regex for efficient matching.

**Watch out for:** Not using a word boundary in the regex could match conditions that contain `DIAB1` in the middle, not just at the start.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)

```python
import pandas as pd

def find_patients(patients: pd.DataFrame) -> pd.DataFrame:

    # Use str.contains() with the word boundary regex
    has_diabetes = patients['conditions'].str.contains(r'\bDIAB1')

    return patients[has_diabetes]
```

Source: [1527-patients-with-a-condition.py](./1527-patients-with-a-condition.py)

<details>
<summary><b>Problem statement</b></summary>

Table: `Patients`

```text
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| patient_id   | int     |
| patient_name | varchar |
| conditions   | varchar |
+--------------+---------+
patient_id is the primary key (column with unique values) for this table.
'conditions' contains 0 or more code separated by spaces.
This table contains information of the patients in the hospital.
```

Write a solution to find the patient_id, patient_name, and conditions of the patients who have Type I Diabetes. Type I Diabetes always starts with `DIAB1` prefix.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Patients table:
+------------+--------------+--------------+
| patient_id | patient_name | conditions   |
+------------+--------------+--------------+
| 1          | Daniel       | YFEV COUGH   |
| 2          | Alice        |              |
| 3          | Bob          | DIAB100 MYOP |
| 4          | George       | ACNE DIAB100 |
| 5          | Alain        | DIAB201      |
+------------+--------------+--------------+
Output:
+------------+--------------+--------------+
| patient_id | patient_name | conditions   |
+------------+--------------+--------------+
| 3          | Bob          | DIAB100 MYOP |
| 4          | George       | ACNE DIAB100 |
+------------+--------------+--------------+
Explanation: Bob and George both have a condition that starts with DIAB1.
```

</details>
