--Note that these examples assume that we are still using the same
--tables as we defined during part 2 on TABLE_CREATION_FUNDAMENTALS.
--These tables in particular.
CREATE TABLE Owner (
  id int NOT NULL AUTO_INCREMENT,
  Name varchar(255),
  PRIMARY KEY(id)
);

--Now your dogs table must reference a record
--by it's ID from the Owner's table. 
CREATE TABLE Dogs (
  id int NOT NULL AUTO_INCREMENT,
  Name varchar(255),
  Breed varchar(255),
  Color varchar(255),
  Birthdate DATE,
  OwnerId int,
  PRIMARY KEY(id),
  FOREIGN KEY (OwnerId) REFERENCES Owner(id) 
);

---------------------------------------
--Now lets populate it with some test data just so we have something
--to actually retrieve data from / of. 

INSERT INTO owner
(id, Name) 
VALUES 
(1, 'John Doe'),
(2, 'Jane Doe'),
(3, 'Claire Doe'),
(4, 'Shaggy Doo');

INSERT INTO Dogs
(id, Name, Breed, Color, Birthdate, OwnerId) 
VALUES 
(1, 'Spot', 'Pomeranian', 'Brown', '2020-02-05', 1), 
(2, 'Woof', 'Labrador', 'Black', '2019-11-04', 2),
(3, 'Spot2', 'Pomeranian', 'Brown', '2020-02-05', 3), 
(4, 'Woof2', 'Labrador', 'Black', '2019-11-04', 2),
(5, 'Spot3', 'Pomeranian', 'Brown', '2020-02-05', 3), 
(6, 'Woof3', 'Labrador', 'Black', '2019-11-04', 2),
(7, 'Spot4', 'Pomeranian', 'Brown', '2020-02-05', 1), 
(8, 'Woof4', 'Labrador', 'Black', '2019-11-04', 2),
(9, 'Scooby Doe', 'Great Dane', 'Brown', '1969-02-05', 4), 
(10, 'Woof5', 'Labrador', 'Black', '2019-11-04', 2),
(11, 'Spot6', 'Pomeranian', 'Brown', '2020-02-05', 1), 
(12, 'Woof6', 'Labrador', 'Black', '2019-11-04', 3),
(13, 'Spot7', 'Pomeranian', 'Brown', '2020-02-05', 1), 
(14, 'Woof7', 'Labrador', 'Black', '2019-11-04', 2),
(15, 'Woof8', 'Labrador', 'Black', '2019-11-04', 3),
(16, 'Spot8', 'Pomeranian', 'Brown', '2020-02-05', 1), 
(17, 'Woof9', 'Labrador', 'Black', '2019-11-04', 2),
(18, 'Woof9', 'Labrador', 'Black', '2019-11-04', 3);


---------------------------------------
--1: Most basic select statement. Select everything from dogs.
SELECT *
FROM Dogs;

--2: Select one super specific dog record by specific id of that dog.
SELECT * 
FROM Dogs
WHERE id=2;

--3: Select all dogs with a specific criterion.
SELECT *
FROM Dogs 
WHERE Breed='Pomeranian';

--4: Select all dogs by slightly more specific criterion.
SELECT *
FROM Dogs 
WHERE Breed='Labrador' AND OwnerId = 2;

--5: Get the COUNT of all labrador breed dogs of ownerId =2
SELECT COUNT(*)
FROM Dogs 
WHERE Breed='Labrador' AND OwnerId = 2;

--6: Get the results where "lab" is in the dog breed name.
SELECT * 
FROM Dogs
WHERE Breed LIKE "%Lab%";

--Interesting to note that this will return nothing.
--The "%" signs translate to mean 'anything' but are based on the position
--relative to the key search word here. So "%Lab%" means that it will 
--return any result that contains Lab at any point of Breed.
--But try this next command and note that it returns nothing... 
SELECT * 
FROM Dogs
WHERE Breed LIKE "%Lab";

--So why nothing? That's because it will NOT return results with 'anything'
--after Lab. So "Labrador" has 'rador' after Lab. Therefore this will not match
--As this SPECIFICALLY looks for Lab at the end.
--Like the word 'something something Lab'would be returned. 
--So key positioning of the "%" symbol in this is actually very important...

