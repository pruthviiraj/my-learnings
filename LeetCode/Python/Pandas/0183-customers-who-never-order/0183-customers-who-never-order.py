import pandas as pd

def find_customers(customers: pd.DataFrame, orders: pd.DataFrame) -> pd.DataFrame:

    # Join tables
    df_merge = customers.merge(orders, how='left', left_on='id', right_on='customerId')

    # Filter for rows where the order data is missing (NaN)
    df_missing_orders = df_merge[df_merge['customerId'].isna()]

    df_result = df_missing_orders[['name']].rename(columns={'name':'Customers'})

    return df_result
