# The Blunder

### 📝 Problem Statement  
Samantha was asked to calculate the average salary of employees. Unfortunately, her keyboard’s **`0` key was broken**, so she calculated salaries with all `0`s removed.  

**Task:**  
- Compute the **actual average salary**.  
- Compute the **miscalculated average salary** (with zeros removed).  
- Return the **difference (error)** between them, rounded **up** to the next integer.  

---

### 💡 Approach  
1. Calculate the actual average salary using `AVG(salary)`.  
2. Clean the salary values for the miscalculated average:  
   - Convert salary to string → `CAST`.  
   - Remove all zeros → `REPLACE`.  
   - Handle empty results → `NULLIF`.  
   - Convert back to number → `CAST`.  
3. Compute the miscalculated average salary.  
4. Find the difference = actual average − miscalculated average.  
5. Round the final result **up** using `CEIL`.  

---

### 📚 Key Learnings  
- **CAST** → convert between string and numeric datatypes.  
- **REPLACE** → remove unwanted characters (`0`s here).  
- **NULLIF** → prevents errors from empty strings after replacement.  
- **AVG** → computes mean and ignores `NULL`s.  
- **CEIL** → rounds results up to the next integer.  

---
