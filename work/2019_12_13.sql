--<< merge >>

--테이블에 조건에 해당하는 데이터가 없을 경우 : insert
--테이블에 데이터가 있을 경우 update
--
--select 랑 insert or update 까지 더한게 merge 임


SELECT *
FROM emp_test
ORDER BY empno;

--7개가 지워졌다.
--emp테이블에 존재하는 데이터를 emp_test 테이블로 머지.
--만약 empno가 동일한 데이터가 존재하면
--ename update : ename || '_merge'
--만약 empno가 동일한 데이터가 존재하지 않을 경우
--emp테이블의 empno, ename emp_test 데이터로 insert 할 것이다.

----타노스 js

--emp_test 의 데이터에서 절반의 데이터를 삭제
DELETE emp_test
WHERE empno >= 7788;

--emp 테이블에는 14건의 데이터가 존재
--emp_test 테이블에는 사번이 7788보다 작은 7명의 데이터가 존재
--emp테이블을 이용하며 emp_test 테이블을 머지하게 되면
--emp테이블에만 존재하는 직원 (사번이 7788보다 크거나 같은 직원) 7명이
--emp_test로 새롭게 insert가 될 것이고
--emp, emp_test 에 사원번호가 동일하게 존재하는 7명(사번이 7788보다 작은 직원)의 데이터는
--ename 컬럼을 ename || 'modify' 로 업데이트를 한다.
--머지구문 사용방법:
/*
MERGE INTO 테이블명
USING 머지대상 테이블 혹은 뷰 혹은 버스쿼리
ON (테이블명과 머지대상의 연결관계)
WHEN MATCHED THEN
    UPDATE .....
WHEN NOT MATCHED THEN
    INSERT ......
*/

MERGE INTO emp_test
USING emp
ON (emp.empno = emp_test.empno)
WHEN MATCHED THEN
    UPDATE SET ename = ename || 'mod'
WHEN NOT MATCHED THEN
    INSERT VALUES (emp.empno, emp.ename);
--결과 : 14개의 행이 병합되었습니다. 라고 출력된다.

-- emp_test 테이블에 사번이 9999인 데이터가 존재하면 ename 을 'brown'으로 update
--존재하지 않을 경우 empno, ename VALUES (9999, 'brown') 으로 insert.
-- 위의 시나리오를 merge 구문을 황용해 한번의 sql로 구현.
-- :empno = 9999, ename = 'brown'
MERGE INTO emp_test
USING dual
ON (emp_test.empno = :empno)
WHEN MATCHED THEN
    UPDATE SET ename = : ename || '_mod'
WHEN NOT MATCHED THEN
    INSERT VALUES (:empno,  :ename);
    
SELECT *
FROM emp_test
WHERE empno = 9999;

--정말 유용하대
--쿼리 2번쓸것을 1번으로 줄임

--만약 merge 문이 없다면 
--1. empno = 9999인 데이터가 존재하는지 확인
--2-1 1번 사항에서 데이터가 존재하면 update
--2-2 1번 사항에서 데이터가 존재하지않으면 insert

--<< reprot 함수 >>

--그룹별 합계, 전체함계를 다음과 같이 구하려면? table : emp

SELECT *
FROM emp;
----------------------------------------------------

