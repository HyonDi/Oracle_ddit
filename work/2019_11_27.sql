--group function
--그루핑단위를 뭐로 하냐에따라 결과가 다름.
--WHERE 절도 올 수 있음.
--특정 컬럼이나, 표현으로 여러행의 값을 한행의 결과로 생성.
-- function : avg, count(건수), max, min, sum 으로 그루핑 가능.
/*
SELECT [column, ], grou[ function(column)
FROM table
[GROUP BY column,]
[HAVING group function condition]
[ORDER BY column,]
*/

--전체직원을 대상으로 가장 높은 급여.(14건의 데이터가 1건으로 줄은 것.)
SELECT  MAX(sal) max_sal,
        MIN(sal) min_sal,
        ROUND(AVG(sal),2) avg_sal,
        SUM(sal) sum_sal,
        COUNT(sal) count_sal, --NULL이 아닌 값이면 1건.
        COUNT(mgr) count_mgr,--KING 은 mgr 이 null 이라 위에것 보다 하나 줄었다.
        COUNT(*) count_row--특정 컬럼의 건수가 아니라 행의ㅣ 개수를 알고 싶을 떄
FROM emp;
-------------------------------------------

DESC emp;
--groub by 절에 작성된 컬럼 이외의 컬럼은 select 절에 올 수 없다.
--groub by 절에 작성된 컬럼은 select 절에 올 수 있음.

--부서번호별 그룹함수 적용
SELECT  deptno,
        MAX(sal) max_sal,
        MIN(sal) min_sal,
        ROUND(AVG(sal),2) avg_sal,
        SUM(sal) sum_sal,
        COUNT(sal) count_sal, --NULL이 아닌 값이면 1건.
        COUNT(mgr) count_mgr,
        COUNT(*) count_row--특정 컬럼의 건수가 아니라 행의ㅣ 개수를 알고 싶을 떄
FROM emp
GROUP BY deptno;


--부서번호, 사원이름으로
SELECT  deptno, ename,
        MAX(sal) max_sal,
        MIN(sal) min_sal,
        ROUND(AVG(sal),2) avg_sal,
        SUM(sal) sum_sal,
        COUNT(sal) count_sal, --NULL이 아닌 값이면 1건.
        COUNT(mgr) count_mgr,
        COUNT(*) count_row--특정 컬럼의 건수가 아니라 행의ㅣ 개수를 알고 싶을 떄
FROM emp
GROUP BY deptno, ename;
--groub by 절데 없는 컬럼이 나올 경우 에러. (논리적으로 맞지 않는다.)
--여러명의 직원 정보로 한 건의 데이터를 그루핑해 만들었는데 
--단 예외적으로 상수값들은 SELECT 절에 표현이 가능.
SELECT  deptno, 1, 'ㅁ', SYSDATE,
        MAX(sal) max_sal,
        MIN(sal) min_sal,
        ROUND(AVG(sal),2) avg_sal,
        SUM(sal) sum_sal,
        COUNT(sal) count_sal, --NULL이 아닌 값이면 1건.
        COUNT(mgr) count_mgr,
        COUNT(*) count_row--특정 컬럼의 건수가 아니라 행의ㅣ 개수를 알고 싶을 떄
FROM emp
GROUP BY deptno;

--그룹함수에서는 NULL 컬럼은 계산에서 제외한다.
--emp 테이블에서 comm컬럼이 null이 아닌 데이터는 4건이 존재. 9건은 null
--0!=null
SELECT COUNT(comm)count_comm,--null이 아닌 값의 개수 = 4
        SUM (comm) sum_comm,
        SUM (sal) sum_sal,--null값 제외하고 300 +500+1400+0 = 2200
        SUM(sal + comm) tot_sal_sum , 
        --왜 7800밖에 안나와? 샐러리랑 커미션 더하면 더나와야하는데
        --연산순서때문에 그렇다고 함. 뭔순서?
        SUM(sal + NVL(comm,0)) tot_sal_sum2 --이렇게 null값이 나올때에 0으로 취급하라고 해줘야해,  
FROM emp;


--WHERE 절에 groub 함수를 표현할 수 없다.
--부서별 최대 급여 구하기
--이 중 최대 급여값이 3000이 넘는 행만 구하기.
SELECT deptno, MAX(sal)
FROM emp
WHERE MAX(sal) > 3000 --ORA - --934 WHERE 절에는 그룹함수가 올 수 없다.
GROUP BY deptno;

SELECT deptno, MAX(sal)
FROM emp
GROUP BY deptno
HAVING MAX(sal) >=3000; --그룹함수에서 조건을 넣을때는 HAVNG 절을 사용한다.


--실습 grp1
SELECT  MAX(sal) MAX_SAL, MIN(sal) MIN_SAL, ROUND (AVG(sal),2) AVG_SAL, 
        SUM(sal) sum_sal, COUNT(sal) count_sal, COUNT(mgr) count_mgr,
         COUNT(*) count_all
