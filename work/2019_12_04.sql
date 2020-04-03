--<<서브쿼리 SUB QUERY>>
--SMITH 가 속한 부서찾기
SELECT deptno
FROM emp
WHERE ename = 'SMITH';

SELECT *
FROM emp
WHERE deptno = 20;
-------------스미스가 속한 부서의 다른 사원들---------------------
SELECT *
FROM emp
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE ename = 'SMITH');
--웨어절에있는 셀렉트절이 서브쿼리임. 쿼리안의 또다른 쿼리.
--하나의 종합된 쿼리로 만들 수 있음.
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                FROM emp
                WHERE ename = 'SMITH');
--서브쿼리의 분류(사용위치)
--SELECT 에서 사용 : 스칼라 서브쿼리(scalar subquery) : 하나의 행, 하나의 컬럼만 리턴하는 서브쿼리.
--FROM 에서 사용 : 인라인 뷰
--WHERE 에서 사용 : 서브쿼리

--스칼라서브쿼리
--셀렉트 절에 표현된 서브쿼리. 한행, 한 컬럼을 조회해야 한다.아래는 되고, 아래아래는 안됨.
--스칼라서브워리가 한 행을 조회하는것이 아니기때문.위는 서브쿼리에서 메인쿼리를 참조.(상호연관 서브쿼리) : 메인쿼리없으면 실행불가.
--메인쿼리가 먼저 실행됨.
--아래는 서브쿼리에서 메인쿼리를 참조하지 않음.(비상호 연관 서브쿼리) 뭐부터 실행할지 모름.
SELECT empno, ename, deptno, (SELECT dname FROM dept WHERE dept.deptno = emp.deptno) dname
from emp;
-- 
SELECT empno, ename, deptno, (SELECT dname FROM dept) dname
from emp;

--INLINE VIEW
--FROM 절에 사용되는 서브쿼리.

--SUBQUERY
--WHERE절에 사용되는 서브쿼리.


--서브쿼리 실습 1
--평균급여보다 높은 급여를 받는 직원의 수 조회.
SELECT *
FROM emp;

SELECT COUNT(*) cnt
FROM emp
WHERE sal > (SELECT AVG(sal)
            FROM emp);
SELECT AVG(sal)
            FROM emp;
            

--서브쿼리 실습 2
--평균 급여보다 높은 급여를 받는 직원의 정보를 조회.
SELECT empno, ename, sal
FROM emp
WHERE sal > (SELECT AVG(sal)
            FROM emp);
            
            
--여러건 리턴하는 서브쿼리의 연산자. (멀티로우 연산자)
--IN : 서브쿼리 결과 중 같은 값이 있을 때.
--ANY : 서브쿼리 결과중 만족하는 것이 하나라도 있을 때. sal < any(subquery)
--ALL : 서브쿼리 결과를 모두 만족시킬때. sal>all(subquery)

--실습3
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                 FROM emp
                 WHERE ename IN ('WARD','SMITH'));
                 
--1. 스미스, 워드가 속한 부서 조회
--2. 1번에 나온 결과값을 이요하여 해당 부서 번호에 속하는 직원조회.
SELECT *
FROM emp
WHERE deptno IN
(SELECT deptno
FROM emp
WHERE ename IN ('SMITH','WARD'));

SELECT *
FROM emp
WHERE sal <= ALL
            (SELECT sal
            FROM emp
            WHERE ename IN ('SMITH','WARD'));
--서브쿼리에서 NULL : NOT IN
--관리자인 사원.
SELECT *
FROM emp
WHERE empno IN (SELECT mgr
                    FROM emp);
--관리자가 아닌사원
--NOT IN 연산자 사용시 null 이 데이터에 존재하지 않아야 정상동작 한다.
SELECT *
FROM emp
WHERE empno NOT IN (SELECT NVL(mgr, -1)
                    FROM emp);
--                    
SELECT *
FROM emp
WHERE empno NOT IN (SELECT mgr
                    FROM emp
                    WHERE mgr IS NOT NULL);
--                    
--페어와이즈 pairwise (Multi column subquery) = 여러컬럼의 값을 동시에 만족해야하는 경우.
--allen, clark 의 매니저와 부서번호가 동시에 같은 사원정보 조회.
--(매니저번호가 7698 이면서 부서번호가 30), (7839 이면서 10)
SELECT *
FROM emp
WHERE (mgr, deptno) IN(
                        SELECT mgr, deptno
                        FROM emp
                        WHERE empno IN (7499, 7782));
-- 페어와이즈가 아니면?
--매니저가 7698 이거나, 7839이면서 소속부서가 10번 이거나 30번인 직원 정보 조회.
SELECT *
FROM emp
WHERE mgr IN( SELECT mgr
              FROM emp
              WHERE empno IN (7499, 7782))
AND deptno IN( SELECT deptno                        
               FROM emp
               WHERE empno IN (7499, 7782));
               
--inlineview (from)
SELECT *
FROM (SELECT AVG(sal) sal_avg
        FROM emp);
        
--비상호 연관 서브쿼리:
--메인쿼리에서 사용하는 테이블, 서브쿼리 조회 순서를 성능적으로 유리한 쪽으로 판단하여 순서를 결정한다.
--메인 쿼리의 emp 테이블을 먼저 읽을 수도 있고, 서브쿼리의 emp 테이블을 먼저 읽을 수도 있다.
--직원의 급여 평균보다 높은 급여를 받는 직원 정보 조회.
--oltp 프로그램????
--실행계획을 빨리세워야해. 뭘 먼저읽을지 오라클이 고려한 후 결정한다. 단독적으로 서브쿼리를 실행할 수 있기 때문에.

--비상호 연관 서브쿼리에서 서브쿼리쪽 테이블을 먼저 읽을 때는 서브쿼리가 제공자역할을 했다 라고 모 도서에서 표현함.
--비상호 연관 서브쿼리에서 서브쿼리쪽 테이블을 나중에 읽을 때는 서브쿼리가 확인자 역할을 했다 라고 모 도서에서 표현.
--논리적으로 코드를..짜라고..논리..논리.연산ㄷ자....뭐지..


--직원의 급여 평균
SELECT AVG(sal)
FROM emp;
--
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
                FROM emp);
                
--상호 연관 서브쿼리
--해당 직원이 속한 부서의 급여 평균보다 높은 급여를 받는 직원 조회

SELECT *
FROM emp m
WHERE sal > (SELECT AVG(sal)
            FROM emp
            WHERE deptno = m.deptno);


--10번부서의 급여 평균
SELECT AVG(sal)
FROM emp
WHERE deptno = 10;

페어와이즈. 서브쿼리........