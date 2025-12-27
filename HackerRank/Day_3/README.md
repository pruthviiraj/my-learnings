# Weather Observation Station 19

> Category: SQL – Aggregation & Mathematical Functions  
> Platform: HackerRank  
> Difficulty: Medium  


## Problem Statement

The `STATION` table contains geographic data:
- `LAT_N` → Northern Latitude
- `LONG_W` → Western Longitude

The task is to:
- Consider two points on a 2D plane:
  - Point A → (minimum latitude, minimum longitude)
  - Point B → (maximum latitude, maximum longitude)
- Calculate the **Euclidean distance** between these two points
- Display the result rounded to **4 decimal places**


## Step-by-Step Approach

1. Identify the extreme coordinates:
   - Point A = (`MIN(LAT_N)`, `MIN(LONG_W)`)
   - Point B = (`MAX(LAT_N)`, `MAX(LONG_W)`)

2. Use the Euclidean distance formula:

   \[
   \sqrt{(x_2 - x_1)^2 + (y_2 - y_1)^2}
   \]

3. Apply SQL aggregate and mathematical functions:
   - `MIN()` and `MAX()` for aggregation
   - `POWER()` for squaring values
   - `SQRT()` for square root
   - `ROUND()` to format the output


## SQL Solution

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

OUTPUT: 184.1616
