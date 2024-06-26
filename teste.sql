CREATE TABLE "bibliotecarias" (
  "matricula" NUMERIC(5) NOT NULL,
  "nome" VARCHAR(50) NOT NULL,
  PRIMARY KEY("matricula")
);

CREATE TABLE "unidades_atendimento" (
  "codigo" NUMERIC(3) NOT NULL,
  "matricula_bibliotecaria" NUMERIC(5) NOT NULL UNIQUE,
  "nome" VARCHAR(50) NOT NULL UNIQUE,
  "endereco" VARCHAR(200) NOT NULL,
  PRIMARY KEY("codigo"),
  FOREIGN KEY("matricula_bibliotecaria") REFERENCES "bibliotecarias"("matricula")
);

CREATE TABLE "atendentes" (
  "matricula" NUMERIC(5) NOT NULL,
  "codigo_unidade" NUMERIC(3) NOT NULL,
  "nome" VARCHAR(50) NOT NULL,
  PRIMARY KEY("matricula"),
  FOREIGN KEY("codigo_unidade") REFERENCES "unidades_atendimento"("codigo")
);

CREATE TABLE "telefones_unidade" (
  "codigo_unidade" NUMERIC(3) NOT NULL,
  "telefone" NUMERIC(10) NOT NULL,
  PRIMARY KEY("codigo_unidade", "telefone"),
  FOREIGN KEY("codigo_unidade") REFERENCES "unidades_atendimento"("codigo")
);

CREATE TABLE "unidades_academicas" (
  "codigo" CHAR(4) NOT NULL,
  "nome" VARCHAR(50) NOT NULL UNIQUE,
  PRIMARY KEY("codigo")
);

CREATE TABLE "cursos" (
  "codigo" NUMERIC(3) NOT NULL,
  "nome" VARCHAR(50) NOT NULL UNIQUE,
  "codigo_unidade" CHAR(4) NOT NULL,
  PRIMARY KEY("codigo"),
  FOREIGN KEY("codigo_unidade") REFERENCES "unidades_academicas"("codigo")
);

CREATE TABLE "disciplinas" (
  "codigo" CHAR(7) NOT NULL,
  "nome" VARCHAR(50) NOT NULL,
  PRIMARY KEY("codigo")
);

CREATE TABLE "titulos" (
  "isbn" NUMERIC(5) NOT NULL,
  "nome_titulo" VARCHAR(100) NOT NULL,
  "area_principal" VARCHAR(100) NOT NULL,
  "assunto" VARCHAR(100) NOT NULL,
  "ano_publicacao" NUMERIC(4) NOT NULL,
  "editora" VARCHAR(50) NOT NULL,
  "idioma" CHAR(1) NOT NULL,
  "prazo_emprestimo_professor" NUMERIC(2) NOT NULL,
  "prazo_emprestimo_aluno" NUMERIC(2) NOT NULL,
  "numero_max_renovacao" NUMERIC(2) NOT NULL,
  "edicao" NUMERIC(3) NULL,
  "periodicidade" CHAR(15) NULL,
  "tipo_periodico" CHAR(1) NULL,
  "tipo_titulo" CHAR(1) NOT NULL,
  PRIMARY KEY("isbn"),
  CHECK (
    ("tipo_titulo" = 'L' AND "edicao" IS NOT NULL AND "periodicidade" IS NULL AND "tipo_periodico" IS NULL) OR
    ("tipo_titulo" = 'P' AND "periodicidade" IS NOT NULL AND "tipo_periodico" IS NOT NULL AND "edicao" IS NULL)
  ),
  CHECK (
    "periodicidade" IN ('SEMANAL', 'QUINZENAL', 'MENSAL', 'TRIMESTRAL', 'QUADRIMESTRAL', 'SEMESTRAL', 'ANUAL')
  ),
  CHECK (
    "tipo_periodico" IN ('J', 'R', 'B')
  ),
  CHECK (
    "tipo_titulo" IN ('L', 'P')
  )
);

CREATE TABLE "autores" (
  "isbn_titulo" NUMERIC(5) NOT NULL,
  "autor" VARCHAR(100) NOT NULL,
  PRIMARY KEY("isbn_titulo", "autor"),
  FOREIGN KEY("isbn_titulo") REFERENCES "titulos"("isbn")
);

