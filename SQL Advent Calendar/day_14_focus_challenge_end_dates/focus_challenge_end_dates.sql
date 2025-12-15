SELECT
  *,
  DATE(start_date, '+14 days') AS focus_end_date
FROM focus_challenges;
