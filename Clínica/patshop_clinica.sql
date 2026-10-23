
CREATE TABLE convenio (
    id_convenio INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone_central VARCHAR(20) NULL
);

CREATE TABLE paciente (
    id_paciente INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    telefone VARCHAR(20) NULL,    
    carteirinha VARCHAR(40) NULL,
    id_convenio INT NOT NULL,

    CONSTRAINT FK_Paciente_Convenio FOREIGN KEY (id_convenio) REFERENCES convenio(id_convenio)    
);


CREATE TABLE medico (
    id_medico INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    crm VARCHAR(20) NOT NULL UNIQUE
);


CREATE TABLE especialidade (
    id_especialidade INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE medico_especialidade (
    id_medico INT NOT NULL,
    id_especialidade INT NOT NULL,
    CONSTRAINT PK_Medico_Especialidade PRIMARY KEY (id_medico, id_especialidade),
    CONSTRAINT FK_ME_Medico FOREIGN KEY (id_medico) REFERENCES medico(id_medico),
    CONSTRAINT FK_ME_Especialidade FOREIGN KEY (id_especialidade) REFERENCES especialidade(id_especialidade)
);


CREATE TABLE consulta (
    id_consulta INT IDENTITY(1,1) PRIMARY KEY,
    data_hora DATETIME2(0) NOT NULL,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    id_especialidade INT NOT NULL,
    CONSTRAINT FK_Consulta_Paciente FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
    CONSTRAINT FK_Consulta_Medico FOREIGN KEY (id_medico) REFERENCES medico(id_medico),
    CONSTRAINT FK_Consulta_Especialidade FOREIGN KEY (id_especialidade) REFERENCES especialidade(id_especialidade)    
);


CREATE TABLE receita (
    id_receita INT IDENTITY(1,1) PRIMARY KEY,
    id_consulta INT NOT NULL,
    validade DATE NOT NULL,
    CONSTRAINT FK_Receita_Consulta FOREIGN KEY (id_consulta) REFERENCES consulta(id_consulta)
);


CREATE TABLE medicamento (
    id_medicamento INT IDENTITY(1,1) PRIMARY KEY,
    nome_medicamento VARCHAR(150) NOT NULL UNIQUE
);


CREATE TABLE receita_medicamento (
    id_receita INT NOT NULL,
    id_medicamento INT NOT NULL,
    posologia VARCHAR(250) NOT NULL,
    CONSTRAINT PK_Receita_Medicamento PRIMARY KEY (id_receita, id_medicamento),
    CONSTRAINT FK_RM_Receita FOREIGN KEY (id_receita) REFERENCES receita(id_receita),
    CONSTRAINT FK_RM_Medicamento FOREIGN KEY (id_medicamento) REFERENCES medicamento(id_medicamento)
);

