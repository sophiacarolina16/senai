--View ou visões - transformar determinadas consultas em visões reutilizaveis

SELECT * FROM CLIENTE;

--DISPONIBILIZAR UMA CONSULTA COMO SE ELA FOSSE UMA TABELA?
--RESPOSTAS:VIEWS

--1 EXP: VIEW- COMO CONSULTAR UMA VISÃO LOGICA

CREATE VIEW vw_produtos_ativos 
AS SELECT id_produto, nome, preco 
FROM produto 
WHERE ativo = TRUE;

--VISUALIZAR A CONSULTA CRIADA ATRAVES DA VIEW
SELECT * FROM vw_produtos_ativos;

--OBS: A VIEW GUARDA A DEFINIÇÃO DA CONSULTA. EM UMA VIEW COMUNM OS DADOS CONTINUAM PERTENCENDP AS TABELAS DE ORIGEM.

--TABELA - ARMAZENA REGISTROS
--VIEW - REPRESENTA O RESULTADO LOGICO DA CONSULTA

--PORQUE UTILIZAR?
--PORQUE DESEJO SIMPLIFICAR MINHA CONSULTA
--REUTILIZAR LOGICA ONDE A CONSULTA GANHA UM NOME
--PADRONIZAÇÃO DE RELATORIOS
--RESTRIÇÃO DE EXPOSIÇÃO DA MINHA LOGICA

--RESUMO 1:
--UMA CONSULTA ORIGINAL OU INCIAL:

SELECT id_produto, nome, preco
FROM produto
WHERE ativo = TRUE;

--TRANSFORMAR EM UMA VIEW

SELECT id_produto, nome, preco
FROM produto
WHERE ativo = TRUE;

--COMO UTILIZAR:
SELECT * FROM vw_produtos_ativos;


--2 EXP: UTILIZAR FILTROS NAS VIEWS

SELECT id_produto,nome,preco
FROM produto 
WHERE preco >= 10.00 
ORDER BY preco DESC;

SELECT * FROM vw_produtos_ativos 
WHERE preco >= 10.00 
ORDER BY preco DESC;

--OBS: VIEW NAO ELIMINA A POSSIBILIDADE DE USAR WHERE, ORDER BY E OUTRAS CLAUSULAS

--3 EXP: VIEW COM JOINS - MOSTRAR PRODUTOS E CATEGORIAS

--CONSULTA ORIGINAL
SELECT p.id_produto, p.nome AS produto, ca.nome AS categorias, p.preco 
FROM produto AS p 
INNER JOIN categoria as ca 
ON ca.id_categoria = p.id_categoria;

--CRIANDO EM VIEW

CREATE VIEW vw_produtos_categorias AS 
SELECT p.id_produto, p.nome AS produto, ca.nome AS categoria, p.preco 
FROM produto AS p 
INNER JOIN categorias as ca on ca.id_categoria= p.id_categoria;

--RESULTADO VISUAL POR VIEW

SELECT * FROM vw_produtos_categorias 
ORDER BY categoria, produto;

--4 EXP: VIEW COM VARIAS TABELAS - RELATORIO DE PEDIDOS

CREATE VIEW vw_pedidos_clientes AS
SELECT p.id_pedido, p.data_pedido, p.status, c.id_cliente, c.nome AS cliente,pr.id_produto, pr.nome AS produto
FROM pedido AS p 
INNER JOIN cliente AS c ON c.id_cliente = p.id_cliente
ON c.id_cliente = p.id_cliente 
INNER JOIN produto AS pr 
ON p.id_pedido = pr.id_produto;

--RESULTADO
SELECT * FROM vw_pedidos_clientes 
WHERE status = 'ABERTO';


--5 EXP: VIEW PARA UM RELATORIO COMPLETO

CREATE VIEW vw_itens_pedidos AS 
SELECT pe.id_pedido, pe.data_pedido, c.nome AS cliente, pr.nome AS 
produto, ip.quantidade, ip.preco_unitario, ip.quantidade * ip.preco_unitario AS subtotal 
FROM pedido AS pe 
INNER JOIN cliente AS c
ON c.id_cliente = pe.id_cliente 
INNER JOIN item_pedido as ip 
ON ip.id_pedido = pe.id_pedido 
INNER JOIN produto AS pr 
ON pr.id_produto = ip.id_produto;

