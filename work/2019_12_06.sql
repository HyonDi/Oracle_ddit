--DML <<UPDATE>>
--
--UPDATE  table Set column = value [,column = value, ...]
--[WHERER condition];
SELECT *
FROM dept;

--dept 테이블에 부서번호 99, 부서명 ddit, 위치 daejeon 만들렴.

INSERT INTO dept (deptno, dname, loc) values(99, 'DDIT', 'daejeon');

SELECT *
FROM dept;

--실제테이블에있는 데이터 '변경'은 UPDAT!

--UPDATE : 테이블에 저장된 컬럼의 값을 변경.
--UPDATE 테이블명, SET 컬럼명1 = 적용하려고 하는 값1, 컬럼명2 = 적용하려고하는 값 2............
--이로케 콤마로 구분지어
--[WHERE row 조회 조건] : 이건 들어갈수도있고 안들어갈수도 있다.
--조회조건에 해당하는 데이터만 업데이트가 된다.

--부서번호가 99번인 부서의 부서명을 대덕IT로, 지역을 영민빌딩 으로 변경.
UPDATE dept SET dname = '대덕IT', loc = '영민빌딩'
WHERE deptno = 99;

--UPDATE전에 업데이트 하려고하는 테이블을 웨어절에 기술한 조건으로 SELECT를 하여
--업데이트 대상 로우를 확인해보자. 실수를 방지하고자.
SELECT *
FROM dept;

--다음 query를 실행하면 where 절에 row 제한 조건이 없이 때문에 
--dept 테이블의 모든 행에 대해 부서명, 위치정보를 수정한다.
UPDATE dept SET dname = '대덕IT', loc = '영민빌딩';

--오라클에서는 실수했을 때 한번의 기회가 있음. 오토커밋이 아니기때문. 롤뱁하묭대.
--SELECT 꼭 해보기!!!!
--subquery를 활용해 update 가능.
--가능하긴하지만 효율적이진 않은 편. 
--실수할 가능성도 있규..........

--subquery를 이용한 update
--emp테이블에 신규 데이터 입력
--사원 번호 9999, 사원이름 brown, 업무 : null인 ㄷ이터를 넣어보렴.
INSERT INTO emp ( empno, ename) VALUES (9999,'brown');

SELECT*
FROM emp;
--사원번호가 9999인 사원의 소속 부서와, 담당업무를 smith사원의 부서, 업무로 업데이트

UPDATE emp SET deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH'), 
                job =  (SELECT job FROM emp WHERE ename = 'SMITH')
WHERE empno = 9999;
COMMIT;

--DML DELETE : 조건에 해당하는 row를 삭제.
--컬럼의 값을 삭제?? (null) 값으로 변경하려면 --> UPDATE.

--딜리트는 로우를 삭제해버림. 그 행을 몽땅 날리는것.
--DELETE 테이블명
--[WHERE 조건]

--UPDATE 쿼리와 마찬가지로 DELETE쿼리 실행전에는 해당 테이블을  WHERE조건을 동일하게 하여
--SELECT  를 실행, 삭제될 row를 먼저 확인해보자.!!!

--emp에 존재하는 사원번호 999인 사람을 삭제해보쟈ㅣ.
DELETE emp
WHERE empno = 9999;

--확인하고 삭제하기!
SELECT *
FROM emp
WHERE empno = 9999;

DELETE emp; --> 테이블에 존재하는 모든 데이터를 삭제.

--매니저가 7698인 모든 사원을 삭제!
--먼저 자기 매니저가 7698인 사원을 조회해보자
SELECT *
FROM emp
WHERE mgr = 7698;

DELETE emp
WHERe mgr = 7698;
--> 이렇게 해도 되지만서브쿼리를 이용하면

DELETE emp
WHERe empno IN(SELECT *
                FROM emp
                WHERE mgr = 7698);
SELECT *
FROM emp;

--DELETE 말고 TRUNCATE 라는 것도 있어
--얘는 복구가 불가능해! 주로 개발 데이터베이스에서 사용.
--dbms 실행모드마다 다르긴하지만 일반적으로는 식행시 복구를 위해 로그를 남긴다.
--undo (redo) log 에 남겨놓음. 남기다보니까 속도가 좀 드려서 로그를 남기지 않아 빠르지만
--복구가 불가능하다. 주로 개방 데이터베이스에서 사용된다. 테스트용으로. 운영데이터에서는 사용안함.
--DELETE 는 DML 이고, TRUNCATE 는 DDL 이얌.

