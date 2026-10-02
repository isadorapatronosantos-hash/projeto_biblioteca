CREATE DATABASE biblioteca_2ano;


USE biblioteca_2ano;



-- Criando usuário
CREATE USER 'biblioteca_user2'@'localhost'
IDENTIFIED BY 'projeto2';




-- Dar permissão ao usuário
GRANT ALL PRIVILEGES
ON biblioteca_2ano.*
TO 'biblioteca_user2'@'localhost';


FLUSH PRIVILEGES;




-- Tabela de Aluno
CREATE TABLE aluno (
    id_aluno INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    serie VARCHAR(20) NOT NULL,
    turma VARCHAR(20) NOT NULL,
    telefone VARCHAR(20)
);




-- Tabela de Livro
CREATE TABLE livro (
    id_livro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    categoria VARCHAR(50),
    status VARCHAR(20) NOT NULL DEFAULT 'Disponível'
);




-- Tabela de Professor
CREATE TABLE professor (
    id_professor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL
);




-- Tabela de Bibliotecário
CREATE TABLE bibliotecario (
    id_bibliotecario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL
);




-- Tabela de Empréstimo
CREATE TABLE emprestimo (
    id_emprestimo INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT,
    id_livro INT,
    id_bibliotecario INT,
    data_emprestimo DATE NOT NULL,
    data_prevista_devolucao DATE NOT NULL,
    data_devolucao DATE,
    status VARCHAR(20) NOT NULL DEFAULT 'Emprestado',


    FOREIGN KEY (id_aluno)
        REFERENCES aluno(id_aluno),


    FOREIGN KEY (id_livro)
        REFERENCES livro(id_livro),


    FOREIGN KEY (id_bibliotecario)
        REFERENCES bibliotecario(id_bibliotecario)
);




-- Tabela de Usuário
CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(100) NOT NULL,
    perfil VARCHAR(30) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Ativo',


    id_aluno INT,
    id_professor INT,
    id_bibliotecario INT,


    FOREIGN KEY (id_aluno)
        REFERENCES aluno(id_aluno),


    FOREIGN KEY (id_professor)
        REFERENCES professor(id_professor),


    FOREIGN KEY (id_bibliotecario)
        REFERENCES bibliotecario(id_bibliotecario)
);






INSERT INTO aluno
(nome, serie, turma, telefone)
VALUES
('Ana Beatriz Silva', '2º Ano', 'A', '41999990001'),
('Bruno Henrique Souza', '2º Ano', 'A', '41999990002'),
('Carolina Mendes', '2º Ano', 'B', '41999990003'),
('Daniel Oliveira', '2º Ano', 'B', '41999990004'),
('Eduarda Santos', '2º Ano', 'C', '41999990005');




INSERT INTO livro
(titulo, autor, categoria, status)
VALUES
('Dom Casmurro', 'Machado de Assis', 'Literatura', 'Disponível'),
('O Pequeno Príncipe', 'Antoine de Saint-Exupéry', 'Literatura', 'Disponível'),
('Harry Potter e a Pedra Filosofal', 'J.K. Rowling', 'Fantasia', 'Disponível'),
('A Revolução dos Bichos', 'George Orwell', 'Ficção', 'Disponível'),
('Capitães da Areia', 'Jorge Amado', 'Literatura Brasileira', 'Disponível');




INSERT INTO professor
(nome, telefone, email)
VALUES
('Mariana Costa', '41998880001', 'mariana.costa@escola.com'),
('Rafael Almeida', '41998880002', 'rafael.almeida@escola.com'),
('Patricia Martins', '41998880003', 'patricia.martins@escola.com'),
('Carlos Eduardo Lima', '41998880004', 'carlos.lima@escola.com'),
('Juliana Ferreira', '41998880005', 'juliana.ferreira@escola.com');




INSERT INTO bibliotecario
(nome, email)
VALUES
('Fernanda Rocha', 'fernanda.rocha@biblioteca.com'),
('Lucas Pereira', 'lucas.pereira@biblioteca.com'),
('Camila Oliveira', 'camila.oliveira@biblioteca.com'),
('Marcelo Santos', 'marcelo.santos@biblioteca.com'),
('Renata Gomes', 'renata.gomes@biblioteca.com');




INSERT INTO emprestimo
(id_aluno, id_livro, id_bibliotecario, data_emprestimo, data_prevista_devolucao, data_devolucao, status)
VALUES
(1, 1, 1, '2026-08-01', '2026-08-15', '2026-08-14', 'Devolvido'),
(2, 2, 2, '2026-08-03', '2026-08-17', '2026-08-16', 'Devolvido'),
(3, 3, 3, '2026-08-05', '2026-08-19', NULL, 'Emprestado'),
(4, 4, 4, '2026-08-07', '2026-08-21', NULL, 'Emprestado'),
(5, 5, 5, '2026-08-10', '2026-08-24', NULL, 'Emprestado');






UPDATE livro
SET status = 'Emprestado'
WHERE id_livro IN (3, 4, 5);




INSERT INTO usuario
(nome, email, senha, perfil, status, id_aluno, id_professor, id_bibliotecario)
VALUES
('Ana Beatriz Silva', 'admin@escola.com', '123', 'Aluno', 'Ativo', 1, 1, 1),
('Bruno Henrique Souza', 'bruno@biblioteca.com', 'senha123', 'Aluno', 'Ativo', 2, 2, 2),
('Carolina Mendes', 'carolina@biblioteca.com', 'senha123', 'Aluno', 'Ativo', 3, 3, 3),
('Daniel Oliveira', 'daniel@biblioteca.com', 'senha123', 'Aluno', 'Ativo', 4, 4, 4),
('Administrador', 'admin@escola.com', '123', 'admin', 'Ativo',6,6,6),
('Eduarda Santos', 'eduarda@biblioteca.com', 'senha123', 'Aluno', 'Ativo', 5, 5, 5);




SELECT * FROM aluno;
SELECT * FROM livro;
SELECT * FROM professor;
SELECT * FROM bibliotecario;
SELECT * FROM emprestimo;
SELECT * FROM usuario;					

ALTER TABLE aluno
ADD COLUMN id_usuario INT;


ALTER TABLE aluno
ADD CONSTRAINT fk_aluno_usuario
FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario);


ALTER TABLE bibliotecario
ADD COLUMN id_usuario INT;


ALTER TABLE bibliotecario
ADD CONSTRAINT fk_bibliotecario_usuario
FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario);


UPDATE bibliotecario
SET id_usuario = 2
WHERE id_bibliotecario = 1;


UPDATE aluno
SET id_usuario = 3
WHERE id_aluno = 1;

DELETE FROM emprestimo;
DELETE FROM aluno;
DELETE FROM livro;
DELETE FROM bibliotecario;


ALTER TABLE emprestimo AUTO_INCREMENT = 1;
ALTER TABLE aluno AUTO_INCREMENT = 1;
ALTER TABLE livro AUTO_INCREMENT = 1;
ALTER TABLE bibliotecario AUTO_INCREMENT = 1;

