/*
	Rodrigo Victor da Silva Nascimento	RA 200897
	Letícia Rodrigues Nepomucena Lopes	RA 200592
	Natanael Filipe Garcia Vitorino		RA 200032


	AC1 –Atividade 1: Comandos DDL +DML+ SELECT	

	1. Criar as tabelas do modeloERindicado abaixo.
	Crias as restrições solicitadas (not null, identity).
	Criar os relacionamentos necessários (chaves primárias e chaves estrangeiras). */


CREATE TABLE Habilidade(
	IDHabilidade int NOT NULL identity,
	Nome varchar(200) NOT NULL,
	CONSTRAINT PKIDHabilidade PRIMARY KEY (IDHabilidade),
);

CREATE TABLE Classe(
	IDClasse int NOT NULL identity,
	Nome varchar(100) NOT NULL,
	Caracteristicas varchar(1000),
	IDHabilidade int NOT NULL,
	CONSTRAINT PKIDClasse PRIMARY KEY (IDClasse),
	CONSTRAINT FKIDHabilidade FOREIGN KEY (IDHabilidade) REFERENCES Habilidade(IDHabilidade)
);

CREATE TABLE Raça(
	IDRaça int NOT NULL identity,
	Nome varchar(100) NOT NULL,
	Descrição varchar(500),
	Origem varchar(150) NOT NULL,
	Perdido datetime NOT NULL,
	CONSTRAINT PKIDRaça PRIMARY KEY (IDRaça),
);

CREATE TABLE Personagem(
	IDPersonagem int NOT NULL identity,
	Nome varchar(100) NOT NULL,
	Descrição varchar(500) NOT NULL,
	DataNascimento datetime NOT NULL,
	IDRaça int NOT NULL,
	IDClasse int NOT NULL,
	CONSTRAINT PKIDPersonagem PRIMARY KEY (IDPersonagem),
	CONSTRAINT FKIDClasse FOREIGN KEY (IDClasse) REFERENCES Classe(IDClasse),
	CONSTRAINT FKIDRaça FOREIGN KEY (IDRaça) REFERENCES Raça(IDRaça)
);

/*	2. Adicionar na tabela Habilidade o campo Poder do tipo int.	*/

ALTER TABLE Habilidade ADD Poder int not null;

/*	3. Alterar o campo Características da tabela Classe para varchar(500).		*/

ALTER TABLE Classe ALTER COLUMN Caracteristicas varchar(500);

/*	4. Excluir o campo Perdido da tabela Raça	*/

ALTER TABLE Raça DROP COLUMN Perdido;


/*	5. Inserir pelo menos 3 (três) linhas de dados para cada uma das tabelas (atenção para a ordem 
de inserção nas tabelas).*/
SET DATEFORMAT YMD
INSERT INTO Habilidade VALUES
	('Fogo', 2),
	('Gelo', 3),
	('Vento', 102)

SELECT * FROM Habilidade

INSERT INTO Classe VALUES
	('Leticia', 'Arqueira',3),
	('Natanael', 'Guerreiro', 2),
	('Rodrigo', null, 1)

SELECT * FROM Classe;

INSERT INTO Raça VALUES
	('Leticia', 'A mira nunca falha', 'Elfa'),
	('Natanael', 'Agilidade e força sao o destaque', 'Humano'),
	('Rodrigo', 'Bom em realizar feiticos', 'Goblin')

SELECT * FROM Raça

INSERT INTO Personagem   VALUES
	('Big Tux', 'Pinguim do Linux', '2001-08-20', 1, 2),
	('Crash Big', 'Raposa Corredora', '1991-08-20', 3,1),
	('Big Mario', 'Jogo de Nitendo', '1991-08-20', 2, 3 )

SELECT * FROM Personagem

/*	6. Atualizar as Caracteristicas da tabela Classe para “Características Gerais” quando o seu valor 
estiver null.*/

UPDATE Classe SET Caracteristicas = 'Caracteristicas Gerais' WHERE Caracteristicas IS null;
SELECT * FROM Classe;

/*	7. Excluir todos os Personagens com ano de nascimento (DataNascimento) entre 1970 e 1990.*/

DELETE FROM Personagem WHERE DataNascimento BETWEEN '1970' AND '1990';

/*	8.Selecionar todas as informações da tabela Personagem.	*/

SELECT * FROM Personagem;

/*	9.Selecionar  o  Nome  e  Poder  da  tabela Habilidade  quando  o  valor  do  poder  estiver  entre  0  e 100.	*/

SELECT Nome, Poder FROM Habilidade WHERE Poder BETWEEN 0 AND 100

/*	10.Selecionar  o  Nome, Descrição  e  Data  de  Nascimentos  da  tabela  Personagem quando  o  nome possuir“Big” 
(em qualquer parte do texto) e o ano de nascimento estiver entre 1990 e 2000.	*/

SELECT Nome, Descrição, DataNascimento FROM Personagem WHERE Nome LIKE '%Big%' AND YEAR(DataNascimento) BETWEEN 1990 AND 2000

