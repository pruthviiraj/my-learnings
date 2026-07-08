[← Python · Pandas](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/find-users-with-valid-e-mails/)

# 1517. Find Users With Valid E-Mails

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![Python](https://img.shields.io/badge/Python-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 8, 2026](https://img.shields.io/badge/Solved%20Jul%208%2C%202026-555555?style=flat-square)

## How I approached it

I need to filter the `Users` table for rows where the `mail` column matches a certain pattern, which is a string that starts with a letter and has a specific domain. My first idea was to check each part of the email separately, but using a `regex` pattern is simpler and faster. I use `pandas` to make this easier.

**How I got there:** I looked at the rules for a valid email and saw that the prefix can have many characters, but must start with a letter, and the domain must be exactly `@leetcode.com`. This told me to use a `regex` pattern that checks both the prefix and the domain at the same time.

1. Define a `regex` pattern that matches the rules for a valid email, using `^` to start with a letter and `*` to allow many characters in the prefix.
2. Create a mask using `str.match()` to apply this pattern to the `mail` column of the `users` table.
3. Use this mask to filter the `users` table and return only the rows where the email is valid.

**Pattern to remember:** Using a `regex` pattern to validate email addresses is a common trick that can save time and make the code easier to read.

**Watch out for:** Forgetting the `^` at the start of the `regex` pattern would allow emails that start with an invalid character to pass the filter.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 352 ms (beats 5.9%)](https://img.shields.io/badge/Runtime-352%20ms%20(beats%205.9%25)-2cbb5d?style=flat-square)
![Memory: 67.4 MB (beats 65.3%)](https://img.shields.io/badge/Memory-67.4%20MB%20(beats%2065.3%25)-2f81f7?style=flat-square)

```python
import pandas as pd

def valid_emails(users: pd.DataFrame) -> pd.DataFrame:

    # Defining the regx pattern on mail column to meet the requirement
    pattern = r'^[a-zA-Z][a-zA-Z0-9_.-]*@leetcode\.com$'

    # Create a mask using str.match()
    is_valid = users['mail'].str.match(pattern)

    return users[is_valid]
```

Source: [1517-find-users-with-valid-e-mails.py](./1517-find-users-with-valid-e-mails.py)

<details>
<summary><b>Problem statement</b></summary>

Table: `Users`

```text
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| name          | varchar |
| mail          | varchar |
+---------------+---------+
user_id is the primary key (column with unique values) for this table.
This table contains information of the users signed up in a website. Some e-mails are invalid.
```

Write a solution to find the users who have **valid emails**.

A valid e-mail has a prefix name and a domain where:

- **The prefix name** is a string that may contain letters (upper or lower case), digits, underscore `'_'`, period `'.'`, and/or dash `'-'`. The prefix name ** must** start with a letter.
- **The domain** must be exactly `'@leetcode.com'` in lowercase.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Users table:
+---------+-----------+-------------------------+
| user_id | name      | mail                    |
+---------+-----------+-------------------------+
| 1       | Winston   | winston@leetcode.com    |
| 2       | Jonathan  | jonathanisgreat         |
| 3       | Annabelle | bella-@leetcode.com     |
| 4       | Sally     | sally.come@leetcode.com |
| 5       | Marwan    | quarz#2020@leetcode.com |
| 6       | David     | david69@gmail.com       |
| 7       | Shapiro   | .shapo@leetcode.com     |
+---------+-----------+-------------------------+
Output:
+---------+-----------+-------------------------+
| user_id | name      | mail                    |
+---------+-----------+-------------------------+
| 1       | Winston   | winston@leetcode.com    |
| 3       | Annabelle | bella-@leetcode.com     |
| 4       | Sally     | sally.come@leetcode.com |
+---------+-----------+-------------------------+
Explanation:
The mail of user 2 does not have a domain.
The mail of user 5 has the # sign which is not allowed.
The mail of user 6 does not have the leetcode domain.
The mail of user 7 starts with a period.
```

</details>
