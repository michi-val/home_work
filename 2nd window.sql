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
















	
	
	
	
	