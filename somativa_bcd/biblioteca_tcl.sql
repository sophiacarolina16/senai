-- Active: 1788436126633@@127.0.0.1@3308@biblioteca_som2
USE biblioteca_som2;


START TRANSACTION;

--21. Transação de empréstimo — 7 pts

--22. ROLLBACK — 5 pts

UPDATE livro
SET quantidade_disponivel = 7
WHERE id_livro = 1;

SELECT * FROM livro;
ROLLBACK;

--23. SAVEPOINT — 4 pts

