import pandas as pd

def find_products(products: pd.DataFrame) -> pd.DataFrame:

    # Check the condition 'Y' for low_fats and recyclable
    is_valid = (products['low_fats']=='Y') & (products['recyclable']=='Y')

    result_df = products[is_valid][['product_id']]

    return result_df
