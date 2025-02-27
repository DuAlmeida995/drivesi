--Sequences

CREATE SCHEMA "ENG";

CREATE SEQUENCE "ENG"."SEQ_ID_USUARIO"
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9999
  START 1
  CACHE 20;
ALTER TABLE "ENG"."SEQ_ID_USUARIO" OWNER TO postgres;
COMMENT ON SEQUENCE "ENG"."SEQ_ID_USUARIO" IS 'GERA ID''S DE USU�RIO';


-- Sequence: "ENG"."SEQ_ID_OPCAO"

-- DROP SEQUENCE "ENG"."SEQ_ID_OPCAO";

CREATE SEQUENCE "ENG"."SEQ_ID_OPCAO"
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9999
  START 1
  CACHE 20;
ALTER TABLE "ENG"."SEQ_ID_OPCAO" OWNER TO postgres;
COMMENT ON SEQUENCE "ENG"."SEQ_ID_OPCAO" IS 'GERA ID''S DE OP��O';


-- Sequence: "ENG"."SEQ_ID_DISCUSSAO"

-- DROP SEQUENCE "ENG"."SEQ_ID_DISCUSSAO";

CREATE SEQUENCE "ENG"."SEQ_ID_DISCUSSAO"
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9999
  START 1
  CACHE 20;
ALTER TABLE "ENG"."SEQ_ID_DISCUSSAO" OWNER TO postgres;
COMMENT ON SEQUENCE "ENG"."SEQ_ID_DISCUSSAO" IS 'GERA ID''S DE DISCUSS�O';


-- Sequence: "ENG"."SEQ_ID_VOTACAO"

-- DROP SEQUENCE "ENG"."SEQ_ID_VOTACAO";

CREATE SEQUENCE "ENG"."SEQ_ID_VOTACAO"
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9999
  START 1
  CACHE 20;
ALTER TABLE "ENG"."SEQ_ID_VOTACAO" OWNER TO postgres;
COMMENT ON SEQUENCE "ENG"."SEQ_ID_VOTACAO" IS 'GERA ID''S DE VOTA��O';

-- Sequence: "ENG"."SEQ_ID_GRUPO"

-- DROP SEQUENCE "ENG"."SEQ_ID_GRUPO";

CREATE SEQUENCE "ENG"."SEQ_ID_GRUPO"
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9999
  START 1
  CACHE 20;
ALTER TABLE "ENG"."SEQ_ID_GRUPO" OWNER TO postgres;
COMMENT ON SEQUENCE "ENG"."SEQ_ID_GRUPO" IS 'GERA ID''S DE GRUPO';


ALTER SEQUENCE "ENG"."SEQ_ID_USUARIO" RESTART WITH 1;
ALTER SEQUENCE "ENG"."SEQ_ID_VOTACAO" RESTART WITH 1;
ALTER SEQUENCE "ENG"."SEQ_ID_OPCAO" RESTART WITH 1;
ALTER SEQUENCE "ENG"."SEQ_ID_DISCUSSAO" RESTART WITH 1;
ALTER SEQUENCE "ENG"."SEQ_ID_GRUPO" RESTART WITH 1;

--Tables


-- Table: "ENG"."USUARIO"

-- DROP TABLE "ENG"."USUARIO";

CREATE TABLE "ENG"."USUARIO"
(
  "ID_USUARIO" numeric NOT NULL,
  "NM_LOGIN" character varying NOT NULL,
  "CD_SENHA" numeric NOT NULL,
  "CD_STATUS" numeric(1) DEFAULT 0,
  CONSTRAINT "PK_USUARIO" PRIMARY KEY ("ID_USUARIO"),
  CONSTRAINT "UK_USUARIO" UNIQUE ("NM_LOGIN")
)
WITH (OIDS=FALSE);
ALTER TABLE "ENG"."USUARIO" OWNER TO postgres;


-- Table: "ENG"."OPCAO"

-- DROP TABLE "ENG"."OPCAO";

CREATE TABLE "ENG"."OPCAO"
(
  "ID_OPCAO" numeric NOT NULL,
  "DS_OPCAO" character varying,
  CONSTRAINT "PK_OPCAO" PRIMARY KEY ("ID_OPCAO"),
  CONSTRAINT "UK_OPCAO" UNIQUE ("DS_OPCAO")
)
WITH (OIDS=FALSE);
ALTER TABLE "ENG"."OPCAO" OWNER TO postgres;


-- Table: "ENG"."GRUPO"

-- DROP TABLE "ENG"."GRUPO";

CREATE TABLE "ENG"."GRUPO"
(
  "ID_GRUPO" numeric NOT NULL,
  "NM_GRUPO" character varying,
  CONSTRAINT "PK_GRUPO" PRIMARY KEY ("ID_GRUPO")
)
WITH (OIDS=FALSE);
ALTER TABLE "ENG"."GRUPO" OWNER TO postgres;


-- Table: "ENG"."VOTACAO"

-- DROP TABLE "ENG"."VOTACAO";

CREATE TABLE "ENG"."VOTACAO"
(
  "ID_VOTACAO" numeric NOT NULL,
  "CD_PRIVACIDADE" numeric(1) NOT NULL,
  "CD_DISCUSSAO" numeric(1) NOT NULL,
  "NR_INTERVALO" numeric,
  "DS_TEMA" character varying NOT NULL,
  "DS_DESCRICAO" character varying,
  "DS_PROPONENTE" character varying,
  "DT_VOTACAO" date,
  CONSTRAINT "PK_VOTACAO" PRIMARY KEY ("ID_VOTACAO")
)
WITH (OIDS=FALSE);
ALTER TABLE "ENG"."VOTACAO" OWNER TO postgres;


