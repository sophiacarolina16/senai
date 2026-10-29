-- Active: 1788436126633@@127.0.0.1@3308@smartcoffee_dml_sophia


--Parte A
--cadastre dois novos clientes, cadastre uma nova categoria Especiais da Casa, insira um dos clientes cadastrados, use last_insert_id() para inserir pelo menos dois itens no pedido.

DROP DATABASE IF EXISTS smartcoffee_dml_sophia;
CREATE DATABASE IF NOT EXISTS smartcoffee_dml_sophia;
USE smartcoffee_dml_sophia;

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


INSERT INTO cliente (nome, email, telefone, cidade) VALUES
('Ana Silva', 'ana.silva@email.com', '11999999999', 'São Paulo'),
('Pedro Santos', 'pedro.santos@email.com', NULL, 'Belo Horizonte'),
('Julia Costa', 'julia.costa@email.com', '21988888888', 'Rio de Janeiro'), 
('Carlos Souza', 'carlos.souza@email.com', '31977777777', 'Belo Horizonte'); -- julia carlos novo

INSERT INTO categoria (id_categoria,nome) VALUES (1,'Especiais da Casa');

@categoria_especial = SELECT id_categoria FROM categoria WHERE nome = 'Especiais da Casa';
INSERT INTO produto (nome, preco, ativo, id_categoria) VALUES
('Milkshake de Caramelo', 13.50, TRUE, 1),
('torta Holandesa', 14.90, TRUE, 1),
('Soda Italiana', 10.00, TRUE, 2);


INSERT INTO pedido (id_cliente, valor_total, status_pedido) 
VALUES (3, 26.50, 'ABERTO');


INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario, observacao) VALUES 
(LAST_INSERT_ID(), 1, 1, 14.50, 'Sem açúcar'),
(LAST_INSERT_ID(), 2, 1, 12.00, 'Bem quente');


SELECT * FROM cliente;
SELECT * FROM categoria;
SELECT * FROM produto;
SELECT * FROM pedido;
SELECT * FROM item_pedido;



--Parte B
--Corrija o telefone de um dos clientes criados, altere a cidade e telefone de outro cliente em um unico comando, aumente em 8% os preços dos produtos da categoria criada, altere o status do novo pedidio para PREPARANDO, atualiza valor total do pedido para refletir os itens adcionados, desative um produto utilizando exclusão logica

UPDATE cliente SET telefone = '700000000' WHERE id_cliente = 3;

UPDATE cliente SET cidade = 'Miami' WHERE id_cliente = 4;
UPDATE cliente SET telefone = '900000000' WHERE id_cliente = 4;

UPDATE produto SET preco = preco * 1.08 WHERE id_categoria = 5;

UPDATE pedido SET status_pedido = "PREPARANDO" WHERE id_pedido =1;
UPDATE pedido SET valor_total = 5.00 WHERE id_pedido =1;

UPDATE produto SET ativo = FALSE WHERE id_produto = 4;

--Parte C
--Crie um cliente de teste que não possuia pedidos e depois exclua-o, tente excluir um cliente que possui pedidos e registre o que aconteceu, explique porque a FK protegeu o banco, crie uma categoria de teste sem produtos e depois remova-a.

INSERT INTO cliente (nome, email, telefone, cidade) 
VALUES ('Cliente Teste', 'teste@gmail.com', '11000000000', 'São Paulo');

DELETE FROM cliente WHERE email = 'teste@gmail.com';

DELETE FROM cliente WHERE id_cliente = 5;

INSERT INTO categoria (nome) VALUES ('Categoria Temporaria');

DELETE FROM categoria WHERE nome = 'Categoria Temporaria';

--Parte D
--Tente inserir um produto usando uma categoria inexistente, tente cadastrar um cliente usando um e-mail que ja existe, tente criar um pedido para um cliente inexistente, para cada erro, identifique qual restrição foi responsavel



--Parte E
--Inicie uma transação,cadastre um cliente,um pedido e dois itens relacionados, consulte os dados criados atraves do JOIN, execute ROLLBACK e prove com SELECT que os novos registros foram desfeitos, repita o proceso e finzalize com COMMMIT

