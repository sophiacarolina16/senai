

USE smartcoffee_procedures_sophia;

-- AULA 13 - ATIVIDADE STORED PROCEDURES
-- Aluno: SOPHIA CAROLINA SOARES DA CUNHA
-- Turma: DEVIS

-- 1. listar_clientes_ativos()
DROP PROCEDURE LISTAR_CLIENTES_ATIVOS;
DELIMITER $$
CREATE PROCEDURE LISTAR_CLIENTES_ATIVOS() BEGIN
SELECT NOME
FROM CLIENTE
WHERE ATIVO = TRUE;
END $$
DELIMITER ;

CALL LISTAR_CLIENTES_ATIVOS();

-- 2. buscar_produto_por_nome(IN p_busca VARCHAR(100))
DROP PROCEDURE BUSCAR_PRODUTO_POR_NOME;
DELIMITER $$
CREATE PROCEDURE BUSCAR_PRODUTO_POR_NOME(IN p_busca VARCHAR(100)) BEGIN
SELECT NOME
FROM PRODUTO;
END $$
DELIMITER ;

CALL BUSCAR_PRODUTO_POR_NOME(1);


-- 3. produtos_por_categoria(IN p_id_categoria INT)


-- 4. total_clientes(OUT p_total INT)
DELIMITER $$
CREATE PROCEDURE total_clientes(OUT p_total INT) BEGIN
SELECT * FROM PRODUTO;
END $$
DELIMITER ;

CALL total_clientes;

-- 5. consultar_estoque(IN p_id_produto INT) usando variável local


-- 6. classificar estoque: 0 SEM ESTOQUE / <=5 BAIXO / >5 NORMAL

DELIMITER $$
CREATE PROCEDURE CONSULTAR_ESTOQUE (IN P_ID_PRODUTO INT)
BEGIN
    DECLARE V_QUANTIDADE INT;

    SELECT QUANTIDADE
    INTO V_QUANTIDADE
    FROM ESTOQUE
    WHERE ID_PRODUTO = P_ID_PRODUTO;

    IF V_QUANTIDADE = 0 THEN
        SELECT 'SEM ESTOQUE' AS SITUAÇÃO;
    ELSEIF V_QUANTIDADE <= 5 THEN
        SELECT 'ESTOQUE BAIXO' AS SITUAÇÃO;
    ELSE
        SELECT 'ESTOQUE NORMAL' AS SITUAÇÃO;
    END IF;
END $$

DELIMITER ;

CALL CONSULTAR_ESTOQUE(1);

-- 7. cadastrar_cliente(...) com três parâmetros IN
DELIMITER $$

CREATE PROCEDURE CADASTRANDO_CLIENTE (
    IN P_NOME VARCHAR (100),
    IN P_EMAIL VARCHAR(120),
    IN P_TELEFONE VARCHAR(20)
)
BEGIN
    INSERT INTO CLIENTE (NOME, EMAIL, TELEFONE, ATIVO)
    VALUES (P_NOME, P_EMAIL, P_TELEFONE, TRUE);
END $$

DELIMITER ;

CALL CADASTRANDO_CLIENTE ('ANA CLARA', 'ANA@GMAIL.COM','1999995999');

SELECT * FROM CLIENTE;

-- 8. alterar_preco(...) impedindo valor <= 0


-- 9. criar_pedido(IN p_id_cliente INT, OUT p_id_pedido INT)

    
-- 10. devolver ID com LAST_INSERT_ID()


-- 11. adicionar_item_pedido(...) buscando o preço atual


-- 12. Faça uma chamada inválida e explique o resultado.


-- 13. Use SHOW CREATE PROCEDURE.


-- 14. Remova uma procedure com DROP PROCEDURE IF EXISTS e recrie-a.


-- DESAFIO FINAL:
-- Crie uma procedure de negócio com:
-- - pelo menos 2 parâmetros;
-- - variável local;
-- - IF;
-- - pelo menos uma alteração no banco.