-- Table: "ENG"."OPCAO_VOTACAO"

-- DROP TABLE "ENG"."OPCAO_VOTACAO";

CREATE TABLE "ENG"."OPCAO_VOTACAO"
(
  "ID_OPCAO" numeric NOT NULL,
  "ID_VOTACAO" numeric NOT NULL,
  CONSTRAINT "PK_OPCAO_VOTACAO" PRIMARY KEY ("ID_OPCAO", "ID_VOTACAO"),
  CONSTRAINT "FK_ID_OPCAO" FOREIGN KEY ("ID_OPCAO")
      REFERENCES "ENG"."OPCAO" ("ID_OPCAO") MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION,
  CONSTRAINT "FK_ID_VOTACAO" FOREIGN KEY ("ID_VOTACAO")
      REFERENCES "ENG"."VOTACAO" ("ID_VOTACAO") MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION
)
WITH (OIDS=FALSE);
ALTER TABLE "ENG"."OPCAO_VOTACAO" OWNER TO postgres;


-- Table: "ENG"."GRUPO_USUARIO"

-- DROP TABLE "ENG"."GRUPO_USUARIO";

CREATE TABLE "ENG"."GRUPO_USUARIO"
(
  "ID_GRUPO" numeric NOT NULL,
  "ID_USUARIO" numeric NOT NULL,
  "CD_STATUS" numeric(1) DEFAULT 0,
  CONSTRAINT "PK_GRUPO_USUARIO" PRIMARY KEY ("ID_GRUPO", "ID_USUARIO"),
  CONSTRAINT "FK_ID_GRUPO" FOREIGN KEY ("ID_GRUPO")
      REFERENCES "ENG"."GRUPO" ("ID_GRUPO") MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION,
  CONSTRAINT "FK_ID_USUARIO" FOREIGN KEY ("ID_USUARIO")
      REFERENCES "ENG"."USUARIO" ("ID_USUARIO") MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION
)
WITH (OIDS=FALSE);
ALTER TABLE "ENG"."GRUPO_USUARIO" OWNER TO postgres;


-- Table: "ENG"."PARTICIPANTE"

-- DROP TABLE "ENG"."PARTICIPANTE";

CREATE TABLE "ENG"."PARTICIPANTE"
(
  "ID_GRUPO" numeric NOT NULL,
  "ID_VOTACAO" numeric NOT NULL,
  CONSTRAINT "PK_PARTICIPANTE" PRIMARY KEY ("ID_GRUPO", "ID_VOTACAO"),
  CONSTRAINT "FK_ID_GRUPO" FOREIGN KEY ("ID_GRUPO")
      REFERENCES "ENG"."GRUPO" ("ID_GRUPO") MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION,
  CONSTRAINT "FK_ID_VOTACAO" FOREIGN KEY ("ID_VOTACAO")
      REFERENCES "ENG"."VOTACAO" ("ID_VOTACAO") MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION
)
WITH (OIDS=FALSE);
ALTER TABLE "ENG"."PARTICIPANTE" OWNER TO postgres;


-- Table: "ENG"."DISCUSSAO"

-- DROP TABLE "ENG"."DISCUSSAO";

CREATE TABLE "ENG"."DISCUSSAO"
(
  "ID_DISCUSSAO" numeric NOT NULL,
  "ID_USUARIO" numeric NOT NULL,
  "ID_VOTACAO" numeric NOT NULL,
  "ID_GRUPO" numeric NOT NULL,
  "DS_DISCUSSAO" character varying,
  CONSTRAINT "PK_DISCUSSAO" PRIMARY KEY ("ID_DISCUSSAO"),
  CONSTRAINT "FK_ID_GRUPO_USUARIO" FOREIGN KEY ("ID_GRUPO", "ID_USUARIO")
      REFERENCES "ENG"."GRUPO_USUARIO" ("ID_GRUPO", "ID_USUARIO") MATCH FULL
      ON UPDATE CASCADE ON DELETE NO ACTION,
  CONSTRAINT "FK_ID_GRUPO_VOTACAO" FOREIGN KEY ("ID_VOTACAO", "ID_GRUPO")
      REFERENCES "ENG"."PARTICIPANTE" ("ID_VOTACAO", "ID_GRUPO") MATCH FULL
      ON UPDATE CASCADE ON DELETE NO ACTION
)
WITH (OIDS=FALSE);
ALTER TABLE "ENG"."DISCUSSAO" OWNER TO postgres;


-- Table: "ENG"."VOTO"

-- DROP TABLE "ENG"."VOTO";

CREATE TABLE "ENG"."VOTO"
(
  "ID_OPCAO" numeric NOT NULL,
  "ID_VOTACAO" numeric NOT NULL,
  "ID_USUARIO" numeric NOT NULL,
  "ID_GRUPO" numeric NOT NULL,
  CONSTRAINT "PK_VOTO" PRIMARY KEY ("ID_OPCAO", "ID_VOTACAO", "ID_USUARIO", "ID_GRUPO"),
  CONSTRAINT "FK_ID_GRUPO_USUARIO" FOREIGN KEY ("ID_GRUPO", "ID_USUARIO")
      REFERENCES "ENG"."GRUPO_USUARIO" ("ID_GRUPO", "ID_USUARIO") MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION,
  CONSTRAINT "FK_ID_GRUPO_VOTACAO" FOREIGN KEY ("ID_GRUPO", "ID_VOTACAO")
      REFERENCES "ENG"."PARTICIPANTE" ("ID_GRUPO", "ID_VOTACAO") MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION,
  CONSTRAINT "FK_ID_OPCAO_VOTACAO" FOREIGN KEY ("ID_OPCAO", "ID_VOTACAO")
      REFERENCES "ENG"."OPCAO_VOTACAO" ("ID_OPCAO", "ID_VOTACAO") MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION
)
WITH (OIDS=FALSE);
ALTER TABLE "ENG"."VOTO" OWNER TO postgres;

