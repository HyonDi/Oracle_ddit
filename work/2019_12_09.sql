--PAIRWISE : 쌍의 개념.
--상단의 PRIMARY KEY 제약 조건의 경우 하나의 컬럼에 제약조건을 생성.
--하지만 여러 컬럼을 복합으로 PRIMARY KEY 제약으로 생성할 수 있다.
--해당 방법은 위의 두 가지 예시 처럼 컬럼 레벨에서는 생성할 수 없다.
----> TABLE LEVEL 제약 조건 생성.

--기존에 생성한 dept_test 테이블 삭제(drop)
DROP table dept_test;

-- 컬럼레벨이 아닌, 테이블 레벨의 제약조건 생성.
CREATE TABLE dept_test(
    deptno NUMBER(2) ,
    dname VARCHAR2(14),
    loc VARCHAR(13), --마지막 컬럼 선운 후 컴마 빼먹지 않기
    
    --deptno와 dname 컬럼이 같을 때 동일한(중복된) 데이터로 인식.
    CONSTRAINT pk_dept_test PRIMARY KEY ( deptno, dname) 
    );

--부서명은 다르므로 서로 다른 데이터로 인식 --> INSERT 가능.    
INSERT INTO dept_test Values(99, 'ddit', 'daejeon');
INSERT INTO dept_test Values (99, '대덕', '대전');

SELECT *
FROM dept_test;

--두번째 INSERT  쿼리와 키값이 중복되므로 에러.
INSERT INTO dept_test VALUES(99, '대덕', '청주');
--이럴경우 키컬럼(괄호안쪽) 에 값을 제대로 넣었는지 봐야한다.

--프라이머리키를 컬럼레벨과 테이블레벨로 설정 가능.
--

--
CONSTRAINT pk_dept_test PRIMARY KEY ( deptno, dname),
loc2 VARCHAR2(13)
    );
--이렇게 해도 생성이 되었습니다!


--<<NOT NULL 제약조건>>
--해당 컬럼에 NULL값이 들어오는 것을 제한할 때 사용.
--복합컬럼과는 거리가 멀다.
--dept_test 삭제하고 만들어봅니다.
--dname 컬럼에 null값이 들어오지 못하도록 NOT NULL 제약 조건 생성.
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14) NOT NULL,
    loc VARCHAR(13)
    );

INSERT INTO dept_test Values(99, 'ddit', NULL);
--> 결과 : 1번 insert 는 잘 들어간다. pk 제약에 위반되지 않는다.
-- deptno 컬럼이 primary key 제약에 걸리지 않고 loc 컬럼은 nullable 이기 때문에
-- null값이 입력될 수 있다.
INSERT INTO dept_test Values (98, NULL, '대전');
--> 결과 : --2번 insert 는 에러. 
--deptno 컬럼이 priamry key 제약조건이 걸리지 않고(중복된 값이 아니니까)
--dname 컬럼의 NOT  NULL 제약조건을 위배.


--NOT NULL 제약조건도 이름을 붙일 수 있다.
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    --deptno NUMBER(2) CONSTRAINT pk_dept_test PRIMARY KEY,  (명명)
    dname VARCHAR2(14) CONSTRAINT NN_dname NOT NULL,
    loc VARCHAR(13)
    );
--CONSTRAINT 명명 조건이름!!!
--제약조건은 테이블에 딱 하나만 걸수 있는게 아님.

--테이블레벨로 만들어 볼까요?
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR(13),
    CONSTRAINT NN_dname NOT NULL (dname)
    );
--NOT NULL 은 명명해서 할 수 없음. 허용되지않음.


--1. 컬럼레벨, 2. 컬럼레벨 + 제약조건 이름붙이기, 3. 테이블레벨
--로  제약조건을 걸었습니다. [4. 테이블 수정시 제약조건을 적용.]이 남았다.


--UNIQUE 제약 조건
--해당 컬럼에 값이 중복되는 것을 제한.
--단 NULL 값은 허용.
--GLOBAL solution 의 경우 국가간 법적 적용 사항이 다르기 때문에
--pk 제약 보다는 UNIQUE 제약을 사용하는 편이며,
--부족한 제약 조건은 APPLICATION 레벨에서 체크하도록 설계하는 경향이 있다.

