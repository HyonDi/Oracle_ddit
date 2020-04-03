--특정 테이블의 컬럼 조회
--1. DESC 테이블명
--2. SELECT * FROM user_tab_columns;

--prod 테이블의 컬럼조회
DESC prod;

VARCHAR2, CHAR --> 문자열. variable character(character) : 최대사이즈 4000byte
Number --> 숫자
CLOB --> character Large Object --> 최대사이즈 4GB
DATE --> 날짜(일시 = 년, 월, 일 + 시간, 분, 초)

--date 타입에 대한 연산의 결과는?
'2019/11/20 09:16:20' + 1 = ?

--USERS 테이블의 모든 커럼을 조회 해보세요.
SELECT userid, usernm, reg_dt
FROM USERS;

--사용자가 소유한테이블 목록을 조회해보자





--USERS 테이블의 모든 커럼을 조회 해보세요.
--연산을 통해 새로운 컬럽 생성(reg_dt에 숫자 연산을 한 새로운 가공 컬럼)
--날짜 + 정수 연산 ==> 일자를 더한 날짜타입이 결과로 나온다.
SELECT userid, usernm, reg_dt regdate, reg_dt+5 after5day
FROM USERS;

--reg_dt+5 목차에 별칭을 줘보자 뒤에 As 를 쓰고 별칭이름을 쓴다. As 는 생략 가능
--별칭 : 기존 컬럼명이나 연산을 통해 생성된 가상 컬럼에 임의의 컬럼이름을 부여.
--col : express [As] 별칭명


DESC users
--숫자 상수, 문자열 상수 (오라클에서 문자열은 ' ' 만 사용)
--table 에 없는 값을 임의로 컬럼으로 생성
--숫자에 대한 연산
--문자에 대한 연산 ( + 가 존재하지 않음!!!,==> ||)
SELECT 10+5*2, 'DB_SQL 수업', userid || '_modified', usernm, reg_dt
FROM users;

--Null : 아직 모르는 값.
--NULL 에 대한 연산 결과는 항상 NULL 이다.
--DESC 테이블명 : NOT NULL 로 설정되어있는 컬럼에는 값이 반드시 들어가야 한다.

--users 불필요한 데이터 삭제
--
SELECT *
FROM users;

DELETE users
WHERE userid NOT IN ('brown', 'sally', 'cony', 'moon', 'james');

rollback;

commit;
--commit 하면 롤백해도 안먹는대 ㅜㅜ 확정.

SELECT userid, usernm, reg_dt
FROM users;

--null 연산을 시험해보기 위해 moon의 reg_dt 컬럼을 null로 변경
UPDATE users SET reg_dt = NULL
WHERE userid = 'moon';

COMMIT;
ROLLBACK;

--users 테이블의 reg_dt 컬럼값에 5일을 더한 새로운 컬럼을 생성
SELECT userid, usernm, reg_dt, reg_dt +5
FROM users;
--결과 : NULL 값에 연산을 하면 NULL 이다.
--나중에 NULL을 처리하는 함수를 배울거야~!


--실습2
--1.
SELECT prod_id id, prod_name name
FROM prod;

--2.
SELECT lprod_gu gu, lprod_nm nm
FROM lprod;

--2.
SELECT buyer_id as "바이어 아이디", buyer_name 이름
FROM buyer;


-------------------------------------------------------내가 저 가격표랑 상품이름 설정하고싶으면 어떻게해야해??

--문자열 컬럼간 결합   (컬럼 || 컬럼, '문자열상수' || 컬럼)
--(CONCAT (컬럼, 컬럼) )- CONCAT 은 인자를 24개밖에 가지지 못함.
--3개이상 묶으려면 CONCAT괄호 속에 CONCAT을 다시 넣어 묶는다!

SELECT userid, usernm, 
        userid || usernm AS id_nm, 
        CONCAT(userid, usernm) con_id_nm,
        userid || usernm || pass id_nm_pass     