--Functions � Servi�os - Inserts


-- Function: "ENG"."INSERE_USUARIO"(numeric, character varying)

-- DROP FUNCTION "ENG"."INSERE_USUARIO"(numeric, character varying);

CREATE LANGUAGE "plpgsql";
CREATE OR REPLACE FUNCTION "ENG"."INSERE_USUARIO"(pcd_senha numeric, pnm_login character varying)
  RETURNS numeric AS
$BODY$
DECLARE
BEGIN
	INSERT INTO "ENG"."USUARIO" ("ID_USUARIO", "NM_LOGIN", "CD_SENHA", "CD_STATUS") VALUES 
		(NEXTVAL('"ENG"."SEQ_ID_USUARIO"'), PNM_LOGIN, PCD_SENHA, 0);
	RETURN CURRVAL('"ENG"."SEQ_ID_USUARIO"');
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;
ALTER FUNCTION "ENG"."INSERE_USUARIO"(numeric, character varying) OWNER TO postgres;
COMMENT ON FUNCTION "ENG"."INSERE_USUARIO"(numeric, character varying) IS 'Insere um Usu�rio no banco';



-- Function: "ENG"."INSERE_OPCAO"(character varying)

-- DROP FUNCTION "ENG"."INSERE_OPCAO"(character varying);

CREATE OR REPLACE FUNCTION "ENG"."INSERE_OPCAO"(pds_opcao character varying)
  RETURNS numeric AS
$BODY$
DECLARE
BEGIN
	INSERT INTO "ENG"."OPCAO" VALUES 
		(NEXTVAL('"ENG"."SEQ_ID_OPCAO"'), PDS_OPCAO);
	RETURN CURRVAL('"ENG"."SEQ_ID_OPCAO"');
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;
ALTER FUNCTION "ENG"."INSERE_OPCAO"(character varying) OWNER TO postgres;
COMMENT ON FUNCTION "ENG"."INSERE_OPCAO"(character varying) IS 'Insere uma opcao de vota��o';


-- Function: "ENG"."INSERE_VOTACAO"(numeric, numeric, numeric, character varying, character varying, character varying, date)

-- DROP FUNCTION "ENG"."INSERE_VOTACAO"(numeric, numeric, numeric, character varying, character varying, character varying, date);

CREATE OR REPLACE FUNCTION "ENG"."INSERE_VOTACAO"(pcd_privacidade numeric, pcd_discussao numeric, pnr_intervalo numeric, pds_tema character varying, pds_descricao character varying, pnm_proponente character varying, pdt_votacao date)
  RETURNS numeric AS
$BODY$
DECLARE
BEGIN
	INSERT INTO "ENG"."VOTACAO" VALUES 
		(NEXTVAL('"ENG"."SEQ_ID_VOTACAO"'),
		 PCD_PRIVACIDADE,
		 PCD_DISCUSSAO,
		 PNR_INTERVALO,
		 PDS_TEMA,
		 PDS_DESCRICAO,
		 PNM_PROPONENTE,
		 PDT_VOTACAO );
	RETURN CURRVAL('"ENG"."SEQ_ID_VOTACAO"');
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;
ALTER FUNCTION "ENG"."INSERE_VOTACAO"(numeric, numeric, numeric, character varying, character varying, character varying, date) OWNER TO postgres;
COMMENT ON FUNCTION "ENG"."INSERE_VOTACAO"(numeric, numeric, numeric, character varying, character varying, character varying, date) IS 'Insere uma votacao';


-- Function: "ENG"."INSERE_PARTICIPANTE"(numeric, numeric)

-- DROP FUNCTION "ENG"."INSERE_PARTICIPANTE"(numeric, numeric);

CREATE OR REPLACE FUNCTION "ENG"."INSERE_PARTICIPANTE"(pid_grupo numeric, pid_votacao numeric)
  RETURNS integer AS
$BODY$
DECLARE
BEGIN
	INSERT INTO "ENG"."PARTICIPANTE" VALUES 
		(PID_GRUPO,
		 PID_VOTACAO);
	
	UPDATE "ENG"."GRUPO_USUARIO"
	SET "CD_STATUS"=0;

	RETURN NULL;

END;


$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;
ALTER FUNCTION "ENG"."INSERE_PARTICIPANTE"(numeric, numeric) OWNER TO postgres;
COMMENT ON FUNCTION "ENG"."INSERE_PARTICIPANTE"(numeric, numeric) IS 'Vincula um grupo a uma vota��o.';

--------------------

-- Function: "ENG"."INSERE_OPCAO_NA_VOT"(numeric, numeric)

-- DROP FUNCTION "ENG"."INSERE_OPCAO_NA_VOT"(numeric, numeric);

