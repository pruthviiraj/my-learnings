SELECT
  e.elf_name,
  CASE 
    WHEN v.return_date IS NULL THEN 'Still resting'
    ELSE v.return_date::text
  END AS return_status
FROM elves e
LEFT JOIN vacations v
ON e.elf_id = v.elf_id
