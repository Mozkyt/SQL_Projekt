SELECT
    a.product_name,
    round(AVG((b.average_price - a.average_price) / a.average_price * 100), 2) AS avg_percent_increase
FROM
    t_josef_zenka_project_sql_primary_final a
JOIN
    t_josef_zenka_project_sql_primary_final b 
    ON a.product_name = b.product_name
    AND b.year = a.year + 1
GROUP BY a.product_name
ORDER BY
    avg_percent_increase ASC;