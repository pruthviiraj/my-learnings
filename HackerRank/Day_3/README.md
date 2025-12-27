# Weather Observation Station 19

> Category: SQL – Aggregation & Mathematical Functions  
> Platform: HackerRank  
> Difficulty: Medium  

---

## 📝 Problem Statement

The `STATION` table contains geographic data:
- `LAT_N` → Northern Latitude
- `LONG_W` → Western Longitude

The task is to:
- Treat **two points on a 2D plane** as:
  - Point A → (minimum latitude, minimum longitude)
  - Point B → (maximum latitude, maximum longitude)
- Calculate the **Euclidean distance** between these two points
- Display the result **rounded to 4 decimal places**

---

## 🧠 How I Thought About the Problem

I first identified that this is **not a row-level problem**.  
The result depends only on **extreme values**, so the solution must operate at the **aggregate level**.

Instead of iterating through rows, I focused on:
- Finding the minimum and maximum latitude
- Finding the minimum and maximum longitude
- Treating them as coordinates of two points

Since the output is a **single numeric value**, no `GROUP BY` or subqueries are required.

---

## 🧩 Step-by-Step Approach

1. Identify the two points:
   - Point A = (`MIN(LAT_N)`, `MIN(LONG_W)`)
   - Point B = (`MAX(LAT_N)`, `MAX(LONG_W)`)

2. Apply the Euclidean distance formula:

   \[
   \sqrt{(x_2 - x_1)^2 + (y_2 - y_1)^2}
   \]

3. Translate the math into SQL using:
   - `MIN()` and `MAX()` for aggregation
   - `POWER()` for squaring values
   - `SQRT()` for square root
   - `ROUND()` for formatting

---

## 💻 SQL Solution

```sql
SELECT
    ROUND(
        SQRT(
            POWER(MAX(LAT_N) - MIN(LAT_N), 2)
          + POWER(MAX(LONG_W) - MIN(LONG_W), 2)
        ),
        4
    ) AS euclidean_distance
FROM STATION;

Output: 184.1616
