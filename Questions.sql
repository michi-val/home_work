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
ON wins_sub.driverId = d.driverId 

-- V jakém státě se odjelo nejvíce závodů?

SELECT *
FROM races 
LEFT JOIN circu

