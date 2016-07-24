-- Gera��o de Modelo f�sico
-- Sql ANSI 2003 - brModelo.



CREATE TABLE Taxas (
id int PRIMARY KEY AUTO_INCREMENT,
ano int,
serie varchar(255),
tipo varchar(255),
escola_id int
);

CREATE TABLE Escolas (
id int PRIMARY KEY AUTO_INCREMENT,
rede varchar(255),
nome varchar(255),
localizacao varchar(255),
municipio_id int
);

CREATE TABLE Estados (
uf varchar(255) PRIMARY KEY,
nome varchar(255),
regiao varchar(255),
bandeira blob
);

CREATE TABLE Terceirizadas (
id int PRIMARY KEY AUTO_INCREMENT,
tipo_servico varchar(255),
nome varchar(255)
);

CREATE TABLE TerceirizadaEscola (
terceirazada_id int,
escola_id int,
PRIMARY KEY(terceirazada_id,escola_id),
FOREIGN KEY(terceirazada_id) REFERENCES Terceirizadas (id),
FOREIGN KEY(escola_id) REFERENCES Escolas (id)
);

CREATE TABLE Telefones (
id int PRIMARY KEY AUTO_INCREMENT,
codigo int,
numero int,
escola_id int,
FOREIGN KEY(escola_id) REFERENCES Escolas (id)
);

CREATE TABLE Municipios (
id int PRIMARY KEY AUTO_INCREMENT,
nome varchar(255),
populacao int,
estado_id varchar(255),
FOREIGN KEY(estado_id) REFERENCES Estados (uf)
);

ALTER TABLE Taxas ADD FOREIGN KEY(escola_id) REFERENCES Escolas (id);
ALTER TABLE Escolas ADD FOREIGN KEY(municipio_id) REFERENCES Municipios (id);
