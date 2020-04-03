
--별칭 : 테이블, 컬럼을 다른이름으로 저장
--  [AS] 별칭명
-- SELECT empno [AS] eno
-- FROM emp e

-- SYNONIM (동의어)
--오라클 객체를 다른 이름으로 부를 수 있도록 하는 것
-- 만약에 emp 테이블을 e라고 하는 synonym(동의어)로 생성을 하면
-- 다음과 같이 sql을 작성할 수 있다.
-- SELECT *
-- FROM e;
--오라클의 객체~!!!
--synonuym 생성 - 시스템권한 사용자만 만들 수 있다.
--CREATE [PUBLIC] SYNONYM synonym_name for object;

--emp 테이블을 사용하여 synonym 생성

--권한! 시스템으로 접속해서 본인계정에 생성권한 부여하기
--GRANT CREATE SYNONYM TO 내계정이름;
--끝났으면 시스템계정 접속해재 꼭 누르기!!

CREATE PUBLIC SYNONYM E FOR EMP;
--이제 EMP 테이블명 대신 E 라고 하는 시노님을 사용하여 쿼리를 작성할 수 있따!

SELECT *
FROM emp;

SELECT *
FROM e;

--SYSTEM계정에서 아래쿼리를 해보면 계정실제명이 쭉나옴. 이거로해야해.
SELECT *
FROM DBA_USERTS;

--권한부여 회수 등은 개발자가 하는 일은 아니라고 생각하신대.
--grant dcl!


--DML
--SELECT/ INSERT/ UPDATE/ DELETE/ INSERT ALL/ MERGE

--TCL
--COMMIT/ ROLLBACK/ SAVEPOINT

--DDL
--CREATE/ ALTER/ DROP

--DCL
--GRAMT / REVOKE
--오라클에 접속하기위해 필요한 권한, 객체를 생성하기위해 필요한 권한, 오라클 사용자를 신규로 생성.
-- CONNECT                          RESOURCE                       GRANT CONNECT, RESOURCE TO user_name

--오라클에서 권한을 크게 2가지로 나눕니다.
--1. 시스템권한(시스템 관리, 생성), 2. 객체권한 (객체관리)
--스키마 객체들의 집함(tables, views, indexes...)
--오라클에서 스키마는 사용자?라고 하면된다고?
--sem에있는 뷰, 인덱스. 패키지, 프로시저 이런거???
--스키마 = 사용자 가 가진 집합들. 객체들.

--계정비밀번호 바꾸기
--alter user sem idntified by 비밀번호;

--오라클 시스템권한 찾아가며 하면 된다.

--grant privilege to user | role;
GRANT CONNECT, RESOURCE TO sem;
--> 권한을 줬다.
REVOKE RESOURCE FROM sem;
--> 권한을 뺐었다.

--개발자에게 생성권한을 안주는 회사도 있다. 


GRANT CONNECT, INSERT ON emp TO sem;
-->여러개에 줌.

--옵션 시스템권한, 객체권한 / 시스템권한은 각각 뺏어야함.
WITH ADMIN OPTION : 권한을 부여받은 사용자가 다른 사용자에게 권한 부여 가능.
WITH GRANT OPTION
--스탭으로 쓰는거구나?

ROLE : 반장같은거넹 권한관리를 해줌.

;

--시스템 정보를 조회할 수 있는 뷰. DATA DICTIONARY

--개발자가 만드는 테이블들을 업무데이터라고 부름. 
--따로관리되는 것이 DATA DICTIONARY

--DATA DICTIONARY CATEGORY
--USER, ALL, DVA, V%
--사용자 소유 객체 뷰, 사용자가 참조할수있는 뷰, DB관리자 뷰, 성능, 시스템관련 뷰


SELECT *
FROM DICTIONARY;

--인덱스정보와 인덱스컬럼정보는 꼭 확인해보자.
--

--동일한 SQL 의 개념에 따르면..
SELECT * FROM emp;
--와
SELECT * FROM EMP;
--와
SELECt * FROM emp;
--는 각각 다르다. 세가지 실행계획을 각각 만들어야함.

SELECT /*201911_205*/ * FROM emp;
SELECT /*201911_205*/ * FROM EMP;
SELECt /*201911_205*/ * FROM emp;

