import pandas as pd

def big_countries(world: pd.DataFrame) -> pd.DataFrame:
    # Filtering the data
    is_big = (world['area']>=3000000) | (world['population']>=25000000)

    # Selecting/Returning ['name','population','area']
    return world[is_big][['name', 'population', 'area']]
