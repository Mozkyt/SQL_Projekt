SELECT
    year,
    product_name,
    industry_name,
    average_price,
    average_wage,
    round(average_wage / average_price, 2) AS units_purchasable,
    unit
FROM
    t_josef_zenka_project_sql_primary_final
WHERE
    product_name IN ('Mléko polotučné pasterované', 'Chléb konzumní kmínový')
    AND (year = (SELECT MIN(year) FROM t_josef_zenka_project_sql_primary_final)
         OR year = (SELECT MAX(year) FROM t_josef_zenka_project_sql_primary_final))
GROUP BY  product_name, YEAR, industry_name;
        