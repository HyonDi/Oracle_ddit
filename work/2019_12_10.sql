--제약조건 활서오하/비활성화
--테스트목적 등
--ALTER TABLE 테이블명 ENABLE OR DISABLE CONSTRAINTS 제약조건명;

--제약조건 이름 찾는법 1. 테이블정보의 CONSTRAINT 확인
-- 2. SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'DEPT_TEST';(DEPT계약조건 비활성화할거니까)


SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'DEPT_TEST';

--DEPT_TEST의 PRIMARY KEY 를 비활성화함.
ALTER TABLE dept_test DISABLE CONSTRAINT sys_c007119;

--비활성화한 DEPT_TEST 에 값을 넣어보자.
--dept_test 테이블의 deptno컬럼에 적용된 PRIMARY KEY 제약조건을 
--비활성화 하여 동일한 부서번호를 갖는 데이터를 입력할 수 있다.
INSERT INTO dept_test VALUES (99,'ddit','daejeon');
INSERT INTO dept_test VALUES (99,'DDIT','대전');

--다시 활성화해보자.
ALTER TABLE dept_test ENABLE CONSTRAINT sys_c007119;
--이미 위에서 실행한 2개의 insert 구문에 의해 같은 부서번호를 갖는 데이터가 존재하기 때문에
--PRIMARY KEY 계약조건을 활성화 할수 없다. 
--활성화하려면 중복데이터를 삭제해야한다.

--중복데이터 삭제하려면 중복데이터를 찾는다.
--해당 데이터에 대해 수정 후 PRIMARY KEY 계약조건을 활성화 할 수 있다.
SELECT deptno, COUNT(*)
FROM dept_test
GROUP BY deptno
HAVING COUNT(*) >= 2;

--
SELECT *
FROM user_constraints;
--
SELECT *
FROM user_constraints
WHERE table_name = 'BUYER';

SELECT *
FROM user_cons_columns
WHERE table_name = 'BUYER';

--위를 조인해보자. TABLE,_NAME, CONSTRAINT_NAME, COLUMN_NAME
--제약조건 POSITION 정렬(asc)

SELECT *
FROM user_cons_columns, user_constraints
WHERE 
????
;

--테이블에 대한 설명 (주석) VIEW
SELECT *
FROM USER_TAB_COMMENTS;
--여기에 나오는 COMMENTS 달아보자.
--테이블 주석:
--COMMENT ON TABLE 테이블명 IS '주석';
COMMENT ON TABLE dept IS '부서';

--컬럼주석 :
--COMMENT ON COLUMN 테이블명. 컬럼명 IS'주석';
SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'DEPT';

COMMENT ON COLUMN dept.deptno IS '부서번호';
COMMENT ON COLUMN dept.dname IS '부서명';
COMMENT ON COLUMN dept.loc IS '부서 위치 지역';

--실습 commet1
SELECT t.table_name, table_type,t.comments TAB_COMMENT, column_name
        , c.comments COL_COMMENT
FROM user_tab_comments t,user_col_comments c
WHERE t.table_name = c.table_name
AND t.table_name IN ('CUSTOMER','PRODUCT','CYCLE','DAILY');

SELECT *
FROM user_tab_comments;
SELECT *
FROM user_col_comments;

--<<view>>
--emp 테이블에서 급여정보를 몇몇에게만 보여주고싶어. hr시스템담당하면 꿀잼이라신다. 원래보면안돼..
--실행한 sql의 기록이 남는 규모가 큰회사도 있음. 
--컬럼 제한, 자주사용하는 결과물의 재활욜, 쿼리 길이 단축. 을 목적으로 사용함.
--조인의 결과를 뷰로 만들어놓을 수 있다.

--view 생성. 뷰도 객체임 creat 로 만든다. 테이블과 다른점은 옵션은 변경!
 --create [replace] view v_emp AS 
 --subquery;
 --view 는 쿼리이다. (o)
 --view 는 테이블이다. (x)
 --view 는 테이블처럼 데이터가 물리적으로 존재하는 것이 아니다.
 --약간 스태틱메서드같은 느낌이넹
 --논리적 데이터셋 = query
 
--CREATE OR REPLACE VIEW 뷰이름 [(컬럼별칭1, 컬럼별칭2....)]AS
--SUBQUERY
 
--emp 테이블에서 sal,. comm컬럼을 제외한 나머지 6새 컬럼만 조회가 되는 view 를 v_emp 이름으로 생성해보자.
CREATE OR REPLACE VIEW v_emp AS 
SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp;

--계정권한이 없음. VIEW 생성 권한이 필요. SYSTEM 계정에서 실행.*****
--GRANT  CREATE VIEW TO 계정(SYSTEM 말고 현재 사용중인거) (GRANT 성공했다고 떠야함!!)

--view 를 통해 데이터를 조회했다.
SELECT *
FROM v_emp;

--inline view 의 형태로 view 를 표현하면?(view 생성없이 view 를 보려면)
SELECT*
FROM (SELECT empno, ename, job, mgr, hiredate, deptno
        FROM emp);
--재사용시 복사해가야하지만 뷰를 만들어놓는 것이 재사용성이 높다.