CREATE OR REPLACE FUNCTION "ENG"."INSERE_OPCAO_NA_VOT"(pid_opcao numeric, pid_votacao numeric)
  RETURNS integer AS
$BODY$
DECLARE
BEGIN
	INSERT INTO "ENG"."OPCAO_VOTACAO" VALUES 
		(PID_OPCAO,
		 PID_VOTACAO );
	RETURN NULL;
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;
ALTER FUNCTION "ENG"."INSERE_OPCAO_NA_VOT"(numeric, numeric) OWNER TO postgres;
COMMENT ON FUNCTION "ENG"."INSERE_OPCAO_NA_VOT"(numeric, numeric) IS 'Insere uma opcao na votacao';


-- Function: "ENG"."INSERE_DISCUSSAO"(numeric, numeric, numeric, character varying)

-- DROP FUNCTION "ENG"."INSERE_DISCUSSAO"(numeric, numeric, numeric, character varying);

CREATE OR REPLACE FUNCTION "ENG"."INSERE_DISCUSSAO"(pid_usuario numeric, pid_grupo numeric, pid_votacao numeric, pds_discussao character varying)
  RETURNS numeric AS
$BODY$
DECLARE
BEGIN
	INSERT INTO "ENG"."DISCUSSAO" VALUES 
		( NEXTVAL('"ENG"."SEQ_ID_DISCUSSAO"'),
		  PID_USUARIO,
		  PID_VOTACAO,
		  PID_GRUPO,
		  PDS_DISCUSSAO);
	RETURN CURRVAL('"ENG"."SEQ_ID_DISCUSSAO"');
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;
ALTER FUNCTION "ENG"."INSERE_DISCUSSAO"(numeric, numeric, numeric, character varying) OWNER TO postgres;
COMMENT ON FUNCTION "ENG"."INSERE_DISCUSSAO"(numeric, numeric, numeric, character varying) IS 'Insere uma discussao';


-- Function: "ENG"."INSERE_VOTO"(numeric, numeric, numeric, numeric)

-- DROP FUNCTION "ENG"."INSERE_VOTO"(numeric, numeric, numeric, numeric);

CREATE OR REPLACE FUNCTION "ENG"."INSERE_VOTO"(pid_opcao numeric, pid_votacao numeric, pid_usuario numeric, pid_grupo numeric)
  RETURNS integer AS
$BODY$
DECLARE
BEGIN
	INSERT INTO "ENG"."VOTO" VALUES 
		( PID_OPCAO ,
		  PID_VOTACAO ,
		  PID_USUARIO,
		  PID_GRUPO );
	RETURN NULL;
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;
ALTER FUNCTION "ENG"."INSERE_VOTO"(numeric, numeric, numeric, numeric) OWNER TO postgres;
COMMENT ON FUNCTION "ENG"."INSERE_VOTO"(numeric, numeric, numeric, numeric) IS 'Insere um Voto';

----------------------------------


-- Function: "ENG"."INSERE_GRUPO"(character varying)

-- DROP FUNCTION "ENG"."INSERE_GRUPO"(character varying);

CREATE OR REPLACE FUNCTION "ENG"."INSERE_GRUPO"(pnm_grupo character varying)
  RETURNS integer AS
$BODY$
DECLARE
BEGIN
	INSERT INTO "ENG"."GRUPO" VALUES 
		( NEXTVAL('"ENG"."SEQ_ID_GRUPO"') ,
		  PNM_GRUPO );
	RETURN CURRVAL('"ENG"."SEQ_ID_GRUPO"');
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;
ALTER FUNCTION "ENG"."INSERE_GRUPO"(character varying) OWNER TO postgres;
COMMENT ON FUNCTION "ENG"."INSERE_GRUPO"(character varying) IS 'Insere um grupo';

------------

-- Function: "ENG"."INSERE_USUARIO_EM_GRUPO"(numeric, numeric)

-- DROP FUNCTION "ENG"."INSERE_USUARIO_EM_GRUPO"(numeric, numeric);

CREATE OR REPLACE FUNCTION "ENG"."INSERE_USUARIO_EM_GRUPO"(pid_grupo numeric, pid_usuario numeric)
  RETURNS integer AS
$BODY$
DECLARE
BEGIN
	INSERT INTO "ENG"."GRUPO_USUARIO" VALUES 
		( PID_GRUPO,
		  PID_USUARIO);
	RETURN NULL;
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;
ALTER FUNCTION "ENG"."INSERE_USUARIO_EM_GRUPO"(numeric, numeric) OWNER TO postgres;
COMMENT ON FUNCTION "ENG"."INSERE_USUARIO_EM_GRUPO"(numeric, numeric) IS 'Insere um usu�rio em um grupo';

--Functions � Servi�os - Consultas


-- Function: "ENG"."CONSULTA_LOGIN"(numeric, character varying)

-- DROP FUNCTION "ENG"."CONSULTA_LOGIN"(numeric, character varying);

CREATE OR REPLACE FUNCTION "ENG"."CONSULTA_LOGIN"(pcd_senha numeric, pnm_login character varying)
  RETURNS boolean AS
$BODY$
DECLARE
VCD_SINAL BOOLEAN; 
BEGIN
	SELECT CASE "CD_SENHA" WHEN PCD_SENHA THEN TRUE ELSE FALSE END INTO VCD_SINAL
	FROM "ENG"."USUARIO" 
	WHERE "NM_LOGIN" = PNM_LOGIN;

	RETURN VCD_SINAL;
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;
ALTER FUNCTION "ENG"."CONSULTA_LOGIN"(numeric, character varying) OWNER TO postgres;
COMMENT ON FUNCTION "ENG"."CONSULTA_LOGIN"(numeric, character varying) IS 'Consulta se o Login � valido retornando TRUE/FALSE';


