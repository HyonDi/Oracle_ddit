--index만 조회하여 사용자의 요구사항에 만족하는 데이터를 만들어낼 수 있는 경우

SELECT *
FROM emp;

SELECT rowid
FROM emp;

SELECT empno, rowid
FROM emp;

--emp테이블의 모든 컬럼을 조회.
SELECT *
FROM emp
WHERE empno = 7782;

--위 실행계획을보자.
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE((dbms_xplan.display));


--emp테이블의 empno컬럼을 조회
SELECT *
FROM emp
WHERE empno=7782;

SELECT empno
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE((dbms_xplan.display));
--> 인덱스만 일고서 끝날 수도 있다!!! 오라클은 똒띠하ㅣ니까!~!!~!

--기존 인덱스 제거 -> pk_emp 제약조건 삭제 -> 제약 삭제 -> pk_emp 인덱스 삭제
ALTER TABLE emp DROP CONSTRAINT pk_emp;
--인덱스의 종류 (컬럼 중복여부에 따라)
--UNIQUE INDEX  : 인덱스 컬럼의 값이 중복될 수 없는 인덱스. (emp.empno, dept.deptno)
-- NON-UNIQUE INDEX : 인덱스 컬럼의 값이 중복될 수 있는 인덱스  (EMP.JOB) = 얘가 디폴트!!

CREATE INDEX index_n_emp_01 ON emp (empno);
CREATE UNIQUE INDEX index_n_emp_01 ON emp (empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno=7782;

SELECT *
FROM TABLE((dbms_xplan.display));

--> 위의 상활이랑달리진것은 empno컬럼으로 생성된 인덱스가 UNIQUE -> NONUNIQUE 인덱스로 변경됨.

EXPLAIN PLAN FOR
SELECT *
FROM EMP;

--7782 
INSERT INTO emp(empno, ename) VALUES (7782, 'brown');
COMMIT;

--emp 테이블에 job컬럼으로 non-unique 인덱스 생성
-- 인덱스명  : idx_n_emp_02

CREATE INDEX idx_n_emp_02 ON emp (job);
EXPLAIN PLAN FOR
SELECT job, rowid
FROM emp
ORDER BY JOB;
SELECT *
FROM TABLE((dbms_xplan.display));


--emp 테이블에 인덱스가 2개가 되었다.
--1. empno 로 정렬.
--2. job 으로 정렬.
--

SELECT *
FROM emp
WHERE empno= 7369;

--잘못된인덱스를사용하면 속도가 더 느려져여~!
--무기!
--인덱스르최대한절제해서만드는게 능력이래.
--하나의인덱스로 여러sql에서 활용할수있도록.

--수정, 신규입력시 테이블과 인덱스 모두 고쳐야하니까 불리하다.dml할때는 인덱스가 오히려 안좋아.
--어떻게 착 하고찾아? job컬럼읽어야하는거아냐?

--idx_02 인덱스
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';
--job인덱스를 전체읽고, c로시작하지않는건 읽고 거름.

--데이터를 접근하게 하는게 access predicate, 거르고 버리는건 filter predicate.
--filter predicate 는 읽고 버리는게있으니까 대체적으로 안좋은것임. 
--하지만 모든 쿼리를 효율적으로 하기어려웡..

--컬럼끼리 묶어서 인덱스를 만들수도있대ㅏ.
--idx_n_emp_03
--emp 테이블의job, ename 컬럼으로 non-unique 인덱스 생성.
CREATE INDEX idx_n_emp_03 ON emp (job, ename);
--job인덱스랑 ename 인덱스랑 적는 순서도 중요해.
--이렇게해서 읽은 모든걸 나오게햇다. 버린게 없음.
--C로 시작하는것도 읽어봐야 아는거아냐?(ename 이 후행)

--idx_n_emp_04
--enam, job 컬럼으로 emp 테이블에 non_uique 인덱스 생성.
CREATE INDEX idx_n_emp_04 ON emp (ename, job);
--=
SELECT ename, job, rowid
FROM emp
ORDER BY ename, job;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
OR ename LIKE 'J%';
SELECT *
FROM TABLE((dbms_xplan.display));

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'J%';
SELECT *
FROM TABLE((dbms_xplan.display));

--여러단계걸치는것보다 그냥 쭉 읽는게 낫지않을까

--JOIN 쿼리에서의 인덱스
--emp. empno 컬럼으로 primary key 제약조건이 존재.
--dept 테이블은 deptno컬럼으로 primary key 제약조건이 존재.
--EMP테이블은 PRIMARY KEY 제약을 삭제한 상태이므로 재생성.
--
DELETE emp
WHERE ename = 'brown';

SELECT *
FROM emp
WHERE ename = 'brown';

ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY(empno);

EXPLAIN PLAN FOR
SELECT ename, dname, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.empno = 7788;

SELECT *
FROM TABLE(dbms_xplan.display);


--인덱스읽기와 테이블 풀엑세스랑 뭐가더 유리함강?보통은 인덱스구성을 잘 안보고 쿼리를 작성한다.
--특정부분만 느리다는 연락을 받으면 그부분에대해서는 찾아봐야한다.
--인덱스만드느부분은dba와 상의를 해야함.

--실습idx1
DROP TABLE DEPT_TEST;

CREATE TABLE DEPT_TEST AS 
SELECT *
FROM DEPT 
WHERE 1=1;
--deptno 컬럼을 기준으로 unique 인덱스 생성
CREATE UNIQUE INDEX idx_u_dept_test_01 ON DEPT_TEST (deptno);
--dname 컬럼을 기준으로 non-unique 인덱스 생성
CREATE  INDEX idx_n_dept_test_02 ON DEPT_TEST (dename);
--deptno,dname 컬럼을 기준으로 non-unique 인덱스 생성
CREATE INDEX idx_n_dept_test_03 ON DEPT_TEST (deptno, dname);

--실습 idx2
DROP INDEX idx_u_dept_test_01;
DROP INDEX idx_n_dept_test_02;
DROP INDEX idx_n_dept_test_03;

--실습 idx3










