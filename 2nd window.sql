SELECT 
	COUNT(c.country) AS number_of_races
	, c.country 
FROM races AS r 
LEFT JOIN circuits AS c 
ON r.circuitId = c.circuitId 
GROUP BY country 
ORDER BY number_of_races DESC 