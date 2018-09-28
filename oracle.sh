0. oracle download
   http://www.oracle.com
   
1. 오라클 엔진 설치(INSTALL)
   1] 오라클 엔진 설치 - http://raccoonjy.tistory.com/19?category=748711
   2] 오라클 데이터베이스 생성 - http://raccoonjy.tistory.com/20
   3] listener.ora 및 tnsname.ora 설정 - http://raccoonjy.tistory.com/21?category=748711
   4] initTESTDB.ora(spfileTESTDB.ora) 설정 변경
   
2. 스키마 및 오브젝트 생성 순서
DB 생성이 되어 있다는 가정으로 다음과 같은 순서로

스키마(SCHEMA) 및 OBJECT를 생성한다면 무난할 것이다.

   1] 데이터파일을 저장할 Directory를 생성 
      % su - oracle
      % mkdir -p /data01/TESTDB
      % mkdir -p /data02/TESTDB

 
   2] 테이블스페이스(TABLESPACE) 생성
      SQL> CONNECT / as sysdba
      -- 데이터용 테이블스페이스 생성
      SQL> CREATE TABLESPACE       TS_GDXX01
                  datafile       '/data01/TESTDB/TS_GDXX01_01.dbf' size 50M REUSE
                  extent management local  autoallocate
                  segment space management auto;

      -- 인덱스용 테이블스페이스 생성
      SQL> CREATE TABLESPACE       TS_GIXX01
                  datafile       '/data02/TESTDB/TS_GIXX01_01.dbf' size 50M REUSE
                  extent management local  autoallocate
                  segment space management auto;

 

   3] 사용자(USER) 생성
      SQL> CONNECT / as sysdba
      -- 응용프로그램 접속 계정(최소권한) : US_APPL
      SQL> CREATE USER                 US_APPL
                  IDENTIFIED BY        password
                  DEFAULT TABLESPACE   TS_GDXX01
                  TEMPORARY TABLESPACE TEMP;
      SQL> GRANT ALTER SESSION, CREATE SESSION         TO US_APPL;
      SQL> GRANT CREATE SYNONYM, UNLIMITED TABLESPACE  TO US_APPL;

      -- 오브젝트 소유 계정 : US_OWNER
      SQL> CREATE USER                 US_OWNER
                  IDENTIFIED BY        password
                  DEFAULT TABLESPACE   TS_GDXX01
                  TEMPORARY TABLESPACE TEMP;

      SQL> GRANT CONNECT, RESOURCE                            TO US_OWNER;
      SQL> GRANT CREATE PUBLIC SYNONYM, UNLIMITED TABLESPACE  TO US_OWNER;
  
   4] 테이블(TABLE) 생성
      SQL> CONNECT US_OWNER/password
      SQL> CREATE TABLE TB_GXX001  (
                  PgmID     VARCHAR2(30) NOT NULL,
                  PgmNm     VARCHAR2(50) NULL,
                  BatchType CHAR(1) NULL
                  ChngDtime VARCHAR2(14) NOT NULL,
                  CONSTRAINT IX_GXX001_PK  PRIMARY KEY (PgmID)
                             USING INDEX TABLESPACE TS_GIXX01
                 ) TABLESPACE TS_GDXX01;
  
   5] 인덱스(INDEX) 생성
      SQL> CONNECT US_OWNER/password
      SQL> CREATE INDEX IX_GXX001 ON TB_GXX001
                  ( BatchType ASC, PrgNm ASC )
                  TABLESPACE TS_GIXX01;
  
   6] 테이블(TABLE) 권한부여(GRANT)
      SQL> CONNECT US_OWNER/password
      SQL> GRANT INSERT, SELECT, UPDATE, DELETE ON TB_GXX001  TO US_APPL;
  
   7] 테이블(TABLE) 동의어(SYNONYM)
      SQL> CONNECT US_OWNER/password
      SQL> CREATE PUBLIC SYNONYM TB_GXX001  FOR US_OWNER.TB_GXX001;
  
   8] 시퀀스(SEQUENCE) 생성
      SQL> CONNECT US_OWNER/password
      SQL> CREATE SEQUENCE SQ_GXX001  START WITH 1 INCREMENT BY 1 MAXVALUE 999999 CYCLE ORDER CACHE 10;
      SQL> GRANT SELECT ON SQ_GXX001  TO US_OWNER;
      SQL> CREATE PUBLIC SYNONYM SQ_GXX001  FOR US_OWNER.SQ_GXX001 ;
  
   9] 뷰(VIEW) 생성
      SQL> CONNECT US_OWNER/password
      SQL> CREATE VIEW VW_GXX001_LIST .... ;
      SQL> GRANT SELECT ON VW_GXX001_LIST     TO US_APPL;
      SQL> CREATE PUBLIC SYNONYM VW_GXX001_LIST FOR US_OWNER.VW_GXX001_LIST;
  
   10] 저장 프로시져(STORED PROCEDURE/FUNCTION 등) 생성
      SQL> CONNECT US_OWNER/password
      SQL> CREATE OR REPLACE PROCEDURE SP_GXX001_LIST ....;
      SQL> CREATE OR REPLACE FUNCTION  SF_GXX001_LIST ....;
      SQL> GRANT EXCUTE ON SP_GXX001_LIST     TO US_APPL;
      SQL> GRANT EXCUTE ON SF_GXX001_LIST     TO US_APPL;
      SQL> CREATE PUBLIC SYNONYM SP_GXX001_LIST FOR US_OWNER.SP_GXX001_LIST;
      SQL> CREATE PUBLIC SYNONYM SF_GXX001_LIST FOR US_OWNER.SF_GXX001_LIST;
  
   11] 외래키(FK CONSTRAINT) 생성
      SQL> CONNECT US_OWNER/password
      SQL> ALTER TABLE TB_GXX001  ADD ( CONSTRAINT FK__GXX001
                 FOREIGN KEY ( SubPgmID ) REFERENCES TB_GXX999 ( PgmID ) );
  
   12] 트리거(TRIGGER) 생성
      SQL> CONNECT US_OWNER/password
      SQL> CREATE OR REPLACE TRIGGER TR_GXX001_LIST .... ;


   13] 기타 필요한 것들 생성 및 등록

         - DB LINK, M-VIEW, DBMS JOB 등록 등

