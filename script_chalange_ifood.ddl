-- Gerado por Oracle SQL Developer Data Modeler 21.4.1.349.1605
--   em:        2022-06-07 18:33:10 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE enderecar (
    t_local_cd_local       NUMBER NOT NULL,
    t_endereco_cd_endereco NUMBER NOT NULL
);

ALTER TABLE enderecar ADD CONSTRAINT relation_14_pk PRIMARY KEY ( t_local_cd_local,
                                                                  t_endereco_cd_endereco );

CREATE TABLE entregar (
    t_entregador_cd_entregador NUMBER NOT NULL,
    t_entrega_cd_entrega       NUMBER NOT NULL
);

ALTER TABLE entregar ADD CONSTRAINT entregar_pk PRIMARY KEY ( t_entregador_cd_entregador,
                                                              t_entrega_cd_entrega );

CREATE TABLE t_avaliacao_cliente (
    cd_avalicao                NUMBER NOT NULL,
    t_entregador_cd_entregador NUMBER,
    cd_consumidor              NUMBER NOT NULL,
    nt_consumidor              NUMBER NOT NULL,
    mv_nota                    VARCHAR2(100)
);

CREATE UNIQUE INDEX t_avaliacao_cliente__idx ON
    t_avaliacao_cliente (
        t_entregador_cd_entregador
    ASC );

ALTER TABLE t_avaliacao_cliente ADD CONSTRAINT t_avaliacao_cliente_pk PRIMARY KEY ( cd_avalicao );

CREATE TABLE t_combustivel (
    cd_combustivel     NUMBER NOT NULL,
    t_regiao_cd_regiao NUMBER,
    cd_endereço        NUMBER NOT NULL,
    vl_combustivel     FLOAT NOT NULL,
    tp_combustivel     VARCHAR2(25) NOT NULL
);

CREATE UNIQUE INDEX t_combustivel__idx ON
    t_combustivel (
        t_regiao_cd_regiao
    ASC );

ALTER TABLE t_combustivel ADD CONSTRAINT t_combustivel_pk PRIMARY KEY ( cd_combustivel );

CREATE TABLE t_consumidor (
    cd_consumidor          NUMBER NOT NULL,
    t_entrega_cd_entrega   NUMBER NOT NULL,
    t_endereco_cd_endereco NUMBER NOT NULL,
    nm_consumidor          VARCHAR2(25) NOT NULL,
    cd_entrega             NUMBER NOT NULL,
    vl_gorjeta             FLOAT
);

CREATE UNIQUE INDEX t_consumidor__idx ON
    t_consumidor (
        t_endereco_cd_endereco
    ASC );

CREATE UNIQUE INDEX t_consumidor__idxv1 ON
    t_consumidor (
        t_entrega_cd_entrega
    ASC );

ALTER TABLE t_consumidor ADD CONSTRAINT t_consumidor_pk PRIMARY KEY ( cd_consumidor );

CREATE TABLE t_endereco (
    cd_endereco                NUMBER NOT NULL,
    t_consumidor_cd_consumidor NUMBER NOT NULL,
    t_regiao_cd_regiao         NUMBER NOT NULL,
    nm_endereco                VARCHAR2(50) NOT NULL,
    nr_endereco                NUMBER NOT NULL,
    nm_bairro                  VARCHAR2(50) NOT NULL,
    nr_cep                     NUMBER NOT NULL
);

CREATE UNIQUE INDEX t_endereco__idx ON
    t_endereco (
        t_regiao_cd_regiao
    ASC );

CREATE UNIQUE INDEX t_endereco__idxv1 ON
    t_endereco (
        t_consumidor_cd_consumidor
    ASC );

ALTER TABLE t_endereco ADD CONSTRAINT t_endereco_pk PRIMARY KEY ( cd_endereco );

CREATE TABLE t_entrega (
    cd_entrega                 NUMBER NOT NULL,
    t_local_cd_local           NUMBER NOT NULL,
    t_consumidor_cd_consumidor NUMBER NOT NULL,
    cd_local                   NUMBER NOT NULL,
    nm_consumidor              VARCHAR2(25) NOT NULL,
    nm_local                   VARCHAR2(25) NOT NULL,
    tp_entrega                 VARCHAR2(25) NOT NULL,
    tx_entrega                 FLOAT,
    cg_consumidor              NUMBER
);

CREATE UNIQUE INDEX t_entrega__idx ON
    t_entrega (
        t_consumidor_cd_consumidor
    ASC );

CREATE UNIQUE INDEX t_entrega__idxv1 ON
    t_entrega (
        t_local_cd_local
    ASC );

ALTER TABLE t_entrega ADD CONSTRAINT t_entrega_pk PRIMARY KEY ( cd_entrega );

CREATE TABLE t_entregador (
    cd_entregador NUMBER NOT NULL,
    nm_entregador VARCHAR2(25) NOT NULL,
    tp_veiculo    VARCHAR2(25) NOT NULL,
    pc_veiculo    NUMBER NOT NULL,
    nr_telefone   NUMBER NOT NULL,
    ft_entregador BLOB NOT NULL
);

ALTER TABLE t_entregador ADD CONSTRAINT t_entregador_pk PRIMARY KEY ( cd_entregador );

CREATE TABLE t_local (
    cd_local             NUMBER NOT NULL,
    t_entrega_cd_entrega NUMBER NOT NULL,
    nm_local             VARCHAR2(25) NOT NULL,
    nr_telefone          NUMBER NOT NULL
);

CREATE UNIQUE INDEX t_local__idx ON
    t_local (
        t_entrega_cd_entrega
    ASC );

ALTER TABLE t_local ADD CONSTRAINT t_local_pk PRIMARY KEY ( cd_local );

