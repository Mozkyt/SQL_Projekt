WITH yearly_comparisons AS (
    SELECT 
        a.year,
        a.product_name,
        a.industry_name,
        (a.average_price - b.average_price) / b.average_price * 100 AS avg_price_increase,
        (a.average_wage - b.average_wage) / b.average_wage * 100 AS avg_wage_increase
    FROM 
        t_josef_zenka_project_sql_primary_final a 
    JOIN 
        t_josef_zenka_project_sql_primary_final b 
    ON 
        a.product_name = b.product_name 
    AND a.industry_name = b.industry_name
    AND a.year = b.year + 1
)
SELECT
    year,
    industry_name,
    round(AVG(avg_price_increase),2) AS overall_avg_price_increase,
    round(AVG(avg_wage_increase),2) AS overall_avg_wage_increase,
    CASE
        WHEN round(AVG(avg_price_increase), 2) - round(AVG(avg_wage_increase), 2) > 10 THEN 'Yes'
        ELSE 'No'
    END AS significant_difference
FROM 
    yearly_comparisons
GROUP BY 
    YEAR, industry_name
HAVING round(AVG(avg_price_increase), 2) - round(AVG(avg_wage_increase), 2) > 10
ORDER BY
    YEAR;