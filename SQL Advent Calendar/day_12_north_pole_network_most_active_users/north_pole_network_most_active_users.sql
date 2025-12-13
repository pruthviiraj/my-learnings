WITH daily_message_count AS (
  SELECT
    nm.sent_at::date AS sent_date,
    nu.user_id,
    nu.user_name,
    COUNT(*) AS num_messages
  FROM npn_users nu
  JOIN npn_messages nm
    ON nu.user_id = nm.sender_id
  GROUP BY
    nm.sent_at::date,
    nu.user_id,
    nu.user_name
),
ranked AS (
  SELECT
    sent_date,
    user_id,
    user_name,
    num_messages,
    RANK() OVER (PARTITION BY sent_date ORDER BY num_messages DESC) AS chat_rank
  FROM daily_message_count
)
SELECT
  sent_date,
  user_id,
  user_name,
  num_messages
FROM ranked
WHERE chat_rank = 1
ORDER BY sent_date, user_id;
