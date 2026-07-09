import pandas as pd

def nth_highest_salary(employee: pd.DataFrame, N: int) -> pd.DataFrame:

    # Find the nth distinct salary
    unique_salaries = employee['salary'].drop_duplicates().sort_values(ascending=False)

    # Check if N is valid and not out of bound
    if N > len(unique_salaries) or N <= 0:
        result = None
    else:
        result =  unique_salaries.iloc[N-1]

    # Return the result datafram
    return pd.DataFrame({f'getNthHighestSalary({N})':[result]})
