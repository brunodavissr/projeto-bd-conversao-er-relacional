CREATE TABLE "unidades_atendimento" (
  "codigo" INTEGER(3) NOT NULL,
  "nome" VARCHAR(50) NOT NULL UNIQUE,
  "endereco" VARCHAR(200) NOT NULL
  PRIMARY KEY("codigo")
);

CREATE TABLE "telefones_unidades" (
  "codigo_unidade" INTEGER(3) NOT NULL,
  "telefone" INTEGER(10) NOT NULL,
  PRIMARY KEY("codigo_unidade", "telefone")
  FOREIGN KEY("codigo_unidade") REFERENCES "unidades_atendimento"("codigo")
);

CREATE TABLE "unidades_academicas" (
  "codigo" CHAR(4) NOT NULL,
  "nome" VARCHAR(50) NOT NULL UNIQUE,
  PRIMARY KEY("codigo")
);

CREATE TABLE "cursos" (
  "codigo" INTEGER(3) NOT NULL,
  "nome" VARCHAR(50) NOT NULL UNIQUE,
  PRIMARY KEY("codigo")
);

CREATE TABLE "disciplinas" (
  "codigo" CHAR(7) NOT NULL,
  "nome" VARCHAR(50) NOT NULL,
  PRIMARY KEY("codigo")
);

CREATE TABLE "funcionarios_biblioteca" (
  "matricula" INTEGER(5) NOT NULL,
  "nome" VARCHAR(50) NOT NULL,
  "tipo_funcionario" CHAR(1) NOT NULL,
  PRIMARY KEY("codigo")
);

CREATE TABLE "titulos" (
  "isbn" INTEGER(5) NOT NULL,
  "nome_titulo" VARCHAR(100) NOT NULL,
  "area_principal" VARCHAR(100) NOT NULL,
  "assunto" VARCHAR(100) NOT NULL,
  "ano_publicacao" INTEGER(4) NOT NULL,
  "editora" VARCHAR(50) NOT NULL,
  "idioma" CHAR(1) NOT NULL,
  "prazo_emprestimo_professor" INTEGER(2) NOT NULL,
  "prazo_emprestimo_aluno" INTEGER(2) NOT NULL,
  "numero_max_renovacao" INTEGER(2) NOT NULL,
  "edicao" INTEGER(3) NULL,
  "periodicidade" CHAR(15) NULL CHECK("periodicidade" IN ("semanal", "quinzenal", "mensal", "trimestral", "quadrimestral", "semestral", "anual")),
  "tipo" CHAR(1) NULL CHECK("tipo" IN ("J", "R", "B")),
  PRIMARY KEY("isbn")
);

CREATE TABLE "autores" (
  "isbn_titulo" INTEGER(5) NOT NULL,
  "autor" VARCHAR(100) NOT NULL,
  PRIMARY KEY("isbn_titulo", "autor"),
  FOREIGN KEY("isbn_titulo") REFERENCES "titulos"("isbn")
);

CREATE TABLE "areas_secundarias" (
  "isbn_titulo" INTEGER(5) NOT NULL,
  "area_secundaria" VARCHAR(100) NOT NULL,
  PRIMARY KEY("isbn_titulo","area_secundaria"),
  FOREIGN KEY("isbn_titulo") REFERENCES "titulos"("isbn")
);

CREATE TABLE "usuarios_biblioteca" (
  "codigo" INTEGER(5) NOT NULL,
  "nome" VARCHAR(50) NOT NULL,
  "identidade" CHAR(12) NULL,
  "cpf" CHAR(14) NULL,
  "endereco" VARCHAR(100) NOT NULL,
  "sexo" CHAR(1) NOT NULL CHECK("sexo" IN ("M", "F")),
  "data_nascimento" DATE NOT NULL,
  "estado_civil" CHAR(1) NOT NULL CHECK("estado_civil" IN ("C", "S", "D", "V")),
  "matricula_professor" INTEGER(5) NULL UNIQUE,
  PRIMARY KEY ("codigo")
);

CREATE TABLE "telefones_usuarios" (
  "codigo_usuario" INTEGER(5) NOT NULL,
  "telefone" INTEGER(10) NOT NULL,
  PRIMARY KEY("codigo_usuario", "telefone"),
  FOREIGN KEY("codigo_usuario") REFERENCES "usuarios_biblioteca"("codigo")
);
