-- 1. varianta - impakt wages a prices v jednom.

SELECT
    a.year AS current_year,
    a.industry_Name AS profession,
    c.GDP_growth AS current_GDP_growth,
    round((a.average_wage - b.average_wage) / b.average_wage * 100 , 2) AS wage_change_percent,
    round((a.average_price - b.average_price) / b.average_price * 100 , 2) AS price_change_percent,
    CASE
        WHEN (a.average_wage - b.average_wage) / b.average_wage * 100 > c.GDP_growth THEN 'Wage Increase greater than GDP Growth'
        ELSE 'Change not significant'
    END AS wage_economic_impact,
    CASE
        WHEN (a.average_price - b.average_price) / b.average_price * 100 > c.GDP_growth THEN 'Price Increase greater than GDP Growth'
        ELSE 'Change not significant'
    END AS price_economic_impact
FROM
    t_josef_zenka_project_sql_primary_final a
JOIN
    t_josef_zenka_project_sql_primary_final b 
    ON a.industry_name = b.industry_name
    AND a.product_name = b.product_name
    AND a.year = b.year + 1
JOIN
    t_josef_zenka_project_sql_secondary_final c 
    ON a.year = c.YEAR
GROUP BY a.YEAR, a.industry_name, a.average_wage
ORDER BY
    a.year;
    
   
-- 2. varianta - wage economic impact odfiltrovaný (wage se musí jít obor po oboru, z daných údajů nelze spočítat relevantní průměrnou wage za všechna odvětví (aspoň pokud jsem pochopil správně data))
   
   SELECT
    a.year AS year,
    c.GDP_growth AS current_GDP_growth,
    round((a.average_price - b.average_price) / b.average_price * 100 , 2) AS price_change_percent,
    CASE
        WHEN (a.average_price - b.average_price) / b.average_price * 100 > c.GDP_growth THEN 'Price Increase greater than GDP Growth'
        ELSE 'Change not significant'
    END AS price_economic_impact
FROM
    t_josef_zenka_project_sql_primary_final a
JOIN
    t_josef_zenka_project_sql_primary_final b 
    ON a.industry_name = b.industry_name
    AND a.product_name = b.product_name
    AND a.year = b.year + 1
JOIN
    t_josef_zenka_project_sql_secondary_final c 
    ON a.year = c.YEAR
GROUP BY a.YEAR

-- 3. varianta ob rok, pouze mzdy
SELECT
    a.year AS year,
    a.industry_Name AS profession,
    c.GDP_growth AS current_GDP_growth,
    round(a.average_wage - b.average_wage) / b.average_wage * 100 , 2) AS wage_change_percent,
    CASE
        WHEN (a.average_wage - b.average_wage) / b.average_wage * 100 > c.GDP_growth THEN 'Wage Increase greater than GDP Growth'
        ELSE 'Change not significant'
    END AS wage_economic_impact
FROM
    t_josef_zenka_project_sql_primary_final a
JOIN
    t_josef_zenka_project_sql_primary_final b 
    ON a.industry_name = b.industry_name
    AND a.product_name = b.product_name
    AND a.year = b.year + 1
JOIN
    t_josef_zenka_project_sql_secondary_final c 
    ON a.year = c.YEAR
GROUP BY a.YEAR, a.industry_name, a.average_wage
ORDER BY
    a.year;
   
-- 4. varianta impakt prices rok+1 - tady jsem s tím nejvíc bojoval, snad jsem to gdp_growth napojil správně

   SELECT
    b.year AS base_year,  
    a.year AS comparison_year,  
    c.year AS gdp_year,  
 	round((a.average_wage - b.average_wage) / b.average_wage * 100 , 2) AS wage_change_percent,
    CASE
        WHEN (a.average_price - b.average_price) / b.average_price * 100 > c.GDP_growth THEN 'Price Increase greater than GDP Growth'
        ELSE 'Change not significant'
    END AS price_economic_impact
FROM
    t_josef_zenka_project_sql_primary_final a
JOIN
    t_josef_zenka_project_sql_primary_final b 
    ON a.industry_name = b.industry_name
    AND a.product_name = b.product_name
    AND a.year = b.year + 1
JOIN
    t_josef_zenka_project_sql_secondary_final c 
    ON a.year = c.YEAR + 1
GROUP BY a.YEAR;


-- 5. varianta impakt wages + 1 (pro limitaci konkrétního odvětví by šlo doplnit where klauzulí s názvem odvětví)
SELECT
    b.year AS base_year,  
    a.year AS comparison_year,  
    c.year AS gdp_year,
    a.industry_Name AS profession,
    c.GDP_growth AS current_GDP_growth,
	round((a.average_wage - b.average_wage) / b.average_wage * 100 , 2) AS wage_change_percent,
    CASE
        WHEN (a.average_wage - b.average_wage) / b.average_wage * 100 > c.GDP_growth THEN 'Wage Increase greater than GDP Growth'
        ELSE 'Change not significant'
    END AS wage_economic_impact
FROM
    t_josef_zenka_project_sql_primary_final a
JOIN
    t_josef_zenka_project_sql_primary_final b 
    ON a.industry_name = b.industry_name
    AND a.product_name = b.product_name
    AND a.year = b.year + 1
JOIN
    t_josef_zenka_project_sql_secondary_final c 
    ON a.year = c.YEAR + 1
GROUP BY a.YEAR, a.industry_name, a.average_wage;



-- 6. varianta - vše dohromady rok +1;

SELECT
    b.year AS base_year,  
    a.year AS comparison_year,  
    c.year AS gdp_year,
    a.industry_Name AS profession,
    c.GDP_growth AS current_GDP_growth,
    round((a.average_wage - b.average_wage) / b.average_wage * 100 , 2) AS wage_change_percent,
    round((a.average_price - b.average_price) / b.average_price * 100, 2) AS price_change_percent,
    CASE
        WHEN (a.average_wage - b.average_wage) / b.average_wage * 100 > c.GDP_growth THEN 'Wage Increase greater than GDP Growth'
        ELSE 'Change not significant'
    END AS wage_economic_impact,
    CASE
        WHEN (a.average_price - b.average_price) / b.average_price * 100 > c.GDP_growth THEN 'Price Increase greater than GDP Growth'
        ELSE 'Change not significant'
    END AS price_economic_impact
FROM
    t_josef_zenka_project_sql_primary_final a
JOIN
    t_josef_zenka_project_sql_primary_final b 
    ON a.industry_name = b.industry_name
    AND a.product_name = b.product_name
    AND a.year = b.year + 1
JOIN
    t_josef_zenka_project_sql_secondary_final c 
    ON a.year = c.YEAR + 1
GROUP BY a.YEAR, a.industry_name, a.average_wage
ORDER BY
    a.year;