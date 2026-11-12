-- Active: 1794486144748@@127.0.0.1@3308@biblioteca_senai_sophia
-- A escola Biblioteca Conecta deseja substituir planilhas e registros manuais por um banco de dados relacional capaz de controlar usuários, livros e empréstimos. Sua missão é desenvolver a primeira versão do banco, desde sua criação até operações de consulta, manipulação e controle transacional. A atividade já inicia com 3 tabelas e você deverá criar e adaptar mais 2 tabelas.

-- Criar tabelas - Usuario, Livro, Emprestimo, Categoria, Fornecedor

CREATE DATABASE IF NOT EXISTS BIBLIOTECA_SENAI_SOPHIA;


CREATE TABLE USUARIO (
    ID_USUARIO INT AUTO_INCREMENT,
    NOME VARCHAR(100) NOT NULL,
    EMAIL VARCHAR(120) NOT NULL UNIQUE,
    TELEFONE VARCHAR(20),
    CIDADE VARCHAR(80),
    ATIVO BOOLEAN DEFAULT TRUE,
    CONSTRAINT PK_USUARIO PRIMARY KEY(ID_USUARIO)
    CONSTRAINT UQ_EMAIL UNIQUE (EMAIL)
);

CREATE TABLE LIVRO (
    ID_LIVRO INT AUTO_INCREMENT,
    TITULO VARCHAR(200) NOT NULL,
    AUTOR VARCHAR(100) NOT NULL,
    ANO_PUBLICACAO INT,
    ID_CATEGORIA INT NOT NULL,
    ID_FORNECEDOR INT NOT NULL,
    ATIVO BOOLEAN DEFAULT TRUE,
);