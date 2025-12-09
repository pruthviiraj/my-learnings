SELECT
  t.color_name,
  l.color_name,
  CONCAT(t.color_name, '-', l.color_name) AS combination
FROM tinsel_colors t
CROSS JOIN light_colors l;
