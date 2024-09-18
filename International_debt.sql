
-- Let's create the table in which we will import the csv

CREATE TABLE international_debt (
    country_name VARCHAR(100),
    country_code CHAR(3),
    indicator_name VARCHAR(255),
    indicator_code VARCHAR(255),
    debt NUMERIC(15, 2)
);

-- Now we import the data

COPY international_debt (country_name, country_code, indicator_name, indicator_code, debt)
FROM '/Users/edoardochiari/Downloads/international_debt.csv'
DELIMITER ','
CSV HEADER;

-- See if the import was successfull

SELECT *
FROM international_debt;

-- Check for null values in any columns
SELECT 
    COUNT(*) AS total_rows,
    COUNT(country_name) AS country_name_not_null,
    COUNT(country_code) AS country_code_not_null,
    COUNT(indicator_name) AS indicator_name_not_null,
    COUNT(indicator_code) AS indicator_code_not_null,
    COUNT(debt) AS debt_not_null
FROM international_debt;

-- What is the number of distinct countries in the dataset?

SELECT COUNT(DISTINCT(country_name)) AS number_of_countries
FROM international_debt;

-- Distinct debt indicators

SELECT DISTINCT(indicator_code)
FROM international_debt;

-- Total debt owed by the countries

SELECT ROUND(SUM(debt)/1000000,2) AS total_international_debt_millions
FROM international_debt;

-- Top 5 countries with the highest debt

SELECT
	country_name,
	SUM(debt) AS total_debt
FROM international_debt
GROUP BY country_name
ORDER BY total_debt DESC
LIMIT 5;

-- Debt distribution analysis

SELECT 
    country_name,
    SUM(debt) AS total_debt,
    PERCENT_RANK() OVER (ORDER BY SUM(debt) ASC) AS debt_percentile  -- ASC for correct percentile ranking
FROM international_debt
GROUP BY country_name
ORDER BY debt_percentile ASC;

-- Average amount of debt across indicators

SELECT
	indicator_code,
	indicator_name,
	ROUND(AVG(debt),2) AS average_debt
FROM international_debt
GROUP BY indicator_code, indicator_name
ORDER BY average_debt DESC;

-- Identify countries with debt significantly higher or lower than the average

WITH country_debt AS (
    SELECT
        country_name,
        SUM(debt) AS total_debt
    FROM international_debt
    GROUP BY country_name
),
avg_debt AS (
    SELECT ROUND(AVG(total_debt), 2) AS avg_country_debt
    FROM country_debt
)
SELECT
    cd.country_name,
    cd.total_debt,
    ad.avg_country_debt,
    ROUND((cd.total_debt - ad.avg_country_debt), 2) AS deviation_from_avg
FROM country_debt cd
JOIN avg_debt ad ON TRUE
WHERE cd.total_debt > ad.avg_country_debt * 2  -- Adjust for outliers
ORDER BY deviation_from_avg DESC;

-- Debt proportion by indicator code

SELECT
	indicator_code,
	indicator_name,
	SUM(debt) AS total_debt,
	ROUND(SUM(debt)*100 / (SELECT SUM(debt) FROM international_debt),2) AS percentage_of_total
FROM international_debt
GROUP BY indicator_code, indicator_name
ORDER BY percentage_of_total DESC;

-- The most common debt indicators 

SELECT 
	DISTINCT(indicator_code),
	COUNT(indicator_code) AS frequency
FROM international_debt
GROUP BY indicator_code
ORDER BY frequency DESC;

-- Top 10 countries for each indicator of debt
SELECT 
    country_name,
    debt AS total_debt
FROM international_debt
WHERE indicator_code = 'DT.AMT.DLXF.CD'
ORDER BY total_debt DESC
LIMIT 10;

WITH ranked_debt AS (
    SELECT 
        country_name,
        indicator_code,
        debt AS total_debt,
        ROW_NUMBER() OVER (PARTITION BY indicator_code ORDER BY debt DESC) AS rank
    FROM international_debt
)
SELECT 
    country_name,
    indicator_code,
    total_debt
FROM ranked_debt
WHERE rank <= 10
ORDER BY indicator_code, rank;
