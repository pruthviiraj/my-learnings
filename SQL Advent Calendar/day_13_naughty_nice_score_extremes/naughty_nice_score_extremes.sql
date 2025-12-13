SELECT
  MIN(behavior_score) AS nice,
  MAX(behavior_score) AS naughty
FROM
  behavior_scores;
