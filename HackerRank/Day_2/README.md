### Occupations

----

## Problem Statement

You are given a table containing names and their occupations. The goal is to **pivot the data** so that all names are grouped under their respective occupation columns.

## Task:

- Display names in **alphabetical order** under four columns: Doctor, Professor, Singer, and Actor.  
- Each row should contain one name from each occupation (if available).  
- If an occupation has fewer names than others, the empty spaces should remain NULL.  
- Occupations must appear in this order: **Doctor → Professor → Singer → Actor**.


## Approach  

- Sort all records alphabetically by `name`.  
- Assign a **row number (ROW_NUMBER)** to each occupation group.  
- Transform rows into columns using:
  - `CASE WHEN occupation = '...' THEN name END`  
  - Place each occupation into its correct column.  
- Use `MAX()` to collapse each group into a single row per row number.  
- Group everything using the assigned row number to align rows correctly.  
- Order by row number so output is consistent.


## Key Learnings  

- **ROW_NUMBER()** → helps align rows when pivoting manually.  
- **CASE WHEN** → used to distribute names across occupation-based columns.  
- **MAX() with GROUP BY** → converts row-based data into pivot-style columns.  
- **Alphabetical sorting** is crucial for consistent alignment.  
- Understanding how to **manually pivot data** without SQL PIVOT functions.
