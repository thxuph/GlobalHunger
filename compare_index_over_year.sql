SELECT * FROM global_hunger_index

--Compare the number of countries in each category of hunger index scores in two years 2000 and 2021

SELECT
  SUM(CASE WHEN year = 2000 AND global_hunger_index >= 50 THEN 1 ELSE 0 END) AS extremely_alarming_2000,
  SUM(CASE WHEN year = 2021 AND global_hunger_index >= 50 THEN 1 ELSE 0 END) AS extremely_alarming_2021,
  SUM(CASE WHEN year = 2000 AND global_hunger_index >= 35 AND global_hunger_index < 50 THEN 1 ELSE 0 END) AS alarming_2000,
  SUM(CASE WHEN year = 2021 AND global_hunger_index >= 35 AND global_hunger_index < 50 THEN 1 ELSE 0 END) AS alarming_2021,
  SUM(CASE WHEN year = 2000 AND global_hunger_index >= 20 AND global_hunger_index < 35 THEN 1 ELSE 0 END) AS serious_2000,
  SUM(CASE WHEN year = 2021 AND global_hunger_index >= 20 AND global_hunger_index < 35 THEN 1 ELSE 0 END) AS serious_2021,
  SUM(CASE WHEN year = 2000 AND global_hunger_index >= 10 AND global_hunger_index < 20 THEN 1 ELSE 0 END) AS moderate_2000,
  SUM(CASE WHEN year = 2021 AND global_hunger_index >= 10 AND global_hunger_index < 20 THEN 1 ELSE 0 END) AS moderate_2021,
  SUM(CASE WHEN year = 2000 AND global_hunger_index < 10 THEN 1 ELSE 0 END) AS low_2000,
  SUM(CASE WHEN year = 2021 AND global_hunger_index < 10 THEN 1 ELSE 0 END) AS low_2021
FROM global_hunger_index;

--Look at countries with hunger index scores categorized "Extremely alarming"(>=50) in 2000 and 2021.

SELECT entity, year, global_hunger_index FROM global_hunger_index
WHERE year = 2000 AND global_hunger_index >= 50

UNION ALL

SELECT entity, year, global_hunger_index FROM global_hunger_index
WHERE year = 2021 AND global_hunger_index >= 50
ORDER BY year, global_hunger_index DESC;

--Look at countries with hunger index scores categorized "Alarming"(>=35 & <50) in 2000 and 2021.

SELECT entity, year, global_hunger_index FROM global_hunger_index
WHERE year = 2000 AND global_hunger_index >= 35 AND global_hunger_index < 50

UNION ALL

SELECT entity, year, global_hunger_index FROM global_hunger_index
WHERE year = 2021 AND global_hunger_index >= 35 AND global_hunger_index < 50
ORDER BY year, global_hunger_index DESC;

--Look at top 10 countries with highest hunder index score in 2000

SELECT entity, global_hunger_index FROM global_hunger_index 
WHERE year = 2000
ORDER BY global_hunger_index DESC
LIMIT 10

--Look at top 10 countries with highest hunger index score in 2021

SELECT entity, global_hunger_index FROM global_hunger_index 
WHERE year = 2021
ORDER BY global_hunger_index DESC
LIMIT 10

--Look at improvements of lowering hunger index score 

WITH countries_2000 AS (
  SELECT entity, global_hunger_index FROM global_hunger_index 
  WHERE year = 2000
  ),

countries_2021 AS (
  SELECT entity, global_hunger_index FROM global_hunger_index 
  WHERE year = 2021
  )

SELECT c2000.entity,
       c2000.global_hunger_index AS index_2000,
       c2021.global_hunger_index AS index_2021,
       c2000.global_hunger_index - c2021.global_hunger_index AS improvement
FROM countries_2000 c2000
JOIN countries_2021 c2021 ON c2000.entity = c2021.entity
ORDER BY improvement DESC;