FROM emp;

--실습 grp2
SELECT deptno, 
        MAX(sal) MAX_SAL, MIN(sal) MIN_SAL, ROUND (AVG(sal),2) AVG_SAL, 
        SUM(sal) sum_sal, COUNT(sal) count_sal, COUNT(mgr) count_mgr,
         COUNT(*) count_all
FROM emp
GROUP BY deptno;

--실습 3

SELECT DECODE(deptno, 30, 'SALES', 20 , 'RESEARCH', 10, 'ACCOUNTING') dname,  
        MAX(sal) MAX_SAL, MIN(sal) MIN_SAL, ROUND (AVG(sal),2) AVG_SAL, 
        SUM(sal) sum_sal, COUNT(sal) count_sal, COUNT(mgr) count_mgr,
         COUNT(*) count_all
FROM emp
GROUP BY deptno; 

--실습 4

SELECT TO_CHAR(hiredate, 'YYYYMM') hire_yyyymm, COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYYMM');

--연월을 별도 컬럼으로 만들거나, 함수기반인덱스? 하이어데이트 컬럼에 투캐릭터 를 담는 함수로 인덱스를 만들 수 있음.............

SELECT hire_yyyymm, COUNT(*) cnt
FROM
    (SELECT TO_CHAR(hiredate, 'yyyymm') hire_yyyymm
    FROM emp) 
GROUP BY hire_yyyymm; --결국은 컬럼을 TO_CHAR 로 바꿔야한다
--인라인뷰 써도 괜찮다.

--원인을보는게 중요해. 에러코드. ORA-00904 : invalid identifier : 오탈자
-- 오탈자같은 경우에는 거의 100% 완벽하게 위치 잡아줌.


--실습 5
SELECT  TO_CHAR(hiredate, 'yyyy') hire_yyyy, COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'yyyy');
--GROUP BY 에 알리아스는 못주나보다. 가져다쓰기도 안됨.

--실습 6
SELECT COUNT(*) cnt
FROM
(SELECT COUNT(*) 
FROM dept
GROUP BY deptno) a;
---------------------------------
SELECT COUNT (*), COUNT(deptno)
FROM dept;

--실습 7
--직원이 속한 부서의 개수를 조회하는 쿼리를 작성하시오.
DESC emp;

SELECT COUNT(*), deptno
FROM emp
GROUP BY deptno;

SELECT deptno
FROM emp;

SELECT COUNT(*) cnt
FROM
(SELECT COUNT(*)
FROM emp
GROUP BY deptno);
-->
SELECT COUNT(COUNT(*))
FROM emp
GROUP BY deptno;

--DISTINCT : 잘못작성됐을 확률이 굉장히 높다. 구별된다. 중복을 제거함.
--

SELECT DISTINCT deptno, deptno
FROM emp;
--무슨차이지
--------------------------------------------------------------------------------------------------

SELECT COUNT(DISTINCT deptno)
FROM emp;

--JOIN
--RDBMS 는 중복을 최소화하는 형태의 베이스.
--내가 필요로하는 데이터를 다른 테이블이랑 결합을해서 가져온다

--JOIN

--1. 테이블의 구조변경(컬럼추가)
--2. 추가된 컬럼에 값을 update.
--dname 컬럼을 emp 테이블에 추가
DESC emp;
--컬럼추가
desc dept;
--형식과 용량?확인후 맞춰서 생성한다.
ALTER TABLE emp DROP (dname.......;

ALTER TABLE emp ADD (dname VARCHAR2(14));
SELECT *
FROM emp;

--dname에 값을 넣어보자
UPDATE emp SET dname = CASE
                            WHEN deptno = 10 THEN 'ACCOUNTING'
                            WHEN deptno = 20 THEN 'RESEARCH'
                            WHEN deptno = 30 THEN 'SALES'
                        END;
COMMIT;                        
--락을 가지고있다?? 트랜잭션?? 

SELECT empno, ename, deptno, dname
FROM emp;
--3..뭐......ㅇ몰르겠따>>>>...
--SALES --> MARKETSALES
--값의 중복이 있는 형태(반 정규형)
UPDATE emp SET dname = 'MARKET SALES'
WHERE dname = 'SALES';

SELECT empno, ename, deptno, dname
FROM emp;
rollback;

--emp테이블에는 부서코드만 존재. 부서 정보를 담은 dept테이블 별도로 생성.
--emp테이블과 dept 테이블의 연결고리(deptno)로 조인하여 실제부서명을 조회한다.

SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;
--컬럼이 모호하게 정의됐다고 오류발생. 셀렉 deptno -> emp.deptno 로 변경해서 명확하게 정의해준다.
--조인이 되었다.