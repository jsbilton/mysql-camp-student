-- Exercise 2 --

USE RockStarDay2;

SHOW COLUMNS FROM Band;

-- Excercise 3 --

SELECT * FROM Individual
WHERE LastName = 'Jennings';

SELECT ID, LastName
FROM Individual
WHERE DeceasedDate IS NOT NULL;


SELECT ID, LastName, BirthDate
FROM Individual
WHERE Year(BirthDate) > 1940;


SELECT * FROM Individual
WHERE ID IN (1,3,5,7,19);


-- Exercise 4 --

SELECT * FROM Band
WHERE Genre = 'Alternative' and isTogether = 0;

SELECT ID, Name FROM Band
WHERE ID = 4;

-- Exercise 5 --
SELECT *
FROM Band
WHERE Name LIKE '%and%';

SELECT *
FROM Individual
WHERE FirstName LIKE '_im';

SELECT *
FROM Band
WHERE Name LIKE '%s';


-- Exercise 10-joins/1 --
Select * from player;
Select * from team;
Select * from batting;
Select * from roster;

SELECT team.ID
, team.TeamName
, batting.TeamID
, batting.Rank
, batting.BattingAvg
FROM team
INNER JOIN batting ON team.ID = batting.TeamID;

SELECT player.ID
 , player.LastName
 , batting.Rank
 , batting.BattingAvg
 FROM player
 INNER JOIN batting ON player.ID = batting.PlayerID;

 SELECT player.ID
 , player.LastName
 , batting.Rank
 , batting.BattingAvg
 FROM player
 INNER JOIN batting ON player.ID = batting.PlayerID
 WHERE batting.BattingAvg = 331;

 SELECT roster.*
, player.LastName
, player.ID
FROM roster
INNER JOIN player ON roster.playerID = player.ID;



SELECT * FROM vteamRoster;

DESCRIBE vteamRoster;

SHOW CREATE VIEW vteamRoster;


-- Joins Exercise 10-joins/2 --

-- Create a SELECT statement that joins the **player** table and the **batting** table. The query should show all the players and any matching players that exist within the batting table. You should see NULL when there are no matches in the batting table.

SELECT player.ID
, player.LastName
, player.FirstName
, batting.TeamID
, batting.BattingAvg
, batting.Rank
FROM player
LEFT JOIN batting ON batting.playerID = player.ID;


-- Create a SELECT statement that joins the roster table and the team table. The query should display all the teams and any matching players within the roster table. You should see NULL when there are no matches in the roster table.


SELECT roster.ID
, roster.playerID
, roster.Position
, roster.SeasonYear
, team.teamName
, team.league
, team.DivisionName
FROM roster
RIGHT JOIN team ON roster.teamID = team.ID;


-- Create a query that shows teams that have players on a roster. If a team does not have any players on a roster, then do not display the team.

SELECT roster.ID
, roster.playerID
, roster.Position
, roster.SeasonYear
, team.teamName
, team.league
, team.DivisionName
FROM roster
LEFT JOIN team ON roster.teamID = team.ID;

-- Create a query that displays teams that do not have players on a roster.

SELECT team.ID
, team.teamName
, team.League
, roster.ID
, roster.SeasonYear
FROM team
RIGHT JOIN roster ON team.ID = roster.teamID
WHERE roster.playerID IS NULL;


-- order by last name
SELECT ID
, LastName
, FirstName
, BirthDate
FROM  player
ORDER BY LastName;

-- order by first Name

SELECT ID
, LastName
, FirstName
, BirthDate
FROM player
ORDER BY FirstName;

-- Random examples from class
SELECT ID
, LastName
, FirstName
, BirthDate
FROM  player
ORDER BY LastName, FirstName;

SELECT ID
, LastName
, FirstName
, BirthDate
FROM  player
ORDER BY BirthDate DESC;

SELECT ID
, LastName
, FirstName
, BirthDate
FROM  player
ORDER BY BirthDate ASC;

