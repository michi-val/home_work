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
	,sec_to_time((SUM(p_s.milliseconds) OVER (PARTITION BY driverId)) / 1000) AS time_in_pit_stop_sec
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



SELECT 
*
FROM results AS r2 
LEFT JOIN races AS r 
ON r2.raceId = r.raceId 


SELECT 
	DISTINCT `year` 
FROM races AS r 


SELECT 
	count(DISTINCT(raceId))
FROM results AS r 


SELECT 
DISTINCT (driverRef)
FROM drivers AS d 

SELECT 
*
FROM drivers AS d 
WHERE (YEAR(dob) + 17) > 2017



-- 

SELECT 
	resultId
	, positionOrder 
    , LAG(positionOrder) OVER (PARTITION BY raceId ORDER BY resultId) AS prev_value
FROM results AS r 
WHERE positionOrder - LAG(positionOrder) OVER (PARTITION BY raceId ORDER BY resultId) != 1;




SELECT *
FROM (
	SELECT 
	resultId
	, driverId
	, positionOrder 
    , LAG(positionOrder) OVER (PARTITION BY raceId ORDER BY resultId) AS prev_value
	FROM results AS r ) AS sq_po
WHERE positionOrder - prev_value != 1;


CREATE TABLE 770_duplicates AS
SELECT *
FROM results AS r 
WHERE raceId = 770


SELECT *
FROM `770_duplicates` AS d 


SELECT 
	driverId 
	, COUNT(*) AS count
FROM `770_duplicates` AS d 
GROUP BY driverId 
HAVING COUNT(*) > 1;


SELECT 
	driverId 
	, COUNT(*) AS count
FROM `770_duplicates` AS d 
GROUP BY driverId 
HAVING COUNT(*) > 1;



WITH Duplicates AS (
	SELECT 
		driverId 
		, COUNT(*) AS count
	FROM `770_duplicates`
	GROUP BY driverId 
	HAVING COUNT(*) > 1
)
SELECT *
FROM `770_duplicates`
WHERE driverId IN (SELECT driverId FROM Duplicates);


WITH Duplicates AS (
	SELECT 
		raceId 
		,driverId 
		, COUNT(*) AS d_count
	FROM results
	GROUP BY raceId, driverId 
	HAVING COUNT(*) > 1
)
SELECT 
	*
FROM results AS res
LEFT JOIN races AS rac
ON res.raceId = rac.raceId 
WHERE (res.raceId, res.driverId) IN (SELECT raceId, driverId FROM Duplicates)
ORDER BY res.raceId, res.driverId 


SELECT *
FROM results AS r 
WHERE raceId = 540


SELECT 
		raceId 
		,driverId 
		, COUNT(*) AS d_count
	FROM results
	GROUP BY raceId, driverId 
	HAVING COUNT(*) > 1
	

SELECT *
FROM results AS r 
WHERE raceId = 800

-- -------------------------------

WITH DuplicateResults AS (
    SELECT 
        res.resultId, 
        res.raceId, 
        res.driverId, 
        res.positionOrder
    FROM results AS res
    LEFT JOIN races AS rac ON res.raceId = rac.raceId
    WHERE (res.raceId, res.driverId) IN (
        SELECT 
            raceId, 
            driverId
        FROM results
        GROUP BY raceId, driverId
        HAVING COUNT(*) > 1
    )
),
PositionOrderGaps AS (
    SELECT 
        r.resultId, 
        r.raceId, 
        r.driverId, 
        r.positionOrder,
        LAG(r.positionOrder) OVER (PARTITION BY r.raceId ORDER BY r.resultId) AS prev_value
    FROM results AS r
)
SELECT 
    dr.resultId, 
    dr.raceId, 
    dr.driverId, 
    dr.positionOrder
FROM DuplicateResults AS dr
INNER JOIN PositionOrderGaps AS pog
    ON dr.resultId = pog.resultId
WHERE pog.positionOrder - pog.prev_value != 1
ORDER BY dr.raceId, dr.driverId;







SELECT *
FROM results AS r 
WHERE raceId = 18

SELECT
	DISTINCT(r.`year`)
FROM qualifying AS q 
LEFT JOIN races AS r 
ON q.raceId = r.raceId 


SELECT *
FROM qualifying AS q 
LEFT JOIN results AS r 
ON q.raceId = r.raceId 
	AND q.driverId = r.driverId
WHERE  q.`position` != r.grid 




SELECT *
FROM qualifying AS q 

SELECT *
FROM( 
	SELECT *
	FROM results AS res 
	WHERE res.raceId IN (982, 934, 941, 916, 18)) AS a
LEFT JOIN 
	(SELECT *
		FROM (
			SELECT 
			resultId
			, raceId
			, driverId
			, positionOrder 
		    , LAG(positionOrder) OVER (PARTITION BY raceId ORDER BY resultId) AS prev_value
			FROM results AS r ) AS sq_po
		LEFT JOIN races AS rac 
		ON sq_po.raceId = rac.raceId 
		WHERE positionOrder - prev_value != 1) AS b
ON a.resultId = b.resultId


SELECT *
	FROM results AS res 
	WHERE res.raceId IN (982, 934, 941, 916, 18)


	
	
	
SELECT 
    *	
FROM results AS res
LEFT JOIN races AS rac
ON res.raceId = rac.raceId
WHERE (res.raceId, res.driverId) IN
			(SELECT 
				raceId
				, driverId
		    FROM results
		    GROUP BY raceId, driverId
		    HAVING COUNT(*) > 1)
ORDER BY res.raceId, res.driverId;	
	

SELECT 
    *	
FROM qualifying AS q 
LEFT JOIN races AS rac
ON q.raceId = rac.raceId
WHERE (q.raceId, q.driverId) IN
			(SELECT 
				raceId
				, driverId
		    FROM qualifying
		    GROUP BY raceId, driverId
		    HAVING COUNT(*) > 1)
ORDER BY q.raceId, q.driverId;	



SELECT 
				raceId
				, driverId
				, COUNT(*) AS d_count
		    FROM qualifying
		    GROUP BY raceId, driverId
		    HAVING COUNT(*) > 0




SELECT 
    *	
FROM qualifying AS q 
LEFT JOIN races AS rac
ON q.raceId = rac.raceId
WHERE (q.raceId, q.driverId) IN
			(SELECT 
				raceId
				, driverId
		    FROM qualifying
		    GROUP BY raceId, driverId
		    HAVING COUNT(*) > 1)
ORDER BY q.raceId, q.driverId;	
	
	



SELECT 
				raceId
				, driverId
				, COUNT(*) AS d_count
		    FROM pitstops AS p 
		    GROUP BY raceId, driverId
		    HAVING COUNT(*) > 0









	