-- Function: "ENG"."VERIFICA_STATUS_VOT"(numeric)

-- DROP FUNCTION "ENG"."VERIFICA_STATUS_VOT"(numeric);

CREATE OR REPLACE FUNCTION "ENG"."VERIFICA_STATUS_VOT"(pid_votacao numeric)
  RETURNS boolean AS
$BODY$
DECLARE
VCD_STATUS INTEGER;
BEGIN
	SELECT COUNT(*) INTO VCD_STATUS
	FROM "ENG"."PARTICIPANTE" PART, "ENG"."GRUPO_USUARIO" GRU 
	WHERE PART."ID_VOTACAO" = PID_VOTACAO AND PART."ID_GRUPO" = GRU."ID_GRUPO" AND GRU."CD_STATUS" = 0;
	
	IF (VCD_STATUS = 0) THEN 
	 RETURN TRUE;
	ELSE 
	 RETURN FALSE;
	END IF;	
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;
ALTER FUNCTION "ENG"."VERIFICA_STATUS_VOT"(numeric) OWNER TO postgres;
COMMENT ON FUNCTION "ENG"."VERIFICA_STATUS_VOT"(numeric) IS 'Consulta se todos os participantes confirmaram a participa��o em uma vota��o';


CREATE OR REPLACE FUNCTION "ENG"."CONTA_VOTOS"(PID_VOTACAO numeric, PID_OPCAO NUMERIC)
  RETURNS NUMERIC AS
$BODY$
DECLARE
VRESULT NUMERIC(1);
BEGIN
	SELECT VOTO.COUNT(*) INTO VRESULT
	FROM "ENG"."VOTO" VOTO 
	WHERE VOTO.ID_VOTACAO = PID_VOTACAO AND VOTO.ID_OPCAO = PID_OPCAO;
	
	RETURN VRESULT;	
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;
ALTER FUNCTION "ENG"."CONTA_VOTOS"(numeric, numeric) OWNER TO postgres;
COMMENT ON FUNCTION "ENG"."CONTA_VOTOS"(numeric, numeric) IS 'Consulta a quantidade de votos de determinada op��o numa vota��o especificada';



--DROP FUNCTION "ENG"."OPCAO_MAIS_VOTADA"(numeric);

CREATE OR REPLACE FUNCTION "ENG"."OPCAO_MAIS_VOTADA"(PID_VOTACAO numeric)
  RETURNS RECORD AS
$BODY$
DECLARE
VRESULT RECORD;
BEGIN	
	SELECT OP.ID_OPCAO, OP.DS_OPCAO, MAX(COUNT(*)) INTO VRESULT
	FROM "ENG"."OPCAO" OP, "ENG"."VOTO" VOTO
	WHERE VOTO.ID_VOTACAO = PID_VOTACAO AND VOTO.ID_OPCAO = OP.ID_OPCAO;
	
	RETURN VRESULT;	
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;
ALTER FUNCTION "ENG"."OPCAO_MAIS_VOTADA"(numeric) OWNER TO postgres;
COMMENT ON FUNCTION "ENG"."OPCAO_MAIS_VOTADA"(numeric) IS 'Consulta a op��o mais votada em uma vota��o especificada';


-- Function: "ENG"."RECUPERA_SENHA"(character varying)

-- DROP FUNCTION "ENG"."RECUPERA_SENHA"(character varying);

CREATE OR REPLACE FUNCTION "ENG"."RECUPERA_SENHA"(pnm_login character varying)
  RETURNS numeric AS
$BODY$
DECLARE
VRESULT NUMERIC;
BEGIN	
	SELECT USU."CD_SENHA" INTO VRESULT
	FROM "ENG"."USUARIO" USU
	WHERE USU."NM_LOGIN" = PNM_LOGIN;
	
	RETURN VRESULT;	
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;
ALTER FUNCTION "ENG"."RECUPERA_SENHA"(character varying) OWNER TO postgres;
COMMENT ON FUNCTION "ENG"."RECUPERA_SENHA"(character varying) IS 'Retorna a senha dado um nome de login';


-- Function: "ENG"."CONSULTA_DISCUSSAO_USU"(numeric, numeric)

-- DROP FUNCTION "ENG"."CONSULTA_DISCUSSAO_USU"(numeric, numeric);

CREATE OR REPLACE FUNCTION "ENG"."CONSULTA_DISCUSSAO_USU"(pid_votacao numeric, pid_usuario numeric)
  RETURNS SETOF record AS
$BODY$
DECLARE
VRESULT RECORD;
BEGIN	
	FOR VRESULT IN 
	SELECT DIS."DS_DISCUSSAO" 
	FROM "ENG"."DISCUSSAO" DIS
	WHERE DIS."ID_USUARIO" = PID_USUARIO AND DIS."ID_VOTACAO" = PID_VOTACAO
	LOOP
	RETURN NEXT VRESULT;	
	END LOOP;
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION "ENG"."CONSULTA_DISCUSSAO_USU"(numeric, numeric) OWNER TO postgres;
COMMENT ON FUNCTION "ENG"."CONSULTA_DISCUSSAO_USU"(numeric, numeric) IS 'Consulta todas as discuss�es de um participante em determinada vota��o';

