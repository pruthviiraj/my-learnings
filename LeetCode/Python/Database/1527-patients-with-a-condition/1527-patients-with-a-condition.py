import pandas as pd

def find_patients(patients: pd.DataFrame) -> pd.DataFrame:

    # Use str.contains() with the word boundary regex
    has_diabetes = patients['conditions'].str.contains(r'\bDIAB1')

    return patients[has_diabetes]
