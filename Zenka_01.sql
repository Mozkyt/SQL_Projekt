SELECT
    a.year,
    a.industry_name,
    a.average_wage AS current_wage,
    b.average_wage AS previous_wage,
    CASE
        WHEN a.average_wage > b.average_wage THEN 'Increase'
        WHEN a.average_wage < b.average_wage THEN 'Decrease'
        ELSE 'Unknown'
    END AS wage_change
FROM
    t_josef_zenka_project_sql_primary_final a
LEFT JOIN
    t_josef_zenka_project_sql_primary_final b 
    ON a.industry_name = b.industry_name
    AND a.year = b.year + 1
WHERE
    a.average_wage < b.average_wage 
GROUP BY `year`, industry_name
ORDER BY
    a.industry_name, a.year;
    
-- příklad seřazení podle roku   
SELECT
    a.year,
    a.industry_name,
    a.average_wage AS current_wage,
    b.average_wage AS previous_wage,
    CASE
        WHEN a.average_wage > b.average_wage THEN 'Increase'
        WHEN a.average_wage < b.average_wage THEN 'Decrease'
        ELSE 'Unknown'
    END AS wage_change
FROM
    t_josef_zenka_project_sql_primary_final a
LEFT JOIN
    t_josef_zenka_project_sql_primary_final b 
    ON a.industry_name = b.industry_name
    AND a.year = b.year + 1
WHERE
    a.average_wage < b.average_wage 
GROUP BY `year`, industry_name
ORDER BY
  	a.year;
   
-- filtrace jen těch, které rostou pořád
SELECT
    a.industry_name,
    min(CASE
        WHEN a.average_wage > b.average_wage THEN 'Increase'
        WHEN a.average_wage < b.average_wage THEN 'Decrease'
        ELSE 'Unknown'
    END) AS wage_change_status
FROM
    t_josef_zenka_project_sql_primary_final a
LEFT JOIN
    t_josef_zenka_project_sql_primary_final b 
    ON a.industry_name = b.industry_name
    AND a.year = b.year + 1
GROUP BY
    a.industry_name
HAVING
    min(CASE
        WHEN a.average_wage > b.average_wage THEN 'Increase'
        WHEN a.average_wage < b.average_wage THEN 'Decrease'
        ELSE 'Unknown'
    END) = 'Increase';
    