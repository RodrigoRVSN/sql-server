/* 1.Criar uma Stored Procedure para realizar a inser��o de informa��es na tabela GameServer, os valores  dever�o  ser  informados  viapar�metro.  Dever�  ser  aplicado  o  procedimento  de tratamento de erro no processo. */

CREATE OR ALTER PROCEDURE gsInsertInfo
	@IP varchar(20), @Type varchar(30), @DNSServer int
AS
BEGIN
	BEGIN TRY
		INSERT INTO GameServer(IP, Type, CreationDate, DNSServer)
		VALUES (@IP, @Type, GETDATE(), @DNSServer)
	END TRY

	BEGIN CATCH
		PRINT 'Errou a� amig�o!'
		PRINT cast(ERROR_NUMBER() as varchar) + ' - ' + ERROR_MESSAGE()
	END CATCH
END

EXEC gsInsertInfo @IP='Moryo Kujou', @Type="Dom�nio", @DNSServer=8

/* 2. Criar  uma Stored  Procedurepararealizar  a  inser��o  de  informa��es  na  tabela  Player,  os valores  dever�o  ser  informados  via  par�metro.  Dever�  ser  aplicado  o  procedimento  de tratamento de erro no processo. Al�m disso, uma mensagem de erro customizada/personalizada deve ser exibida. */

SELECT * FROM Player

GO
CREATE OR ALTER PROCEDURE plInsertInfo
	@Name varchar(20), @UserName varchar(30), @Password varchar(30), @Points int, @IDGameServer int
AS
BEGIN
	BEGIN TRY
		INSERT INTO Player(Name, UserName, Password, Points, IDGameServer)
		VALUES (@Name, @UserName, @Password, @Points, @IDGameServer)
	END TRY

	BEGIN CATCH
		RAISERROR ('Errou a� amig�o!', 13, 1)
		PRINT cast(ERROR_NUMBER() as varchar) + ' - ' + ERROR_MESSAGE()
	END CATCH
END
GO

EXEC plInsertInfo @Name='Moryo Kujou', @UserName = "Dom�nio", @Password="Pericles", @Points = 5000, @IDGameServer = 2

/* 3. Criar uma Stored Procedurepararealizar a exclus�o de um GameServer atrav�s do ID que ser� informado  via  par�metro.  Dever�  ser  aplicado  o  procedimento  de  tratamento  de  erro  no processo. Al�m disso, uma mensagem de erro customizada/personalizada deve ser exibida. */

SELECT * FROM GameServer

GO
CREATE OR ALTER PROCEDURE plInsertInfo
	@IDGameServer int
AS
BEGIN 
	BEGIN TRY
	BEGIN TRANSACTION
		DELETE FROM GameServer WHERE IDGameServer = @IDGameServer
		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		RAISERROR ('Errou a� amig�o!', 13, 1)
		PRINT cast(ERROR_NUMBER() as varchar) + ' - ' + ERROR_MESSAGE()
		ROLLBACK TRANSACTION
	END CATCH
END
GO

EXEC plInsertInfo @IDGameServer = 8
GO

/* 4. Criar  uma Stored  Procedure para  atualizar  o  valor  dos  Points  da  tabela  Player.  Dever�  ser informado  o  IDPlayer  e  a  nova  quantidade  de  Points a  ser  adicionada  ou  subtra�da.  A quantidade sempre deve ser positiva e menor do que 1000 (mil). Caso a nova quantidade n�o atenda  esses  requisitos  a  opera��o  deve  ser  �desfeita�  e  uma  mensagem  de  erro customizada/personalizada deve ser exibida. */


GO
CREATE OR ALTER PROCEDURE plUpdatePoints @IDPlayer int, @Points int
AS
BEGIN 
	DECLARE @NewValue int;
	BEGIN TRY
		BEGIN TRAN MyTransaction
		UPDATE Player SET Points = Points + @Points WHERE IDPlayer = @IDPlayer
		SET @NewValue = (SELECT Points FROM Player WHERE IDPlayer = @IDPlayer)
		PRINT 'NOVO: ' + cast(@NewValue as varchar);

		IF @NewValue BETWEEN 0 AND 1000
			COMMIT
		ELSE 
			ROLLBACK
	END TRY
	BEGIN CATCH
		PRINT cast(ERROR_NUMBER() as varchar) + ' - ' + ERROR_MESSAGE()
		RAISERROR ('Valor deve ser > 0 e < 1000.', 16, 1)
	END CATCH
END
GO

EXEC plUpdatePoints @IDPlayer = 80, @Points = 900
GO
SELECT * FROM Player
