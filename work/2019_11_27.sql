--group function
--�׷��δ����� ���� �ϳĿ����� ����� �ٸ�.
--WHERE ���� �� �� ����.
--Ư�� �÷��̳�, ǥ������ �������� ���� ������ ����� ����.
-- function : avg, count(�Ǽ�), max, min, sum ���� �׷��� ����.
/*
SELECT [column, ], grou[ function(column)
FROM table
[GROUP BY column,]
[HAVING group function condition]
[ORDER BY column,]
*/

--��ü������ ������� ���� ���� �޿�.(14���� �����Ͱ� 1������ ���� ��.)
SELECT  MAX(sal) max_sal,
        MIN(sal) min_sal,
        ROUND(AVG(sal),2) avg_sal,
        SUM(sal) sum_sal,
        COUNT(sal) count_sal, --NULL�� �ƴ� ���̸� 1��.
        COUNT(mgr) count_mgr,--KING �� mgr �� null �̶� ������ ���� �ϳ� �پ���.
        COUNT(*) count_row--Ư�� �÷��� �Ǽ��� �ƴ϶� ���Ǥ� ������ �˰� ���� ��
FROM emp;
-------------------------------------------

DESC emp;
--groub by ���� �ۼ��� �÷� �̿��� �÷��� select ���� �� �� ����.
--groub by ���� �ۼ��� �÷��� select ���� �� �� ����.

--�μ���ȣ�� �׷��Լ� ����
SELECT  deptno,
        MAX(sal) max_sal,
        MIN(sal) min_sal,
        ROUND(AVG(sal),2) avg_sal,
        SUM(sal) sum_sal,
        COUNT(sal) count_sal, --NULL�� �ƴ� ���̸� 1��.
        COUNT(mgr) count_mgr,
        COUNT(*) count_row--Ư�� �÷��� �Ǽ��� �ƴ϶� ���Ǥ� ������ �˰� ���� ��
FROM emp
GROUP BY deptno;


--�μ���ȣ, ����̸�����
SELECT  deptno, ename,
        MAX(sal) max_sal,
        MIN(sal) min_sal,
        ROUND(AVG(sal),2) avg_sal,
        SUM(sal) sum_sal,
        COUNT(sal) count_sal, --NULL�� �ƴ� ���̸� 1��.
        COUNT(mgr) count_mgr,
        COUNT(*) count_row--Ư�� �÷��� �Ǽ��� �ƴ϶� ���Ǥ� ������ �˰� ���� ��
FROM emp
GROUP BY deptno, ename;
--groub by ���� ���� �÷��� ���� ��� ����. (�������� ���� �ʴ´�.)
--�������� ���� ������ �� ���� �����͸� �׷����� ������µ� 
--�� ���������� ��������� SELECT ���� ǥ���� ����.
SELECT  deptno, 1, '��', SYSDATE,
        MAX(sal) max_sal,
        MIN(sal) min_sal,
        ROUND(AVG(sal),2) avg_sal,
        SUM(sal) sum_sal,
        COUNT(sal) count_sal, --NULL�� �ƴ� ���̸� 1��.
        COUNT(mgr) count_mgr,
        COUNT(*) count_row--Ư�� �÷��� �Ǽ��� �ƴ϶� ���Ǥ� ������ �˰� ���� ��
FROM emp
GROUP BY deptno;

--�׷��Լ������� NULL �÷��� ��꿡�� �����Ѵ�.
--emp ���̺��� comm�÷��� null�� �ƴ� �����ʹ� 4���� ����. 9���� null
--0!=null
SELECT COUNT(comm)count_comm,--null�� �ƴ� ���� ���� = 4
        SUM (comm) sum_comm,
        SUM (sal) sum_sal,--null�� �����ϰ� 300 +500+1400+0 = 2200
        SUM(sal + comm) tot_sal_sum , 
        --�� 7800�ۿ� �ȳ���? �������� Ŀ�̼� ���ϸ� �����;��ϴµ�
        --������������� �׷��ٰ� ��. ������?
        SUM(sal + NVL(comm,0)) tot_sal_sum2 --�̷��� null���� ���ö��� 0���� ����϶�� �������,  
FROM emp;


--WHERE ���� groub �Լ��� ǥ���� �� ����.
--�μ��� �ִ� �޿� ���ϱ�
--�� �� �ִ� �޿����� 3000�� �Ѵ� �ุ ���ϱ�.
SELECT deptno, MAX(sal)
FROM emp
WHERE MAX(sal) > 3000 --ORA - --934 WHERE ������ �׷��Լ��� �� �� ����.
GROUP BY deptno;

SELECT deptno, MAX(sal)
FROM emp
GROUP BY deptno
HAVING MAX(sal) >=3000; --�׷��Լ����� ������ �������� HAVNG ���� ����Ѵ�.


