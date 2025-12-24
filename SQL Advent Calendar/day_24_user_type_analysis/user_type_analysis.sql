SELECT
  user_type,
  ROUND(AVG(completed_goals),2) AS avg_completed_goals
FROM(
  SELECT
    user_id,
    user_type,
    COUNT(*) AS completed_goals
  FROM user_goals
  WHERE goal_status = 'Completed'
  GROUP BY user_id, user_type
) t 
GROUP BY user_type;
