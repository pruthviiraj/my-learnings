# Day 7 – Top Competitors

**Category:** SQL – Basic Join

**Platform:** HackerRank

**Difficulty:** Medium

## Problem Statement

Julia needs a leaderboard for a coding contest. The goal is to identify hackers who have achieved a **full score** on **more than one challenge**.

The report must follow these specific requirements:

* **Metric:** Count how many times each hacker earned a score equal to the maximum possible score for a challenge.
* **Filter:** Only include hackers who achieved this for **more than one** challenge.
* **Sorting Tier 1:** Sort by the total count of full-score challenges in **descending** order.
* **Sorting Tier 2:** If multiple hackers have the same count, sort them by `hacker_id` in **ascending** order.

## Key Concept

The primary challenge is the **Relational Chain**. The information needed to define a "full score" is spread across multiple tables. You must bridge the `Submissions` table (actual score) to the `Difficulty` table (max score) by passing through the `Challenges` table.

## Approach

1. **Chain Multiple Joins:** Connect `Submissions` to `Challenges` (via `challenge_id`), then `Challenges` to `Difficulty` (via `difficulty_level`), and finally `Submissions` to `Hackers` (via `hacker_id`).
2. **Filter for Full Scores:** Use a `WHERE` clause to keep only rows where `Submissions.score = Difficulty.score`.
3. **Aggregate by Hacker:** Group the results by `hacker_id` and `name` to count their successful submissions.
4. **Filter Groups:** Use a `HAVING` clause to restrict the output to those with a `COUNT > 1`.
5. **Final Sort:** Apply the two-tiered `ORDER BY` logic as requested.

## SQL Functions Used

* **`INNER JOIN`** – To link four different tables based on shared keys.
* **`GROUP BY`** – To aggregate challenge counts for individual hackers.
* **`HAVING`** – To filter results based on an aggregate condition (count > 1).
* **`ORDER BY`** – To handle the multi-level sorting requirement.

## SQL Solution

```sql
SELECT 
    h.hacker_id, 
    h.name
FROM Submissions s
JOIN Challenges c ON s.challenge_id = c.challenge_id
JOIN Difficulty d ON c.difficulty_level = d.difficulty_level
JOIN Hackers h ON s.hacker_id = h.hacker_id
WHERE s.score = d.score
GROUP BY h.hacker_id, h.name
HAVING COUNT(s.submission_id) > 1
ORDER BY COUNT(s.submission_id) DESC, h.hacker_id ASC;

```

## Output Example

```text
27232 Phillip
28614 Willie
15719 Christina
43892 Roy
14246 David

```
