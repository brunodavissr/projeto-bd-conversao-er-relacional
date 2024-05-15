CREATE TABLE "unidades_atendimento" (
  "codigo" INTEGER,
  "nome" TEXT NOT NULL,
  "endereco" TEXT NOT NULL
  PRIMARY KEY("codigo")
);

CREATE TABLE "telefones" (
  "codigo_unidade" INTEGER,
  "telefone" INTEGER NOT NULL,
  PRIMARY KEY("codigo_unidade", "telefone")
  FOREIGN KEY("codigo_unidade") REFERENCES "unidades_atendimento"("codigo")
);

CREATE TABLE "unidades_academicas" (
  "codigo" INTEGER,
  "nome" TEXT NOT NULL UNIQUE,
  PRIMARY KEY("codigo")
);

CREATE TABLE "cursos" (
  "codigo" INTEGER,
  "nome" TEXT NOT NULL UNIQUE,
  PRIMARY KEY("codigo")
);

CREATE TABLE "disciplinas" (
  "codigo" INTEGER,
  "nome" TEXT NOT NULL,
  PRIMARY KEY("codigo")
);

CREATE TABLE "funcionarios_biblioteca" (
  "matricula" INTEGER,
  "nome" TEXT NOT NULL,
  "tipo" TEXT NOT NULL,
  PRIMARY KEY("codigo")
  );

CREATE TABLE "titulos" (
  "isbn" INTEGER,
  "nome_titulo" TEXT NOT NULL,
  "area_principal" TEXT NOT NULL,
  "assunto" TEXT NOT NULL,
  "ano_publicacao" INTEGER NOT NULL,
  "editora" TEXT NOT NULL,
  "idioma" TEXT NOT NULL,
  "prazo_emprestimo_professor" INTEGER NOT NULL,
  "prazo_emprestimo_aluno" INTEGER NOT NULL,
  "numero_max_renovacao" INTEGER NOT NULL,
  "edicao" INTEGER NULL,
  "periodicidade" TEXT NULL CHECK("periodicidade" IN ("semanal", "quinzenal", "mensal", "trimestral", "quadrimestral", "semestral", "anual")),
  "tipo" TEXT NULL CHECK("tipo" IN ("J", "R", "B")),
  PRIMARY KEY("isbn")
);

CREATE TABLE "autores" (
  "isbn_titulo" INTEGER,
  "autor" TEXT NOT NULL,
  PRIMARY KEY("isbn_titulo","autor"),
  FOREIGN KEY("isbn_titulo") REFERENCES "titulos"("isbn")
);

CREATE TABLE "areas_secundarias" (
  "isbn_titulo" INTEGER,
  "area_secundaria" TEXT NOT NULL,
  PRIMARY KEY("isbn_titulo","area_secundaria"),
  FOREIGN KEY("isbn_titulo") REFERENCES "titulos"("isbn")
);

CREATE TABLE "usuarios_biblioteca" (
  "codigo" INTEGER,
  "nome" TEXT NOT NULL,
  "identidade" TEXT NULL,
  "cpf" TEXT NULL,
  "endereco" TEXT NOT NULL,
  "sexo" TEXT NOT NULL CHECK("sexo" IN ("M", "F")),
  "data_nascimento" NUMERIC NOT NULL,
  "estado_civil" TEXT NOT NULL CHECK("estado_civil" IN ("C", "S", "D", "V")),
  "matricula_professor" INTEGER NULL,
  PRIMARY KEY ("codigo")
);
