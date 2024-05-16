CREATE TABLE "funcionarios_biblioteca" (
  "matricula" INTEGER NOT NULL,
  "nome" VARCHAR(50) NOT NULL,
  "tipo_funcionario" CHAR(1) NOT NULL CHECK("tipo_funcionario" IN ('A', 'B')),
  PRIMARY KEY("matricula")
);

CREATE TABLE "unidades_atendimento" (
  "codigo" INTEGER NOT NULL,
  "matricula_bibliotecaria" INTEGER NOT NULL UNIQUE,
  "nome" VARCHAR(50) NOT NULL UNIQUE,
  "endereco" VARCHAR(200) NOT NULL,
  PRIMARY KEY("codigo"),
  FOREIGN KEY("matricula_bibliotecaria") REFERENCES "funcionarios_biblioteca"("matricula")
);

CREATE TABLE "telefones_unidades" (
  "codigo_unidade" INTEGER NOT NULL,
  "telefone" INTEGER NOT NULL,
  PRIMARY KEY("codigo_unidade", "telefone"),
  FOREIGN KEY("codigo_unidade") REFERENCES "unidades_atendimento"("codigo")
);

CREATE TABLE "unidades_academicas" (
  "codigo" CHAR(4) NOT NULL,
  "nome" VARCHAR(50) NOT NULL UNIQUE,
  PRIMARY KEY("codigo") 
);

CREATE TABLE "cursos" (
  "codigo" INTEGER NOT NULL,
  "nome" VARCHAR(50) NOT NULL UNIQUE,
  PRIMARY KEY("codigo")
);

CREATE TABLE "disciplinas" (
  "codigo" CHAR(7) NOT NULL,
  "nome" VARCHAR(50) NOT NULL,
  PRIMARY KEY("codigo")
);

CREATE TABLE "titulos" (
  "isbn" INTEGER NOT NULL,
  "nome_titulo" VARCHAR(100) NOT NULL,
  "area_principal" VARCHAR(100) NOT NULL,
  "assunto" VARCHAR(100) NOT NULL,
  "ano_publicacao" INTEGER NOT NULL,
  "editora" VARCHAR(50) NOT NULL,
  "idioma" CHAR(1) NOT NULL,
  "prazo_emprestimo_professor" INTEGER NOT NULL,
  "prazo_emprestimo_aluno" INTEGER NOT NULL,
  "numero_max_renovacao" INTEGER NOT NULL,
  "edicao" INTEGER NULL,
  "periodicidade" CHAR(15) NULL CHECK("periodicidade" IN ('SEMANAL', 'QUINZENAL', 'MENSAL', 'TRIMESTRAL', 'QUADRIMESTRAL', 'SEMESTRAL', 'ANUAL')),
  "tipo_periodico" CHAR(1) NULL CHECK("tipo_periodico" IN ('J', 'R', 'B')),
  "tipo_titulo" CHAR(1) NOT NULL CHECK("tipo_titulo" IN ('L', 'P')),
  PRIMARY KEY("isbn")
  --Adicionar check para verificar se cada tipo de entidade está preenchida com seus dados corretamente.
);

CREATE TABLE "autores" (
  "isbn_titulo" INTEGER NOT NULL,
  "autor" VARCHAR(100) NOT NULL,
  PRIMARY KEY("isbn_titulo", "autor"),
  FOREIGN KEY("isbn_titulo") REFERENCES "titulos"("isbn")
);

CREATE TABLE "areas_secundarias" (
  "isbn_titulo" INTEGER NOT NULL,
  "area_secundaria" VARCHAR(100) NOT NULL,
  PRIMARY KEY("isbn_titulo","area_secundaria"),
  FOREIGN KEY("isbn_titulo") REFERENCES "titulos"("isbn")
);

CREATE TABLE "usuarios_biblioteca" (
  "codigo" INTEGER NOT NULL,
  "nome" VARCHAR(50) NOT NULL,
  "identidade" CHAR(12) NULL,
  "cpf" CHAR(14) NULL,
  "endereco" VARCHAR(100) NOT NULL,
  "sexo" CHAR(1) NOT NULL CHECK("sexo" IN ('M', 'F')),
  "data_nascimento" DATE NOT NULL,
  "estado_civil" CHAR(1) NOT NULL CHECK("estado_civil" IN ('C', 'S', 'D', 'V')),
  "matricula_professor" INTEGER NULL UNIQUE,
  "tipo_usuario" CHAR(1) NOT NULL CHECK("tipo_usuario" IN ('A', 'P')),
  PRIMARY KEY ("codigo")
  --Adicionar verificação para caso usuário seja professor, ter a mátricula preenchida obrigatoriamente
);

CREATE TABLE "telefones_usuarios" (
  "codigo_usuario" INTEGER NOT NULL,
  "telefone" INTEGER NOT NULL,
  PRIMARY KEY("codigo_usuario", "telefone"),
  FOREIGN KEY("codigo_usuario") REFERENCES "usuarios_biblioteca"("codigo")
);

CREATE TABLE "transacoes" (
  "numero_transacao" INTEGER NOT NULL,
  "data_transacao" DATE NOT NULL DEFAULT CURRENT_DATE,
  "horario_transacao" TIME NOT NULL DEFAULT CURRENT_TIME,
  "tipo_transacao" CHAR(10) NOT NULL CHECK("tipo_transacao" IN ('EMPRESTIMO', 'DEVOLUÇÃO', 'RENOVAÇÃO', 'RESERVA')),
  PRIMARY KEY("numero_transacao")
);

CREATE TABLE "copias_titulos" (
  "numero_copia" INTEGER NOT NULL,
  "isbn_titulo" INTEGER NOT NULL,
  "secao_copia" INTEGER NOT NULL,
  "estante_copia" INTEGER NOT NULL,
  PRIMARY KEY("numero_copia", "isbn_titulo"),
  FOREIGN KEY("isbn_titulo") REFERENCES "titulos"("isbn")
);

CREATE TABLE "itens_emprestimo" (
  "numero_item" INTEGER NOT NULL,
  "numero_transacao" INTEGER NOT NULL,
  "data_limite_devolucao" DATE NOT NULL,
  PRIMARY KEY("numero_item", "numero_transacao"),
  FOREIGN KEY("numero_transacao") REFERENCES "transacoes"("numero_transacao")
);

CREATE TABLE "curso_aluno" (
  "codigo_curso" INTEGER NOT NULL,
  "codigo_aluno" INTEGER NOT NULL,
  "matricula" INTEGER NOT NULL UNIQUE,
  PRIMARY KEY("codigo_curso", "codigo_aluno"),
  FOREIGN KEY("codigo_curso") REFERENCES "cursos"("codigo"),
  FOREIGN KEY("codigo_aluno") REFERENCES "usuarios_biblioteca"("codigo")
  --Checar se o código aluno é realmente de um aluno
);
