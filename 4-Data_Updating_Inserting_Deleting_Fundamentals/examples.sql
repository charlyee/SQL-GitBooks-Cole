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

--1: Example of insertting data.
INSERT INTO owner 
(id, Name) 
VALUES (1, 'Jane Doe');

INSERT INTO owner
(id, Name) 
VALUES (2, 'John Doe');

--2: Another example of inserting data. But we needed to set 
--at least one owner in the OWNER table so we have a foriegn key for owner.
INSERT INTO Dogs
(id, Name, Breed, Color, Birthdate, OwnerId) 
VALUES
(1, 'Doge', 'Shih Tzu', 'White and Black', '2020-02-01', 1)

--3: Example of insertting multiple records into the DB.
INSERT INTO Dogs
(id, Name, Breed, Color, Birthdate, OwnerId) 
VALUES 
(2, 'Spot', 'Pomeranian', 'Brown', '2020-02-05', 1), 
(3, 'Woof', 'Labrador', 'Black', '2019-11-04', 2);

--4: Example of updating data.
UPDATE Dogs
SET 
Name = 'Any Other Name' 
WHERE Dogs.id = 1

--5: Another updating data example.
UPDATE dogs 
SET 
Name = 'Super Pom', 
Breed = 'Super Sized Pomeranian', 
Color = 'Brown and White Spotted', 
Birthdate = '2016-10-10', 
OwnerId = 2
WHERE Dogs.id = 1

--6: A deletion example, based on ID.
DELETE FROM Dogs
WHERE Dogs.Id=1

--7: A deletion example, based on owner ID.
--But first lets add some data...
INSERT INTO Dogs
(id, Name, Breed, Color, Birthdate, OwnerId) 
VALUES 
(5, 'Spot', 'Pomeranian', 'Brown', '2020-02-05', 1), 
(6, 'Woof', 'Labrador', 'Black', '2019-11-04', 2),
(7, 'Spot', 'Pomeranian', 'Brown', '2020-02-05', 1), 
(8, 'Woof', 'Labrador', 'Black', '2019-11-04', 2),
(9, 'Spot', 'Pomeranian', 'Brown', '2020-02-05', 1), 
(10, 'Woof', 'Labrador', 'Black', '2019-11-04', 2),
(11, 'Spot', 'Pomeranian', 'Brown', '2020-02-05', 1), 
(12, 'Woof', 'Labrador', 'Black', '2019-11-04', 2),
(13, 'Spot', 'Pomeranian', 'Brown', '2020-02-05', 1), 
(14, 'Woof', 'Labrador', 'Black', '2019-11-04', 2),
(15, 'Woof', 'Labrador', 'Black', '2019-11-04', 2),
(16, 'Spot', 'Pomeranian', 'Brown', '2020-02-05', 1), 
(17, 'Woof', 'Labrador', 'Black', '2019-11-04', 2);

--Now check the database before running the delete, and you'll see
--all of these new entries... now run the delete command and you'll see
--all of them with owner id of 2 be deleted.

DELETE FROM Dogs 
WHERE Dogs.OwnerId=2

--8: Deletion example with a join to filter owners by name.
--Assuming we have the same old data... owners with ID = 1 still exists. 
--So deleting based on that...
DELETE dogs
FROM dogs
INNER JOIN owner ON dogs.OwnerId = owner.id
WHERE owner.Name = "Jane Doe";