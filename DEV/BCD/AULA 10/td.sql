-- Active: 1788436126633@@127.0.0.1@3308@smartcoffee_dml_sophia
-- TCL - Transações e Integridade 
-- Sem transação: parte do processo ira permanecer gravado 
-- Com transação:podemos confirmar ou desfazer o processo inteiro 


-- Estrutura de Transação

BEGIN TRANSACTION
--Comandos SQL

COMMIT; --Confirma a Transação
--ou
ROLLBACK; --Desfaz a Transação

--Processo Inicial

INSERT INTO cliente(nome, email, telefone, cidade, ativo) VALUES ('C. Ronaldo', 'cronaldo@email.com', '1692292992', 'Funchal',TRUE)

SELECT nome FROM cliente

-- EX 1: COMMIT

--Confirma as alterações dentro da transação

START TRANSACTION;
SET produto
SET preco = 8.50,
WHERE id_produto = 1;

COMMIT;

-- EX 2: ROLLBACK

-- DESFAZ AS ALTERAÇÕES AINDA NÃO CONFIRMADAS

START TRANSACTION

UPDATE produto
SET preco = 5000.00
WHERE id_produto = 1;

SELECT * FROM produto WHERE id_produto = 1;
ROLLBACK;

--EX 3: SAVEPOINT

--CRIAR UM PONTO DENTRO DE UMA TRANSAÇÃO
START TRANSACTION;
UPDATE produto
SET preco = preco * 1.50
WHERE id_categoria = 1;

SAVEPOINT reajuste_cafes;

UPDATE produto
SET preco = preco * 2.00
WHERE id_categoria = 4;
ROLLBACK TO SAVEPOINT reajuste_cafes;
COMMIT;

--EX 4: RELEASE SAVEPOINT

--Remove o savepoint da transação

RELEASE SAVEPOINT reajuste_cafes;


--EX 5: Autocommit

SELECT @@autocommit;

--Ativo por padrão no mysql

START TRANSACTION;

--dmls relacionadas

COMMIT;

--EX 6: TRANSAÇÕES NAO SUBSTITUI CONSTRAINT


CREATE TABLE cliente(
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(60),
    telefone VARCHAR(15),
    cidade VARCHAR(60),
    ativo BOOLEAN DEFAULT TRUE,


    CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE CASCADE ON UPDATE CASCADE
);

--SEMPRE CHECAR A QUANTIDADE E SE ABAIXO DE 0 OU IGUAL QUE 0 SINALIZAR
CONSTRAINT ck_estoque_quantidade CHECK (quantidade>=0);

SELECT * FROM cliente;


--EXEMPLO COM UTILIZAÇÃO

CREATE TABLE estoque (
    id_estoque INT AUTO_INCREMENT,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 0,
    CONSTRAINT pk_estoque PRIMARY KEY (id_estoque), -- chave primaria
    CONSTRAINT uq_estoque_produto UNIQUE(id_produto), -- chave unica
    CONSTRAINT ck_estoque_quantidade CHECK( quantidade >= 0), -- checar ou validar uma operação
    CONSTRAINT fk_estoque_produto FOREIGN KEY (id_produto) --chave estrangeira
    REFERENCES produto (id_produto) ON UPDATE CASCADE ON DELETE RESTRICT
);

INSERT INTO estoque(id_produto, quantidade) VALUES (1,50),(2,40),(3,30);
INSERT INTO estoque(id_produto, quantidade) VALUES (2,-1);-- sem o check esse codigo funcionaria

select * from estoque;


--EX 7: Fluxo seguro para update/delete
-- exclusão fisica

delete from produto
where id_produto = 11;

--exclusão logica

update produto
set ativo = FALSE
where id_produto = 10;

select * from produto

start transaction;
update produto
set preco = 15.50
where id_produto = 3;


select * from produto where id_produto = 3;

commit;


--rollback;

-- EX 8: Pedido completo com transação

start transaction;
select * from pedido


INSERT INTO pedido (data_pedido, status_pedido, valor_total, id_cliente) 
VALUES (NOW(), 'aberto', 0.00, 2);

SET @pedido = LAST_INSERT_ID();

INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario) 
VALUES 
    (@pedido, 1, 2, 7.50), 
    (@pedido, 1, 2, 8.50);

insert into pagamento(id_pedido, valor, id_forma_pagamento) VALUES (@pedido, 23.00,2);

commit;


--EX 9: PEDIDO COMPLETO COM TRANSIÇÃO E ROLLBACK

START TRANSACTION;

INSERT INTO pedido(data_pedido, status_pedido,valor_total, id_cliente) values(now(), 'aberto', 0.00, 4);
set @pedido = last_insert_id();

--produto inexistente

insert into item_pedido(id_pedido, id_produto, quantidade,preco_unitario) values(@pedido, 1,999, 9.00), (@pedido,1,999,11.00);

rollback;

