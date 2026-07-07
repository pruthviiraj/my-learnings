[← Python · Pandas](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/article-views-i/)

# 1148. Article Views I

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![Python](https://img.shields.io/badge/Python-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 7, 2026](https://img.shields.io/badge/Solved%20Jul%207%2C%202026-555555?style=flat-square)

## How I approached it

I need to find authors who viewed their own articles, which means `author_id` must equal `viewer_id`. My first idea was to use a loop, but that would be slow, so I used a comparison to filter the rows instead. This way is fast because it uses pandas' built-in operations.

**How I got there:** I noticed that the problem is about finding authors who viewed their own articles, so I looked for a way to compare `author_id` and `viewer_id` directly. I realized I could use a boolean mask to filter the rows where these two ids are equal.

1. Compare `author_id` and `viewer_id` to get a boolean mask where they are equal.
2. Use this mask to filter the rows in the `views` dataframe.
3. Select only the `author_id` column from the filtered rows and rename it to `id`.
4. Drop duplicate `id` values to get unique authors.
5. Sort the result by `id` in ascending order.

**Pattern to remember:** When I need to find rows where two columns are equal, I use a boolean comparison to filter the dataframe.

**Watch out for:** If I forget to drop duplicates, I will get multiple rows for the same author.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 330 ms (beats 8.0%)](https://img.shields.io/badge/Runtime-330%20ms%20(beats%208.0%25)-2cbb5d?style=flat-square)
![Memory: 67.8 MB (beats 6.1%)](https://img.shields.io/badge/Memory-67.8%20MB%20(beats%206.1%25)-2f81f7?style=flat-square)

```python
import pandas as pd

def article_views(views: pd.DataFrame) -> pd.DataFrame:
    
    df_compare = (views['author_id']) == (views['viewer_id'])

    return views[df_compare][['author_id']].rename(columns={'author_id':'id'}).drop_duplicates().sort_values(by='id')
```

Source: [1148-article-views-i.py](./1148-article-views-i.py)

<details>
<summary><b>Problem statement</b></summary>

Table: `Views`

```text
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| article_id    | int     |
| author_id     | int     |
| viewer_id     | int     |
| view_date     | date    |
+---------------+---------+
There is no primary key (column with unique values) for this table, the table may have duplicate rows.
Each row of this table indicates that some viewer viewed an article (written by some author) on some date.
Note that equal author_id and viewer_id indicate the same person.
```

Write a solution to find all the authors that viewed at least one of their own articles.

Return the result table sorted by `id` in ascending order.

The result format is in the following example.

### Example 1

```text
Input:
Views table:
+------------+-----------+-----------+------------+
| article_id | author_id | viewer_id | view_date  |
+------------+-----------+-----------+------------+
| 1          | 3         | 5         | 2019-08-01 |
| 1          | 3         | 6         | 2019-08-02 |
| 2          | 7         | 7         | 2019-08-01 |
| 2          | 7         | 6         | 2019-08-02 |
| 4          | 7         | 1         | 2019-07-22 |
| 3          | 4         | 4         | 2019-07-21 |
| 3          | 4         | 4         | 2019-07-21 |
+------------+-----------+-----------+------------+
Output:
+------+
| id   |
+------+
| 4    |
| 7    |
+------+
```

</details>
