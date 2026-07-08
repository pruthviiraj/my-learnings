import pandas as pd

def valid_emails(users: pd.DataFrame) -> pd.DataFrame:

    # Defining the regx pattern on mail column to meet the requirement
    pattern = r'^[a-zA-Z][a-zA-Z0-9_.-]*@leetcode\.com$'

    # Create a mask using str.match()
    is_valid = users['mail'].str.match(pattern)

    return users[is_valid]