--interface! 몰까

--emp 테이블을 수정하면 view 에 영향이 있을까?
--view 는 쿼리임. 원본데이터는 테이블에서 가져오는것. 
--따라서 테이블이 바뀌면 뷰도 바뀐데이터에 영향을 받는다.

--KING 부서번호가 현재 10번. emp테이블의 KING의 부서번호 데이터를 30번으로 수정.
-- v_emp 테이블에서 KING 의 부서번호를 관찰.
UPDATE emp set deptno = 30
WHERE ename = 'KING';

SELECT *
FROM emp
WHERE ename = 'KING';

--
SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--위를 view로 생성해보자
CREATE OR REPLACE VIEW v_emp_dept AS
SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--위의뷰 조회
SELECT *
FROM v_emp_dept;

--emp 테이블에서 KING 데이터 삭제.(삭제후 다시 king 등록해야함. ddl 은 오토커밋됨.)
DELETE emp
WHERE ename = 'KING';
--확인
SELECT *
FROM emp
WHERE enmae = 'KING';
--킹 삭제후 뷰다시 조회
SELECT *
FROM v_emp_dept;

--inline view 로 표현해보렴.
SELECT *
FROM (SELECT emp.empno, emp.ename, dept.deptno, dept.dname
        FROM emp, dept
        WHERE emp.deptno = dept.deptno);


--emp 테이블의 컬럼이름을 바꾸면 (empno->eno)
ALTER TABLE emp RENAME COLUMN empno TO eno;
--만들어놓은 뷰는 어떻게될까?
SELECT *
FROM v_emp_dept;
--왼쪽 접속창에서도 뷰를 보면 빨강 엑스가 쳐진다.깨졌다. 다시 살아나지않음.
--뷰만드는 스크립트를 다시 실행하면 된다.
--이번엔 CREATE OR REPLACE 에서 REPLACE 부분이 실행되어수정될것이다.

--v_emp 삭제해보자.
DROP VIEW v_emp;
--접속창보면 삭제됨.

--view 밑밑밑에 구체화된 뷰. 라고 있음(시퀀스 아래). 물리적데이터를 갖는 것.이 있기는 하다.
--다른 dbms에는 아마 없을것이다.

--view 의 종류
--1. simple view
--: from 절에 나오는 table수가 1개, 함수포함 없고 그룹바이함수 없고 view 통한 dml 실행가능.
--2,complex view
--: from 절에 나오는 table수 1개이상. 함수, 그룹바이함수 있음. view는 통한 dml 실행 일반적으로 안돼.
--여기서 말하는 dml = (select 말고 insert 나 update 등)



--부서별 직원의 급여합계
SELECT *
FROM emp;

SELECT deptno, SUM(sal) sum_sal
FROM emp
GROUP BY deptno;
--위를 뷰로 만들어보자.
CREATE OR REPLACE VIEW v_emp_sal AS
SELECT deptno, SUM(sal) sum_sal
FROM emp
GROUP BY deptno;
--
SELECT *
FROM v_emp_sal
WHERE deptno = 20;
--위를 인라인뷰로.
SELECT *
FROM (SELECT deptno, SUM(sal) sum_sal
        FROM emp
        GROUP BY deptno;
        )
WHERE deptno = 20;
--이걸
SELECT *
FROM (SELECT deptno, SUM(sal) sum_sal
        FROM emp
        WHERE deptno = 20
        GROUP BY deptno);
--group by에 wehre .....뷰 머징 (뷰가 머지됬다.)실행결과를 봐야만 알 수 있다. 답이 없음.
--결과가나오긴하지만 내가생각한데로 된건가? 싶음. 그래서어렵대.
--인라인뷰안에서 로우넘사용시 뷰머징이 일어나지 않는다.

--그.. group by 절에 having 웨어절 그거.. 그룹바이함수가 웨어절에 올수없다는 뜻!

SELECT *
FROM (SELECT deptno, sal, rownum FROM emp)
WHERE deptno = 20;
--> 웨어절이 프롬절안으로 들어갈 수 없게된다.
--로우넘을 적으면서 프롬절안의 인라인뷰를 먼저실행할수있도록 하는 것.튜닝.







--<<시퀀스>>시퀀스도 객체임.
--데이터에 key 컬럼은 값이 유일해야함.
--유일한 값을 만드는 방법? 1. key table 2. UUID/혹은 별도의 라이브러리 3.  sequence
--for update로 조회 막아놓고.......??자바에서는 uuid 라는 클래스가 있다.

