--분석함수, window 함수.
--사원이름, 사원번호, 전체직원건수
SELECT ename, empno, COUNT(*)
from emp
group by ename, empno;
--원하는데로 안나오는데, 분석함수를 쓰면 조타.
--하지만 내부적 연산이 많아 부하가 걸린다. 가급적 안쓰는게 좋아.
--sql이 길어지면 써라. 행간연산을 지원해준다.

--사원의 부서별, 급여별 순위구하기.
--이건 전체순위
SELECT a.*, ROWNUM sal_ranck
FROM
(SELECT ename, sal, deptno
FROM emp
ORDER BY sal desc) a;
--

SELECT a.*, ROWNUM sal_rank
FROM
(SELECT ename, sal, deptno
FROM emp
GROUP BY ename, sal,deptno
ORDER BY deptno,sal desc)a;
--
SELECT b.*, ROWNUM sal_rank
FROM
(SELECT ename, sal, deptno
FROM emp
GROUP BY ename, sal,deptno
HAVING deptno = 10
ORDER BY deptno,sal desc) b

UNION ALL

SELECT c.*, ROWNUM sal_rank
FROM
(SELECT ename, sal, deptno
FROM emp
GROUP BY ename, sal,deptno
HAVING deptno = 20
ORDER BY deptno,sal desc) c

UNION ALL

SELECT a.*, ROWNUM sal_rank
FROM
(SELECT ename, sal, deptno
FROM emp
GROUP BY ename, sal,deptno
HAVING deptno = 30
ORDER BY deptno,sal desc) a;

--선생님 답
SELECT ename, sal, deptno
FROM emp
ORDER BY deptno,sal desc;

--
SELECT ename, sal, deptno
FROM emp
ORDER BY deptno,sal desc;

--
SELECT b.*, a.rn
FROM
(SELECT ROWNUM rn
FROM dual
CONNECT BY level <=(SELECT COUNT(*) FROM emp)) a,

(SELECT deptno, COUNT(*) cnt
FROM emp
GROUP BY deptno) b
WHERE b.cnt >= a.rn
ORDER BY b.deptno, a.rn;
--
SELECT a.ename, a.sal, a.deptno, b.rn
FROM
(SELECT ename, sal, deptno, ROWNUM j_rn
FROM
(SELECT ename, sal, deptno
FROM emp
ORDER BY deptno,sal desc)) a,

(SELECT rn, ROWNUM j_rn
FROM
(SELECT b.*, a.rn
FROM
(SELECT ROWNUM rn
FROM dual
CONNECT BY level <=(SELECT COUNT(*) FROM emp)) a,

(SELECT deptno, COUNT(*) cnt
FROM emp
GROUP BY deptno) b
WHERE b.cnt >= a.rn
ORDER BY b.deptno, a.rn))b
WHERE a.j_rn = b.j_rn;

--위를 분석함수로 해 봅시다.
SELECT ename, sal, deptno, RANK() OVER(PARTITION BY deptno ORDER BY sal desc) rn 
FROM emp;


--
SELECT ename, sal, deptno, 
        RANK() OVER(PARTITION BY deptno ORDER BY sal) rank, 
        DENSE_RANK() OVER(PARTITION BY deptno ORDER BY sal) dense_rank,
        ROW_NUMBER() OVER(PARTITION BY deptno ORDER BY sal) row_number
FROM emp;


--실습 ana1
--사원 전체 급여 순위를 rank, dens_rank, row_number 를 이용하여 구하세요.
--단 급여가 동일할 경우 사번이 빠른 사람이 높은 순위가 되도록작성하세요,

SELECT empno, ename, sal, deptno, 
        RANK() OVER(ORDER BY sal desc,empno) rank, 
        DENSE_RANK() OVER(ORDER BY sal desc,empno) dense_rank,
        ROW_NUMBER() OVER(ORDER BY sal desc,empno) row_number
FROM emp;

--window 함수
--기존의 배운 내용을 활용하여, 모든 사원에 대해 사원번호, 사원이름, 
--해당 사원이 속한 부서의 사원 수를 조회하는 쿼리를 작성하세요.

SELECT b.empno, b.ename,a.*
FROM
    (SELECT deptno, COUNT(deptno) cnt
    FROM emp
    GROUP BY deptno) a,
    (SELECT empno, ename, deptno
    FROM emp) b
WHERE a.deptno = b.deptno
ORDER BY a.deptno;
--emp 테이블은 뷰로 묶지 않아도 된다
--
--위를 분석함수로.
--사원번호, 사원이름, 부서번호, 부서의 직원수
SELECT empno, ename, deptno,
    COUNT(*) OVER (PARTITION BY deptno) cnt
FROM emp;

--실습 ana2
SELECT empno, ename, sal, deptno,
    ROUND((AVG(sal) OVER (PARTITION BY deptno)),2) avg
FROM emp;

--실습 3
SELECT empno, ename, sal, deptno, 
        MAX(sal) OVER (PARTITION BY deptno) max_sal
FROM emp;

--실습 4
SELECT empno, ename, sal, deptno, 
        MIN(sal) OVER (PARTITION BY deptno) min_sal
FROM emp;


--LAG, LEAD (이전(위쪽), 이후(아래쪽))
--전체사원을 대상으로 급여순위가 자신보다 한단계 낮은 사람의 급여. 급여가 같을 경우 입사일자가 빠른사람이 높은 순위.
SELECT empno, ename, hiredate, sal,
        LEAD(sal) OVER (ORDER BY sal DESC, hiredate) lead_sal
FROM emp;

--실습 ana5
SELECT empno, ename, hiredate, sal,
        LAG(sal) OVER (ORDER BY sal DESC, hiredate) lead_sal
FROM emp;

--실습 6
SELECT empno, ename, hiredate, job, sal,
    LAG(sal) OVER (PARTITION BY job ORDER BY sal desc, hiredate) lag_sal
FROM emp;

--no_ana 실습
-- window 함수 없이.


SELECT b.*, SUM(rn BETWEEN 1 AND rn)
FROM
(SELECT a.* ,ROWNUM rn
FROM
(SELECT empno, ename, sal
FROM emp
ORDER BY sal,empno) a)b
;

--
SELECT a.* ,ROWNUM rn, SUM(sal)
FROM
(SELECT empno, ename, sal
FROM emp
ORDER BY sal,empno) a
GROUP BY empno, ename, sal;
--

SELECT a.empno, a.ename, a.sal, b.sal
FROM
    (SELECT a.*, ROWNUM rn
    FROM
    (SELECT empno, ename, sal
    FROM emp
    ORDER BY sal,empno)a)a,
    
    (SELECT a.*, ROWNUM rn
    FROM
    (SELECT empno, ename, sal
    FROM emp
    ORDER BY sal,empno)a) b
WHERE a.rn >= b.rn;

--여기서 그룹바이절 넣고 SUM 을 뭘하라하심.
--


--위에거에서 추가시킴!!!!답!
SELECT a.empno, a.ename, a.sal, SUM(b.sal) 
FROM
    (SELECT a.*, ROWNUM rn
    FROM
    (SELECT empno, ename, sal
    FROM emp
    ORDER BY sal,empno)a)a,
    
    (SELECT a.*, ROWNUM rn
    FROM
    (SELECT empno, ename, sal
    FROM emp
    ORDER BY sal,empno)a) b
WHERE a.rn >= b.rn
GROUP BY a.empno,a.ename,a.sal
ORDER BY sal;
