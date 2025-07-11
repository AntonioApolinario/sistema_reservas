CREATE TABLE IF NOT EXISTS usuarios (
    cpf VARCHAR(11) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    tipo VARCHAR(20) NOT NULL, -- 'aluno', 'professor', 'administrador'
    data_criacao TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS ambientes (
    id SERIAL PRIMARY KEY,
    identificacao VARCHAR(100) NOT NULL UNIQUE,
    tipo VARCHAR(50),
    status VARCHAR(20) NOT NULL DEFAULT 'Disponível'
);

CREATE TABLE IF NOT EXISTS equipamentos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    marca VARCHAR(50),
    modelo VARCHAR(50),
    quantidade_total INTEGER NOT NULL CHECK (quantidade_total >= 0),
    ambiente_id INTEGER REFERENCES ambientes(id) ON DELETE SET NULL 
);

CREATE TABLE IF NOT EXISTS reservas (
    id SERIAL PRIMARY KEY,
    usuario_cpf VARCHAR(11) REFERENCES usuarios(cpf),
    recurso_id INTEGER NOT NULL,
    recurso_tipo VARCHAR(50) NOT NULL,
    data_inicio TIMESTAMP WITH TIME ZONE NOT NULL,
    data_fim TIMESTAMP WITH TIME ZONE NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'pendente', -- pendente, aprovada, rejeitada, cancelada
    data_criacao TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_recurso_tipo CHECK (recurso_tipo IN ('ambiente', 'equipamento'))
);

-- Inserção de dados para teste
INSERT INTO usuarios (cpf, nome, email, senha, tipo) VALUES
('12345678900', 'Admin Padrão', 'admin@email.com', 'senha_hash_segura', 'administrador')
ON CONFLICT (cpf) DO NOTHING;