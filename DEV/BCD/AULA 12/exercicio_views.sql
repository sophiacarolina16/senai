--1. Crie vw_produtos_ativos .

CREATE VIEW vw_produtos_ativos AS
SELECT *
FROM produto
WHERE status = 'ativo';

--2. Consulte apenas produtos da view com preço maior que R$ 10,00.
SELECT *
FROM vw_produtos_ativos
WHERE preco > 10.00;

--3. Liste todas as views do banco.
SHOW FULL TABLES WHERE Table_type = 'VIEW';

--4. Exiba a definição de vw_produtos_ativos .
SELECT name FROM sys.views;

--5. Crie vw_produtos_categorias usando INNER JOIN.
SELECT p.id_produto, p.nome AS produto, ca.nome AS categorias, p.preco 
FROM produto AS p 
INNER JOIN categoria as ca 
ON ca.id_categoria = p.id_categoria;

--6. Crie vw_pedidos_clientes .

--7. Consulte somente pedidos FINALIZADOS pela view.

--8. Crie uma view com pedido, produto, quantidade, preço unitário e subtotal.

