SELECT
  SUM(paper_used_meters) AS total_wrapped_paper
FROM
  holiday_orders
WHERE
  gift_wrap = true AND
  delivery_status = 'Delivered'
