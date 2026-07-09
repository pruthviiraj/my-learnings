import pandas as pd

def second_highest_salary(employee: pd.DataFrame) -> pd.DataFrame:

    # Drop duplicates and sort highest to lowest (Descending)
    unique_salaries = employee['salary'].drop_duplicates().sort_values(ascending=False)

    # Check if there are at least 2 unique salaries
    if len(unique_salaries) >= 2:
        #Index 1 is the 2nd highest(0-indexed)
        result = unique_salaries.iloc[1]
    else:
        result = None

    return pd.DataFrame({'SecondHighestSalary': [result]})