--
DROP TABLE dept_test;

--1. 컬럼레벨 UNIQUE 제약 생성.

CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14) UNIQUE,
    loc VARCHAR(13),
    );

--두개의 insert 구문을 통해 dname이 같은 값을 입력하기 때문에
--dname 컬럼에 적용된 UNQUE 제약에 의해 두번째 쿼리는 적상적으로 실행될 수 없다.
--
INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (98, 'ddit', '대전');


--이름을 붙여봅니다.
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14) CONSTRAINT IDX_U_dept_test_01 UNIQUE,
    loc VARCHAR(13),
    );

INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (98, 'ddit', '대전');

--제약조건에 우리가 이름붙인 이름이 나온다. 에러생겼을 때에 더 쉽게 찾을 수 있음.

--2. 테이블레벨 UNIQUE 제약 생성
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14) CONSTRAINT,
    loc VARCHAR(13), --테이블레벨 에서는 콤마 꼭 써야해!!!
    
    CONSTRAINT IDX_U_dept_test_01 UNIQUE(dname)
    );
INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (98, 'ddit', '대전');


--<<Foreign key>>!!
--외래키, 포린키.

--FOREIGN KEY 제약조건!
--다른 테이블에 존재하는 값만 입력될 수 있도록 제한.
--emp_test.deptno - > dept_test.deptno 컬럼을 참조하도록 할거다.
--포린키제약은 두 테이블 사이의 관계니까.

--DEPT_TEST 테이블 삭제 (DROP)
DROP TABLE dept_test;

--dept_test 테이블 생성 (deptNO 컬럼 primary key 제약)
--dept 테이블과 컬럼이름, 타입 동일하게 생성해라.
CREAT TABLE dept_test (
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR(14),
    loc VARCHAR(13) );

SELECT *
FROM dept;

--이제 데이터를 넣어봅시다.
INSERT INTO dept_test VALUES(99, 'DDIT','daejeon');

--emp_test 테이블을 만듭니다.
--empno, ename, deptno : emp_test
--empno PRIMARY KEY
--eptno dept_test.deptno FOREIGN KEY

CREAT TABLE emp_test(
    empno  NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    deptno NUMBER(2) REFERENCES dept_test (deptno)
);
--포린키라고 쓰지않고 레퍼런스라고 썼다. 

--dept_test 테이블에 존재하는 deptno로 값을 입력해보자.
INSERT INTO emp_test VALUES(9999, 'brown', 99);
--> 문제없이 작동한다.


--dept_test 테이블에 존재하지않는 deptno로 값을 입력해보자.
INSERT INTO emp_test VALUES(9998, 'brown', 98);
-->98번은 존재하지 않는다. 에러가나와요. 
--> 98을 99로 바꾸고 실행하면 잘 될거다.


--컬럼레벨 포린키(제약조건명 추가)
--컬럼레벨에서 불가능. (NOT NULL 처럼. 테이블레벨에서 해야한다.)
CREAT TABLE emp_test(
    empno  NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    deptno NUMBER(2),
    
    CONSTRAINT FK_dept_test FOREIGN KEY (deptno) 
    REFERENCES dept_test (deptno) );

--dept_test 테이블에 존재하는 deptno로 값을 입력해보자.
INSERT INTO emp_test VALUES(9999, 'brown', 99);
--> 문제없이 작동한다.

--dept_test 테이블에 존재하지않는 deptno로 값을 입력해보자.
INSERT INTO emp_test VALUES(9998, 'brown', 98);
--> 안된다. 98이 없으니까.

--테이블간의 컬럼연결을 해봤다.

--롤백,커밋 따로 해야하는경우와 안해도되는경우를 알아보자.
--CREAT TABLE 은 커밋을 안해도 되는건가?
--INSERT 랑 제약조건들은?

