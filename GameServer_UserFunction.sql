CREATE TABLE GameServer (
	IDGameServer int identity not null,
	IP varchar(30) not null,
	Type varchar(100),
	CreationDate datetime not null,
	DNSServer int,

	CONSTRAINT PKIDGameServer PRIMARY KEY (IDGameServer),
);

create TABLE Player (
	IDPlayer int identity not null,
	Name varchar(100) not null,
	UserName varchar(20) not null,
	Password varchar(20) not null,
	Points int not null,
	IDGameServer int,

	CONSTRAINT PKIDPlayer PRIMARY KEY (IDPlayer),
	CONSTRAINT FKIDGameServer FOREIGN KEY (IDGameServer) REFERENCES GameServer(IDGameServer)
);

INSERT INTO GameServer VALUES 
	('marimo', 'Dedicated server', '20-10-2018 10:00:00', 1),
	('bora', 'Listen server', getDate(), 2),
	('teste', 'Peer-to-Peer', '20-10-2011 10:00:00', 3),
	('sobreisso', 'Dedicated server', getDate(), 5),
	('rodrigo', 'Peer-to-Peer', '20-10-2010 10:00:00', 4);
	
INSERT INTO Player VALUES 
	('Rodrigo', 'RodrigoRVSN', '123', 1000, 1),
	('Gabrielly', 'GabriellyGVSN', '321', 2, 3),
	('Cosme', 'DiguinhoDVSN', 'dig', 50000, 1),
	('Lucas', 'Faker Moreno SLK', 'faker', 10, 2),
	('Isabelly', 'Izinha do Grau', 'isa', 1, 1);

SELECT * FROM GameServer
SELECT * FROM Player
SELECT AVG(Points) FROM Player

/* 1- Criar uma Scalar Function que recebe como par�metro uma data e retorne a quantidade de anos (diferen�a entre a data informada e a data atual).oComo  exemplo,  fazer a chamada da fun��o utilizando o campo �Creation Date� da tabela GameServer*/

GO
CREATE FUNCTION dbo.FNDateDiff(@creationDate datetime)
RETURNS int
AS
BEGIN
	DECLARE @diff int
	SELECT @diff =  YEAR(GETDATE()) - YEAR(@creationDate)
	RETURN @diff
END
GO

SELECT dbo.FNDateDiff(CreationDate) Diff FROM GameServer
/* DROP FUNCTION dbo.FNDateDiff */

/* 2- Criar   uma Scalar   Functionque   recebe   como   par�metro   o   IDGameServer   e   retorna   a quantidade total de Points que possui com base nos Players associados. */

GO
CREATE FUNCTION dbo.FNTotalPointAssociate(@idGameServer int)
RETURNS int
AS
BEGIN
	DECLARE @points int
	SELECT @points = SUM(Points) FROM Player WHERE IDGameServer = @idGameServer
	RETURN @points
END
GO

SELECT dbo.FNTotalPointAssociate(IDGameServer) TotalDePontos FROM GameServer

/* DROP FUNCTION dbo.FNTotalPointAssociate */

/* 3- Criar  uma Scalar Function que  recebe  como  par�metro  um  texto  (password  do  Player)  e verificar se o mesmo est� dentro do requisito de senhas, ou seja, possui pelo menos 8 (oito) caracteres. Retorne �SIM� se estiver dentro dos requisitos, caso contr�rio retorne �N�O� concatenado com a quantidade atual de caracteres */


GO
CREATE FUNCTION dbo.FNVerifySize(@password varchar(20))
RETURNS varchar(10)
AS
BEGIN
	DECLARE @confirm varchar(10)
	SELECT @confirm = LEN(@password)

	IF @confirm > 8
		SET @confirm = 'SIM'
	ELSE
		SET @confirm = 'N�O -> a senha contem ' + CONVERT(varchar(10),LEN(@password)) + ' d�gitos'
	RETURN @confirm
END
GO

SELECT dbo.FNVerifySize(Password) Valida��o FROM Player

/* DROP FUNCTION dbo.FNVerifySize */

/* 4- Criar uma Scalar Function que recebe par�metro uma o IDPlayer e com base nos seus Points indica o quanto o mesmo est� abaixo ou acima do valor m�dio.Exemplo 1Valor M�dio de Points do Player: 85Valor de Points do Player 1: 110Points acima de M�dia: 25Exemplo 2Valor M�dio de Points do Player: 85Valor de Points do Player 2: 15Points abaixo de M�dia: -70*/

GO
CREATE FUNCTION dbo.VerifyAverage(@idPlayer int)
RETURNS varchar(50)
AS
BEGIN
	DECLARE @average int
	DECLARE @averageOfPlayer int
	DECLARE @diffPoints varchar(50)

	SELECT @average = AVG(Points) FROM Player
	SELECT @averageOfPlayer = AVG(Points) FROM Player WHERE IDPlayer = @idPlayer
	IF @averageOfPlayer - @average > 0
		SET @diffPoints = 'O jogador est� ' + CONVERT(varchar(10), (@averageOfPlayer - @average)) + ' pontos acima da m�dia.'
	ELSE IF @averageOfPlayer - @average < 0
		SET @diffPoints = 'O jogador est� ' + CONVERT(varchar(10), (@average - @averageOfPlayer)) + ' pontos abaixo da m�dia.'
	ELSE
		SET @diffPoints = 'O jogador est� na m�dia com ' +  CONVERT(varchar(10), @averageOfPlayer) + ' pontos.'

	RETURN @diffPoints
END
GO

SELECT dbo.VerifyAverage(IDPlayer) Par�metro FROM Player

/* DROP FUNCTION dbo.VerifyAverage */