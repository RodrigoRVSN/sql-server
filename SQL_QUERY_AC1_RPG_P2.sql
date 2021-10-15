/*
	Rodrigo Victor da Silva Nascimento	RA 200897
	Let�cia Rodrigues Nepomucena Lopes	RA 200592
	Natanael Filipe Garcia Vitorino		RA 200032


	AC1 � Atividade 2: Comandos Agrupamento + Totaliza��o + Jun��es
*/

/*	0.1. Criar as tabelas do modelo ER */


CREATE TABLE Habilidade(
	IDHabilidade int NOT NULL identity,
	Nome varchar(200) NOT NULL,
	Poder int,
	CONSTRAINT PKIDHabilidade PRIMARY KEY (IDHabilidade),
);

CREATE TABLE Classe(
	IDClasse int NOT NULL identity,
	Nome varchar(100) NOT NULL,
	Caracteristicas varchar(500),
	IDHabilidade int NOT NULL,
	CONSTRAINT PKIDClasse PRIMARY KEY (IDClasse),
	CONSTRAINT FKIDHabilidade FOREIGN KEY (IDHabilidade) REFERENCES Habilidade(IDHabilidade)
);

CREATE TABLE Ra�a(
	IDRa�a int NOT NULL identity,
	Nome varchar(100) NOT NULL,
	Descri��o varchar(500),
	Origem varchar(150) NOT NULL,
	CONSTRAINT PKIDRa�a PRIMARY KEY (IDRa�a),
);

CREATE TABLE Personagem(
	IDPersonagem int NOT NULL identity,
	Nome varchar(100) NOT NULL,
	Descri��o varchar(500) NOT NULL,
	DataNascimento datetime NOT NULL,
	IDRa�a int NOT NULL,
	IDClasse int NOT NULL,
	CONSTRAINT PKIDPersonagem PRIMARY KEY (IDPersonagem),
	CONSTRAINT FKIDClasse FOREIGN KEY (IDClasse) REFERENCES Classe(IDClasse),
	CONSTRAINT FKIDRa�a FOREIGN KEY (IDRa�a) REFERENCES Ra�a(IDRa�a)
);

--	0.2 - Inserir dados
SET DATEFORMAT YMD
INSERT INTO Habilidade VALUES
	('Fogo', 2),
	('Gelo', 3),
	('Vento', 102),
	('Ar', 220),
	('Terra', 155),
	('Agua', 160)

SELECT * FROM Habilidade

INSERT INTO Classe VALUES
	('Leticia', 'Arqueira',3),
	('Natanael', 'Guerreiro', 2),
	('Rodrigo', null, 1),
	('Jose', 'Soldado',4),
	('Tom', 'Infantaria', 5),
	('Alex', null, 6),
	('John', 'Soldado', 3),
	('Tom', 'Infantaria', 5),
	('Alex', null, 2)

SELECT * FROM Classe;

INSERT INTO Ra�a VALUES
	('Leticia', 'A mira nunca falha', 'Elfa'),
	('Natanael', 'Agilidade e for�a sao o destaque', 'Humano'),
	('Rodrigo', 'Bom em realizar feiticos', 'Goblin')

SELECT * FROM Ra�a

INSERT INTO Personagem   VALUES
	('Big Tux', 'Pinguim do Linux', '2001-08-20', 1, 2),
	('Crash Big', 'Raposa Corredora', '1991-08-20', 3,1),
	('Big Mario', 'Jogo de Nitendo', '2021-08-20', 2, 3 ),
	('Ubuntu', 'SO Ruim', '1981-10-20', 2, 3 )

SELECT * FROM Personagem

/*	1. Criar uma consulta para exibir a quantidade de Habilidades cadastradas. */

SELECT COUNT(*) QtdHabildiades FROM Habilidade;

/* 2. Criar uma consulta para exibir a Data de Nascimento do Personagem mais velho e mais novo */

SELECT MAX(DataNascimento) MaxCreationDate, MIN(DataNascimento) MinCreationDate FROM Personagem;


/* 3. Criar uma consulta para exibir o Nome da Classe e a quantidade de personagens associados a cada uma delas */
 
SELECT Nome, Count(*) Contagem 
FROM Classe 
GROUP BY Nome;

/* 4. Criar  uma  consulta  para  exibir  o Nome  de TODAS as  Ra�as  e  aquantidade  de  personagens associadas a cada uma delas.Quando a ra�a n�o estiver associada a nenhum personagem deve ser exibido o valor 0 (zero). */

SELECT 
	R.Nome,
	COUNT (P.IDPersonagem) Quantidade
FROM Ra�a R LEFT JOIN Personagem P 
ON R.IDRa�a = P.IDRa�a 
GROUP BY R.Nome;

/* 5. Criar uma consulta para exibir o Nome da classe e o valor m�dio dos seus poderes. 
	  Somente devem ser exibidas as classes que o valor m�dio do poder for maior ou igual a 100. */
SELECT 
	C.Nome,
	AVG(H.Poder) Media
FROM Classe C INNER JOIN Habilidade H
ON C.IDHabilidade = H.IDHabilidade
GROUP BY C.Nome
HAVING AVG(H.Poder) >= 100


/* 6. Criar uma consulta para exibir o Nome da classe e a soma do valor dos seus poderes. 
	  Somente devem ser exibidas as classes cuja a soma dos poderes esteja entre 150 e 250.*/
SELECT 
	C.Nome, SUM(H.Poder) Poder
FROM Classe C RIGHT JOIN Habilidade H
ON C.IDHabilidade = H.IDHabilidade
GROUP BY C.Nome
HAVING SUM(H.Poder) BETWEEN 150 AND 250


/* 7. Criar uma consulta para exibir o Nome e Data de Nascimento do Personagem, o Nome da sua 
	  Ra�a, o Nome da sua Classe e o Nome da sua Habilidade.  */
SELECT
	P.Nome NomePersonagem, P.DataNascimento,
	R.Nome NomeRa�a,
	C.Nome NomeClasse,
	H.Nome NomeHabilidade
FROM Personagem P INNER JOIN Ra�a R
ON P.IDRa�a = R.IDRa�a
INNER JOIN Classe C
ON P.IDClasse = C.IDClasse
INNER JOIN Habilidade H
ON C.IDHabilidade = H.IDHabilidade



