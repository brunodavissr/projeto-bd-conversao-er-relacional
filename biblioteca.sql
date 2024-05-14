CREATE TABLE "unidades_atendimento" (
  "codigo" INTEGER,
  "nome" TEXT NOT NULL,
  "endereco" TEXT NOT NULL
  PRIMARY KEY("codigo")
);

CREATE TABLE "unidades_academicas" (
  "codigo" INTEGER,
  "nome" TEXT NOT NULL UNIQUE,
  PRIMARY KEY("codigo")
);

CREATE TABLE "Disciplina" (
  "codigo" INTEGER,
  "nome" VARCHAR(50) NOT NULL,
  PRIMARY KEY("codigo")
  );

CREATE TABLE "Funcionario_Biblioteca" (
  "codigo" INTEGER,
  "nome" VARCHAR(50) NOT NULL,
  PRIMARY KEY("codigo")
  );

CREATE TABLE "Titulo" (
  "ISBN" CHAR(13) PRIMARY KEY,
  "nome_Titulo" VARCHAR(100) NOT NULL,
  "area_Princip" VARCHAR(100) NOT NULL,
  "assunto" TEXT NOT NULL,
  "area_Secun" VARCHAR(50) NULL,
  "ano_Public" INTEGER NOT NULL,
  "editora" VARCHAR(50) NOT NULL,
  "idioma" TEXT NOT NULL,
  "prazo_Emprestimo_Professor" INTEGER NOT NULL,
  "prazo_Emprestimo_Aluno" INTEGER NOT NULL,
  "numero_Max_Renov" INTEGER NOT NULL
  );

CREATE TABLE "Titulo_Periodico" (
  "
  


  
  
  