-------------------OU (ACIMA = TDS LINHAS, ABAIXO = UMA LINHA)

CREATE OR REPLACE FUNCTION "ENG"."CONSULTA_DISCUSSAO_USU"(PID_VOTACAO NUMERIC, PID_USUARIO NUMERIC, PID_DISCUSSAO NUMERIC)
  RETURNS character varying AS
$BODY$
DECLARE
VRESULT character varying;
BEGIN	
	SELECT DIS.DS_DISCUSSAO INTO  VRESULT 
	FROM "ENG"."DISCUSSAO" DIS
	WHERE DIS.ID_USUARIO = PID_USUARIO AND DIS.ID_VOTACAO = PID_VOTACAO AND DIS.ID_DISCUSSAO = PID_DISCUSSAO;
	
	RETURN VRESULT;	
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;
ALTER FUNCTION "ENG"."CONSULTA_DISCUSSAO_USU"(NUMERIC, NUMERIC, NUMERIC) OWNER TO postgres;
COMMENT ON FUNCTION "ENG"."CONSULTA_DISCUSSAO_USU"(NUMERIC, NUMERIC, NUMERIC) IS 'Consulta a �ltima discuss�o de um participante';


-- Function: "ENG"."CONSULTA_DISCUSSAO"(numeric)

-- DROP FUNCTION "ENG"."CONSULTA_DISCUSSAO"(numeric);

CREATE OR REPLACE FUNCTION "ENG"."CONSULTA_DISCUSSAO"(pid_votacao numeric)
  RETURNS SETOF record AS
$BODY$
DECLARE
VRESULT RECORD;
BEGIN	
	FOR VRESULT IN 
	SELECT DIS."ID_USUARIO", DIS."DS_DISCUSSAO" 
	FROM "ENG"."DISCUSSAO" DIS
	WHERE DIS."ID_VOTACAO" = PID_VOTACAO
	LOOP
	RETURN NEXT VRESULT;	
	END LOOP;
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION "ENG"."CONSULTA_DISCUSSAO"(numeric) OWNER TO postgres;
COMMENT ON FUNCTION "ENG"."CONSULTA_DISCUSSAO"(numeric) IS 'Consulta os registros de discuss�o de uma dada vota��o';


-- Function: "ENG"."CONSULTA_OPCOES"(numeric)

-- DROP FUNCTION "ENG"."CONSULTA_OPCOES"(numeric);

CREATE OR REPLACE FUNCTION "ENG"."CONSULTA_OPCOES"(pid_votacao numeric)
  RETURNS SETOF record AS
$BODY$
DECLARE
VRESULT RECORD;
BEGIN	
	FOR VRESULT IN 
	SELECT OP."ID_OPCAO", OP."DS_OPCAO" 
	FROM "ENG"."OPCAO_VOTACAO" OV, "ENG"."OPCAO" OP
	WHERE OV."ID_VOTACAO" = PID_VOTACAO AND OP."ID_OPCAO" = OV."ID_OPCAO"
	LOOP
	RETURN NEXT VRESULT;	
	END LOOP;
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION "ENG"."CONSULTA_OPCOES"(numeric) OWNER TO postgres;
COMMENT ON FUNCTION "ENG"."CONSULTA_OPCOES"(numeric) IS 'Consulta as op��es de dada uma vota��o';


-- Function: "ENG"."CONFIRMA_USUARIO"(character varying)

-- DROP FUNCTION "ENG"."CONFIRMA_USUARIO"(character varying);

CREATE OR REPLACE FUNCTION "ENG"."CONFIRMA_USUARIO"(pnm_login character varying)
  RETURNS numeric AS
$BODY$
DECLARE
BEGIN	
	UPDATE "ENG"."USUARIO"
	SET "CD_STATUS" = 1
	WHERE "NM_LOGIN" = PNM_LOGIN;

	RETURN NULL;
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;
ALTER FUNCTION "ENG"."CONFIRMA_USUARIO"(character varying) OWNER TO postgres;
COMMENT ON FUNCTION "ENG"."CONFIRMA_USUARIO"(character varying) IS 'Confirma cadastro de usu�rio';


-- Function: "ENG"."CONFIRMA_PARTICIPACAO"(numeric, numeric)

-- DROP FUNCTION "ENG"."CONFIRMA_PARTICIPACAO"(numeric, numeric);

CREATE OR REPLACE FUNCTION "ENG"."CONFIRMA_PARTICIPACAO"(pid_usuario numeric, pid_grupo numeric)
  RETURNS numeric AS
$BODY$
DECLARE
BEGIN	
	UPDATE "ENG"."GRUPO_USUARIO" 
	SET "CD_STATUS" = 1
	WHERE "ID_USUARIO" = PID_USUARIO AND "ID_GRUPO" = PID_GRUPO;

	RETURN NULL;
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;
ALTER FUNCTION "ENG"."CONFIRMA_PARTICIPACAO"(numeric, numeric) OWNER TO postgres;
COMMENT ON FUNCTION "ENG"."CONFIRMA_PARTICIPACAO"(numeric, numeric) IS 'Confirma a participa��o de um usu�rio em uma vota��o';


-- Function: "ENG"."ALTERA_USUARIO"(character varying)

-- DROP FUNCTION "ENG"."ALTERA_USUARIO"(character varying);

CREATE OR REPLACE FUNCTION "ENG"."ALTERA_USUARIO"(pnm_login character varying)
  RETURNS numeric AS
