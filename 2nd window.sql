SELECT 
	COUNT(c.country) AS number_of_races
	, c.country 
FROM races AS r 
LEFT JOIN circuits AS c 
ON r.circuitId = c.circuitId 
GROUP BY country 
ORDER BY number_of_races DESC 


WITH cte_number_of_circuits AS (
	SELECT 
		c.name 
		,c.location 
		,c.country 
	FROM races AS r 
	LEFT JOIN circuits AS c 
	ON r.circuitId = c.circuitId 
	GROUP BY c.country, c.location, c.name)
SELECT 
	name 
	,location 
	,country 
	,COUNT(country) AS number_of_circuits
FROM cte_number_of_circuits


,COUNT(country) AS number_of_circuits
ORDER BY number_of_circuits

SELECT 
	c.name 
	,c.location 
	,c.country 
	,COUNT(country) OVER (PARTITION BY country) AS number_of_circuits
FROM races AS r 
LEFT JOIN circuits AS c 
ON r.circuitId = c.circuitId 
GROUP BY c.country , c.location, c.name
ORDER BY number_of_circuits DESC, country, location, name


-- 

SELECT *
FROM laptimes AS lap_t
LEFT JOIN drivers AS dr
ON lap_t.driverId = dr.driverId 
LEFT JOIN races AS rac
ON lap_t.raceId = rac.raceId



SELECT 
	sum(duration)
FROM pitstops AS p
WHERE driverId = 13

-- 

ALTER TABLE status_2 
ADD clasification VARCHAR(50)

SELECT DISTINCT name 
FROM circuits AS c 


SELECT *
FROM pitstops_4 AS p2
WHERE ((HOUR(duration) * 3600000) + (MINUTE(duration)* 60000) + (SECOND(duration) * 1000) + (MICROSECOND(duration) / 1000)) != milliseconds 

SELECT 
	du
FROM pitstops_3 AS p 


SELECT 
	duration * 1000
FROM pitstops_3 AS p 
WHERE raceId = 967




SELECT 
	DISTINCT p_s.driverId 
	, dr.forename 
	, dr.surname 
	,(SUM(p_s.milliseconds) OVER (PARTITION BY driverId)) / 1000 AS time_in_pit_stop_sec
FROM pitstops AS p_s
LEFT JOIN drivers AS dr
ON p_s.driverId = dr.driverId 
ORDER BY time_in_pit_stop_sec DESC, driverId, forename, surname;


SELECT 
	duration * 1000
FROM pitstops_4 AS p 

	
SELECT DISTINCT positionText 
FROM results AS r 
	



UPDATE results_2 
SET `time` 

SELECT 
*
FROM results_2 AS r 
WHERE `position` != 1 AND `time` NOT LIKE '+%'


SELECT raceId, COUNT(*)
FROM results AS r 
GROUP BY raceId 
HAVING COUNT(*) > 1;

-- -------------------




SELECT 
	DISTINCT country
	, number_of_circuits
FROM 
	(SELECT 
		c.name  
		,location 
		,country 
		,COUNT(country) OVER (PARTITION BY country) AS number_of_circuits
	FROM races AS r 
	LEFT JOIN circuits AS c 
	ON r.circuitId = c.circuitId 
	GROUP BY c.country , c.location, c.name
	ORDER BY number_of_circuits DESC, country, location, name) AS n_o_c



SELECT 
	c.country 
	,COUNT(c.name) OVER (PARTITION BY c.country) AS number_of_circuits
FROM races AS r 
LEFT JOIN circuits AS c 
ON r.circuitId = c.circuitId 
ORDER BY number_of_circuits DESC;









	