

START TRANSACTION;
UPDATE produto
SET preco = preco * 2.80
WHERE id_categoriA = 1;

SELECT id_produto, nome, preco
FROM produto
WHERE id_categoria = 1;


ROLLBACK;

COMMIT;

START TRANSACTION;
UPDATE cliente SET cidade = 'Limeira' WHERE id_cliente = 181;
SELECT * FROM cliente WHERE id_cliente = 181;
COMMIT;


INSERT INTO cliente (nome, email, telefone, cidade, ativo) VALUES (
'Sonia Bernardes', 'sonia.bern@gmail.com', '199999999999915', 'Limeira', TRUE);
SET @cliente_compra = LAST_INSERT_ID();


INSERT INTO pedido (data_pedido, status, valor_total, id_cliente)
VALUES (NOW(), 'ABERTO', 0.00, @cliente_compra);
SET @pedido_compra = LAST_INSERT_ID(); 


INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (@pedido_compra, 4, 1, 13.00), (@pedido_compra, 5, 1, 9.00);


UPDATE pedido
SET valor_total = 22.00,
    status = 'PREPARANDO'
WHERE id_pedido = @pedido_compra;


INSERT INTO pagamento (id_pedido, id_forma_pagamento, valor, data_pagamento)
VALUES (@pedido_compra, 2, 22.00, NOW());


SELECT p.id_pedido,
       c.nome AS cliente,
       p.status AS Status Pedido,
       p.valor_total AS Compra_Total
FROM pedido p
JOIN cliente c ON c.id_cliente = p.id_cliente
WHERE p.id_pedido = @pedido_compra;


SELECT nome FROM cliente WHERE id_cliente = @cliente_compra;
SELECT nome FROM cliente WHERE id_cliente = 181;

SELECT * FROM pedido WHERE id_pedido = @pedido_compra;
