SELECT
  task_id,
  task_name,
  noise_level,
  CASE
    WHEN noise_level IS NULL THEN 'Unknown'
    WHEN noise_level <50 THEN 'Calm' ELSE 'Chaotic'
  END AS noise_category
FROM evening_tasks;
