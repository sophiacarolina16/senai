-- Active: 1788436126633@@127.0.0.1@3308@smartcoffee_dml_sophia
AULA_10_-_TCL_ATIVIDADE.sql
100%
-- ATIVIDADE PRATICA - AULA 10
-- Aluno(a): Sophia Carolina Soares da Cunha
-- Regra: valide sempre antes de COMMIT.

-- 01. Consulte produto 2 e seu preço.
START TRANSACTION;

SELECT nome, preco 
FROM produto
WHERE id_produto = 2;

COMMIT;

-- 02. START TRANSACTION e aumente produto 2 em R$3,00.
START TRANSACTION;
UPDATE produto
SET preco = preco + 3.00
WHERE id_categoria = 2;

COMMIT;

-- 03. Consulte dentro da transação.
SELECT * FROM produto;

-- 04. ROLLBACK.
ROLLBACK;

-- 05. Consulte e comprove retorno.

SELECT nome, preco FROM produto WHERE id_produto = 2;

-- 06. Repita a alteração e finalize com COMMIT.
UPDATE produto SET preco = preco + 3.00 WHERE id_produto = 2;
SELECT nome, preco FROM produto WHERE id_produto = 2;
COMMIT;

-- 07. START TRANSACTION e aumente produto 3 em 10%.
START TRANSACTION;
UPDATE produto
SET preco = preco +(preco* 0.1)
WHERE id_categoria = 3;

-- 08. SAVEPOINT ajuste_produto3.
SAVEPOINT ajuste_produto3;
-- 09. Aumente produto 4 em 50%.

UPDATE produto
SET preco = preco +( preco* 0.5)
WHERE id_categoria = 4;
-- 10. Consulte os dois.
SELECT id_produto, nome, preco FROM produto WHERE id_produto IN (3, 4);


-- 11. ROLLBACK TO SAVEPOINT ajuste_produto3.
ROLLBACK TO SAVEPOINT ajuste_produto3;

-- 12. COMMIT e explique em comentário qual alteração permaneceu.
COMMIT;
-- A UNICA ALTERAÇÃO QUE CONTINUOU FOI A DE AUMENTAR A 3 EM 10%, POIS FOI DEFINIDO QUE TODA VEZ QUE RESETA ELE VOLTA PARA ESSE SAVEPOINT


-- 13. START TRANSACTION.

START TRANSACTION;

-- 14. Crie pedido para cliente 1 e salve o id em @novo_pedido.


INSERT INTO pedido (data_pedido,valor_total, status_pedido,id_cliente) VALUES (NOW(),15.00, 'aberto', 1);
SET @novo_pedido = LAST_INSERT_ID();
-- 15. Insira dois itens válidos.
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario) 
VALUES (@novo_pedido, 1, 1, (SELECT preco FROM produto WHERE id_produto = 1));

INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario) 
VALUES (@novo_pedido, 2, 1, (SELECT preco FROM produto WHERE id_produto = 2));
-- 16. Registre pagamento válido.
INSERT INTO pagamento (id_pedido, valor, forma_pagamento, status_pagamento) 
VALUES (@novo_pedido, 25.00, 'CARTÃO', 'APROVADO');

-- 17. Consulte pedido, itens e pagamento.
SELECT * FROM pedido WHERE id_pedido = @novo_pedido;
SELECT * FROM item_pedido WHERE id_pedido = @novo_pedido;
SELECT * FROM pagamento WHERE id_pedido = @novo_pedido;
-- 18. COMMIT.
COMMIT;

-- 19. START TRANSACTION e crie pedido para cliente 2.
START TRANSACTION;

-- 20. Salve o id em @pedido_com_erro.

-- 21. Tente inserir item com id_produto inexistente.

-- 22. Após observar a FK, ROLLBACK.

-- 23. Consulte @pedido_com_erro e comprove que não permaneceu.

-- 24. Tente excluir uma categoria que possui produtos.
-- Explique em comentário por que foi bloqueado.

-- 25. Crie em uma transação um pedido temporário com dois itens,
-- exclua o pedido e observe ON DELETE CASCADE.
-- Finalize com ROLLBACK para preservar a base.

-- DESAFIO EXTRA - CAIXA DO SMARTCOFFEE
-- Em UMA transação:
-- a) pedido; b) 3 itens; c) baixa de estoque;
-- d) SAVEPOINT; e) pagamento; f) status FINALIZADO;
-- g) consultas; h) COMMIT.