--포린키제약조건은 참조하려는 컬럼에 인덱스가 생성되어 있어야 한다.
--왜?
--테이블에는 데이터에느 순서가 없다.
--인덱스가 없다면 테이블의 모든데이터를 검색해야한다. 인덱스를 통해 속도 개선 가능.
--오라클에서는 속도적인 이슈로 인덱스를 반드시 생성하도록 강제한다.
--그래서 인덱스가 꼭 있어야함. 참조하려는 컬럼쪽에.
--유니크제약조건 생성히 해당 컬럼으로 유니크인덱스가 자동생성된다.
--유니크제약조건은 검증이 필요하기때문. 중복된사항이 있는지 없는지.



--<<포린키의 옵션!>> 여태까지는 계속 디폴트로 사용해왔음.


SELECT *
FORm emp_test;

DELETE dept_test
WHERE deptno=99;
--에러난다. emp가 dept 를 참조하고있기때문.
--부서정보를 지우려면, 지우려고하는 부서번호를 참조하는 직원정보를 삭제 
--또는 deptno 컬럼을 NULL 처리.
--emp 작업 후 dept 작업을 해야함. 데이터를 지우는데에도 순서가 있다.


OPTION
1. ON DELETE CASCADE : 부모 삭제시 참조하고있던 자식 컬럼의 데이터도 같이 삭제.
2. ON DELETE SET NULL : 부모삭제시 참조하고 있던 자식컬럼의 데이터를 null로 변경.
3. 옵션을 아무것도 안 주는 것.
--편하기는 1,2번이 편할 수도 있지만 3번이 제일 안전하다.
--개발자는 데이터를 잘 관리할 수 있어야 함.



--foreign key OPTIION - ON DELETE CASCADE.

CREAT TABLE emp_test(
    empno  NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    deptno NUMBER(2),
    
    CONSTRAINT FK_dept_test FOREIGN KEY (deptno) 
    REFERENCES dept_test (deptno) ON DELETE CASCADE );

INSERT INTO emp_test VALUES(9999, 'brown', 99);
COMMIT;
--데이터 입력 확인.
SELECT *
FROM emp_test;

--옵션에 따르면 찾고하고있는 사원테이블도 같이 삭제가 되어야한다.

DELECT dept_test
WHERE deptno = 99;
--위험함.emp도 날라갔다.
--ON DELETE CASCADE 옵션에 따라 DEPT 데이터를 삭제할 경우
--해당 데이터를 참조하고 있는 EMP 테이블의 사원 데이터도 삭제된다.


--
--기존테이블 삭제
DROP TABLE emp_test;

--FOREIGN KEY OPTION _ ON DELETE SET NULL.
CREAT TABLE emp_test(
    empno  NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    deptno NUMBER(2),
    
    CONSTRAINT FK_dept_test FOREIGN KEY (deptno) 
    REFERENCES dept_test (deptno) ON DELETE SET NULL );

--데이터 입력.
INSERT INTO emp_test VALUES(9999, 'brown', 99);
COMMIT;

--데이터 입력 확인.
SELECT *
FROM emp_test;

--SET NULL 이 되었나 삭제해봅니다.
--dept 데이터를 삭제할 경우
--해당 데이터를 참조하고 있는 emp테이블의 deptno 컬럼을 null로 변경.
DELETE dept_test
WHERE deptno = 99;
ROLLBACK;

--CASCADE 는 데이터가 몽땅사라졌지만 SET NULL 은 삭제되지않고 
--참조하고있던 deptno 의 값만 null로 바뀌었다.


--테이블생성3개하고 롤백하면 세개 다 되돌려지나?


--<<CHECK 제약조건>>
--해달컬럼에 값이 들어갈때 그 값을 제한하거나, 값의 범위라던가 체크가 가능하다.
--컬럼에 들어가는 값을 검증할 때
--EX : 급여 컬럼에는 값이 0보다 큰 값만 들어가도록 체크
--      성별컬럼에는 남/녀 혹은 F/M 값만 들어가도록 제한.

--emp_test 테이블 삭제.
DROP TABLE emp_test;

