SELECT *
FROM drivers AS d 

-- odhalení špatného driverID
SELECT *
FROM qualifying AS q 
WHERE raceId = 982 AND constructorId = 5 AND number = 26

SELECT *
FROM qualifying AS q 
WHERE raceId = 18 AND constructorId = 11 AND number = 17

-- kontrola souřadnic
SELECT *
FROM circuits AS c 
WHERE latitude NOT BETWEEN -90 AND 90 
	OR longtitude NOT BETWEEN -180 AND 180 ;
	
-- správný formát data narození jezdců

UPDATE drivers 
SET dob = REPLACE(dob , '%\x00%', '');

UPDATE drivers 
SET dob = STR_TO_DATE(REPLACE(dob, '\x00', ''), '%d/%m/%Y')
WHERE dob LIKE '%/%/%';

-- kontrola času laptimes

SELECT *
FROM laptimes AS l 
WHERE `time` REGEXP '^[0-5][0-9]:[0-5][0-9]\\.[0-9]{1,3}$';

SELECT *
FROM laptimes AS l 
WHERE `time` not REGEXP '^[0-9]{1,3}:[0-5][0-9]\\.[0-9]{1,3}$';


-- formátování 'time' z laptimes na time format

UPDATE laptimes
SET `time` = 
	STR_TO_DATE(CONCAT('00:', `time`), '%H:%i:%s.%f')
WHERE time NOT LIKE '%:__:__.___' ;

UPDATE laptimes	
SET `time` =  STR_TO_DATE(`time`, '%H:%i:%s.%f');

-- přepočet času na milisekundy
SELECT 
	`time` 
	,((HOUR(`time`) * 3600000) + (MINUTE(`time`)* 60000) + (SECOND(`time`) * 1000) + (MICROSECOND(`time`) / 1000))  AS mss
	,milliseconds 
FROM laptimes AS l 

-- ověření správnosti dat
SELECT *
	,((HOUR(`time`) * 3600000) + (MINUTE(`time`)* 60000) + (SECOND(`time`) * 1000) + (MICROSECOND(`time`) / 1000)) AS ms_ref
FROM laptimes AS l 
WHERE milliseconds != ((HOUR(`time`) * 3600000) + (MINUTE(`time`)* 60000) + (SECOND(`time`) * 1000) + (MICROSECOND(`time`) / 1000))

-- 
UPDATE qualifying 
SET q1 = REPLACE(q1 , '%\x00%', '');


SELECT CONCAT('00:', q1)
FROM qualifying2 AS q 

-- prázdné buňky nastaveny jako NULL
UPDATE qualifying2 
SET q1 = NULL
WHERE TRIM(q1) = '';

UPDATE qualifying2 
SET q2 = NULL
WHERE TRIM(q2) = '' OR q2 LIKE 'null';

UPDATE qualifying2 
SET q3 = NULL
WHERE TRIM(q3) = '' OR q3 LIKE 'null';

UPDATE qualifying2
SET q1 = 
	STR_TO_DATE(CONCAT('00:', q1), '%H:%i:%s.%f')
WHERE q1 NOT LIKE '%:__:__.___' 
AND TRIM(q1) IS NOT NULL ;

UPDATE qualifying2
SET q2 = 
	STR_TO_DATE(CONCAT('00:', q2), '%H:%i:%s.%f')
WHERE q2 NOT LIKE '%:__:__.___' 
AND TRIM(q2) IS NOT NULL ;

UPDATE qualifying2
SET q2 = 
	STR_TO_DATE(CONCAT('00:0', q2), '%H:%i:%s.%f')
WHERE q2 NOT LIKE '%_:__.___' 
AND q2 IS NOT NULL ;

SELECT
	time(q1)
FROM qualifying AS q 


-- qualifying - Nastavení prázdných buněk a buněk se stringem "NULL" na real NULL u tab. qualifying sloupce q1, q2, q3

UPDATE qualifying 
SET q1 = NULL
WHERE TRIM(q1) = '' OR q1 LIKE 'null';

