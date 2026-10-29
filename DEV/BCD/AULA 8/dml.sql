-- Active: 1788436126633@@127.0.0.1@3308@smartcoffee_dml_sophia
--- BANCO DE DADOS - SMARTCOFFEE - DML

DROP DATABASE IF EXISTS SMARTCOFFEE_DML_SOPHIA;

CREATE DATABASE IF NOT EXISTS SMARTCOFFEE_DML_SOPHIA;

USE SMARTCOFFEE_DML_SOPHIA;

CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(120) UNIQUE,
    telefone VARCHAR(15),
    cidade VARCHAR(60) NOT NULL,
    ativo BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE categoria (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    id_categoria INT NOT NULL,
    CONSTRAINT fk_categoria FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

CREATE TABLE pedido (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    data_pedido DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    valor_total DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    status_pedido ENUM('ABERTO', 'PREPARANDO', 'FINALIZADO', 'CANCELADO') NOT NULL DEFAULT 'ABERTO',
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE item_pedido (
    id_item INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 1,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    observacao VARCHAR(150),
    CONSTRAINT fk_item_pedido FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    CONSTRAINT fk_item_produto FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

CREATE TABLE forma_pagamento (
    id_forma_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE pagamento (
    id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_forma_pagamento INT NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    data_pagamento DATETIME,
    CONSTRAINT fk_pagamento_pedido FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    CONSTRAINT fk_forma_pagamento FOREIGN KEY (id_forma_pagamento) REFERENCES forma_pagamento(id_forma_pagamento)
);



INSERT INTO cliente (nome, email, telefone, cidade, ativo) VALUES 
('Luis Felipe', 'luis@email.com', '1999999991', 'Limeira', TRUE),
('Maria Eduarda', 'maria@email.com', '1999999992', 'Limeira', TRUE),
('Mateus Silva', 'mateus@email.com', '1999999993', 'Limeira', TRUE),
('Matheus Oricolli', 'matheus@email.com', '1999999994', 'Limeira', TRUE),
('Nicolas Filipe', 'nicolas@email.com', '1999999995', 'Limeira', TRUE),
('Otavio Correia', 'otavio@email.com', '1999999996', 'Conchal', TRUE),
('Pedro Mirando', 'pedro@email.com', '1999999997', 'Berlim', TRUE),
('Rafael Viera', 'rafael@email.com', NULL, 'Limeira', TRUE),
('Rebecca', 'rebecca@email.com', NULL, 'Limeira', TRUE),
('Rennan Campos', 'rennan@email.com', '1999999998', 'Americanas', TRUE),
('Samira Dalosto', 'samira@email.com', NULL, 'Ourinhos', TRUE),
('Sophia Carolina', 'sophia@email.com', '1999999911', 'Taubate', TRUE),
('Stefany Santanas', 'stefany@email.com', NULL, 'Ourinhos', FALSE),
('Vanessa Queiroz', 'vanessa@email.com', '1999999912', 'Limeira', TRUE),
('Vinicius OlhoVerde', 'viniciusv@email.com', '1999999913', 'Limeira', TRUE),
('Vinicius OlhoAzul', 'viniciusa@email.com', '1999999914', 'Chicago', TRUE);


SELECT * FROM   cliente;

INSERT INTO categoria (nome) VALUES
('Cafe'), ('Bebidas Quentes'), ('Bebidas Frias'), ('Doces'), ('Salgados'), ('Combo');


INSERT INTO produto (nome, descricao, id_categoria, preco, ativo) VALUES 
('Capuchino', 'Café com leite vaporizado e espuma de leite', 1, 5.00, TRUE),
('Café Expresso', 'Café puro, concentrado e tirado na hora', 1, 4.00, TRUE),
('Mocaccino', 'Café espresso, leite vaporizado, calda de chocolate e chantilly', 1, 8.50, TRUE),
('Chocolate Quente', 'Chocolate quente com leite e canela', 2, 6.00, TRUE),
('Soda Italiana de Maçã Verde', 'Bebida refrescante com xarope artesanal e água com gás', 3, 9.00, TRUE),
('Suco Natural de Laranja', 'Suco 100% natural, espremido na hora (500ml)', 3, 7.50, TRUE),
('Slice Cake de Cenoura', 'Fatia de bolo de cenoura com cobertura de brigadeiro', 4, 9.50, TRUE),
('Tapioca Romeu e Julieta', 'Tapioca com recheio de goiabada e queijo', 4, 10.00, FALSE),
('Pão de Queijo', 'Pão de queijo tradicional mineiro', 5, 7.00, TRUE),
('Croissant de Presunto e Queijo', 'Massa folhada artesanal recheada com presunto e queijo', 5, 8.50, TRUE),
('Combo Matinal', 'Café expresso + pão de queijo', 6, 9.50, TRUE);



INSERT INTO pedido (id_cliente, data_pedido, status_pedido, valor_total) VALUES 
(1, '2026-09-14 10:00:00', 'ABERTO', 10.00),
(2, '2026-09-14 11:00:00', 'PREPARANDO', 6.00),
(3, '2026-09-14 12:00:00', 'FINALIZADO', 7.00),
(4, '2026-09-14 13:00:00', 'CANCELADO', 25.00);

SET @pedido = LAST_INSERT_ID();
SELECT @pedido;

INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario, observacao) VALUES 
(1, 1, 2, 5.00, 'Sem açúcar'),
(2, 2, 1, 6.00, 'Quente'),
(3, 3, 1, 7.00, 'Com recheio'),
(4, 4, 1, 10.00, 'Sem recheio');

INSERT INTO forma_pagamento (nome) VALUES 
('Dinheiro'), ('Cartão de Crédito'), ('Cartão de Débito'), ('Pix');

INSERT INTO pagamento (id_pedido, id_forma_pagamento, valor, data_pagamento) VALUES 
(1, 1, 10.00, '2026-09-14 10:05:00'),
(2, 2, 6.00, '2026-09-14 11:05:00'),
(3, 3, 7.00, '2026-09-14 12:05:00'),
(4, 4, 25.00, '2026-09-14 13:05:00');

--Atualização e modificações de dados

-- Experimento 1
UPDATE cliente SET telefone = '19999999801' WHERE id_cliente = 11;

-- Experimento 2
UPDATE produto SET preco = 1.00;
-- nunca fazer um update sem where, pois ele vai atualizar todos os registros da tabela

-- Experimento 3
update cliente
SET telefone = '1992000000'
cidade= 'Valinhos'
WHERE id_cliente_= 9;


experimento 4
UPDATE produto
SET preco = 1.05
WHERE id_produto = 1;

experimento 5
UPDATE produto
SET preco = CASE 
    WHEN preco < 10 THEN preco * 1.10
    ELSE preco * 1.05
END
WHERE ativo = TRUE;


--APAGAR DADOS DO BANCO DE DADOS

--exp1
DELETE FROM cliente WHERE id_cliente = 9;

--exp2
DELETE FROM cliente WHERE ativo = FALSE;

--exp3
DELETE FROM cliente WHERE cidade = 'Chicago';

--exp4
UPDATE cliente SET ativo = FALSE WHERE id_cliente = 10;
