CREATE INDEX emp 
;
EXPLAIN PLAN FOR
SElECT *
FROM EMP
WHERE EMPNO = :EMPNO;

SELECT *
FROM TABLE (dbms_xplan.display);

SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO
AND EMP.DEPTNO = :DEPTNO
AND EMP.EMPNO LIKE :EMPNO ||'%';


-EMPNO, DEPTNO, 
CREATE INDEX IDX_N_EMP_01 EMP (EMPNO) ;
CREATE INDEX IDX_N_EMP_02 EMP (DEPTNO) ;




--1. 입력받은 EMPNO 사원 *조회
2. 입력받은 ENAME 의 사원 *조회--ENAME --?? 
--3. EMP, DEPT 입력받아서 일치할경우 *조회
4. 입력한 범위의 샐러리 범위속 입력한 DEPTNO속의 사원  조회 --SA//L
5. 입력한 DEPTNO 의 매니저들 조회 --MGR
6. 부서별 입사날자별 / 부서번호와 입사날짜와 건수.. --deptno-HIREDATE1
;
SELECT *
FROM emp;

--