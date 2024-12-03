ALTER TABLE drivers 
ADD CONSTRAINT
PRIMARY KEY (driverId)


ALTER TABLE drivers 
DROP PRIMARY KEY;


ALTER TABLE circuits 
DROP PRIMARY KEY;

ALTER TABLE circuits 
ADD CONSTRAINT
PRIMARY KEY (circuitId)

ALTER TABLE races 
DROP PRIMARY KEY;

ALTER TABLE races 
ADD CONSTRAINT
PRIMARY KEY (raceId)

ALTER TABLE qualifying 
DROP PRIMARY KEY;

ALTER TABLE qualifying 
ADD CONSTRAINT
PRIMARY KEY (qualifyId)

ALTER TABLE qualifying 
DROP PRIMARY KEY;

ALTER TABLE constructors 
ADD CONSTRAINT
PRIMARY KEY (constructorId)

ALTER TABLE status 
ADD CONSTRAINT
PRIMARY KEY (statusId)
~~
ALTER TABLE results 
ADD CONSTRAINT
PRIMARY KEY (resultId)


SELECT 
	*
FROM pitstops AS p
WHERE forename = (
	SELECT forename 
	FROM drivers
	WHERE drivers.forename = 'Nick')

SELECT forename FROM drivers

SELECT DISTINCT 
	driverId 
FROM results AS r 
ORDER BY driverId DESC 

SELECT DISTINCT 
	driverId 
FROM drivers AS d 
ORDER BY driverId DESC 

SELECT DISTINCT 
	*
FROM results AS r 
ORDER BY driverId DESC 




ALTER TABLE qualifying2
DROP PRIMARY KEY;

ALTER TABLE qualifying2 
ADD CONSTRAINT
PRIMARY KEY (qualifyId)





















