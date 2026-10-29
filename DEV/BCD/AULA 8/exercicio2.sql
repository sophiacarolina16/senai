-- TRANSAÇÕES - SEGURANÇA PARA DML --

START TRANSACTION;
UPDATE produto
SET preco = preco * 2.80
WHERE id_categoriA = 1;

SELECT id_produto, nome, preco
FROM produto
WHERE id_categoria = 1;

-- DESFAZ O QUE FIZEMOS ERRADO OU VOLTA UMA TRANSAÇÃO
ROLLBACK;
-- VALIDA O PROCEDIMENTO DE TRANSAÇÃO
COMMIT;

START TRANSACTION;
UPDATE cliente SET cidade = 'Limeira' WHERE id_cliente = 181;
SELECT * FROM cliente WHERE id_cliente = 181;
COMMIT;

-- PROCEDIMENTO DE UMA COMPRA
-- PASSO 1: Cadastrar o cliente
INSERT INTO cliente (nome, email, telefone, cidade, ativo) VALUES (
'Sonia Bernardes', 'sonia.bern@gmail.com', '199999999999915', 'Limeira', TRUE);
SET @cliente_compra = LAST_INSERT_ID();

-- PASSO 2: Criar o pedido para este cliente (FALTAVA ESSE BLOCO!)
INSERT INTO pedido (data_pedido, status, valor_total, id_cliente)
VALUES (NOW(), 'ABERTO', 0.00, @cliente_compra);
SET @pedido_compra = LAST_INSERT_ID(); -- Aqui a variável ganha um valor real!

-- PASSO 3: INSERINDO ITENS (Agora o @pedido_compra não será NULL)
-- Nota: mudei o id_produto de 9 para 5, pois sua tabela só vai até o produto 5.
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (@pedido_compra, 4, 1, 13.00), (@pedido_compra, 5, 1, 9.00);

-- PASSO 4 - ATUALIZANDO TOTAL E STATUS
UPDATE pedido
SET valor_total = 22.00,
    status = 'PREPARANDO'
WHERE id_pedido = @pedido_compra;

-- PASSO 5 - REGISTRAR PAGAMENTO
INSERT INTO pagamento (id_pedido, id_forma_pagamento, valor, data_pagamento)
VALUES (@pedido_compra, 2, 22.00, NOW());

-- PASSO 6 - CONSULTAR PEDIDO E RESULTADO
SELECT p.id_pedido,
       c.nome AS cliente,
       p.status AS Status Pedido,
       p.valor_total AS Compra_Total
FROM pedido p
JOIN cliente c ON c.id_cliente = p.id_cliente
WHERE p.id_pedido = @pedido_compra;

-- PASSO 7 - RELATÓRIO
SELECT nome FROM cliente WHERE id_cliente = @cliente_compra;
SELECT nome FROM cliente WHERE id_cliente = 181;

-- PASSO 2
SELECT * FROM pedido WHERE id_pedido = @pedido_compra;