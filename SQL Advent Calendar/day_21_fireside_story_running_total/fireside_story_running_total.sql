SELECT
  log_date,
  SUM(stories_shared) OVER(
    ORDER BY log_date 
  ) AS running_total_stories
FROM story_log;