$BODY$
DECLARE
BEGIN	
	UPDATE "ENG"."USUARIO"
	SET "CD_STATUS" = 1 ------------DADOS
	WHERE "NM_LOGIN" = PNM_LOGIN;

	RETURN NULL;
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;
ALTER FUNCTION "ENG"."ALTERA_USUARIO"(character varying) OWNER TO postgres;
COMMENT ON FUNCTION "ENG"."ALTERA_USUARIO"(character varying) IS 'Confirma o cadastro de um usu�rio';


-- Function: "ENG"."DELETA_USUARIO"(character varying)

-- DROP FUNCTION "ENG"."DELETA_USUARIO"(character varying);

CREATE OR REPLACE FUNCTION "ENG"."DELETA_USUARIO"(pnm_login character varying)
  RETURNS numeric AS
$BODY$
DECLARE
BEGIN	
	DELETE FROM "ENG"."USUARIO"
	WHERE "NM_LOGIN" = PNM_LOGIN;

	RETURN NULL;
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;
ALTER FUNCTION "ENG"."DELETA_USUARIO"(character varying) OWNER TO postgres;
COMMENT ON FUNCTION "ENG"."DELETA_USUARIO"(character varying) IS 'Exclui um usu�rio';

---OBS: O MSM ID DE UM USU�RIO REMOVIDO N�O PODER� SER USADO PARA OUTRO USU�RIO, POIS AS OUTRAS TABELAS AINDA O UTILIZA. E TAMB�M � GERADO POR SEQUENCE, N�O VAI ACONTECER DE GERAR O MESMO, A N�O SER POR INPUT MANUAL!


-- Function: "ENG"."CONSULTA_USUARIO"(character varying)

-- DROP FUNCTION "ENG"."CONSULTA_USUARIO"(character varying);

CREATE OR REPLACE FUNCTION "ENG"."CONSULTA_USUARIO"(pnm_login character varying)
  RETURNS record AS
$BODY$
DECLARE
VRESULT RECORD;
BEGIN	
	SELECT * INTO VRESULT
	FROM "ENG"."USUARIO" USU
	WHERE USU."NM_LOGIN" = PNM_LOGIN;

	RETURN VRESULT;
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;
ALTER FUNCTION "ENG"."CONSULTA_USUARIO"(character varying) OWNER TO postgres;
COMMENT ON FUNCTION "ENG"."CONSULTA_USUARIO"(character varying) IS 'Consulta todas as informa��es de um usu�rio';



-- Function: "ENG"."CONSULTA_GRUPO_VOTACAO"(numeric)

-- DROP FUNCTION "ENG"."CONSULTA_GRUPO_VOTACAO"(numeric);

CREATE OR REPLACE FUNCTION "ENG"."CONSULTA_GRUPO_VOTACAO"(pid_votacao numeric)
  RETURNS SETOF record AS
$BODY$
DECLARE
VRESULT RECORD;
BEGIN
	FOR VRESULT IN 
	SELECT USU."ID_USUARIO", USU."NM_LOGIN", GRU."CD_STATUS" 
	FROM "ENG"."USUARIO" USU, "ENG"."PARTICIPANTE" PART, "ENG"."GRUPO_USUARIO" GRU 
	WHERE PART."ID_VOTACAO" = PID_VOTACAO AND PART."ID_GRUPO" = GRU."ID_GRUPO" AND GRU."ID_USUARIO" = USU."ID_USUARIO"
	LOOP
	RETURN NEXT VRESULT;
	END LOOP;

	--RETURN VRESULT;	
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100
  ROWS 1000;

ALTER FUNCTION "ENG"."CONSULTA_GRUPO_VOTACAO"(numeric) OWNER TO postgres;
COMMENT ON FUNCTION "ENG"."CONSULTA_GRUPO_VOTACAO"(numeric) IS 'Consulta os usu�rios dos grupos vinculados a uma determinada vota��o';

-- Function: "ENG"."CONSULTA_GRUPO"(numeric)

-- DROP FUNCTION "ENG"."CONSULTA_GRUPO"(numeric);

CREATE OR REPLACE FUNCTION "ENG"."CONSULTA_GRUPO"(pid_grupo numeric)
  RETURNS SETOF record AS
$BODY$
DECLARE
VRESULT RECORD;
BEGIN	
	FOR VRESULT IN
	SELECT USU."NM_LOGIN"
	FROM "ENG"."USUARIO" USU, "ENG"."GRUPO_USUARIO" GRU
	WHERE GRU."ID_GRUPO" = PID_GRUPO AND GRU."ID_USUARIO" = USU."ID_USUARIO"
	LOOP
	RETURN NEXT VRESULT;
	END LOOP;
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION "ENG"."CONSULTA_GRUPO"(numeric) OWNER TO postgres;
COMMENT ON FUNCTION "ENG"."CONSULTA_GRUPO"(numeric) IS 'Consulta os logins dos integrantes de um dado grupo de usu�rios';


-- Function: "ENG"."CONTA_GRUPO"(numeric)

-- DROP FUNCTION "ENG"."CONTA_GRUPO"(numeric);

CREATE OR REPLACE FUNCTION "ENG"."CONTA_GRUPO"(pid_grupo numeric)
  RETURNS numeric AS
$BODY$
DECLARE
VRESULT NUMERIC(1);
BEGIN
	SELECT COUNT(GRU.*) INTO VRESULT
	FROM "ENG"."GRUPO_USUARIO" GRU 
	WHERE GRU."ID_GRUPO" = PID_GRUPO;
	
	RETURN VRESULT;	
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;
ALTER FUNCTION "ENG"."CONTA_GRUPO"(numeric) OWNER TO postgres;
COMMENT ON FUNCTION "ENG"."CONTA_GRUPO"(numeric) IS 'Quantidade de participantes de determinado grupo';

