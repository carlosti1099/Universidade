CREATE DATABASE bdCarlosImobiliaria

USE bdCarlosImobiliaria;

CREATE TABLE tbProprietario(
CodProprietario INT NOT NULL PRIMARY KEY IDENTITY (1,1),
NomeProprietario NVARCHAR (30),
Sexo CHAR(1) NOT NULL,
CPF NVARCHAR (11) UNIQUE NOT NULL,
Telefone NUMERIC (11,0) NOT NULL,
Cidade NVARCHAR (30) DEFAULT 'Campo Grande' NOT NULL,
Estado NVARCHAR (2) DEFAULT 'MS' NOT NULL);
GO

CREATE TABLE tbInquilino(
CodInquilino INT NOT NULL PRIMARY KEY IDENTITY (1, 1),
NomeInquilino NVARCHAR (30),
CPF NVARCHAR (11) UNIQUE NOT NULL,
Sexo CHAR(1) NOT NULL,
Idade TINYINT,
Cidade NVARCHAR (30) DEFAULT 'Campo Grande' NOT NULL,
Estado NVARCHAR (2) DEFAULT 'MS' NOT NULL,
Email VARCHAR(40));
GO

CREATE TABLE tbImovel(
CodImovel INT NOT NULL PRIMARY KEY IDENTITY (1,1),
Cidade NVARCHAR (30) DEFAULT 'Campo Grande' NOT NULL,
Estado NVARCHAR (2) DEFAULT 'MS' NOT NULL,
Logradouro NVARCHAR (30) NOT NULL,
CEP VARCHAR (8) NOT NULL,
ValorAluguel MONEY NOT NULL);
GO

CREATE TABLE tbFuncionario(
CodFuncionario INT NOT NULL PRIMARY KEY IDENTITY (1,1),
NomeFuncionario VARCHAR (30),
Telefone Numeric (11,0),
CPF NVARCHAR (11) UNIQUE,
Sexo CHAR(1) NOT NULL,
Endereco VARCHAR (50),
Idade TINYINT,
Email VARCHAR (100));
GO

CREATE TABLE tbImobiliaria(
CodImobiliaria INT NOT NULL PRIMARY KEY IDENTITY (1,1),
Nome NVARCHAR (50) NOT NULL,
Cidade NVARCHAR (30) default 'Campo Grande' NOT NULL,
Estado NVARCHAR (2) default 'MS' not null,
Preco money not null,
Descricao TEXT);
GO

CREATE TABLE tbLocacao(
CodLocacao INT NOT NULL PRIMARY KEY IDENTITY (1,1),
CodImobiliaria INT NOT NULL FOREIGN KEY REFERENCES tbImobiliaria(CodImobiliaria),
CodInquilino INT NOT NULL FOREIGN KEY REFERENCES tbInquilino(CodInquilino),
CodFuncionario INT NOT NULL FOREIGN KEY REFERENCES tbFuncionario (CodFuncionario),
DataLocacao DATE NOT NULL,
PrecoLocacao MONEY NOT NULL,
StatusLocacao NVARCHAR (11) CHECK (StatusLocacao in ('Active','Deactivated')));
GO

ADD Sexo nvarchar (1) check (Sexo in ('M','F'));
GO

INSERT INTO tbFuncionario 
VALUES 
('ALTAIR', '67996691234', '03999978201', 'RUA CAFELANDIA 110', '30', 'faculdade@gmail.com'),
('JEAN', '67999998878', '12345678911', 'RUA TREZE DE MAIO 200', '40', 'igt@hotmail.com');

INSERT INTO tbImobiliaria
VALUES
('MRV', 'Campo Grande', 'MS', '20000', 'Imovel'),
('VemPraCasa', 'Campo Grande', 'MS', '25000', 'Imovel2'),
('MeuImovel', 'Curitiba', 'PR', '40000', 'Imovel3'),
('MinhaCasa', 'Campo Grande', 'MS', '50.000', 'Imovel4');

INSERT INTO tbImovel
VALUES
('Campo Grande', 'MS', 'CASA', 'Rua Gandu 150', '500'),
('Campo Grande', 'MS', 'APARTAMENTO', 'Rua itatiaia 300', '600'),
('Campo Grande', 'MS', 'SUITE', 'Avenida Afonso Pena 260', '400'),
('Campo Grande', 'MS', 'CASA', 'Rua Gandu 150', '500');

INSERT INTO tbInquilino
VALUES
('SIMONE', '33345678911', '19', 'IGUATEMI', 'MS', 'simo@gmail.com'),
('Carlos', '44345678911', '20', 'IGUATEMI', 'MS', 'carlos@gmail.com'),
('Suely', '55345678911', '21', 'IGUATEMI', 'MS', 'suely@gmail.com'),
('Jessica', '22345678911', '23', 'IGUATEMI', 'MS', 'jessi@gmail.com')