UPDATE qualifying
SET q1 = 
	STR_TO_DATE(CONCAT('00:', q1), '%H:%i:%s.%f')
WHERE q1 NOT LIKE '%:__:__.___' 
AND q1 IS NOT NULL ;

-- odhalena chyba qualifyID 5665: q2 nesplňuje formát - pro jistotu hodnota nastavena na NULL
SELECT *
FROM qualifying AS q 
WHERE q2 NOT LIKE '%:__.___';

UPDATE qualifying 
SET q2 = NULL 
WHERE qualifyId = 5665;

-- 
UPDATE qualifying 
SET q2 = NULL
WHERE TRIM(q2) = '' OR q2 LIKE 'null';

UPDATE qualifying
SET q2 = 
	STR_TO_DATE(CONCAT('00:', q2), '%H:%i:%s.%f')
WHERE q2 NOT LIKE '%:__:__.___' 
AND q2 IS NOT NULL ;

-- 

UPDATE qualifying 
SET q3 = NULL
WHERE TRIM(q3) = '' OR q3 LIKE 'null';

UPDATE qualifying
SET q3 = 
	STR_TO_DATE(CONCAT('00:', q3), '%H:%i:%s.%f')
WHERE q2 NOT LIKE '%:__:__.___' 
AND q2 IS NOT NULL ;

-- nastavení prázdných buněk tab. results col. fastestLapTime na [NULL] hodnotu

UPDATE results 
SET fastestLapTime = NULL
WHERE TRIM(fastestLapTime) = '';

UPDATE results 
SET fastestLapSpeed = NULL
WHERE resultId = 23769;

-- 

SELECT *
FROM results AS r 
LEFT JOIN races AS r2 
ON r.raceId = r2.raceId 
WHERE fastestLapTime IS NOT NULL 
ORDER BY fastestLapTime

SELECT *
FROM results AS r 
LEFT JOIN races AS r2 
ON r.raceId = r2.raceId 
WHERE fastestLapSpeed IS NOT NULL 
ORDER BY fastestLapSpeed


SELECT DISTINCT year
FROM laptimes_1 AS l 
LEFT JOIN races AS r 
ON l.raceId = r.raceId 

-- 

SELECT *
FROM results AS r 
LEFT JOIN qualifying AS q 
ON r.driverId = q.driverId AND r.`number` = q.`number` AND r.`position` = q.`position`
WHERE r.resultId BETWEEN 13900 AND 13960

SELECT *
FROM qualifying AS q 
WHERE driverId = 231

SELECT *
FROM results AS r 
WHERE resultId BETWEEN 13800 AND 14000

-- Chybějící raceId tab results u záznamů resultId 13 913 - 13 942: z kontextu odvozeno, že se jedná o raceId 567
SELECT *
FROM results AS r 
WHERE raceId is NULL

UPDATE results 
SET raceId = 567
WHERE resultId BETWEEN 13913 AND 13942

-- správný formát tab pitstops_4 col duration 

UPDATE pitstops
SET duration = 
	CONCAT('00:', duration)
WHERE duration NOT LIKE '%:__.___' 
;

UPDATE pitstops
SET duration = 
	CONCAT('00:', duration)
WHERE duration NOT LIKE '%:__:__.___' 
;


ALTER TABLE f1.pitstops
MODIFY COLUMN duration time(3) DEFAULT NULL NULL;

-- kontrola zda sedí duration a milliseconds v tab pitStops
SELECT *
FROM pitstops AS ps
WHERE ((HOUR(duration) * 3600000) + (MINUTE(duration)* 60000) + (SECOND(duration) * 1000) + (MICROSECOND(duration) / 1000)) != milliseconds 


-- tab results 
-- pro přehlednost přináno "+" u časů výsledků jezdců, kteří se neumístili jako 1.

UPDATE results 
SET `time` = NULL
WHERE TRIM(`time`) = '';

UPDATE results 
SET `time` = NULL
WHERE TRIM(`time`) = '';

UPDATE results
SET `time` = CONCAT('+', `time`)
WHERE `position` != 1 AND `time` NOT LIKE '+%'