--RESULTADO

SELECT * FROM vw_itens_pedido 
WHERE id_pedido= 3;

SELECT * FROM vw_itens_pedidos 


--6 EXP: VIEW COM FUNCOES DE AGREGAÇÃO
CREATE VIEW vw_vendas_por_produto AS 
SELECT pr.id_produto, pr.nome AS produto, SUM(ip.quantidade) AS unidades_vendidas, SUM(ip.quantidade* ip.preco_unitario) AS faturamento 
FROM produto AS pr 
INNER JOIN item_pedido AS ip 
ON ip.id_produto = pr.id_produto 
INNER JOIN pedido AS pe 
ON pe.id_pedido = ip.id_pedido 
WHERE pe.status = 'ABERTO'
GROUP BY pr.id_produto, pr.nome;

--RESULTADO:

SELECT * FROM vw_vendas_por_produto 
ORDER BY faturamento DESC;


--7 EXP: VIEW COM LEFT JOIN - QUEREMOS TODOS OS CLIENTES INCLUSIVE QUEM NUNCA REALIZOU PEDIDOS

CREATE VIEW vw_clientes_resumo AS 
SELECT c.id_cliente,c.nome AS cliente, COUNT(p.id_pedido) AS quantidade_pedidos FROM cliente AS c 
LEFT JOIN pedido AS p ON p.id_cliente = c.id_cliente 
GROUP BY c.id_cliente,c.nome;

--RESULTADO
SELECT * FROM vw_clientes_resumo 
WHERE quantidade_pedidos = 0;


--8 EXP: NOMEANDO VIEWS
--ALIASES TORNAM AS VIEWS MAIS CLARAS

CREATE VIEW vw_precos_produtos AS 
SELECT id_produto, nome AS produto, preco AS preco_atual 
FROM produto;

SELECT * FROM vw_precos_produtos;

--9 EXP: VISUALIZAR AS VIEWS EXISTENTES

--VISUALIZAR O RESULTADO DE TODAS AS VIEWS CRIADAS
SHOW FULL TABLES WHERE TABLE_TYPE = 'VIEW';

--PODEMOS CONSULTAR O CATALOGO

SELECT TABLE_NAME FROM information_schema.VIEWS 
WHERE TABLE_SCHEMA = DATABASE();

--10 EXP: VISUALIZANDO DEFINICOES
SHOW CREATE VIEW vw_produtos_categorias;


--11 EXP: CREATE OR REPLACE VIEW

CREATE OR REPLACE VIEW vw_produto_ativos AS SELECT id_produto, nome, preco, id_categoria
FROM produto
WHERE ativo = TRUE;

--OBS:IRA SUBSTITUIR OU ALTERAR UMA VIEW JA CRIADA COM SUAS INFORMAÇÕES

--12 EXP: VIEW ATUALIZAVEL
CREATE VIEW vw_clientes_ativos AS SELECT id_cliente,nome,email,ativo FROM cliente WHERE ativo = TRUE;

--ATUALIZAR A TABELA CLIENTE

UPDATE vw_clientes_ativos
SET nome ='Ana Francis'
WHERE id_cliente = 2;




--13:VIEW NAO ATUALIZAVEL
UPDATE vw_vendas_por_produto 
SET faturamento = 1000 
WHERE id_produto = 1

--OBS:O CAMPO É CALCULADO. SIMPLESMENTE NÃO É POSSIVEL RECEBER 1000.

--14:WITH CHECK OPTION - VIEW QUE MOSTRA APENAS PRODUTOS ATIVOS

CREATE OR REPLACE VIEW vw_produtos_ativos AS 
SELECT id_produto, nome, preco, ativo, id_categoria 
FROM produto 
WHERE ativo = TRUE WITH CHECK OPTION;

SELECT * FROM vw_produto_ativos;

--15 EXP: PADRAO DEFINICAO DE NOMENCLATURA
--vw- views 
--nome- complementar a tabela ou consultar que deseja realizar
--vw_nome_desejo
--vw_nome_da_finalidade
--vw_produtos_ativos












--APAGAR VIEWS
DROP VIEW vw_pedidos_clientes;

