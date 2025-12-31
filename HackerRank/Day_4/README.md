# Day 3 — New Companies

## Problem Statement

Amber’s conglomerate acquires multiple companies.
Each company follows a fixed organizational hierarchy:

**Founder → Lead Manager → Senior Manager → Manager → Employee**

Given separate tables for each level, the task is to:

* Print the `company_code` and `founder`
* Count the **distinct** number of:

  * Lead Managers
  * Senior Managers
  * Managers
  * Employees

* Sort results by `company_code` (string order, not numeric)


## Tables Involved

* `Company`
* `Lead_Manager`
* `Senior_Manager`
* `Manager`
* `Employee`


## Approach

### 1. Choose the driving table

`Company` is used as the base table because every required row must represent **one company**, even if some hierarchy levels are missing.


### 2. Join strategy

All hierarchy tables are joined using **LEFT JOINs** on `company_code`.

This ensures:

* Companies without certain roles are still included
* No rows are accidentally dropped due to missing hierarchy levels


### 3. Handle duplication safely

Because joining multiple hierarchy tables can create **row multiplication**, all counts use:

```sql
COUNT(DISTINCT column_name)
```

This prevents inflated numbers caused by join fan-out.

### 4. Aggregation level

Results are grouped by:

* `company_code`
* `founder`

This guarantees **one row per company** in the final output.

## Key Concepts Practiced

* Multi-table joins
* LEFT JOIN vs INNER JOIN
* `COUNT(DISTINCT ...)`
* Aggregation with `GROUP BY`
* Avoiding duplicate inflation
* String-based ordering


## SQL Solution

```sql
SELECT
    c.company_code,
    c.founder,
    COUNT(DISTINCT lm.lead_manager_code) AS ttl_lm,
    COUNT(DISTINCT sm.senior_manager_code) AS ttl_sm,
    COUNT(DISTINCT m.manager_code) AS ttl_m,
    COUNT(DISTINCT e.employee_code) AS ttl_e
FROM company c
LEFT JOIN lead_manager lm
    ON c.company_code = lm.company_code
LEFT JOIN senior_manager sm
    ON c.company_code = sm.company_code
LEFT JOIN manager m
    ON c.company_code = m.company_code
LEFT JOIN employee e
    ON c.company_code = e.company_code
GROUP BY c.company_code, c.founder
ORDER BY c.company_code;

```

## Sample Output
```
C1 Angela 1 2 5 13 
C10 Earl 1 1 2 3 
C100 Aaron 1 2 4 10 
C11 Robert 1 1 1 1 
C12 Amy 1 2 6 14 
C13 Pamela 1 2 5 14 
C14 Maria 1 1 3 5 
C15 Joe 1 1 2 3 
C16 Linda 1 1 3 5 
C17 Melissa 1 2 3 7 
C18 Carol 1 2 5 6 
C19 Paula 1 2 4 7 
C2 Frank 1 1 1 3 
C20 Marilyn 1 1 2 2 
C21 Jennifer 1 1 3 7

```
