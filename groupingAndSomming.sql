
CREATE TABLE GameServer (
	IDGameServer int not null identity,
	IP varchar(30) not null,
	Type varchar(100) not null,
	CreationDate datetime not null,
	DNSServer int,
	CONSTRAINT PKIDGameServer PRIMARY KEY (IDGameServer),
);

CREATE TABLE Player (
	IDPlayer int not null identity,
	Name varchar(100) not null,
	UserName varchar(20) not null,
	Password varchar(20) not null,
	Points int,
	IDGameServer int,
	CONSTRAINT PKIDPlayer PRIMARY KEY (IDPlayer),	
	CONSTRAINT FKIDGameServer FOREIGN KEY (IDGameServer) REFERENCES GameServer(IDGameServer)
);

ALTER TABLE Player ADD Age int;
ALTER TABLE Player ALTER COLUMN Name varchar(200) not null;
ALTER TABLE GameServer DROP COLUMN DNSServer;

/* ------------------- Exercício 2 -------------------*/
/* 1.	Inserir 5 (linhas) de dados para cada uma das tabelas (atenção para a ordem de execução). */

SET DATEFORMAT DMY

INSERT INTO GameServer VALUES 
	('marimo', 'Dedicated server', '20-10-2018 10:00:00'),
	('bora', 'Listen server', getDate()),
	('teste', 'Peer-to-Peer', '20-10-2011 10:00:00'),
	('sobreisso', 'Dedicated server', getDate()),
	('rodrigo', 'Peer-to-Peer', '20-10-2010 10:00:00');
	
INSERT INTO Player VALUES 
	('Rodrigo', 'RodrigoRVSN', '123', 1000, 1, 18),
	('Gabrielly', 'GabriellyGVSN', '321', 2, 3, 100),
	('Cosme', 'DiguinhoDVSN', 'dig', 50000, 1, 5),
	('Lucas', 'Faker Moreno SLK', 'faker', 10, 2, 70),
	('Isabelly', 'Izinha do Grau', 'isa', 1, 1, 19);
	
/* 2.	Atualizar todos os GameServer com Type igual a ‘Peer-to-Peer’ para ‘P2P’. */

UPDATE GameServer SET Type = 'P2P' WHERE Type = 'Peer-to-Peer';

/* 3.	Dobrar o número de Points de todos os Players (atualizar). */

UPDATE Player SET Points = (Points * 2);

/* 4.	Atualizar o UserName do Player para conter as 5 (cinco) primeiras letras do Name. */

UPDATE Player SET UserName = SUBSTRING(Name, 1, 5);

/* 5.	Atualizar o Password de todos os Player para 123. */

UPDATE Player SET Password = '123';

/* 1.COUNT: Exibir a quantidade de GameServer cadastrados */

SELECT COUNT(*) QtdGameServers FROM GameServer;

/* 2.SUM: Exibir a soma de todos os Points dos Players */

SELECT SUM (Points) SumPointsOfPlayers FROM Player;

/* 3.AVG:Exibir a média dos Points dos Players */

SELECT AVG (Points) AveragePointsOfPlayers FROM Player;

/* 4.MAX e MIN:Exibir o GameServer mais novo e mais velho */

SELECT MAX(CreationDate) MaxCreationDate, MIN(CreationDate) MinCreationDate FROM GameServer;

/* 5.SUM + WHERE:Exibir a somada idade (Age) dos Players com mais de 100 pontos (points) */

SELECT SUM (Age) SumAgeOfPlayers FROM Player WHERE Points > 100;

/* 6.COUNT + GROUP BY:Exibir a quantidade deGameServer agrupados por Tipo (Type) */

SELECT COUNT(*) FROM GameServer GROUP BY Type;

/* 7.AVG + GROUP BY:Exibir a média de pontos (points) agrupados por idade (age) */

SELECT AVG (Points) AveragePointsOfPlayersGroupedByAge FROM Player GROUP BY Age;

/* 8.COUNT  +  GROUP  BY+  HAVING:Exibir  a  quantidade  deGameServer  agrupados  por  Tipo (Type). Somente os GameServer com quantidade entre 1 e 3 devem ser exibidos. */

SELECT COUNT(*) ageBetween FROM GameServer GROUP BY Type HAVING COUNT(*) BETWEEN 1 AND 3;

/* 9.AVG  +  GROUP  BY+  HAVING:Exibir  a  média  de pontos  (points)  agrupados  por idade (age). Somente os players com média superior a 100 devem ser exibidos. */

SELECT AVG (Points) AveragePointsOfPlayersGroupedByAgeHave FROM Player GROUP BY Age HAVING AVG(Points) > 100;

/* 10.COUNT+  GROUP  BY  +  HAVING:Exibir  a  quantidade  de  Players  agrupados  por  idade  (age). Somente as idades com mais de 1 player devem ser exibidas. */

SELECT COUNT(*) ageMoreOne FROM Player GROUP BY Age HAVING COUNT(*) > 1;


-- Mostra os valores
SELECT * FROM GameServer
SELECT * FROM Player

-- Apaga as linhas
DELETE FROM GameServer
DELETE FROM Player

-- Reseta o contador identity 
DBCC CHECKIDENT ('GameServer', RESEED, 0 )