SELECT *
FROM
(
(SELECT deptno, SUM(sal), (SELECT SUM(a)
                          FROM 
                         (SELECT deptno, SUM(sal) a
                         FROM emp
                         GROUP BY deptno))
                            
FROM emp
GROUP BY deptno) aa

LEFT OUTER JOIN

(SELECT w.deptno
FROM
(
SELECT
FROM emp
GROUP BY deptno) w)

ON (aa. sal = w. deptno)
;


-- 부서별 sal
SELECT deptno, SUM(sal) a
FROM emp
GROUP BY deptno;

-- 부서별 sal의 합
SELECT null, SUM(a)
FROM
(SELECT SUM(sal) a
FROM emp
GROUP BY deptno);



--실습 AD1UNION----------------------------------------
SELECT deptno, SUM(sal) sal
FROM emp
GROUP BY deptno

UNION

SELECT null, SUM(sal)
FROM emp;
----------------------------------------------

--JOIN 방식으로 풀이
--emp테이블의 14건의 데이터를 28건으로 생성
--구분자(1 14건, 2 14건)를 하나 줘서 이 기준으로 group by 
--구분자 1 : 부서번호 기준으로
--구분자 2 : 전체 (구분자 2에대한 = 14건)row합
SELECT DECODE(b.rn, 1, emp.deptno, 2, null) gp,
        SUM (emp.sal) sal
FROM emp, (SELECT ROWNUM rn
            FROM dept
            WHERE ROWNUM <=2) b
GROUP BY DECODE(b.rn, 1, emp.deptno, 2, null)
ORDER BY DECODE(b.rn, 1, emp.deptno, 2, null);


-------------------------------

--<< report group function >>
--ROLL UP!
--ROLLIP 절에 기술된 컬럼을 오른쪽에서부터 지운 결과로
--서브그룸을 만들어서 여러개의 GROUP BY 절을 하나의 Sql에서 실행되도록 한다.
GROUP BY ROLLUP(job, deptno)
--group by job, deptno
--group by job
--group by --> 전체행을 대상으로 group by


--emp테이블을 이용하여 부서번호별, 전체직원별 급여합을 구하는 쿼리를 rollip기능을 이용하여 작성

--실습 AD1
SELECT deptno, SUM(sal) sal
FROM emp
GROUP BY ROLLUP(deptno);

--후........

--emp테이블을 이용하여 job, deptno 별 sal + comm 합계
--job별 sal + comm합계 , 전체직원의 sal _ comm합계

SELECT job, deptno, SUM(sal + NVL(comm,0)) sal_sum
FROM EMP
GROUP BY ROLLUP(job, deptno);
--주의점 !!
--ROLLUP 은 컬럼순서가  SELECT 조회 결과에 영향을 미친다.

--<< grouping >>

--실습 AD2
SELECT DECODE(GROUPING (job),1,'총계',job) job, deptno, SUM(sal) sal 
FROM emp
GROUP BY ROLLUP(job, deptno)
;

--실습 AD 2-1
SELECT DECODE(GROUPING(job),1,'총',job) job,
       DECODE(GROUPING(deptno)+ GROUPING(job), 1, '소계',2,'계', deptno ) dept ,
       SUM(sal + NVL(comm,0)) sal_sum ,       
        --grouping(job)이 1일때엔 총계쪽 소계가 null이나와야함.
        --grouping(dept)+ gouping(job) = 2 일때 null     
        CASE--이거도 dept 의 소계구하는부분.
            WHEN deptno IS NULL AND job IS NULL THEN '계'
            WHEN deptno IS NULL AND job IS NOT NULL THEN '소계'
            ELSE '' || deptno--TO_CHAR(deptno)
        END deptno
        --,DECODE(GROUPING(deptno), 1, DECODE(GROUPING(job),1 '계', '소계'), deptno) 이거뭐지??암튼 DECODE 중첩해서씀
        
FROM emp
GROUP BY ROLLUP(job, deptno)
;

--실습 AD3
SELECT deptno,job, SUM(sal + NVL(comm,0)) sal
FROM emp
GROUP BY ROLLUP(deptno, job);

--실습 3을 UNION으로
SELECT deptno, job,  SUM(sal + NVL(comm,0)) sal
FROM emp
GROUP BY(deptno, job)
UNION ALL
SELECT deptno, null,  SUM(sal + NVL(comm,0)) sal
FROM emp
GROUP BY (deptno)
UNION ALL
SELECT null, null,  SUM(sal + NVL(comm,0)) sal
FROM emp;

--일단 암기를 합시다.
--rollup 이 그룹바이의 함수인거네??

--실습 AD4
SELECT dname,job, SUM(sal + NVL(comm,0)) sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP(dname, job);
--다른방법
SELECT dept.dname, a.job, a.sal 
FROM
    (SELECT deptno, job, SUM(sal + NVL(comm,0)) sal
    FROM emp
    GROUP BY ROLLUP(deptno, job)) a
WHERE a.deptno = dept.deptno(+);
--뭔가 잘못됐넹...




--실습 AD5
SELECT DECODE(GROUPING(dname),1,'총합',dname) dname,job, SUM(sal + NVL(comm,0)) sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP(dname, job);