SELECT playerID
, playerName
, teamName
, HeightInches
, League
, DivisionName
FROM vteamRoster
ORDER BY League, DivisionName, TeamName, HeightInches DESC;

-- Exercise Order By

-- BA, ID, TeamName
SELECT batting
, batting.ID
, batting.BattingAvg
, team.TeamName
FROM team
INNER JOIN batting ON team.ID = batting.ID
ORDER BY BattingAvg DESC;


-- incomplete
SELECT FirstName
, LastName
, teamName
, ABBR
, Hits
, AtBats
FROM baseball.vbattingleaders
ORDER BY


-- GROUP BY CLause

-- want to list all teams with BA from batting Table

SELECT batting.ID
, team.TeamName
, batting.battingAvg
FROM batting
INNER JOIN team ON batting.teamID = team.ID;

-- determine which teams had the most players on the list

SELECT COUNT(batting.ID),
, team.teamName
FROM batting
INNER JOIN team ON batting.TeamName = team.ID
GROUP BY Team.teamName;



-- Group BY Excercise 12-group-by/1

-- Query 1
-- Retrieve all the columns from the vteamRoster view for only the batting leaders. To accomplish this, create a query that joins the batting table to the vteamRoster view using the playerID column for the join.

SELECT batting.Rank
, batting.ID
, vteamRoster.playerName
, vteamRoster.Position
, vteamRoster.teamName
, batting.battingAvg
FROM vteamRoster
INNER JOIN batting ON batting.playerID = vteamRoster.playerID;

-- Another way
SELECT v.*
FROM vteamRoster v
INNER JOIN batting b on b.playerID = v.playerID;


-- Query 2
-- Make a copy of the first query and place it below the first query. Modify the new query to determine the average weight of the batting leaders by division.

SELECT v.DivisionName
, AVG(Weight)
FROM vteamRoster v
INNER JOIN batting b ON b.playerID = v.playerID
GROUP BY v.DivisionName;


-- Another way
SELECT v.DivisionName as Division
, AVG(v.Weight) as 'averageWeight'
FROM vteamRoster
INNER JOIN batting b on b.playerID = v.playerID
GROUP BY v.DivisionName;

-- Query 3
-- query that returns all rows from just the vteamRoster view
SELECT *
FROM vteamRoster;

-- Query 4
-- query that counts the number of players within the vteamRoster view by position

SELECT Position, COUNT(playerID)
FROM vteamRoster
GROUP BY Position;


-- Another way

SELECT Position, COUNT (playerID) as PositionCount
from vteamRoster
GROUP BY Position;



-- Exercise: HAVING

-- Create three select statements that use the GROUP BY and HAVING clause. Use any table or view from any of the databases created to this point. Feel free to create your own database and tables with data, if you desire.

SELECT player.FirstName
, player.LastName
, player.BirthplaceCity
, player.BirthplaceCountry
, player.BirthplaceState
FROM player
WHERE BirthplaceCity = 'N'
GROUP BY BirthplaceCity;



-- Exercise: Add individuals to a band



-- Exercise: More than one way to INSERT INTO
INSERT INTO Individual
(LastName, FirstName, BirthDate, DateAdded, DeceasedDate)
VALUES
('Marcus', 'King', '1996-09-12', NOW(), NULL)
, ('Stapleton','Chris','1972-11-10', NOW(), NULL)
, ('McKernan', 'Ron', '1945-09-08', NOW(),'1973-03-08');

INSERT INTO Band
(Name, YearFormed, IsTogether, Genre)
VALUES
('Grateful Dead', '1965', 0, 'Rock')
, ('Marcus Kind Band', '2014', 1, 'Rock')
, ('The Steeldrivers', '2007', 1, 'Bluegrass');

INSERT INTO
IndividualBand (BandID, IndividualID)
Values (24,51), (25,49), (26,50);


-- INSERT INTO SELECT
INSERT INTO Individual
(LastName,
FirstName,
BirthDate,
DeceasedDate)
VALUES
('Allman', 'Duane', '1946-11-20', '1971-10-29');

-- DELETE
-- Exercise: Using the DELETE statement


