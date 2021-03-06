CREATE DATABASE IMDB
USE IMDB
CREATE TABLE Actors(Id INT IDENTITY PRIMARY KEY, Name VARCHAR(100), Sex VARCHAR(100), DOB DATE, Bio VARCHAR(1000))
CREATE TABLE Producers(Id INT IDENTITY PRIMARY KEY, Name VARCHAR(100), Sex VARCHAR(100), DOB DATE, Bio VARCHAR(1000))
CREATE TABLE Movies(Id INT IDENTITY PRIMARY KEY, Name VARCHAR(200), YearOfRelease DATE, Plot VARCHAR(2000), Poster IMAGE, ProducersId INT REFERENCES Producers(Id))
CREATE TABLE ActorsMoviesMapping(Id INT IDENTITY PRIMARY KEY, ActorsId INT REFERENCES Actors(Id), MoviesId INT REFERENCES Movies(Id))