--emp_test 테이블 컬럼
--empno NUMBER(4)
--ename VARCHAR2(10)
--sal NUMBER(7,2) --0보다 큰 숫자만 입력되도록 제한.
--emp_gb VARCHAR2(2) --직원 구분. 01: 정규직  02: 인턴. 01, 02만 들어갈 수 있도록 해야한다.

CREATE TABLE emp_test(
    empno  NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    sal NUMBER(7,2) CHECK (sal > 0),
    gmp_gb VARCHAR2(2) CHECK (emp_gb IN ('01', '02'))) ;
    
--데이터를 입력해봅니다. emp_test에.
--sal 컬럼 check 제약조건 (sal > 0)에 의해서 음수 값은 입력 될 수 없다.
INSERT INTO emp_test VALUES (9999, 'brown', -1, '01');

--check 제약조건을 위배하지 않으므로 정상 입력.(sal, emp_gb)
INSERT INTO emp_test VALUES (9999, 'brown', 1000, '01');

--샐리 emp_gb 를 03으로 넣어보자.
--emp_gb 체크조건에 위배(emp_gb IN('01','02')) !
--01, 02 중 하나로 수정하면 잘 들어간다.
INSERT INTO emp_test VALUES (9999, 'sally', 1000, '03');

--check 제약조건 제약조건이름 생성.
CREATE TABLE emp_test(
    empno  NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    sal NUMBER(7,2) CONSTRAINT C_SAL CHECK (sal > 0),
    gmp_gb VARCHAR2(2) CONSTRAINT C_EMP_GB CHECK (emp_gb IN ('01', '02'))) ;



--
DROP TABLE emp_test;
--테이블레벨로 check 제약조건 이름생성.
CREATE TABLE emp_test(
    empno  NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    sal NUMBER(7,2) ,
    gmp_gb VARCHAR2(2), 
    
    CONSTRAINT C_SAL CHECK (sal > 0),
    CONSTRAINT C_EMP_GB CHECK (emp_gb IN ('01', '02'))
    ) ;

--NOT NULL 도 CHECK //..에포함돼..
CONSTRAINT nn_ename CHECK (ename IS NOT NULL)

--NOT NULL워낙 많이 씌여서 키워드로 별도분리한것. 체크임.
--이름안만들고 대체로 컬럼옆에 씀.

--테이블 생성 : CREAT TABLE  테이블명 (컬럼 컬럼타입.....);
--기존 테이블을 활용해서 테이블 생성 : 
--CREATE TABLE AS: STAS 씨타스
--CREATE TABLE 테이블 명 (컬럼,컬럼,컬럼.....생략가능) AS SELECT coll1, col2, col13..
--                                                    FROM 다른 테이블명
--                                                    WHERE 조건

DROP table emp_test;

--emp 테이블의 데이터를 포함새헛 emp_test 이블을 생성.
CREATE TABLE emp _ test AS
SELECT *
FROM emp;

--데이터까지 복제가 가능하다.



--복사하는데 컬럼명을 바꿔봅시다. 이런게있다정도로만 알아도 괜찮아.
DROP table emp_test;

--emp 테이블의 데이터를 포함새헛 emp_test 테이블을 컬럼명을 변경하여 생성.
CREATE TABLE emp _ test(c1,c2, c3, c4, c5, c6,c7, c8), AS
SELECT *
FROM emp;

--데이터 확인해봅시다.
SELECT *
FROM emp_test;
--자주쓰는 형태는 아니다.

--테이블을 만드는데, 데이터의 틀만 복사할 수 있을까?
--컬럼구성만!
CREATE TABLE emp_test AS 
SELECT *
FROM emp
WHERE 1=2;
SELECT *
FROM emp_test;

DROP table emp_test;

--백업해놓는 방법! 오늘날짜로 새 테이블을 만들어서
--뭔가 날렸을 때에 오늘날짜로 돌아올수있음.
--NOT NULL 제약 조건 이외의 제약조건은 복사되지 않는다.( primary, uique 이런거.복사안되니까 별도로 생성해야한다.)
CREATE TABLE emp_20191209 AS
SELECT *
FROM emp;

