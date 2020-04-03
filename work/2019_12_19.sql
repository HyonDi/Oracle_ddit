--�м��Լ�, window �Լ�.
--����̸�, �����ȣ, ��ü�����Ǽ�
SELECT ename, empno, COUNT(*)
from emp
group by ename, empno;
--���ϴµ��� �ȳ����µ�, �м��Լ��� ���� ��Ÿ.
--������ ������ ������ ���� ���ϰ� �ɸ���. ������ �Ⱦ��°� ����.
--sql�� ������� ���. �ణ������ �������ش�.

--����� �μ���, �޿��� �������ϱ�.
--�̰� ��ü����
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

--������ ��
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

--���� �м��Լ��� �� ���ô�.
SELECT ename, sal, deptno, RANK() OVER(PARTITION BY deptno ORDER BY sal desc) rn 
FROM emp;


--
SELECT ename, sal, deptno, 
        RANK() OVER(PARTITION BY deptno ORDER BY sal) rank, 
        DENSE_RANK() OVER(PARTITION BY deptno ORDER BY sal) dense_rank,
        ROW_NUMBER() OVER(PARTITION BY deptno ORDER BY sal) row_number
FROM emp;


--�ǽ� ana1
--��� ��ü �޿� ������ rank, dens_rank, row_number �� �̿��Ͽ� ���ϼ���.
--�� �޿��� ������ ��� ����� ���� ����� ���� ������ �ǵ����ۼ��ϼ���,

SELECT empno, ename, sal, deptno, 
        RANK() OVER(ORDER BY sal desc,empno) rank, 
        DENSE_RANK() OVER(ORDER BY sal desc,empno) dense_rank,
        ROW_NUMBER() OVER(ORDER BY sal desc,empno) row_number
FROM emp;

--window �Լ�
--������ ��� ������ Ȱ���Ͽ�, ��� ����� ���� �����ȣ, ����̸�, 
--�ش� ����� ���� �μ��� ��� ���� ��ȸ�ϴ� ������ �ۼ��ϼ���.

SELECT b.empno, b.ename,a.*
FROM
    (SELECT deptno, COUNT(deptno) cnt
    FROM emp
    GROUP BY deptno) a,
    (SELECT empno, ename, deptno
    FROM emp) b
WHERE a.deptno = b.deptno
ORDER BY a.deptno;
--emp ���̺��� ��� ���� �ʾƵ� �ȴ�
--
--���� �м��Լ���.
--�����ȣ, ����̸�, �μ���ȣ, �μ��� ������
SELECT empno, ename, deptno,
    COUNT(*) OVER (PARTITION BY deptno) cnt
FROM emp;

--�ǽ� ana2
SELECT empno, ename, sal, deptno,
    ROUND((AVG(sal) OVER (PARTITION BY deptno)),2) avg
FROM emp;

--�ǽ� 3
SELECT empno, ename, sal, deptno, 
        MAX(sal) OVER (PARTITION BY deptno) max_sal
FROM emp;

--�ǽ� 4
SELECT empno, ename, sal, deptno, 
        MIN(sal) OVER (PARTITION BY deptno) min_sal
FROM emp;


--LAG, LEAD (����(����), ����(�Ʒ���))
--��ü����� ������� �޿������� �ڽź��� �Ѵܰ� ���� ����� �޿�. �޿��� ���� ��� �Ի����ڰ� ��������� ���� ����.
SELECT empno, ename, hiredate, sal,
        LEAD(sal) OVER (ORDER BY sal DESC, hiredate) lead_sal
FROM emp;

--�ǽ� ana5
SELECT empno, ename, hiredate, sal,
        LAG(sal) OVER (ORDER BY sal DESC, hiredate) lead_sal
FROM emp;

--�ǽ� 6
SELECT empno, ename, hiredate, job, sal,
    LAG(sal) OVER (PARTITION BY job ORDER BY sal desc, hiredate) lag_sal
FROM emp;

--no_ana �ǽ�
-- window �Լ� ����.


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

--���⼭ �׷������ �ְ� SUM �� ���϶��Ͻ�.
--


--�����ſ��� �߰���Ŵ!!!!��!
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
