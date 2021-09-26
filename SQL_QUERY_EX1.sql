/* Exercício 1
	1.	Criar as tabelas do modelo indicado abaixo
	2.	Crias as restrições solicitadas (not null, identity).
	3.	Criar os relacionamentos necessários (chaves primárias e chavesestrangeiras)
	4.	Adicionar na tabela Playero campo Agedo tipo int
	5.	Alterar o campo Nameda tabela Playerpara varchar(200)
	6.	Excluir o campo DNSServerda tabela GameServe
*/

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

/* 6.	Excluir todos os Player com Name igual a Cosme. */

DELETE FROM Player WHERE Name = 'Cosme';

/* 7.	Excluir todos os GameServer com CreationDate dos anos de 2010 à 2013. */

DELETE FROM GameServer WHERE ((YEAR(CreationDate) >= 2010) AND (YEAR(CreationDate) <= 2013));

/* 8.	Excluir todos os Player com points menor do que 750. */

DELETE FROM Player WHERE Points < 750;

/* 9.	Excluir todos os Player com Age maior que 50. */

DELETE FROM Player WHERE Age > 50;

-- Mostra os valores
SELECT * FROM GameServer
SELECT * FROM Player

-- Apaga as linhas
DELETE FROM GameServer
DELETE FROM Player

-- Reseta o contador identity 
DBCC CHECKIDENT ('GameServer', RESEED, 0 )


