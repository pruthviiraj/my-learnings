SELECT DISTINCT
  subject,
  FIRST_VALUE(score) OVER (
    PARTITION BY subject
    ORDER BY quiz_date
  ) AS first_score,
  LAST_VALUE(score) OVER (
    PARTITION BY subject
    ORDER BY quiz_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  ) AS last_score
FROM daily_quiz_scores;
