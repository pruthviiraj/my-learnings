SELECT mgr.name
FROM employee emp
JOIN employee mgr
    ON mgr.id = emp.managerId
GROUP BY mgr.id, mgr.name
HAVING COUNT(emp.id) >= 5;
