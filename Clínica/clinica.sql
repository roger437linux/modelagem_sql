CREATE TABLE dbo.Convenio (
    id_convenio INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    telefone_central VARCHAR(20) NULL
);


CREATE TABLE dbo.Paciente (
    id_paciente INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    cpf CHAR(14) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    telefone VARCHAR(20) NULL,
    id_convenio INT NULL,
    carteirinha VARCHAR(40) NULL,

    CONSTRAINT FK_Paciente_Convenio
        FOREIGN KEY (id_convenio)
        REFERENCES dbo.Convenio(id_convenio),

    CONSTRAINT CK_Paciente_Convenio_Carteirinha
        CHECK (
            (id_convenio IS NULL AND carteirinha IS NULL)
            OR
            (id_convenio IS NOT NULL AND carteirinha IS NOT NULL)
        )
);


CREATE TABLE dbo.Medico (
    id_medico INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    crm VARCHAR(20) NOT NULL UNIQUE
);


CREATE TABLE dbo.Especialidade (
    id_especialidade INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE
);


CREATE TABLE dbo.Medico_Especialidade (
    id_medico INT NOT NULL,
    id_especialidade INT NOT NULL,

    CONSTRAINT PK_Medico_Especialidade
        PRIMARY KEY (id_medico, id_especialidade),

    CONSTRAINT FK_ME_Medico
        FOREIGN KEY (id_medico)
        REFERENCES dbo.Medico(id_medico),

    CONSTRAINT FK_ME_Especialidade
        FOREIGN KEY (id_especialidade)
        REFERENCES dbo.Especialidade(id_especialidade)
);


CREATE TABLE dbo.Consulta (
    id_consulta VARCHAR(10) NOT NULL PRIMARY KEY,
    data_hora DATETIME2(0) NOT NULL,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    id_especialidade INT NOT NULL,

    CONSTRAINT FK_Consulta_Paciente
        FOREIGN KEY (id_paciente)
        REFERENCES dbo.Paciente(id_paciente),

    CONSTRAINT FK_Consulta_Medico
        FOREIGN KEY (id_medico)
        REFERENCES dbo.Medico(id_medico),

    CONSTRAINT FK_Consulta_Especialidade
        FOREIGN KEY (id_especialidade)
        REFERENCES dbo.Especialidade(id_especialidade),

    CONSTRAINT FK_Consulta_Medico_Especialidade
        FOREIGN KEY (id_medico, id_especialidade)
        REFERENCES dbo.Medico_Especialidade
            (id_medico, id_especialidade)
);


CREATE TABLE dbo.Receita (
    id_receita INT IDENTITY(1,1) PRIMARY KEY,
    id_consulta VARCHAR(10) NOT NULL UNIQUE,
    validade DATE NOT NULL,

    CONSTRAINT FK_Receita_Consulta
        FOREIGN KEY (id_consulta)
        REFERENCES dbo.Consulta(id_consulta)
);


CREATE TABLE dbo.Medicamento (
    id_medicamento INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(150) NOT NULL UNIQUE
);


CREATE TABLE dbo.Receita_Medicamento (
    id_receita INT NOT NULL,
    id_medicamento INT NOT NULL,
    posologia VARCHAR(250) NOT NULL,

    CONSTRAINT PK_Receita_Medicamento
        PRIMARY KEY (id_receita, id_medicamento),

    CONSTRAINT FK_RM_Receita
        FOREIGN KEY (id_receita)
        REFERENCES dbo.Receita(id_receita),

    CONSTRAINT FK_RM_Medicamento
        FOREIGN KEY (id_medicamento)
        REFERENCES dbo.Medicamento(id_medicamento)
);

