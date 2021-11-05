/* 1. Criar a tabela do Log chamada LogData conforme detalhes descritos.  */

CREATE TABLE LogData (
	IDLogData INT PRIMARY KEY IDENTITY,
	TableLog VARCHAR(1000),
	Operation varchar(255),
	Details varchar(1000),
	DateEvent datetime,
)

/* 2. Criar  uma  trigger  (gatilho)  que  permita  a  realização  de  inclusão  e/ou  alteração  na  tabela 
GameServer somente entre os dias 01 e 10 de cada mês. Quando a operação estiver fora desse 
intervalo uma mensagem via raiserror deve ser exibida e a operação deve ser cancelada.  */

GO
CREATE OR ALTER TRIGGER tgrValidateIntervalDate
ON GameServer
AFTER INSERT, UPDATE
AS
BEGIN
	DECLARE @today INT;
	SELECT @today = day(CreationDate) FROM INSERTED;
	IF (@today >= 10)
	BEGIN
		RAISERROR('Cadastro somente até o dia 10 de cada mês!', 10, 1)
		ROLLBACK
	END
END

SET DATEFORMAT DMY
INSERT INTO GameServer VALUES('ZORO', 'Peer-to-Peer', '12-08-2021', 2);
SELECT * FROM GameServer

/* 3. Criar  uma  trigger  (gatilho)  que  permita  a  realização  de  exclusão  na  tabela  GameServer 
somente entre os dias 20 e 30 de cada mês. Quando a operação estiver fora desse prazo uma 
mensagem via raiserror deve ser exibida e a operação deve ser cancelada. */

GO
CREATE OR ALTER TRIGGER tgrValidateIntervalDateDelete
ON GameServer
AFTER DELETE
AS
BEGIN
	DECLARE @today INT;
	SELECT @today = day(CreationDate) FROM INSERTED;
	IF (@today <= 20)
	BEGIN
		RAISERROR('Deleções somente a partir do dia 20 de cada mês!', 10, 1)
		ROLLBACK
	END
END

SET DATEFORMAT DMY
DELETE FROM GameServer WHERE IDGameServer = 29
SELECT * FROM GameServer

/* 4. Criar uma trigger (gatilho) que verifica no momento da inclusão de um GameServer se a data 
de  criação  (CreationDate)  está  dentro  do  ano  atual.  Caso  não  esteja  a  operação  deve  ser 
cancelada (rollback). */

GO
CREATE OR ALTER TRIGGER tgrValidateIntervalDateDelete
ON GameServer
AFTER INSERT
AS
BEGIN
	DECLARE @today INT;
	SELECT @today = day(CreationDate) FROM INSERTED;
	IF (@today != year(getDate()))
	BEGIN
		RAISERROR('Inserções devem ser feitas no ano atual!', 10, 1)
		ROLLBACK
	END
END

SET DATEFORMAT DMY
INSERT INTO GameServer VALUES('ZORO', 'Peer-to-Peer', '09-08-2019', 2);
SELECT * FROM GameServer

/* 5. Criar uma trigger (gatilho) que verifica no momento da atualização do player ser o valor dos 
Points  está  nulo  (null)  ou  negativo.  Quando  isso  ocorrer  a  operação  deve  ser  cancelada 
(rollback). */

GO
CREATE OR ALTER TRIGGER tgrValidatePointsNotNull
ON Player
AFTER UPDATE
AS
BEGIN
	DECLARE @points INT;
	SELECT @points = Points FROM INSERTED;
	IF (@points <= 0)
	BEGIN
		RAISERROR('Valor inválido!', 10, 1)
		ROLLBACK
	END
END

UPDATE Player SET Points = -5 WHERE IDPlayer = 7;
SELECT * FROM Player

/* 6. Criar  uma  trigger  (gatilho)  para  gravar  na  tabela  de  log  (LogData)  todas  as  alterações 
(update)  realizados  na tabela  GameServer.  No  campo  Detalhes  deve  conter  o  valor  antigo  e 
atual do IP e Type do GameServer. */

GO
CREATE OR ALTER TRIGGER tgrNewTGTable
ON GameServer
AFTER UPDATE
AS
BEGIN
	INSERT INTO LogData (TableLog, Operation, Details, DateEvent) 
		SELECT 'Tabela GameServer', 'UPDATE', 'IP Antigo: ' + IP + 'Type: ' + Type, getDate()
		FROM INSERTED
END

UPDATE GameServer SET IP = 'Chumbo' WHERE IDGameServer = 30;
SELECT * FROM GameServer
SELECT * FROM LogData

/* 7. Criar  uma  trigger  (gatilho)  para  gravar  na  tabela  de  log  (LogData)  todas  as  exclusões 
realizadas  na  tabela  Player.  No  campo  Detalhes  deve  conter  o  Name  e  UserName  do  player 
excluído. */

GO
CREATE OR ALTER TRIGGER tgrNewTGTablePlayer
ON Player
AFTER DELETE
AS
BEGIN
PRINT 'ENTROU'
	INSERT INTO LogData (TableLog, Operation, Details, DateEvent) 
		SELECT 'Tabela Player', 'DELETE', 'Nome Antigo: ' + Name + 'Usuário antigo: ' + UserName, getDate()
		FROM DELETED
END

DELETE FROM Player WHERE IDPlayer = 7
SELECT * FROM Player
SELECT * FROM LogData