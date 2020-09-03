CREATE DATABASE IMDBTest
USE IMDBTest
CREATE TABLE Producers (Id int identity primary key,Name varchar(100) ,Company varchar(100),CompanyEstDate date)
CREATE TABLE Actors (Id int identity primary key,Name varchar(100) ,Gender varchar(10),DOB date)
CREATE TABLE Movies (Id int identity primary key,Name varchar(100) ,Language varchar(10),ProducerId int references Producers(Id),Profit decimal(18,6))
CREATE TABLE MovieActorMapping (Id int identity primary key,MovieId int references Movies(id),ActorsId int references Actors(id))



INSERT INTO Producers VALUES ('Arjun','Fox','05/14/1998')
INSERT INTO Producers VALUES ('Arun','Bull','09/11/2004')
INSERT INTO Producers VALUES ('Tom','Hanks','11/03/1987')
INSERT INTO Producers VALUES ('Zeshan','Chillie','11/14/1996')




INSERT INTO Actors VALUES ('Mila Kunis','Female','11/14/1986')
INSERT INTO Actors VALUES ('Robert DeNiro','Male','07/10/1957')
INSERT INTO Actors VALUES ('George Michael','Male','11/23/1978')
INSERT INTO Actors VALUES ('Mike Scott','Male','08/06/1969')
INSERT INTO Actors VALUES ('Pam Halpert','Female','09/26/1996')




INSERT INTO Movies VALUES ('Rocky','English',1,10000)
INSERT INTO Movies VALUES ('Rocky','Hindi',2,3000)
INSERT INTO Movies VALUES ('Terminal','English',1,300000)
INSERT INTO Movies VALUES ('Rambo','English',3,93000)



INSERT INTO MovieActorMapping VALUES (1,1)
INSERT INTO MovieActorMapping VALUES (1,3)
INSERT INTO MovieActorMapping VALUES (1,4)
INSERT INTO MovieActorMapping VALUES (2,2)
INSERT INTO MovieActorMapping VALUES (3,4)
INSERT INTO MovieActorMapping VALUES (3,5)
INSERT INTO MovieActorMapping VALUES (3,2)
INSERT INTO MovieActorMapping VALUES (3,1)
INSERT INTO MovieActorMapping VALUES (4,1)
INSERT INTO MovieActorMapping VALUES (4,2)
INSERT INTO MovieActorMapping VALUES (5,1)
INSERT INTO MovieActorMapping VALUES (5,2)
INSERT INTO MovieActorMapping VALUES (5,3)
INSERT INTO MovieActorMapping VALUES (5,4)
INSERT INTO MovieActorMapping VALUES (5,5)



--Update Profit of all the movies by +1000 where producer name contains 'run'

UPDATE M SET M.Profit = M.Profit+1000 FROM Movies M
INNER JOIN Producers P
ON P.Id = M.ProducerId
WHERE P.Name LIKE '%run%'

--List down actors details which have acted in movies where producer name ends with 'n'

SELECT A.Name,A.Gender,A.DOB FROM Actors A
INNER JOIN MovieActorMapping MAM
ON MAM.ActorsId = A.Id
INNER JOIN Movies M
ON M.Id = MAM.MovieId
INNER JOIN Producers P
ON P.Id = M.ProducerId
WHERE P.Name LIKE '%n'

--Find the avg age of male and female actors that were part of a movie called 'Terminal'  --Should return two rows 

SELECT A.Gender,AVG(DATEDIFF("YYYY", A.DOB,GETDATE())) AS AvgAge FROM Actors A
INNER JOIN MovieActorMapping MAM
ON MAM.ActorsId = A.Id
INNER JOIN Movies M
ON M.Id = MAM.MovieId
WHERE M.Name = 'Terminal'
GROUP BY A.Gender

--Find the third oldest female actor

SELECT TOP 1 * FROM (SELECT TOP 3 * FROM Actors WHERE Gender = 'Female' ORDER BY DOB) Actors 
ORDER BY DOB DESC

--List down top 3 profitable movies 

SELECT TOP 3 * FROM Movies
ORDER BY Profit DESC

--List down the oldest actor and Movie Name for each movie

SELECT A.Name, M.Name AS [MOVIE NAME] FROM Actors A
INNER JOIN MovieActorMapping MAM
ON MAM.ActorsId = A.Id
INNER JOIN Movies M
ON M.Id = MAM.MovieId
WHERE A.DOB = (SELECT MIN(DOB) FROM Actors)

--Find duplicate movies having the same name and their count

SELECT Name, COUNT(Name) FROM Movies
GROUP BY NAME
HAVING COUNT(Name)>1

--List down all the producers and +the movie name(even if they dont have a movie)

SELECT P.Name, M.Name AS [MOVIE NAME] FROM Producers P
LEFT OUTER JOIN Movies M
ON M.ProducerId = P.Id

--After all the queries are done:
--Normalise it (If not normalised)

--CREATE A COMPANY TABLE AND GIVE ITS PRIMARY KEY TO PRODUCER AS FOREGIN KEY



--https://docs.google.com/document/d/1M4X3HCP6_py4mWlQgfJqjOW3ICQpuhpHrKXt0x3mQrw/edit