------------------------------------
--Now what if we only wanted to select PARTICULAR columns of data from the table?
--Surely we don't want everything... right? 
-- (And for the record the "SELECT *" with the "*" symbol means WILDCARD. Which
-- in this context means RETURN EVERYTHING. Or every single column.)
-- Here is where the select statement gets a bit more interesting...


--7: Return ONLY the name of all of the dog records.

SELECT Name
FROM Dogs;

--8: Get the distinct dog breeds in the table.
SELECT DISTINCT Breed 
FROM Dogs;

--9: YES you can combine methods! So here we combine count and distinct.
--This use case returns us the count of all of the distinct OwnerId in the databases.
--Or in simpler terms, we want to know how many owners there are across all records in the table.
SELECT COUNT(DISTINCT(OwnerId))
FROM Dogs;

--10: Join statement example
--This is the most basic example of a join, where we just return all results
--of the join between the table dogs and table owner.
--Please note that the ownerid has been the FOREIGN KEY in the DOGS table 
--and that this FOREIGN KEY is the PRIMARY KEY IN THE OWNER TABLE.
--So when we do a join like this, we are matching up the FOREIGN KEY from the
--DOGS table with the PRIMARY KEY from the OWNER table.
--
--Interesting to note that is this statement will just return the dogs table records
--with the matching records from the owners table in full... 
--Try running it and you'll see what I mean.
--This is why it's very important to select SPECIFIC data you want. 
--Also using the WHERE statement wisely is key...
SELECT * 
FROM dogs
INNER JOIN owner ON dogs.OwnerId = owner.id;

--11: Get the count of how many dogs each of the owners has.
--This is a key use of the groupby statement.
SELECT COUNT(*)
FROM dogs 
INNER JOIN owner ON dogs.OwnerId = owner.id
GROUP BY (owner.id);

--12: But what if I wanted the owner name here too in the report?
--This is much easier to read for our purposes...
SELECT COUNT(*), owner.name
FROM dogs 
INNER JOIN owner ON dogs.OwnerId = owner.id
GROUP BY (owner.id);

--13: Return the owner name of the owner that owns a dog named "Spot"
SELECT owner.name
FROM dogs 
INNER JOIN owner ON dogs.OwnerId = owner.id
WHERE dogs.name="Spot";

--14: Return the count of all labradors owned by each owner.
SELECT COUNT(*), owner.name
FROM dogs 
INNER JOIN owner ON dogs.OwnerId = owner.id
WHERE dogs.breed='Labrador'
GROUP BY (owner.id);

--15: Return the list of all dogs owned by someone with Jane in their name.
SELECT owner.Name, dogs.Name, Breed, Color, Birthdate
FROM dogs 
INNER JOIN owner ON dogs.OwnerId = owner.id
WHERE owner.Name LIKE '%Jane%';

--16: Return the list of all owners who own more than 5 dogs.
SELECT owner.Name
FROM dogs 
INNER JOIN owner ON dogs.OwnerId = owner.id
GROUP BY (owner.id)
HAVING COUNT(*) > 5;  --Key syntax here is having.

--17: Return the list of all owners and the number of dogs that they have
--where they own at least 1 dog. Return the results in an order of count descending.
SELECT owner.Name, COUNT(*)
FROM dogs 
INNER JOIN owner ON dogs.OwnerId = owner.id
GROUP BY (owner.id)
HAVING COUNT(*) > 0
ORDER BY COUNT(*) DESC;  --Key syntax here

--18: In statement example
--Useful if you want to get a result from a prior set of options.
SELECT * 
FROM Dogs
WHERE breed IN ('Pomeranian', 'Spotty', "SpottedDoge");

--19: In statement example 2
--If you want to run a query on the results of a query in one single
--query this is an option if you want.
SELECT * 
FROM Dogs
WHERE dogs.id 
IN (
    SELECT id 
    FROM dogs
    WHERE dogs.breed LIKE '%Pom%'
);

--20: Sum example.
SELECT SUM(id)  
FROM Dogs;
