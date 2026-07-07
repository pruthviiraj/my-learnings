import pandas as pd

def article_views(views: pd.DataFrame) -> pd.DataFrame:
    
    df_compare = (views['author_id']) == (views['viewer_id'])

    return views[df_compare][['author_id']].rename(columns={'author_id':'id'}).drop_duplicates().sort_values(by='id')