--TRUNCATE TABLE table이름; 테이블 자체가아닌 테이블속 데이터만 지움.

--<<TRANJACTION>>
--여러 단계의 과정을 하나의 작업 행위로 묶는 단위.
--SELECT 제외 DML 구문이 시작되면 그때부터 트랜잭션이 시작되는고야
--트랜잭션은 논리적인 일의 단위.
--아래 사항에서 트랜잭션 발생.
--관련된 여러 dml문장을 하나로 처리하기 위해 사용.
--첫번쨰 dml문을 실행함과 동시에 트랜잭션 시작.(명시적이 아닌 묵시적으로 실행된다.)
--이후 다른 dml문 실행.
--commit 트랜잭션을 종료.
--rollback 트랜잭션에서 실행만 dml문을 취소하고 트랜잭션 종료.

--dcl : 권한관리할때 사용 ddl : 객체관리할때. 테이블이나 인덱스, 뷰, 함수 프로시져? 만들때.
--얘네는 트랜잭션 자동 커밋되서 롤백불가능함.

--<<트랜잭션 읽기 일관성>> (ISOLATION LEVEL)
--되게 어려워. 이해안되면 그냥 넘어가도괜찮아. 보너스정도임.

--A 사용자와 B 시용자가 같은 계정으로 sql에 접속했다고 하자.

--deotno가 99번인 사용자를 A 가 삭제했다.
--A가 커밋하기전, 삭제된내용이었지만 B에서는 여전히 5건이 나옴.
--
--DML문이 다른 사용자에게 어떻게 영향을 미치는지 정의한 레벨.
--0~3까지 표준으로 정의가 되어있다. 0이 가장 저수준, 3이 고수준.

--수정후 커밋!! 중요해 완료안지으면 락이걸려있어. 이걸 해제해줘야해 롤백이나 커밋.

--오라클에서는 data block을 이력에따라 멀티버전으로 관리합니다. 오라클은 이게 가능해요!
--다른 dbms랑 오라클 dbms랑 차이점이 이 부분이얌.
--다른 디비에서 아이솔레이션 레벨이높으면 락이 많이잡힌다는 것. 


--원래 오라클에선 SELECT 에 락을 안걸지만, FOR UPDATE 를 사용해 락을 걸 수 있다.
--다른데서 수정이 불가능하다는 뜻.

--ISOLATION LEVEL2
--선행 트랜잭션에서 읽은 데이터
--(FOR UPDATE) 를 수정, 삭제하지 못함.
UPDATE dept SET dbane = 'ddit'
WHERE deptno = 99;

--락을 검. 커밋은 아직 안한상태.
SELECT *
FROM dept
WHERE deptno = 40
FOR UPDATE;

--다른 사용자에게 위의 쿼리로 락때문에 작업이 불가능하다. 작업이 끝나지 않음. 수정불가.
--다른 트랜잭션에서 수정을 못하기 때문에 현 트랜잭션에서 해당 row 는 항상 동일한 결과값을 조회할 수 있다**
--남들이 수정을 못하니까.

--후행 트랜잭션에서
INSERT INTO dept VALUES (98, 'ddit2','seoul');
--인서트를 커밋하면 선행 트랜잭션에 반영이 됨.
--신규데이터 입력은 막을 수 없음.
--팬텀리드 라고 함. 없던게 갑자기 생기는거. phantom read.

--3레벨은 후행트랜잭션에서 수정, 입력,, 삭제된데이터가 선행트랜잭션에 영향을 주지 않는다.
--후행에서 입력한 데이터가 선행에 조회되지 않음.

--ISOLATION LEVEL3
--SERIALIIZABLE READ
--트랜잭션의 데이터 조회 기준이 트랜잭션 시작 시점으로 맞춰진다. 즉  후행 트랜잭션에서 
--데이터를 신규 입력, 수정, 삭제 후 commit 을 하더라도 선행 드랜잯션에서는 해당 데이터를 보지 않는다.

--4단계(레벨3)를 해봅시다!!
--
SET TRANSACTION isolation LEVEL SERIALIZABLE;


----------------------------------------------------파트1 이 끝났다.