--uuid(이클립스에 쳤다)
--	public static void main(String[] args) {
--		System.out.println(UUID.randomUUID().toString());
--		System.out.println(UUID.randomUUID().toString());

--sequence : 유일한 정수값을 생성해주는 오라클 객체. pk컬럼에 저장할 임의의 값 생성. 
--캐쉬기능을 통한 속도향상.

--생성밥법. 복잡..
CREATE SEQUENCE seq_emp
INCREMENT BY 1
START WITH 1
NOCYCLE
NOCACHE;
--맥스벨류를 설정하지않으면 굉장히 큰값이 들어간다.
--사이클을 설정하면 번호가 중복될 수 있다.

--NEXTVAL : 시퀀스의 다음 값을 조회
--CURRVAL : 현재 시퀀스 값을 조회 NEXTVAL을 통해 값을 가져온 뒤에 사용 가능.

CREATE OR REPLACE SEQUENCE seq_board;
--시퀀스를 만들었다. 사용해보자. 시퀀스명. nextval
SELECT seq_board.nextval
FROM dual;
--현재 시퀀스 번호.
SELECT seq_board.currval
FROM dual;

--시퀀스는 락이 있음. 내부적으로.메모리상에서 락을 관리하는 것이 cache래.  메모리에 20개먼저가져다놓고
--캐쉬가 클수록 빠른거지?
--중간에빠짐없이 순차적으로 해야하는경우 캐쉬는 적당하지않지만 ..rownum으로 어떻게할수있나봄.
--메모리에올려둔것은 사용자가 nextval 하지 않아도 서버를 재기동하면 캐싱되었던 시퀀스 값은 없어진다.
--rollback 해도 복원되지 않는다.

-- 수정은 ALTER , 삭제는 DROP

--연월일-순번
SELECT TO_CHAR(SYSDATE, 'yyyymmdd')||'-'||seq_board.nextval
FROM dual;










--<<index>> 색인. 개요
--오라클에서
--테이블(table)은 힙(heap)에넣고
--인덱스(index)는 트리(tree)에넣음.
--stack : Fist In Last Out = 가장먼저들어온게 가장 나중에나간다.
--정렬!
--이진트리/..로그함수모양으로 데이터가많아져도 시간에별변화가없다.
--컴퓨터는 아주빨라요~!
--시간복작도??
--포문은 / 모양 n에 비례. 포문2개는 포물선모양 n제곱.
--tree(index) ??? iot??? 순서가보장이돼...


--index
--테이블의 일부컬럼을 기준으로 데이터를 정렬한 객체. = 인덱스는 트리구조이다.
--테이블의row를 가리키는 주소를 갖고 있다. (rowid)
SELECT rowid, rownum, emp.*
FROm emp;
--rowid 는 행에대한 주소임.

--현재 emp테이블에 제약조건 없어. 먼저 만듭니다. empno -> primary key : pk_emp
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY(empno);

--dept 테이블 deptno컬럼으로 primary key, : pk_dept
ALTER TABLE dept ADD CONSTRAINT pk_dept PRIMARY KEY(deptno);

--emp 테이블의 deptno컬럼이 dept 테이블의 deptno 컬럼을 참조하도록.
--foreign key 제약 추가 : fk_dept_deptno
ALTER TABLE emp ADD CONSTRAINT fk_dept_deptno FORIGN KEY (deotbi) REFERENCES dept(deptno);

SELECT rowid, rownum, emp.*
FROM emp;

--비교를위해 emp_test 를 가져와봅니다. (emp에서 복사해봅시다.)
--emp_test 삭제
DROP TABLE emp_test;

--emp 테이블을 이용해서 emp_test 테이블 생성
CREATE TABLE emp_test AS
SELECT *
FROM emp;
--시타스로 만든건 제약조건이 (NOT NULL빼고는) 따라오지않아. 
--유니크제약은 유니크인덱스를 만든다.


--emp_test 테이블에는 인덱스가 없는 상태.
--원하는 데이터를 찾기 위해서는 테이블의 데이터를 모두 읽어봐야 한다.
SELECT *
FROM emp_test
WHERE empno = 7369;
--실행계획을 보자.
EXPLAIN PLAN FOR
SELECT *
FROM emp_test
WHERE empno = 7369;
SELECT *
FROM table(dbms_xplan.display);
-->실행계획을 통해(TABLE ACCES FULL 부분)7369사번을 갖는 직원 정보를 조회하기위해 테이블의 모든데이터
--를 읽어본 다음에 사번이 7369인 데이터만 선택하여 사용자에게 반환.
--**13건의 데이터는 불ㅍㄹ요하게 조회 후 버림.

--이번에는 emp 를 읽어보자. (emp_test와의 다른점  : emp 는 empno로 인덱스가 구성되어있음. 
--항상 인덱스를 사용하는것은 아니다.
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7369;

SELECT *
FROM table(dbms_xplan.display);

--index는 항상  rowid를 가지고 다닌다.

--실행계획을 통해 분석을 하면
--empno 가 7369인 직원은 index를 통해 매우 빠르게 인덱스에 접근.
--같이 저장되어 있는 rowid 값을 통해 table에 접근한다.(rowid 테이블의 행의 주소!!)
--table에서 읽은 데이터는 7369사번 데이터 한건만 조회를 하고 나머지 13건에 대해서는 읽지 않고 처리.
--emp_terst 14--> 1    emp 1--> 1
--index 가 정렬을 대신하는 역할을 하긴은 하지만 남발허면 안돼.

--rowid 를알면 웨어절에서 사용도 가능하다.
EXPLAIN PLAN FOR
SELECT rowid, 
FROM emp
WHERE empno = 7369;

SELECT *
FROM table(dbms_xplan.display);

