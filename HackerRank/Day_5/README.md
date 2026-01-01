# Day 5 – Weather Observation Station 20

**Category:** SQL – Aggregation & Window Functions  
**Platform:** HackerRank  
**Difficulty:** Medium  

## Problem Statement

The `STATION` table contains geographic data with the following columns:

- `LAT_N` → Northern Latitude  
- `LONG_W` → Western Longitude  

The task is to:

- Calculate the **median** of all `LAT_N` values  
- Round the final result to **4 decimal places**

> A median is the value that separates the higher half and lower half of a dataset.

## Key Concept

Unlike `AVG()` or `SUM()`, **SQL does not have a built-in MEDIAN function in MySQL**, so the solution requires:

- Ordering the data
- Identifying the middle row(s)
- Handling both **odd and even** row counts correctly

## Approach

1. **Order all latitude values (`LAT_N`)**
2. Assign a row number to each value using `ROW_NUMBER()`
3. Count total rows using a window function
4. Identify the middle row(s):
   - If total rows are odd → one middle value
   - If total rows are even → average of two middle values
5. Use `AVG()` on the selected middle row(s)
6. Round the final result to 4 decimal places

## SQL Functions Used

- `ROW_NUMBER()` – to assign sequential order
- `COUNT() OVER()` – to get total number of rows
- `FLOOR()` & `CEIL()` – to locate median position(s)
- `AVG()` – to compute median value
- `ROUND()` – to format output

## SQL Solution

```
SELECT ROUND(AVG(LAT_N), 4)
FROM (
    SELECT 
        LAT_N,
        ROW_NUMBER() OVER (ORDER BY LAT_N) AS row_num,
        COUNT(*) OVER () AS total_rows
    FROM STATION
) AS subquery
WHERE row_num IN (
    FLOOR((total_rows + 1) / 2),
    CEIL((total_rows + 1) / 2)
);
```

## Output

```
83.8913
```
