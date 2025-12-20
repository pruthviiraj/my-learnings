SELECT
  ct.cocoa_name,
  ls.location_name
FROM cocoa_logs cl
JOIN cocoa_types ct 
  ON cl.cocoa_id = ct.cocoa_id
JOIN break_schedule bs 
  ON cl.break_id = bs.break_id
JOIN locations ls 
  ON bs.location_id = ls.location_id;