CREATE TABLE "areas_secundarias" (
  "isbn_titulo" NUMERIC(5) NOT NULL,
  "area_secundaria" VARCHAR(100) NOT NULL,
  PRIMARY KEY("isbn_titulo","area_secundaria"),
  FOREIGN KEY("isbn_titulo") REFERENCES "titulos"("isbn")
);

CREATE TABLE "usuarios_biblioteca" (
  "codigo" NUMERIC(5) NOT NULL,
  "nome" VARCHAR(50) NOT NULL,
  "identidade" CHAR(12) NULL,
  "cpf" CHAR(14) NULL,
  "endereco" VARCHAR(100) NOT NULL,
  "sexo" CHAR(1) NOT NULL,
  "data_nascimento" DATE NOT NULL,
  "estado_civil" CHAR(1) NOT NULL,
  PRIMARY KEY ("codigo"),
  CHECK (
    "sexo" IN ('M', 'F')
  ),
  CHECK (
    "estado_civil" IN ('C', 'S', 'D', 'V')
  )
);

CREATE TABLE "alunos" (
  "codigo" NUMERIC(5) NOT NULL,
  PRIMARY KEY("codigo"),
  FOREIGN KEY("codigo") REFERENCES "usuarios_biblioteca"("codigo")
);

CREATE TABLE "professores" (
  "codigo" NUMERIC(5) NOT NULL,
  "codigo_unidade" CHAR(4) NOT NULL,
  "matricula" NUMERIC(5) NOT NULL UNIQUE,
  PRIMARY KEY("codigo"),
  FOREIGN KEY("codigo") REFERENCES "usuarios_biblioteca"("codigo"),
  FOREIGN KEY("codigo_unidade") REFERENCES "unidades_academicas"("codigo")
);

CREATE TABLE "telefones_usuario" (
  "codigo_usuario" NUMERIC(5) NOT NULL,
  "telefone" NUMERIC(10) NOT NULL,
  PRIMARY KEY("codigo_usuario", "telefone"),
  FOREIGN KEY("codigo_usuario") REFERENCES "usuarios_biblioteca"("codigo")
);

CREATE TABLE "transacoes" (
  "numero_transacao" NUMERIC(9) NOT NULL,
  "matricula_atendente" NUMERIC(5) NOT NULL,
  "data_transacao" DATE NOT NULL DEFAULT CURRENT_DATE,
  "horario_transacao" TIME NOT NULL DEFAULT CURRENT_TIME,
  PRIMARY KEY("numero_transacao"),
  FOREIGN KEY("matricula_atendente") REFERENCES "atendentes"("matricula")
);

CREATE TABLE "emprestimos" (
  "numero_transacao" NUMERIC(9) NOT NULL,
  "codigo_usuario" NUMERIC(5) NOT NULL,
  PRIMARY KEY("numero_transacao"),
  FOREIGN KEY("numero_transacao") REFERENCES "transacoes"("numero_transacao"),
  FOREIGN KEY("codigo_usuario") REFERENCES "usuarios_biblioteca"("codigo")
);

CREATE TABLE "devolucoes" (
  "numero_transacao" NUMERIC(9) NOT NULL,
  "codigo_usuario" NUMERIC(5) NOT NULL,
  PRIMARY KEY("numero_transacao"),
  FOREIGN KEY("numero_transacao") REFERENCES "transacoes"("numero_transacao"),
  FOREIGN KEY("codigo_usuario") REFERENCES "usuarios_biblioteca"("codigo")
);

CREATE TABLE "reservas" (
  "numero_transacao" NUMERIC(9) NOT NULL,
  "codigo_usuario" NUMERIC(5) NOT NULL,
  PRIMARY KEY("numero_transacao"),
  FOREIGN KEY("numero_transacao") REFERENCES "transacoes"("numero_transacao"),
  FOREIGN KEY("codigo_usuario") REFERENCES "usuarios_biblioteca"("codigo")
);

CREATE TABLE "renovacoes" (
  "numero_transacao" NUMERIC(9) NOT NULL,
  "codigo_professor" NUMERIC(5) NOT NULL,
  PRIMARY KEY("numero_transacao"),
  FOREIGN KEY("numero_transacao") REFERENCES "transacoes"("numero_transacao"),
  FOREIGN KEY("codigo_professor") REFERENCES "professores"("codigo")
);