SELECT /*201911_205*/ * FROM emp WHERE empno = :empno;
--> 이렇게쓰면 바인드변수만다르지 동일한쿼리다. 실행계획 동일.
--하나하나 상수로쓰면다른쿼리.

--SELECT /*201911_205*/ * FROM emp WHERE empno = ?;
--자바에서 이렇게 해서..뭐..함...sql.처리가..
--운영과 개발의 차이.. 운영db에서 하는 행동이 dbms에게는 안좋은 영향을 끼칠수있다는걸 알아두자.
--더닝 크러거 이펙트

--part2 끝!!
--실습 4 과제로 해오기! 기한 : 25일까아지

--sql 응용 ppt 를 엽니다.

--multiple insert
--1. undonditional
--2. conditional all
--3. conditional first

DROP TABLE emp_test;
--밑에서 새로만들거니까.
SELECT *
FROM emp_test;

--emp 테이블의 empno, ename 컬럼으로 emp_test, emp_test2 테이블을 생성.
-- (CTAS, 데이터도 같이 복사.)
CREATE TABLE emp_test AS
SELECT empno, ename
FROM emp;

CREATE TABLE emp_test2 AS
SELECT empno, ename
FROM emp;

--확인
SELECT *
FROM emp_test1 

--unconditional insert : 여러 테이블에 데이터를 동시에 입력한다.
--brown , cony 를 emp_test, emp_test2 테이블에 동시에 입력해라.
INSERT ALL
    INTO emp_test
    INTO emp_test2
SELECT 9999, 'brown'  FROM dual
UNION ALL
SELECT 9998, 'cony' FROM dual;
--4개의 행이 입력됐다고 알려줌.

SELECT *
FROM emp_test
WHERE empno > 9000;
SELECT *
FROM emp_test2
WHERE empno > 9000;
ROLLBACK;

--테이블별 입력되는 데이터의 컬럼을 조절, 제어 가능.

INSERT ALL
    INTO emp_test (empno, ename)  VALUES(eno, enm)
    INTO emp_test2 (empno) VALUES (eno)
SELECT 9999 eno, 'brown' enm  FROM dual UNION ALL
SELECT 9998, 'cony' FROM dual;

--확인
SELECT *
FROM emp_test
WHERE empno > 9000

UNION ALL

SELECT *
FROM emp_test2
WHERE empno > 9000;

--> TEST 2 의 ENAME 이 NULL로 표시되는 것을 알 수 있다.
--생각. 테이블이 중복..?
ROLLBACK;

--CONDITIONAL INSERT : 조건에 따라 테이블에 데이터를 입력. 웨어절인감
INSERT ALL
    WHEN eno > 9000 THEN ~~ --case 절에서 했었음.
        INTO EMP_TEST (eno, ename) VALUES (eno, enm)
        
    ELSE
        INTO EMP_TEST2 (eno) VALUES (eno)
SELECT 9999 eno, 'brown' enm  FROM dual UNION ALL
SELECT 8998, 'cony' FROM dual;

--확인
SELECT *
FROM emp_test
WHERE empno > 9000 UNION ALL
SELECT *
FROM emp_test2
WHERE empno > 8000;

ROLLBACK;
--
INSERT ALL
    WHEN eno > 9000 THEN 
        INTO EMP_TEST (eno, ename) VALUES (eno, enm)
    
    WHEN eno > 9500 THEN 
        INTO EMP_TEST (eno, ename) VALUES (eno, enm)
        
    ELSE
        INTO EMP_TEST2 (eno) VALUES (eno)
SELECT 9999 eno, 'brown' enm  FROM dual UNION ALL
SELECT 8998, 'cony' FROM dual;
ROLLBACK;


--
INSERT FIRST
    WHEN eno > 9000 THEN  
        INTO EMP_TEST (eno, ename) VALUES (eno, enm)
    
    WHEN eno > 9500 THEN  
        INTO EMP_TEST (eno, ename) VALUES (eno, enm)
        
    ELSE
        INTO EMP_TEST2 (eno) VALUES (eno)
SELECT 9999 eno, 'brown' enm  FROM dual UNION ALL
SELECT 8998, 'cony' FROM dual;
--가장 처음에만난것만!!!