-- Function: "ENG"."CONSULTA_ID_USUARIO"(character varying)

-- DROP FUNCTION "ENG"."CONSULTA_ID_USUARIO"(character varying);

CREATE OR REPLACE FUNCTION "ENG"."CONSULTA_ID_USUARIO"(pnm_login character varying)
  RETURNS numeric AS
$BODY$
DECLARE
VRESULT NUMERIC;
BEGIN	
	SELECT USU."ID_USUARIO" INTO VRESULT
	FROM "ENG"."USUARIO" USU
	WHERE USU."NM_LOGIN" = PNM_LOGIN;

	RETURN VRESULT;
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;
ALTER FUNCTION "ENG"."CONSULTA_ID_USUARIO"(character varying) OWNER TO postgres;
COMMENT ON FUNCTION "ENG"."CONSULTA_ID_USUARIO"(character varying) IS 'Consulta o id de um usu�rio atrav�s de seu nm_login';

-- Function: "ENG"."CONSULTA_ID_GRUPOS"()

-- DROP FUNCTION "ENG"."CONSULTA_ID_GRUPOS"();

CREATE OR REPLACE FUNCTION "ENG"."CONSULTA_ID_GRUPOS"()
  RETURNS SETOF record AS
$BODY$
DECLARE
VRESULT RECORD;
BEGIN
	FOR VRESULT IN 
	SELECT GRU."ID_GRUPO", GRU."NM_GRUPO"  
	FROM "ENG"."GRUPO" GRU 	
	LOOP
	RETURN NEXT VRESULT;
	END LOOP;

	--RETURN VRESULT;	
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION "ENG"."CONSULTA_ID_GRUPOS"() OWNER TO postgres;
COMMENT ON FUNCTION "ENG"."CONSULTA_ID_GRUPOS"() IS 'Consulta o Id e o nome dos grupos';

-- Function: "ENG"."CONSULTA_NM_LOGIN"(numeric)

-- DROP FUNCTION "ENG"."CONSULTA_NM_LOGIN"(numeric);

CREATE OR REPLACE FUNCTION "ENG"."CONSULTA_NM_LOGIN"(ID_USR numeric)
  RETURNS character varying AS
$BODY$
DECLARE
VRESULT character varying;
BEGIN	
	SELECT USU."NM_LOGIN" INTO VRESULT
	FROM "ENG"."USUARIO" USU
	WHERE USU."ID_USUARIO" = ID_USR;

	RETURN VRESULT;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "ENG"."CONSULTA_NM_LOGIN"(numeric) OWNER TO postgres;
COMMENT ON FUNCTION "ENG"."CONSULTA_NM_LOGIN"(numeric) IS 'Consulta o nome de um usu�rio atrav�s de seu id_usuario';

-- Function: "ENG"."CONSULTA_GRUPO_USUARIO"(numeric)

-- DROP FUNCTION "ENG"."CONSULTA_GRUPO_USUARIO"(numeric);

CREATE OR REPLACE FUNCTION "ENG"."CONSULTA_GRUPO_USUARIO"(id_usuario numeric)
  RETURNS SETOF record AS
$BODY$
DECLARE
VRESULT RECORD;
BEGIN	
	FOR VRESULT IN
	SELECT GP."ID_GRUPO", GP."NM_GRUPO" 
	FROM "ENG"."GRUPO_USUARIO" GRU, "ENG"."GRUPO" GP
	WHERE GRU."ID_USUARIO" = ID_USUARIO AND GRU."ID_GRUPO" = GP."ID_GRUPO" 
	LOOP
	RETURN NEXT VRESULT;
	END LOOP;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION "ENG"."CONSULTA_GRUPO_USUARIO"(numeric) OWNER TO postgres;
COMMENT ON FUNCTION "ENG"."CONSULTA_GRUPO_USUARIO"(numeric) IS 'Consulta os grupos de um dado usu�rio';

-- Function: "ENG"."CONSULTA_VOTACAO_USU"(numeric)

-- DROP FUNCTION "ENG"."CONSULTA_VOTACAO_USU"(numeric);

CREATE OR REPLACE FUNCTION "ENG"."CONSULTA_VOTACAO_USU"(pid_usuario numeric)
  RETURNS SETOF numeric AS
$BODY$
DECLARE
VRESULT NUMERIC;
BEGIN	
	FOR VRESULT IN 
	SELECT PART."ID_VOTACAO" -- VOT."ID_VOTACAO", VOT."DS_TEMA" -- DEMAIS CAMPOS DA TABELA VOTA��O 
	FROM  "ENG"."GRUPO_USUARIO" GU, "ENG"."PARTICIPANTE" PART
	WHERE GU."ID_USUARIO" = pid_usuario AND GU."ID_GRUPO" = PART."ID_GRUPO" -- AND PART."ID_VOTACAO" = VOT."ID_VOTACAO"
	LOOP
	RETURN NEXT VRESULT;	
	END LOOP;
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION "ENG"."CONSULTA_VOTACAO_USU"(numeric) OWNER TO postgres;
COMMENT ON FUNCTION "ENG"."CONSULTA_VOTACAO_USU"(numeric) IS 'Retorna as op��es de dada uma vota��o';