CREATE TABLE "copias_titulo" (
  "numero_copia" NUMERIC(5) NOT NULL,
  "isbn_titulo" NUMERIC(5) NOT NULL,
  "codigo_unidade" NUMERIC(3) NOT NULL,
  "secao_copia" NUMERIC(4) NOT NULL,
  "estante_copia" NUMERIC(3) NOT NULL,
  PRIMARY KEY("numero_copia", "isbn_titulo"),
  FOREIGN KEY("isbn_titulo") REFERENCES "titulos"("isbn"),
  FOREIGN KEY("codigo_unidade") REFERENCES "unidades_atendimento"("codigo")
);

CREATE TABLE "itens_emprestimo" (
  "numero_item" NUMERIC(1) NOT NULL,
  "numero_emprestimo" NUMERIC(9) NOT NULL,
  "numero_devolucao" NUMERIC(9) NULL,
  "numero_copia" NUMERIC(5) NOT NULL,
  "isbn_titulo" NUMERIC(5) NOT NULL,
  "data_devolucao" DATE NOT NULL,
  "situacao_copia" CHAR(1) NULL,
  "multa_atraso" NUMERIC(7, 2) NULL,
  "multa_dano" NUMERIC(7, 2) NULL,
  PRIMARY KEY("numero_item", "numero_emprestimo"),
  FOREIGN KEY("numero_emprestimo") REFERENCES "emprestimos"("numero_transacao"),
  FOREIGN KEY("numero_devolucao") REFERENCES "devolucoes"("numero_transacao"),
  FOREIGN KEY("numero_copia", "isbn_titulo") REFERENCES "copias_titulo"("numero_copia", "isbn_titulo"),
  CHECK (
    ("numero_devolucao" IS NOT NULL AND "situacao_copia" IN('I', 'D')) OR
    ("numero_devolucao" IS NULL AND "situacao_copia" IS NULL)
  ),
  CHECK (
    NOT("numero_devolucao" IS NULL AND "multa_atraso" IS NOT NULL)
  ),
  CHECK (
    NOT("numero_devolucao" IS NULL AND "multa_dano" IS NOT NULL)
  )
);

CREATE TABLE "itens_renovacao" (
  "numero_renovacao" NUMERIC(9) NOT NULL,
  "numero_emprestimo" NUMERIC(9) NOT NULL,
  "numero_item" NUMERIC(1) NOT NULL,
  "data_devolucao" DATE NOT NULL,
  PRIMARY KEY("numero_renovacao", "numero_emprestimo", "numero_item"),
  FOREIGN KEY("numero_renovacao") REFERENCES "renovacoes"("numero_transacao"),
  FOREIGN KEY("numero_emprestimo", "numero_item") REFERENCES "itens_emprestimo"("numero_emprestimo", "numero_item")
);

CREATE TABLE "cursos_aluno" (
  "codigo_curso" NUMERIC(3) NOT NULL,
  "codigo_aluno" NUMERIC(5) NOT NULL,
  "matricula" NUMERIC(5) NOT NULL UNIQUE,
  PRIMARY KEY("codigo_curso", "codigo_aluno"),
  FOREIGN KEY("codigo_curso") REFERENCES "cursos"("codigo"),
  FOREIGN KEY("codigo_aluno") REFERENCES "alunos"("codigo")
);

CREATE TABLE "disciplinas_professor" (
  "codigo_disciplina" CHAR(7) NOT NULL,
  "codigo_professor" NUMERIC(5) NOT NULL,
  PRIMARY KEY("codigo_disciplina", "codigo_professor"),
  FOREIGN KEY("codigo_disciplina") REFERENCES "disciplinas"("codigo"),
  FOREIGN KEY("codigo_professor") REFERENCES "professores"("codigo")
);

CREATE TABLE "copias_reservadas" (
  "numero_reserva" NUMERIC(9) NOT NULL,
  "numero_copia" NUMERIC(5) NOT NULL,
  "isbn_titulo" NUMERIC(5) NOT NULL,
  "data_reservada" DATE NOT NULL,
  PRIMARY KEY("numero_reserva", "numero_copia", "isbn_titulo"),
  FOREIGN KEY("numero_reserva") REFERENCES "reservas"("numero_transacao"),
  FOREIGN KEY("numero_copia", "isbn_titulo") REFERENCES "copias_titulo"("numero_copia", "isbn_titulo")
);
