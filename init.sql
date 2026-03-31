
CREATE DATABASE IF NOT EXISTS conectamais;
USE conectamais;

-- 1. Tabela de Papeis (Ex: Aluno, Professor, Coordenador)
CREATE TABLE papel (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE
);

-- 2. Tabela de Usuarios
CREATE TABLE usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    id_papel INT,
    CONSTRAINT fk_usuario_papel FOREIGN KEY (id_papel) REFERENCES papel(id) ON DELETE SET NULL
);

-- 3. Tabela de Avisos
CREATE TABLE aviso (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    texto TEXT NOT NULL,
    data_postagem DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_fim DATETIME NOT NULL
);

-- 4. Tabela de Relação (Quais papéis podem ver quais avisos)
-- Esta é a tabela que resolve a lógica de "Aviso X é para Alunos"
CREATE TABLE aviso_papel (
    id_aviso INT,
    id_papel INT,
    PRIMARY KEY (id_aviso, id_papel),
    CONSTRAINT fk_relacao_aviso FOREIGN KEY (id_aviso) REFERENCES aviso(id) ON DELETE CASCADE,
    CONSTRAINT fk_relacao_papel FOREIGN KEY (id_papel) REFERENCES papel(id) ON DELETE CASCADE
);

-- --- INSERTS DE TESTE (Opcional) ---

INSERT INTO papel (nome) VALUES ('Aluno'), ('Professor'), ('Adm');

INSERT INTO usuario (nome, email, senha, id_papel) 
VALUES ('João Silva', 'joao@escola.com', 'hash_senha_123', 1); -- João é Aluno

INSERT INTO aviso (titulo, texto, data_fim) 
VALUES ('Prova de Matemática', 'A prova será no dia 10', '2026-04-10 23:59:59');

-- Vinculando o aviso 1 ao papel 1 (Aluno)
INSERT INTO aviso_papel (id_aviso, id_papel) VALUES (1, 1)