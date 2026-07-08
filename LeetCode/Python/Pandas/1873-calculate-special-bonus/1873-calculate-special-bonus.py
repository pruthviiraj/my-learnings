import pandas as pd

def calculate_special_bonus(employees: pd.DataFrame) -> pd.DataFrame:

    # Create the combined mask for odd emp_id & name not start with 'M'
    gets_bonus = (employees['employee_id'] % 2 !=0) & (employees['name'].str.match(r'^[^M]'))

    # Create new column 'bonus' to calculate the employee bonus
    employees['bonus'] = employees['salary'] * gets_bonus
    
    # Select the bonus column and sorting by employee_id
    result = employees[['employee_id', 'bonus']].sort_values(by='employee_id')

    return result