--�ǽ� grp1
SELECT  MAX(sal) MAX_SAL, MIN(sal) MIN_SAL, ROUND (AVG(sal),2) AVG_SAL, 
        SUM(sal) sum_sal, COUNT(sal) count_sal, COUNT(mgr) count_mgr,
         COUNT(*) count_all
FROM emp;

--�ǽ� grp2
SELECT deptno, 
        MAX(sal) MAX_SAL, MIN(sal) MIN_SAL, ROUND (AVG(sal),2) AVG_SAL, 
        SUM(sal) sum_sal, COUNT(sal) count_sal, COUNT(mgr) count_mgr,
         COUNT(*) count_all
FROM emp
GROUP BY deptno;

--�ǽ� 3

SELECT DECODE(deptno, 30, 'SALES', 20 , 'RESEARCH', 10, 'ACCOUNTING') dname,  
        MAX(sal) MAX_SAL, MIN(sal) MIN_SAL, ROUND (AVG(sal),2) AVG_SAL, 
        SUM(sal) sum_sal, COUNT(sal) count_sal, COUNT(mgr) count_mgr,
         COUNT(*) count_all
FROM emp
GROUP BY deptno; 

--�ǽ� 4

SELECT TO_CHAR(hiredate, 'YYYYMM') hire_yyyymm, COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYYMM');

--������ ���� �÷����� ����ų�, �Լ�����ε���? ���̾��Ʈ �÷��� ��ĳ���� �� ��� �Լ��� �ε����� ���� �� ����.............

SELECT hire_yyyymm, COUNT(*) cnt
FROM
    (SELECT TO_CHAR(hiredate, 'yyyymm') hire_yyyymm
    FROM emp) 
GROUP BY hire_yyyymm; --�ᱹ�� �÷��� TO_CHAR �� �ٲ���Ѵ�
--�ζ��κ� �ᵵ ������.

--���������°� �߿���. �����ڵ�. ORA-00904 : invalid identifier : ��Ż��
-- ��Ż�ڰ��� ��쿡�� ���� 100% �Ϻ��ϰ� ��ġ �����.


--�ǽ� 5
SELECT  TO_CHAR(hiredate, 'yyyy') hire_yyyy, COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'yyyy');
--GROUP BY �� �˸��ƽ��� ���ֳ�����. �����پ��⵵ �ȵ�.

--�ǽ� 6
SELECT COUNT(*) cnt
FROM
(SELECT COUNT(*) 
FROM dept
GROUP BY deptno) a;
---------------------------------
SELECT COUNT (*), COUNT(deptno)
FROM dept;

--�ǽ� 7
--������ ���� �μ��� ������ ��ȸ�ϴ� ������ �ۼ��Ͻÿ�.
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

--DISTINCT : �߸��ۼ����� Ȯ���� ������ ����. �����ȴ�. �ߺ��� ������.
--

SELECT DISTINCT deptno, deptno
FROM emp;
--����������
--------------------------------------------------------------------------------------------------

SELECT COUNT(DISTINCT deptno)
FROM emp;

--JOIN
--RDBMS �� �ߺ��� �ּ�ȭ�ϴ� ������ ���̽�.
--���� �ʿ���ϴ� �����͸� �ٸ� ���̺��̶� �������ؼ� �����´�

--JOIN

--1. ���̺��� ��������(�÷��߰�)
--2. �߰��� �÷��� ���� update.
--dname �÷��� emp ���̺� �߰�
DESC emp;
--�÷��߰�
desc dept;
--���İ� �뷮?Ȯ���� ���缭 �����Ѵ�.
ALTER TABLE emp DROP (dname.......;

ALTER TABLE emp ADD (dname VARCHAR2(14));
SELECT *
FROM emp;

--dname�� ���� �־��
UPDATE emp SET dname = CASE
                            WHEN deptno = 10 THEN 'ACCOUNTING'
                            WHEN deptno = 20 THEN 'RESEARCH'
                            WHEN deptno = 30 THEN 'SALES'
                        END;
COMMIT;                        
--���� �������ִ�?? Ʈ�����?? 

SELECT empno, ename, deptno, dname
FROM emp;
--3..��......�������ڵ�>>>>...
--SALES --> MARKETSALES
--���� �ߺ��� �ִ� ����(�� ������)
UPDATE emp SET dname = 'MARKET SALES'
WHERE dname = 'SALES';

SELECT empno, ename, deptno, dname
FROM emp;
rollback;

--emp���̺��� �μ��ڵ常 ����. �μ� ������ ���� dept���̺� ������ ����.
--emp���̺�� dept ���̺��� �����(deptno)�� �����Ͽ� �����μ����� ��ȸ�Ѵ�.

SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;
--�÷��� ��ȣ�ϰ� ���ǵƴٰ� �����߻�. ���� deptno -> emp.deptno �� �����ؼ� ��Ȯ�ϰ� �������ش�.
--������ �Ǿ���.