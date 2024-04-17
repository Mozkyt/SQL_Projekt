CREATE OR REPLACE TABLE t_josef_zenka_project_SQL_primary_final AS 
WITH wages AS (
    SELECT
        payroll_year AS year,
        cpib.name AS industry_name,
        round(AVG(cp.value), 2) AS average_wage
    FROM czechia_payroll cp
    JOIN czechia_payroll_industry_branch cpib 
    ON cp.industry_branch_code = cpib.code
    WHERE cp.value_type_code = 5958
    GROUP BY payroll_year, industry_name
),
prices AS (
   SELECT
        YEAR(cp.date_from) AS year,
        cpc.name AS product_name,
        round(AVG(cp.value), 2) AS average_price,
        COUNT(cp.value) AS price_count,
        cpc.price_value  AS value, 
        cpc.price_unit AS unit
    FROM czechia_price cp
    JOIN czechia_price_category cpc 
    ON cp.category_code = cpc.code
     WHERE cp.region_code IS NULL
    GROUP BY YEAR(cp.date_from), cpc.name
)
SELECT
    w.year,
    w.industry_name,
    w.average_wage,
    p.product_name,
    p.average_price,
    p.value,
    p.unit,
    p.price_count
FROM wages w
JOIN prices p
WHERE w.year = p.year;