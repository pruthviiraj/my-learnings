import pandas as pd

def fix_names(users: pd.DataFrame) -> pd.DataFrame:

    # Use capitalize() function to overwrite name column
    users['name'] = users['name'].str.capitalize()

    return users.sort_values(by='user_id')
