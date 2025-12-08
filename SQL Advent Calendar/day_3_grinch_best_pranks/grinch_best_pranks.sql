SELECT DISTINCT ON (target_name) *
FROM grinch_prank_ideas
ORDER BY target_name, evilness_score DESC, created_at DESC;