--part2- 
--DDL
--왼쪽 접속 들어가서 계정 눌러보면 나오는게 다아 객체야.
--테이블도 객체고 인라인뷰했던것도 뷰라고 하는 객체로 만들어서 쓸 수 있다.
--인덱스 테이블에관련된 인덱스!
--패키지 : plsql 블럭을 관련된 블럭들을 모으는 역할.
--프로시저 등등 dbms에서 관리하는 객체들이야.;
--
--인덱스는 테이블에 종속된거야. 테이블의 패턴에따라 인덱스를 여러개 만들 수도 있다.
--찾고자하는 데이터의 위치를 빠르게 찾을 수 있어. 조회 성능 향상을 위해 정해진 컬럼 순으로 정렬을 해놓은 객체.
--
--시퀀스 : 중복이되면 안되는 값을 임의로 생성하는 것.
--시노님 : 오라클 객체의 별칭. 저언혀다른이름으로 붙일 수 있다. dept 테이블을 쓰고있는데 d 로별칭을 주는거야.
--알리아스랑 다른거야. 
--dept테이블에 시노님을 생성하면 셀렉* FROM d ;라고 하면돼.

--<<테이블과 컬럼명 규칙>>
--영문자로 시작해야함!
--길이는 1~30글자
--알파벳 대소문자, _, $, # 만 사용가능
--해당 유저가 소유한 다른 객체와 이름이 겹치면 안돼.
--오라클 키워드와 객체명이 동일할 수 없어.


--<<DROP>> 는 당연히 데이터 삭제되고, 껍데기도 다 삭제돼.
--관련된 객체 같이 삭제. 제약조건, 인덱스 모두모두
--drop(ddl)의 경우 rollback이 안된다.
--운영 db에서 해당명령어를 입력할 때는 주의해야함!
--rollback 은 dml 만 된다!!

--<<CREAT>>
--스키마 : 사용자?
--CREATE TABLE (SCHEME.] table_name(
--컬럼명1 컬럼타입1,
--컬럼명1 컬럼타임2,
--컬럼명 N 컬럼타입 N);

--TABLE을 생성해봅시당.
--ranger_no NUMBER          : 레인저 번호
--ranger_nm VARCHAR2 (50)   : 레인저 이름
--rag_dt DTE                : 레인저 등록일자

CREATE TABLE ranger(
    ranger_no NUMBER,
    ranger_nm VARCHAR2(50),
    reg_dt DATE
);

SELECT *
FROM ranger;

DESC ranger;

--테이블 생성 DDL : Data Defination Language(데이터 정의어)
--DDL rollback 이 없다. 자동커밋되므로 롤백할 수 없다!!!!!!!!!!
SELECT *
FROM user_tables
WHERE table_name = 'RANGER';
--* 검색할때 ranger 대문자로해야만 나와
--오라클에서는 객체생성시 소문자로 생성하더라도 내부적으로는 대문자로 관리한다.

ROllBACK 불가능!;

INSERT INTO ranger VALUES(1, 'brown', sysdate);
SELECT *
FROM ranger;
ROLLBACK;
--dml 문은  ddl과 다르게 rollback이 가능하다.

--<<오라클의 주요 데이터 타입>>
--문자, 숫자, 날자
--
--문자: char(size), varchar2(size)
--char 타입 추천 안함. 왜냐면 10바이트로지정해놓고 2바이트만 넣어놔도 나머지 8바이트가 공백으로 들어간다. 고정길이 문자열.
--varchar2는 가변길이 문자열이야. 1~4000 바이트까지 가능
--
--숫자 : number
--(전체자리수, 소수점자리수)
--그냥 NUMBER 로 쓰는거 추천.
--
--DATE 는 일자를 저장하기위해 문자열로 사용하는 경우도 있는데 일자를 문자열로하면 8바이트 필요.
--그냥 문자는 7바이트여서 용량차이가 난다.
--
--CLOB : Character Larger Object : 장문의 문자열 (최대 4G)
--BLOB : Binary Larger Object : 바이너리 데이터. 중요한 파일의 경우 db에 바이너리 형태로 저장.(최대 4G)
--

게시판 짤 수 있냐

--피피티보기
--기차나~!