CREATE TABLE t_regiao (
    cd_regiao                  NUMBER NOT NULL,
    t_entregador_cd_entregador NUMBER,
    t_endereco_cd_endereco     NUMBER NOT NULL,
    nt_regiao                  NUMBER NOT NULL,
    av_regiao                  NUMBER NOT NULL,
    av_iluminacao              NUMBER,
    av_seguranca               NUMBER,
    av_asfaltamento            NUMBER,
    av_inclinacao              NUMBER,
    av_dificuldade             NUMBER
);

CREATE UNIQUE INDEX t_regiao__idx ON
    t_regiao (
        t_entregador_cd_entregador
    ASC );

CREATE UNIQUE INDEX t_regiao__idxv1 ON
    t_regiao (
        t_endereco_cd_endereco
    ASC );

ALTER TABLE t_regiao ADD CONSTRAINT t_regiao_pk PRIMARY KEY ( cd_regiao );

CREATE TABLE t_tp_combustivel (
    t_combustivel_cd_combustivel NUMBER NOT NULL,
    tp_gasolina_aditivada        VARCHAR2(25),
    tp_gasolina_preminum         VARCHAR2(25),
    tp_gasolina_comum            VARCHAR2(25),
    tp_alcool                    VARCHAR2(25)
);

ALTER TABLE t_tp_combustivel ADD CONSTRAINT t_tp_combustivel_pk PRIMARY KEY ( t_combustivel_cd_combustivel );

CREATE TABLE t_ultimas_entregas (
    t_entrega_cd_entrega NUMBER NOT NULL,
    dt_entrega           NUMBER NOT NULL,
    tp_entrega           VARCHAR2(25),
    rg_entrega           VARCHAR2(50),
    vl_gorjeta           FLOAT,
    nt_avaliacao_cliente FLOAT,
    vl_entrega           FLOAT
);

ALTER TABLE t_ultimas_entregas ADD CONSTRAINT t_ultimas_entregas_pk PRIMARY KEY ( t_entrega_cd_entrega );

ALTER TABLE entregar
    ADD CONSTRAINT entregar_t_entrega_fk FOREIGN KEY ( t_entrega_cd_entrega )
        REFERENCES t_entrega ( cd_entrega );

ALTER TABLE entregar
    ADD CONSTRAINT entregar_t_entregador_fk FOREIGN KEY ( t_entregador_cd_entregador )
        REFERENCES t_entregador ( cd_entregador );

ALTER TABLE enderecar
    ADD CONSTRAINT relation_14_t_endereco_fk FOREIGN KEY ( t_endereco_cd_endereco )
        REFERENCES t_endereco ( cd_endereco );

ALTER TABLE enderecar
    ADD CONSTRAINT relation_14_t_local_fk FOREIGN KEY ( t_local_cd_local )
        REFERENCES t_local ( cd_local );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_avaliacao_cliente
    ADD CONSTRAINT t_avaliacao_cliente_t_entregador_fk FOREIGN KEY ( t_entregador_cd_entregador )
        REFERENCES t_entregador ( cd_entregador );

ALTER TABLE t_combustivel
    ADD CONSTRAINT t_combustivel_t_regiao_fk FOREIGN KEY ( t_regiao_cd_regiao )
        REFERENCES t_regiao ( cd_regiao );

ALTER TABLE t_consumidor
    ADD CONSTRAINT t_consumidor_t_endereco_fk FOREIGN KEY ( t_endereco_cd_endereco )
        REFERENCES t_endereco ( cd_endereco );

ALTER TABLE t_consumidor
    ADD CONSTRAINT t_consumidor_t_entrega_fk FOREIGN KEY ( t_entrega_cd_entrega )
        REFERENCES t_entrega ( cd_entrega );

ALTER TABLE t_endereco
    ADD CONSTRAINT t_endereco_t_consumidor_fk FOREIGN KEY ( t_consumidor_cd_consumidor )
        REFERENCES t_consumidor ( cd_consumidor );

ALTER TABLE t_endereco
    ADD CONSTRAINT t_endereco_t_regiao_fk FOREIGN KEY ( t_regiao_cd_regiao )
        REFERENCES t_regiao ( cd_regiao );

ALTER TABLE t_entrega
    ADD CONSTRAINT t_entrega_t_consumidor_fk FOREIGN KEY ( t_consumidor_cd_consumidor )
        REFERENCES t_consumidor ( cd_consumidor );

ALTER TABLE t_entrega
    ADD CONSTRAINT t_entrega_t_local_fk FOREIGN KEY ( t_local_cd_local )
        REFERENCES t_local ( cd_local );

ALTER TABLE t_local
    ADD CONSTRAINT t_local_t_entrega_fk FOREIGN KEY ( t_entrega_cd_entrega )
        REFERENCES t_entrega ( cd_entrega );

ALTER TABLE t_regiao
    ADD CONSTRAINT t_regiao_t_endereco_fk FOREIGN KEY ( t_endereco_cd_endereco )
        REFERENCES t_endereco ( cd_endereco );

ALTER TABLE t_regiao
    ADD CONSTRAINT t_regiao_t_entregador_fk FOREIGN KEY ( t_entregador_cd_entregador )
        REFERENCES t_entregador ( cd_entregador );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_tp_combustivel
    ADD CONSTRAINT t_tp_combustivel_t_combustivel_fk FOREIGN KEY ( t_combustivel_cd_combustivel )
        REFERENCES t_combustivel ( cd_combustivel );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_ultimas_entregas
    ADD CONSTRAINT t_ultimas_entregas_t_entrega_fk FOREIGN KEY ( t_entrega_cd_entrega )
        REFERENCES t_entrega ( cd_entrega );



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            12
-- CREATE INDEX                            11
-- ALTER TABLE                             29
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   3
-- WARNINGS                                 0
