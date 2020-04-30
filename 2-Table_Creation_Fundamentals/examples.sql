--This file contains examples of SQL statements
--that may be used to create tables. We strongly encourage you
--to take this code and manipulate it on your own and test these
--codes in your own local databases.
--1: Basic example of creating a table with 4 fields.
CREATE TABLE Users (
  ID int,
  LastName varchar(255),
  FirstName varchar(255),
  FaveColor varchar(255)
);
--2: Example of creating another table where we enforce not null constraint on name.
CREATE TABLE Dogs (
  id int,
  Name varchar(255) NOT NULL,
  Breed varchar(255),
  Color varchar(255),
  PRIMARY KEY(id)
);

--3: Example of dropping the dogs table made above.
DROP TABLE Dogs;

--4: Example of a constraint on the field of name to be unique.
--Any attempts to enter records with the same name will be errors.
CREATE TABLE Dogs (
  id int NOT NULL,
  Name varchar(255) UNIQUE,
  --Syntax change here.
  Breed varchar(255),
  Color varchar(255),
);

--5: Example of specifying a field of the date type
CREATE TABLE Dogs (
  id int NOT NULL,
  Name varchar(255) UNIQUE,
  Breed varchar(255),
  Color varchar(255),
  Birthdate DATE      --Syntax change here.
) 

--6: Example of specifying a default for a value.
--Now if dog isn't specified (so would be null otherwise) we get 'dog' there.
CREATE TABLE Dogs (
  id int NOT NULL,
  Name varchar(255) UNIQUE,
  Breed varchar(255) DEFAULT "dog", --Syntax change here.
  Color varchar(255),
  Birthdate DATE      
) 

--7: Example of specifying a default for a value.
--Now if dog isn't specified (so would be null otherwise) we get 'dog' there.
CREATE TABLE Dogs (
  id int NOT NULL,
  Name varchar(255) UNIQUE,
  Breed varchar(255) DEFAULT "dog", --Syntax change here.
  Color varchar(255),
  Birthdate DATE      
) 

--8: Example of specifying a primary key. This will be the unique key identifier
-- for the objects. Most frequently this will be see as the record's id.
-- Literally all we do to specify the primary key is specify it at the bottom.
CREATE TABLE Dogs (
  id int NOT NULL,
  Name varchar(255) UNIQUE,
  Breed varchar(255) DEFAULT "dog", 
  Color varchar(255),
  Birthdate DATE,
  PRIMARY KEY (id)     --Syntax change here.
) 


--9: Example of creating another table now with autoincrement on ID
--Note that this does require it to be identified as a key.
CREATE TABLE Dogs (
  id int NOT NULL AUTO_INCREMENT,   --Syntax change here.
  Name varchar(255),
  Breed varchar(255),
  Color varchar(255),
  Birthdate DATE,
  PRIMARY KEY(id)
);

--10: Foriegn Key. 
-- Note that a Foriegn Key is used to link two tables together, the foreign key
-- in this table MUST reference the PRIMARY KEY IN ANOTHER TABLE. 

--Therefore if you're following this example we must create this Owner Table.
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
  FOREIGN KEY (OwnerId) REFERENCES Owner(id) -- Syntax change
);