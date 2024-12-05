-- Připravte tabulku po jménech jezdců sestupně podle počtu vyhraných závodů, kteří vyhráli alespoň 3x. 

SELECT 
	wins_sub.wins
	, d.forename 
	, d.surname
	, wins_sub.driverId 
FROM (	SELECT 
			driverId 
			, COUNT(`position`) AS wins
		FROM results
		WHERE `position` =  1
		GROUP BY driverId
		HAVING COUNT(`position`) >= 3
		ORDER BY wins DESC) AS wins_sub
LEFT JOIN drivers AS d 
ON wins_sub.driverId = d.driverId;

-- V jakém státě se odjelo nejvíce závodů?

SELECT 
	COUNT(c.country) AS number_of_races
	, c.country 
FROM races AS r 
LEFT JOIN circuits AS c 
ON r.circuitId = c.circuitId 
GROUP BY country 
ORDER BY number_of_races DESC;


-- V jakém státě se závodilo na nejvíce okruzích?

-- název, lokace, stát, počet
SELECT 
	c.name 
	,c.location 
	,c.country 
	,COUNT(country) OVER (PARTITION BY country) AS number_of_circuits
FROM races AS r 
LEFT JOIN circuits AS c 
ON r.circuitId = c.circuitId 
GROUP BY c.country , c.location, c.name
ORDER BY number_of_circuits DESC, country, location, name;



	-- vere pouze se státy a počtem
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
		ORDER BY number_of_circuits DESC, country, location, name) AS n_o_c;


-- Jaké bylo nejrychlejší zajeté kolo – kde, kdy, kým a s jakým časem? 

SELECT 
	 rac.`date` 
	, rac.name 
	, dr.forename 
	, dr.surname 
	, lap_t.`time` 
FROM laptimes AS lap_t
LEFT JOIN drivers AS dr
ON lap_t.driverId = dr.driverId 
LEFT JOIN races AS rac
ON lap_t.raceId = rac.raceId
ORDER BY lap_t.`time`
LIMIT 10;

-- Jaký jezdec strávil nejvíce času v pit stopech? 

SELECT 
	DISTINCT p_s.driverId 
	, dr.forename 
	, dr.surname 
	,sec_to_time((SUM(p_s.milliseconds) OVER (PARTITION BY driverId)) / 1000) AS time_in_pit_stop_sec
FROM pitstops AS p_s
LEFT JOIN drivers AS dr
ON p_s.driverId = dr.driverId 
ORDER BY time_in_pit_stop_sec DESC, driverId, forename, surname;

-- V kolika pripadech vyhral jezdec kvalifikaci i závod?

SELECT 
	COUNT(resultId) AS 'wins_Q_and_R'
FROM results AS r 
WHERE grid = 1 AND `position` = 1;







-- 






SELECT *
FROM qualifying AS q 
WHERE raceId = 18 AND grid = 10















