--<<�������� SUB QUERY>>
--SMITH �� ���� �μ�ã��
SELECT deptno
FROM emp
WHERE ename = 'SMITH';

SELECT *
FROM emp
WHERE deptno = 20;
-------------���̽��� ���� �μ��� �ٸ� �����---------------------
SELECT *
FROM emp
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE ename = 'SMITH');
--���������ִ� ����Ʈ���� ����������. �������� �Ǵٸ� ����.
--�ϳ��� ���յ� ������ ���� �� ����.
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                FROM emp
                WHERE ename = 'SMITH');
--���������� �з�(�����ġ)
--SELECT ���� ��� : ��Į�� ��������(scalar subquery) : �ϳ��� ��, �ϳ��� �÷��� �����ϴ� ��������.
--FROM ���� ��� : �ζ��� ��
--WHERE ���� ��� : ��������

--��Į�󼭺�����
--����Ʈ ���� ǥ���� ��������. ����, �� �÷��� ��ȸ�ؾ� �Ѵ�.�Ʒ��� �ǰ�, �Ʒ��Ʒ��� �ȵ�.
--��Į�󼭺������ �� ���� ��ȸ�ϴ°��� �ƴϱ⶧��.���� ������������ ���������� ����.(��ȣ���� ��������) : �������������� ����Ұ�.
--���������� ���� �����.
--�Ʒ��� ������������ ���������� �������� ����.(���ȣ ���� ��������) ������ �������� ��.
SELECT empno, ename, deptno, (SELECT dname FROM dept WHERE dept.deptno = emp.deptno) dname
from emp;
-- 
SELECT empno, ename, deptno, (SELECT dname FROM dept) dname
from emp;

--INLINE VIEW
--FROM ���� ���Ǵ� ��������.

--SUBQUERY
--WHERE���� ���Ǵ� ��������.


--�������� �ǽ� 1
--��ձ޿����� ���� �޿��� �޴� ������ �� ��ȸ.
SELECT *
FROM emp;

SELECT COUNT(*) cnt
FROM emp
WHERE sal > (SELECT AVG(sal)
            FROM emp);
SELECT AVG(sal)
            FROM emp;
            

--�������� �ǽ� 2
--��� �޿����� ���� �޿��� �޴� ������ ������ ��ȸ.
SELECT empno, ename, sal
FROM emp
WHERE sal > (SELECT AVG(sal)
            FROM emp);
            
            
--������ �����ϴ� ���������� ������. (��Ƽ�ο� ������)
--IN : �������� ��� �� ���� ���� ���� ��.
--ANY : �������� ����� �����ϴ� ���� �ϳ��� ���� ��. sal < any(subquery)
--ALL : �������� ����� ��� ������ų��. sal>all(subquery)

--�ǽ�3
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                 FROM emp
                 WHERE ename IN ('WARD','SMITH'));
                 
--1. ���̽�, ���尡 ���� �μ� ��ȸ
--2. 1���� ���� ������� �̿��Ͽ� �ش� �μ� ��ȣ�� ���ϴ� ������ȸ.
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
--������������ NULL : NOT IN
--�������� ���.
SELECT *
FROM emp
WHERE empno IN (SELECT mgr
                    FROM emp);
--�����ڰ� �ƴѻ��
--NOT IN ������ ���� null �� �����Ϳ� �������� �ʾƾ� ������ �Ѵ�.
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
--�������� pairwise (Multi column subquery) = �����÷��� ���� ���ÿ� �����ؾ��ϴ� ���.
--allen, clark �� �Ŵ����� �μ���ȣ�� ���ÿ� ���� ������� ��ȸ.
--(�Ŵ�����ȣ�� 7698 �̸鼭 �μ���ȣ�� 30), (7839 �̸鼭 10)
SELECT *
FROM emp
WHERE (mgr, deptno) IN(
                        SELECT mgr, deptno
                        FROM emp
                        WHERE empno IN (7499, 7782));
-- ������� �ƴϸ�?
--�Ŵ����� 7698 �̰ų�, 7839�̸鼭 �ҼӺμ��� 10�� �̰ų� 30���� ���� ���� ��ȸ.
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
        
--���ȣ ���� ��������:
--������������ ����ϴ� ���̺�, �������� ��ȸ ������ ���������� ������ ������ �Ǵ��Ͽ� ������ �����Ѵ�.
--���� ������ emp ���̺��� ���� ���� ���� �ְ�, ���������� emp ���̺��� ���� ���� ���� �ִ�.
--������ �޿� ��պ��� ���� �޿��� �޴� ���� ���� ��ȸ.
--oltp ���α׷�????
--�����ȹ�� ������������. �� ���������� ����Ŭ�� ����� �� �����Ѵ�. �ܵ������� ���������� ������ �� �ֱ� ������.

--���ȣ ���� ������������ ���������� ���̺��� ���� ���� ���� ���������� �����ڿ����� �ߴ� ��� �� �������� ǥ����.
--���ȣ ���� ������������ ���������� ���̺��� ���߿� ���� ���� ���������� Ȯ���� ������ �ߴ� ��� �� �������� ǥ��.
--�������� �ڵ带..¥���..��..��.���ꤧ��....����..


--������ �޿� ���
SELECT AVG(sal)
FROM emp;
--
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
                FROM emp);
                
--��ȣ ���� ��������
--�ش� ������ ���� �μ��� �޿� ��պ��� ���� �޿��� �޴� ���� ��ȸ

SELECT *
FROM emp m
WHERE sal > (SELECT AVG(sal)
            FROM emp
            WHERE deptno = m.deptno);


--10���μ��� �޿� ���
SELECT AVG(sal)
FROM emp
WHERE deptno = 10;

��������. ��������........