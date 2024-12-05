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

ALTER TABLE results 
ADD CONSTRAINT
PRIMARY KEY (resultId)






















