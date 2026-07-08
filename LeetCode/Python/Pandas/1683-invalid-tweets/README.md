[← Python · Pandas](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/invalid-tweets/)

# 1683. Invalid Tweets

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![Python](https://img.shields.io/badge/Python-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 8, 2026](https://img.shields.io/badge/Solved%20Jul%208%2C%202026-555555?style=flat-square)

## How I approached it

I need to find tweets with content longer than 15 characters, so I check the length of each `content` string. My first idea was to loop through each row, but using a `mask` is faster.

**How I got there:** I noticed the problem asks for tweets with content length strictly greater than 15, so I used a `> 15` condition to create a mask. This mask tells me which rows have invalid tweets.

1. Create a mask to check the string length of each row using `str.len()` on the `content` column.
2. Use this mask to filter the `tweets` dataframe and get only the rows with invalid tweets.
3. Return only the `tweet_id` column from the filtered dataframe.

**Pattern to remember:** When filtering a dataframe based on a condition, use a mask to select rows.

**Watch out for:** Using `>= 15` instead of `> 15` would incorrectly include tweets with exactly 15 characters.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(n)](https://img.shields.io/badge/Space-O(n)-d29922?style=flat-square)
![Runtime: 339 ms (beats 6.5%)](https://img.shields.io/badge/Runtime-339%20ms%20(beats%206.5%25)-2cbb5d?style=flat-square)
![Memory: 67.4 MB (beats 48.2%)](https://img.shields.io/badge/Memory-67.4%20MB%20(beats%2048.2%25)-2f81f7?style=flat-square)

```python
import pandas as pd

def invalid_tweets(tweets: pd.DataFrame) -> pd.DataFrame:
    # Create a mask to check the string length of each row
    invalid_tweets = tweets['content'].str.len() > 15

    # Return only tweet_id column as dataframe
    return tweets[invalid_tweets][['tweet_id']]
```

Source: [1683-invalid-tweets.py](./1683-invalid-tweets.py)

<details>
<summary><b>Problem statement</b></summary>

Table: `Tweets`

```text
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| tweet_id       | int     |
| content        | varchar |
+----------------+---------+
tweet_id is the primary key (column with unique values) for this table.
content consists of alphanumeric characters, '!', or ' ' and no other special characters.
This table contains all the tweets in a social media app.
```

Write a solution to find the IDs of the invalid tweets. The tweet is invalid if the number of characters used in the content of the tweet is **strictly greater** than `15`.

Return the result table in **any order**.

The result format is in the following example.

### Example 1

```text
Input:
Tweets table:
+----------+-----------------------------------+
| tweet_id | content                           |
+----------+-----------------------------------+
| 1        | Let us Code                       |
| 2        | More than fifteen chars are here! |
+----------+-----------------------------------+
Output:
+----------+
| tweet_id |
+----------+
| 2        |
+----------+
Explanation:
Tweet 1 has length = 11. It is a valid tweet.
Tweet 2 has length = 33. It is an invalid tweet.
```

</details>