--테스트개발시에도 사용함.





--<<데이터 변겅!!>>이미생성되어있는 테이블에 새로운 컬럼 추가, 컬럼 변경/ 삭제
--테이터 타입은 변경이 불가능하다. NUMBER 를 VARCHAR2 이런거로 변경 불가능.
--만약 데이터가 안에 들어가있지 않으면 변경가능함.
--데이터가 있는데도 타입이 불가능한경우는 사이즈의 변경뿐이다. 사이즈변경시 축소는 또 제약이 심함. 증가만 쉬움.
--삭제는 그냥 날려버리면 됨.
--이름변경은 쉽다.
--제약조건을 추가하는것도 가능.

--ALTER

--emp_test 테이블 삭제.
DROP TABLE emp_test;
--empno, ename, deptno 컬럼으로 emp_test 생성 (emp에서 틀만 복사해왔다.)
CREATE TABLE emp_test AS
    SELECT empno, ename, deptno
    FROM emp
    WHERE 1=2;

--조회
SELECT *
FROM emp_test;

--emp_test 테이블에 신규컬럼 추가
--HP VARCHAR2(20) DEFAULT '010'
--ALTER TABLE 테이블명 ADD (컬럼명 컬럼타입 [디폴트값]);
ALTER TABLE emp_test 
ADD (HP VARCHAR2(20) DEFAULT '010');

--데이터가 없으니 기존컬럼수정을해보자.
--ALTER TABLE 테이블명 MODIFY (컬럼 컬럼타입[DEFAULT value]);
--우리는 hp컬럼의 타입을 varchar2(20)-> varchar2(30)
ALTER TABLE emp_test MODIFY(hp VARCHAR2(30));

----우리는 hp컬럼의 varchar2(30) -> NUMBER
--현재 emp_test 테이블의 데이터가 없기 때문에 컬럼 타입을 변경하는 것이 가능하다.
ALTER TABLE emp_test MODIFY(hp NUMBER);
--확인
DESC emp_test;

--컬럼명을 변경해봅시다.
--해당컬럼이 PK, UNIQUE, NOT NULL, CHECK 제약 조건시 기술한 컬럼명에 대해서도 자동적으로 변경이 된다.
--hp컬럼이름을 hp_n
--ALTER TABLE 테이블명 RENAME COLUMN 기존컬럼명 TO 변경컬럼명;
ALTER TABLE emp_test RENAME COLUMN hp TO hp_n;
DESC emp_test;


--컬럼 삭제
--ALTER TABLE 테이블명 DROP (컬럼);
--ALTER TABLE 테이블명 DROP COLUMN 컬럼;
ALTER TABLE emp_test DROP (hp_n);
ALTER TABLE emp_test DROP COLUMN hp_n;

--제약조건을 추가해봅시다.
--ALTER TABLE 테이블명 ADD --테이블 레벨 제약조건 스크립트.
--emp_test 테이블의 empno컬럼을 PK 제약조건 추가해보자.
ALTER TABLE emp_test ADD CONSTRAINT pk_emp_test PRIMARY KEY(empno);

--제약조건삭제는? 
--ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건이름;
--위에서 만든 pk_emp_test 제약조건을 삭제해보자.
ALTER TABLE emp_test DROP CONSTRAINT pk_emp_test;

--테이블 컬럼, 타입 변경은 제한적으로나마 가능하다.
--테이블 컬럼의 순서를 변경하는 것은 불가능하다.
--empno, ename, job 순서로 만든 컬럼을 empno, job, ename 으로 바꾸는거
--지웠다가 다시 만드는것뿐이 방법이 없다. 하지만 아주아주어렵다. 실수한번하면 큰일남..


--시타스?로 순서를 바꿨는데 이건 운이좋게되는거라신다.
CREATE TABLE emp_test AS
SELECT *
FROM emp
ORDER BY job ASC;


--신기 SELECT 절에 ALTER TABLE 이런거 추가해넣어서 복사하면 약간 한번에 바꾸는듯이 된다.

