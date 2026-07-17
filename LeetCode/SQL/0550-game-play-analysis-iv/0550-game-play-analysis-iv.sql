WITH first_login AS (
    SELECT 
        player_id, 
        MIN(event_date) AS first_date
    FROM activity
    GROUP BY player_id
)
SELECT 
    -- If a player logged in on Day 2, a.player_id will exist. If not, it will be NULL!
    ROUND(COUNT(a.player_id) / COUNT(fl.player_id), 2) AS fraction
FROM first_login fl
LEFT JOIN activity a
    ON fl.player_id = a.player_id 
    AND a.event_date = DATE_ADD(fl.first_date, INTERVAL 1 DAY);
