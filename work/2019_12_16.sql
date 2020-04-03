--<< report group function (grouping sets(col1, col2))  >>
--다음과 결과가 동일. 개발자가 GROUP BY 의 기준을 직접 명시한다.
--ROLL UP과는 달리 방향성을 갖지 않는다.
--GROUPING SETS(COL1, COL2) = GROUPING SETS(COL2, COL1)
 
--GOUPR BU COL1
--UNION ALL
--GOUP BY COL2

--emp 테이블에서 직원의 job 별 급여(sal) + 상여(comm)합,
--deptno(부서)별 급여(sal)+ 상여(comm) 합 구하기.

--기존방식 (group function) : 2번의 SQL 작성 필요. (UNION/ UNION ALL)

SELECT job, null deptno, sum(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY job

UNION ALL

SELECT '',deptno, sum(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY deptno;

--GROUPING SETS 구문을 이용하여 위의 SQL 을 집합연산을 사용하지 않고 테이블을 한 번 읽어서 처리해라.
SELECT job, deptno, sum(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY GROUPING SETS (job, deptno); 

--job, deptno를 그룹으로 한  sal+comm 합, mgr을 그룹으로한 sal+comm 합.
--GROUP BY job, deptno
--union all
-- GROUP BY mgr
--> GROUPING SETS (job, deptno, mgr) -----> GROUPING SETS ((job, deptno), mgr)
SELECT job, deptno, mgr, sum(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY GROUPING SETS ((job, deptno), mgr);

SELECT job, deptno, mgr, sum(sal + NVL(comm, 0)) sal_comm_sum,
    GROUPING(job), GROUPING(deptno), GROUPING(mgr)
FROM emp
GROUP BY GROUPING SETS ((job, deptno), mgr);


--<< cube >>
--잘안씀...
--cube(col1, col2 ...)
--나열된 컬럼의 모든 가능한 조합으로 group by subset을 만든다.
--cube에 나열된 컬럼이 2개인 경우 : 가능한 조합 4개
--cube에 나열된 컬럼이 3개인 경우 : 가능한 조합 8개
--cube에 나열된 컬럼수를 2의 제곱승 한 결과가 가능한 조합 개수가 된다.(2^n)
--컬럼이 조금만 많아져도 가능한 조합이 기하급수적으로 늘어나기 때문에
--많이 사용하지 않는다.

--job, deptno를 이요하여 CUBE 적용
SELECT job, deptno, sum(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY CUBE(job, deptno);
-- job, deptno
-- 1    1   -> GROUP BY job, deptno
-- 1    0   -> GROUP By job
-- 0    1   -> GROUP BY deptno
-- 0    0   -> GROUP BY --emp 테이블의 모든 행에 대해 GROUP BY.
--
--GROUP BY 응용
--GROUP BY, ROLLUP, CUBE를 섞어 사용하기
-- 가능한 조합을 생각해보면 쉽게 결과를 예측할 수 있다.
-- GROUP BY JOB, rollup(deptno), cube(mgr)

SELECT job, deptno, mgr, SUM(sal + NVL(comm, 0)) SAL_comm
FROM emp
GROUP BY job, rollup(deptno), cube(mgr);
--job 을 디폴트로 고정해놨기때문에 전체총계는 안나옴.



--
SELECT job, SUM(sal)
FROM emp
GROUP BY job, rollup(job);

--
SELECT job, deptno, mgr, SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY job, rollup(deptno), cube(mgr);
--액셀로 칠해보기..

--큐브는 가능한 모든조함, 롤업은 오른쪽부터, 그룹셋은 직접입력.

--ADVANCED SUB QUERY

--실습 SUB_A1
SELECT deptno, COUNT(deptno)
FROM dept_test
GROUP BY  deptno;

DROP TABLE dept_test;

--dept 로 dept_test 만듦.
CREATE TABLE dept_test AS
    SELECT *
    FROM dept;
    
--empcnt 컬럼 추가
ALTER TABLE dept_test ADD (empcnt NUMBER);

UPDATE dept_test 
SET empcnt = (SELECT COUNT(emp.deptno)
                FROM emp
                WHERE dept_test.deptno = emp.deptno);


DESC emp;
DESC dept_test;
SELECT *
FROM dept_test;
SELECT *
FROM dept;

SELECT COUNT(emp.deptno)
FROM dept_test, emp
WHERE dept_test.deptno = emp.deptno;

rollback;

--실습 sub_a2
DROP TABLE dept_test;

CREATE TABLE dept_test AS
SELECT *
FROM dept;

INSERT INTO dept_test values(99, 'it1', 'daejeon');
INSERT INTO dept_test values(98, 'it2', 'daejeon');

--
DELETE FROM dept_test
WHERE  deptno NOT IN (SELECT COUNT(emp.deptno)
                        FROM emp
                        WHERE emp.deptno = dept_test.deptno
                        HAVING COUNT(emp.deptno) = 0);

--
DELETE dept_test
WHERE deptno NOT IN (SELECT deptno
                    FROM emp);
                    
                    
--실습 sub a3
CREATE TABLE emp_test AS
SELECT *
FROM emp;

--
SELECT ename, deptno, sal
FROM
(SELECT deptno, ROUND(AVG(sal),1) a
FROM emp
GROUP BY deptno)
HAVING emp.sal < ROUND(AVG(sal),1);

--부서별 급여 평균
SELECT deptno, ROUND(AVG(sal),1) a
FROM emp
GROUP BY deptno;

SELECT empno, ename, deptno, sal
FROM emp;

SELECT ROUND(AVG(sal), 2)
FROM emp
WHERE deptno = 30;



--급여평균보다 sal 낮은 사람
UPDATE emp_test SET sal = sal +200
WHERE sal < (SELECT ROUND(AVG(sal), 2)
                FROM emp
                WHERE deptno = emp_test.deptno);

SELECT empno, ename, deptno, sal
FROM emp_test;

--위를 merge 구문을 이용해 업데이트해봅시다.

rollback;
--부서별 급여평균
SELECT deptno, AVG(sal)
FROM emp_test
GROUP BY deptno;

--suing 절에 뷰도 올 수 있음.
--on절에 오는 컬럼들은 업데이트될 수 없다.,,
MERGE INTO emp_test a
USING (SELECT deptno, AVG(sal) avg_sal
        FROM emp_test
        GROUP BY deptno) b
ON (a.deptno = b.deptno)
WHEN MATCHED THEN
    UPDATE SET sal = sal + 200
    WHERE a.sal < avg_sal;
--WHEN NOT MATCHED THEN
rollback;

MERGE INTO emp_test a
USING (SELECT deptno, AVG(sal) avg_sal
        FROM emp_test
        GROUP BY deptno) b
ON (a.deptno = b.deptno)
WHEN MATCHED THEN
    UPDATE SET sal = CASE 
                        WHEN a.sal < b.avg_sal THEN sal + 200
                        ELSE sal
                    END;