--DATE 타입에서 필드 추출하기.
-- EXTRACT (필드명 FROM 컬럼/expression);
--SELECT SYSDATE
--FROM dual;
--
--SELECT TO_CHAR(SYSDATE, 'yyyy') yyy,
--        TO_CHAR(SYSDATE, 'mm') mm,
--        EXTRACT (year FROM SYSDATE) ex_yyyy,
--        EXTRACT (month FROM SYSDATE) ex_mm
--FROM dual;
--
--
----테이블의 제약조건.
--데이터의 무결성을 지키기 위한 설정. 잘못된게 없게하기위한 설정.
-- NOT NULL 컬럼에 값이 반드시 들어와야ㅏ 한다.
-- UNIQUE 해당 컬럼중 같은 값을 같는 값이 없어야 함.
-- 컬럼복합 조합도 가능.
-- PRIMARY KEY = UNIQUE + NOT NULL
-- 
-- NULL 은 중복이 아니야!!!
-- --FOREIGN KEY!
-- 해당 컬럼이 참조하는 다른 테이블에 값이 존재 해야함.
-- 
-- CHECK! 컬럼에 들어갈 수 있는 값을 제함.
-- 
-- 컬럼레벨에 제약조건을 거는것을 해봅시다.
-- 그 다음엔 테이블레벨로 기술합니다. 컬럼컨스트레인트의 불가능한부분은 테이블 컨스레인트에서 바꾸면 된다.
-- 들어갈수 있는 문법은?
-- 컬럼_컨스트레인스 : 
-- 컬럼이름 데이터타임[컨스트레인트 컨스트레인트이름)]컨스트레인트 타입.

--테이블 생성시 컬럼 레벨 제약조건 생성을 해봅시다. 너무너무 졸리다 끊임없이 타자를 치면 잠이 깰까?
CREARE TABLE dept_tesct(
deptno NuMBER(2),
dname VARCHAR2(14),
loc VARCHAR(13)),

DROP TABLE dept_tset;

CREARE TABLE dept_tesct(
deptno NuMBER(2) PRIMARY KEY,
dname VARCHAR2(14),
loc VARCHAR(13)),

<<인덱스!!!>>

--dept_test 테이블의 deptno 컬럼에 primary key 제약 조건이 있기 때문이다.
deptno 가 동일한 데이터를 입력하거나 수정할 수 없다.
INSERT INTON dept_test Values(99, 'ddit', 'daejeon;);'
INSERT INTO depr_tst values (oo, eowjs, 'eoejrr');
--UNIQUE +  NOT NULL
--UNIQUE 는 해당컬럼에 동일한 값이 중복될 수 없다.
--해당 컬럼에 null값은 들어갈 수 있음.
--컬럼레벨의 primary key 제약 생성.


--아 왜케졸리냐 좀만 참자 ㅠㅠㅜㅠㅜㅠㅜㅠㅜㅠㅜㅠㅜㅠㅠㅜㅠㅜㅠㅜㅠㅜㅠㅜㅠㅜㅠㅜㅜㅠㅜㅠㅠㅜㅠㅜㅠㅜㅜㅠㅜㅠ
dept_test 데이터에 deptno가 99번인 데이터가있으므로 primary key 제약조건에 의해 입력될 수 없다.
오라0001 유니크 콘슴트레인스 제약 위해.
위배되는 제약조건명 SYS_C007105 위배.
SYS C007105 제약 조건을 어떤 제약 조건인지 판단하기 힘듦으로 
에러코트를 봤을 때에 뭔지 잘 모르니까.

제약조건에 이름을 코딩룽에 의해 분혀주는 편이 유지보수가 쉽다.
primary key : pk_테이블 명
DROP TABLE dept_tset;

CREARE TABLE dept_test(
deptno NuMBER(2) PRIMARY KEY pk_dept_test PRIMARY KEY,
dname VARCHAR2(14),
loc VARCHAR(13)),
오라클 제약조건의 이름을 임의로 명명했다.

DEpt ....
완벽하게 외우지못해도 괜찮아. 검색을해서 보고 사용할 줄 알면 돼.
일반적으로 개발자가 하는경우가 거의 없다. 모델링측에서 다 해줌.
이런게 있었다 까지만 알면되ㅐ. 검색해서 사용하는것도. 아구졸려 아구졸려ㅠㅠㅠㅠ

파일 저장 커밋 


DROP TABLE dept_tset;

CREARE TABLE dept_tesct(
deptno NuMBER(2) PRIMARY KEY,
dname VARCHAR2(14),
loc VARCHAR(13)),
