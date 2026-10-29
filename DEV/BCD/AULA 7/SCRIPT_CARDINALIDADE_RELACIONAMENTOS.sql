-- Gera��o de Modelo f�sico
-- Sql ANSI 2003 - brModelo.



CREATE TABLE cliente (
nome_cliente Texto(1),
id_cliente Auto Incremente Primary Key PRIMARY KEY
)

CREATE TABLE pedido (
Id_pedido Auto incremenet Primary Key PRIMARY KEY,
data_pedido datetime not null,
id_cliente Auto Incremente Primary Key,
FOREIGN KEY(id_cliente) REFERENCES cliente (id_cliente)
)

CREATE TABLE produto+estoque (
nome_produto varchar(100),
id_produto auto increment primary key,
id_estoque auto increment primary key,
quantidade int,
PRIMARY KEY(id_produto,id_estoque)
)


CREATE TABLE CLIENTE (
Id_cliente Auto_increment Primary Key PRIMARY KEY,
CPF varchar(100) not null,
Id_pedido int not null
)

CREATE TABLE PEDIDO (
Id_pedido Auto_increment Primary Key PRIMARY KEY,
Data_pedido datetime 
)

CREATE TABLE Relacao_2+Item_produto (
Id_produto int not null,
Id_Fornecedor int not null,
Id_item Auto_Increment Primary Key PRIMARY KEY,
Valor decimal (10,2)
)

CREATE TABLE PRODUTO (
Nome_produto varchar(100) not null,
Id_produto Auto_Increment_Primary Key PRIMARY KEY
)

CREATE TABLE FORNECEDOR (
Id_Fornecedor Auto_Increment Primary Key PRIMARY KEY,
razao_social varchar(100) not null
)

