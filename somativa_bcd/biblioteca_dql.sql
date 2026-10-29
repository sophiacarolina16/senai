-- Active: 1788436126633@@127.0.0.1@3308@biblioteca_som2

USE biblioteca_som2;

--12. SELECT básico — 2 pts
SELECT titulo,autor,quantidade_disponivel 
FROM livro;

--13. WHERE + ORDER BY — 3 pts
SELECT titulo,autor,quantidade_disponivel 
FROM livro
WHERE quantidade_disponivel > 2 
ORDER BY quantidade_disponivel DESC

--14. LIKE — 3 pts

SELECT titulo
FROM LIVRO
WHERE titulo LIKE '%guerr%'; --vai aparecer dois

--15. BETWEEN — 3 pts
SELECT titulo, ano_publicado 
FROM livro
WHERE ano_publicado BETWEEN 2015 AND 2025;

--16. Funções agregadas — 4 pts
SELECT COUNT(*) Livros_disponiveis
FROM livro;

SELECT SUM(quantidade_disponivel) Livros_totais
FROM livro;

SELECT round(avg(quantidade_disponivel)) media_quantidade
FROM livro;

SELECT MIN(quantidade_disponivel) AS menor_quantidade,MAX(quantidade_disponivel) AS maior_quantidade
FROM livro;

--17. INNER JOIN — 4 pts
--18. JOIN + WHERE — 3 pts
--19. GROUP BY — 4 pts




--20. LEFT JOIN — 4 pts



