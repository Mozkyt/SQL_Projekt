CREATE OR REPLACE TABLE t_josef_zenka_project_SQL_secondary_final AS
WITH GDP_growth AS (
    SELECT 
        e.country, 
        e.year,
        e.GDP, 
        e2.GDP AS GDP_previous_year,
        ROUND( ( e.GDP - e2.GDP ) / e2.GDP * 100, 2 ) AS GDP_growth
    FROM economies e 
    LEFT JOIN economies e2 
    ON e.country = e2.country 
    AND e.year = e2.year + 1
    WHERE e.year <= 2020
)
SELECT 
    c.country,
    e.year,
    e.GDP,
    g.GDP_previous_year,
    g.GDP_growth,
    CASE 
        WHEN g.GDP_growth > 0 AND g.GDP_growth < 5 THEN 'up'
        WHEN g.GDP_growth >= 5 THEN 'skyrocketing'
        ELSE 'down'
    END AS GDP_growth_direction
FROM countries c
LEFT JOIN economies e ON c.country = CASE 
                                         WHEN e.country = 'Czechia' THEN 'Czech Republic'
                                         ELSE e.country
                                      END
LEFT JOIN GDP_growth g 
	ON e.country = g.country 
	AND e.year = g.year
WHERE c.country = 'Czech Republic'
ORDER BY e.year DESC;