SELECT * FROM Individual
WHERE FirstName = 'Dee Dee';

DELETE FROM Individual
WHERE ID = '55';

SELECT ID, FirstName, LastName
FROM Individual
WHERE LastName IN ('Ramone', 'Jennings', 'Presley');

DELETE
FROM Individual
WHERE LastName IN ('Ramone', 'Jennings', 'Presley');

SHOW Tables FROM RockStarDay2;
SHOW COLUMNS FROM IndividualBand;
SHOW CREATE TABLE IndividualBand;


-- UPDATE
-- Exercise: UPDATE Statement

-- UPDATE <table_name>
-- SET <column_name> = {expression}
-- WHERE <where_condition>

SELECT * FROM Band;

--this no work
UPDATE Band
SET Era ENUM('Classic', 'Modern');



SELECT * FROM Band WHERE YearFormed <= 1970;

-- DISTINCT

SELECT * FROM Band;

SELECT DISTINCT Genre FROM Band;

SELECT DISTINCT YearFormed, Genre FROM Band;

SELECT DISTINCT YearFormed FROM Band;

SELECT DISTINCT IsTogether FROM Band;

-- SELECT DISTINCT ID, Genre, Name FROM BandMembers;

SELECT DISTINCT Genre, Name FROM BandMembers;


-- Aliases


SELECT LastName, FirstName, CONCAT(FirstName, '', LastName) AS FullName
FROM BandMembers;


SELECT Genre, count(Genre) as CNT
FROM BandMembers
GROUP BY Genre
HAVING CNT > 1;


-- Exercise: Aliases

SELECT LastName, FirstName, CONCAT(FirstName, '', LastName) AS FullName
FROM BandMembers;

SELECT LastName, FirstName, YEAR(BirthDate) as BirthYear FROM BandMembers;




-- Relief Stuff

CREATE TABLE person (
  ID INT NOT NULL PRIMARY KEY UNSIGNED AUTO_INCREMENT
  , LastName varchar(50) NOT NULL
  , FirstName varchar(25) NOT NULL
  , email varchar(50) NOT NULL UNIQUE
  , phone INT(12) UNSIGNED NOT NULL
  , active NOT NULL TINYINT(1);


  ReliefTeam

  Relief
  ID INT PRIMARY KEY UNSIGNED AUTO_INCREMENT NOT NULL
  Name VARCHAR NOT NULL
  OrgID NOT NULL
  DESC NOT NULL
  Start DATE
  End DATE
  Phase ENUM('planning', 'active', 'completed')

--------------------------------------------------------------------
INSERT INTO person
(LastName, FirstName, email, phone, active)


INSERT INTO relief
(name, organizationID, description, start, end, phase)

INSERT INTO reliefTeam
(personID, reliefID, role)


CREATE TABLE reliefTeam (
  ID int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  personID int(11) UNSIGNED NOT NULL,
  reliefID int(11) UNSIGNED NOT NULL,
  role enum('Team Leader','Team Member') COLLATE latin1_general_ci NOT NULL,
  PRIMARY KEY (ID),
  UNIQUE KEY UI_reliefTeam_personID_reliefID (personID,reliefID),
  KEY FK_reliefTeam_person_idx (personID),
  KEY FK_reliefTeam_relief_idx (reliefID),
  CONSTRAINT FK_reliefTeam_person FOREIGN KEY (personID) REFERENCES person (ID) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_reliefTeam_relief FOREIGN KEY (reliefID) REFERENCES relief (ID) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;





"name": "Haiti Hurricane Mateo 2016",
"organizationID": "
"team": [
    {
        "name": "Steve Harvey",
        "role": "Team Leader",
        "personID": "person_steveharvey1111@gmail.com"
    },
    {
        "name": "Libby Satterfield",
        "role": "Team member",
        "personID": "person_lsat1972@gmail.com"
    },
    {
        "name": "Jimmy Martin",
        "role": "Team member",
        "personID": "person_JimmyMartinJr@gmail.com"
    }
],
"active": true,
"type": "relief"
}
