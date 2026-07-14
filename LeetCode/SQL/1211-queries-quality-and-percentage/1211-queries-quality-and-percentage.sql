SELECT
    query_name,
    ROUND(AVG(rating/position),2) AS quality,
    ROUND((COUNT(rating)<=3)*100.0/COUNT(rating),2) AS poor_query_percentage
FROM queries
GROUP BY query_name;
