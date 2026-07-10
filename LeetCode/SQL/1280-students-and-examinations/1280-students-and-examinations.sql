SELECT
    s.student_id,
    s.student_name,
    sub.subject_name,
    COUNT(exm.student_id) AS attended_exams
FROM students s
CROSS JOIN subjects sub
LEFT JOIN examinations exm
    ON s.student_id = exm.student_id
    AND sub.subject_name = exm.subject_name
GROUP BY s.student_id, sub.subject_name
ORDER BY s.student_id, sub.subject_name;