--        CONCAT(CONCAT(userid, usernm), pass) con_id_nm_pass
--중요한거아니래 생각을 넓히래. 쓰이긴하지만 잘 안쓰임
FROM users;

--실습!
SELECT 'SELECT * ' || 'FROM  ' || table_name || ';' query
FROM user_tables;
--별칭은 큰따옴표. 컬럼은 그냥, 문자열은 작은따옴표 속에 넣는다!!

--실습!

SELECT CONCAT ( , CONCAT(CONCAT('SELECT * FROM ', table_name ), ';'))
FROM user_tables;

SELECT CONCAT(CONCAT('SELECT * FROM ', table_name ), ';')
FROM user_tables;

SELECT * FROM LPROD;


--------------------------------------------------------------------------------------------------
DELETE users
WHERE userid NOT IN ('brown', 'sally', 'cony', 'moon', 'james');

UPDATE users SET reg_dt = NULL
WHERE userid = 'moon';

---------------------------------------------------------------------------------------------------------
-- WHERE : 조건이 일치하는 행만 조회하기 위해 사용
--          행에 대한 조회 기준을 작성

--WHERE 절 없을때 : 
SELECT userid, usernm, alias, reg_dt
FROM users;

--WHERE절 있을때 :
SELECT userid, usernm, alias, reg_dt
FROM users
WHERE userid = 'brown'; --userid 컬럼(열) 이 'brown'인 행(row)만 조회. 행열(로우, 컬럼)


--EMP 테이블의 전체데이터 조회해라.((모든 행, 열) = WHERE절에 제한을 두지 않겠다.)
SELECT *
FROM EMP;


SELECT *
FROM dept;

--20번보다 부서번호(DEPTINO)가 크거나 같은 직원 정보 조회
SELECT *
FROM emp
WHERE deptno >= 20;

--사원번호가 7700보다 크거나 같은 사원의 정보를 조회
SELECT *
FROM emp
WHERE empno >= 7700;

----사원 입사 일자(HIREDATE)가 1982년 1월 1일 이후인 사원 정보 조회
--문자열--> 날짜 타입으로 변경 TO_DATE('날짜문자열', '날짜문자열포맷')
--한국 날짜 표현 : 연,월,일
--미국 날짜 표현 : 일, 월, 년 (01-01-2020)

SELECT empno, ename, hiredate,
        2000 no, '문자열상수' str, TO_DATE('19820101', 'yyyymmdd')
FROM emp
WHERE hiredate >= To_DATE('19820101', 'yyyymmdd');


--범위조회 (BETWEEM 시작기준 AND 종류기준)
--시작기준, 종료기준을 포함.
--사원중에서 급여(SAL)가 1000보다 크거나 같고, 2000보다 작거나 같은 사원 정보 조회.
---------------------------------------------ToDate  를 왜써야하는지 모르겠다.

SELECT *
FROM emp;


SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;
--BETWEEN AND 연산자는 부등호 연산자로 대체 가능.

SELECT *
FROM emp
WHERE sal >=1000
AND sal <=2000


SELECT empno, ename, hiredate,
        2000 no, '문자열상수' str, TO_DATE('19820101', 'yyyymmdd')
FROM emp
WHERE hiredate >= TO_DATE('19820101', 'yyyymmdd');


--실습 where
SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('19820101','yyyymmdd') AND TO_DATE('19830101','yyyymmdd');


SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('19820101','yymmdd') AND TO_DATE('19830101','yymmdd');
--TO_DATE 는 문자열을 날짜로 바꿔주는 역할.
--TO_CHAR (hiredate, 'yy-mm-yy') ? 날자를 문자열로 바꿔준다????

--실습 wehre
SELECT ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE('19820101','yymmdd')
AND hiredate <= TO_DATE('19830101','yymmdd');

커밋은 내일하자!
모르겠으면 분제 계속 다시 풀어보자.
정리좀 하고.

  


