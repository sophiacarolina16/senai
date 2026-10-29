
USE biblioteca_som2;

--6. INSERT de usuários — 4 pts
INSERT INTO usuario(nome, email, telefone, ativo) VALUES
('Sophia Carolina','s.carolina@gmail.com','19999999999',TRUE),
('Ana Clara','ana.clara@gmail.com','19999999991',TRUE),
('Evelyn Barros','e.barros@gmail.com','19999999992',TRUE),
('Pedro Monzani','p.monzani@gmail.com',NULL,TRUE);

select*from usuario

--7. INSERT de livros — 5 pts
INSERT INTO livro(titulo, autor, isbn, ano_publicado, quantidade_disponivel, editora) VALUES
('Guerra Dos Tronos','George R. R. Martin','0001',2010,4,"LeYa" ),
('Jurassic Park','Michael Crichton','0002',1991,5,"Aleph" ),
('A Origem das Especies','Charles Darwin','0003',2014,3,"Martin Claret" ),
('Gatos Guerreiros','Erin Hunter','0004',2010,1,"WMF Martins Fontes" ),
('Jogos Vorazes','Suzanne Collins','0005',2010,2,"Rocco" ),
('Caninos Brancos','Jack London','0006',1995,3,"Atica" );

select*from livro

--8. INSERT de empréstimos — 4 pts
INSERT INTO EMPRESTIMO (data_prevista, status_emprestimo, id_usuario, id_livro) VALUES
('2026-05-10', 'ABERTO', 1, 1),
('2026-05-12', 'ABERTO', 2, 2),
('2026-05-10', 'ABERTO', 1, 2),
('2026-05-10', 'ABERTO', 1, 4),
('2026-05-15', 'ABERTO', 3, 3);



select*from emprestimo

--9. UPDATE — 4 pts
UPDATE USUARIO SET telefone = '1888888888' WHERE id_usuario = 1;

--10. Atualização em lote — 4 pts

INSERT INTO livro(titulo, autor, isbn, ano_publicado, quantidade_disponivel, editora) VALUES
('Guardiã de Pedras','Cristina Bomfim','0007',2025,2,"Thomas Nelson Brasil" );


--11. DELETE e integridade — 4 pts

UPDATE livro SET quantidade_disponivel = quantidade_disponivel + 2 WHERE ano_publicado >= 2020;



INSERT INTO usuario(nome, email, telefone, ativo) VALUES
('Julia Teste','j.teste@gmail.com','1999997777',TRUE);

DELETE FROM usuario WHERE id_usuario = 5;

DELETE FROM usuario WHERE id_usuario = 1;
--não vai por esse id estar tambem listado como FK em outra tabela


