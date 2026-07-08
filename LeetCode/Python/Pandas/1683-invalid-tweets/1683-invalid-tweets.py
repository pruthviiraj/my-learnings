import pandas as pd

def invalid_tweets(tweets: pd.DataFrame) -> pd.DataFrame:
    # Create a mask to check the string length of each row
    invalid_tweets = tweets['content'].str.len() > 15

    # Return only tweet_id column as dataframe
    return tweets[invalid_tweets][['tweet_id']]
