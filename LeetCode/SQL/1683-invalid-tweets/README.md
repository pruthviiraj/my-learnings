[← SQL solutions](../README.md) · [View on LeetCode ↗](https://leetcode.com/problems/invalid-tweets/)

# 1683. Invalid Tweets

![Easy](https://img.shields.io/badge/Easy-00b8a3?style=flat-square)
![SQL](https://img.shields.io/badge/SQL-2f81f7?style=flat-square)
![Database](https://img.shields.io/badge/Database-30363d?style=flat-square)
![Solved Jul 6, 2026](https://img.shields.io/badge/Solved%20Jul%206%2C%202026-555555?style=flat-square)

## How I approached it

I need to find all the tweets that have more than 15 characters in the `content` field, which makes them invalid. My first idea was to count the characters one by one, but that is too slow. I can use a built-in function `CHAR_LENGTH` to get the length of `content` instead.

**How I got there:** I noticed that the problem asks for tweets with `content` length strictly greater than 15, so I need to use a `>` sign in my query. I also saw that the `CHAR_LENGTH` function can give me the length of the `content` field.

1. Select all `tweet_id` from the `tweets` table.
2. Use a `WHERE` clause to filter the tweets based on the length of `content`.
3. Use the `CHAR_LENGTH` function to get the length of `content` and compare it to 15.

**Pattern to remember:** When I need to check the length of a string, I can use a built-in function like `CHAR_LENGTH` instead of counting the characters myself.

**Watch out for:** Using `>=` instead of `>` would incorrectly include tweets with exactly 15 characters.

## Solution

![Time: O(n)](https://img.shields.io/badge/Time-O(n)-8250df?style=flat-square)
![Space: O(1)](https://img.shields.io/badge/Space-O(1)-d29922?style=flat-square)
![Runtime: 636 ms (beats 41.1%)](https://img.shields.io/badge/Runtime-636%20ms%20(beats%2041.1%25)-2cbb5d?style=flat-square)
![Memory: 0B (beats 100.0%)](https://img.shields.io/badge/Memory-0B%20(beats%20100.0%25)-2f81f7?style=flat-square)

```sql
SELECT tweet_id
FROM tweets
WHERE CHAR_LENGTH(content) > 15;
```

Source: [1683-invalid-tweets.sql](./1683-invalid-tweets.sql)

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
