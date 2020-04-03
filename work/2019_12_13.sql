--<< merge >>

--���̺� ���ǿ� �ش��ϴ� �����Ͱ� ���� ��� : insert
--���̺� �����Ͱ� ���� ��� update
--
--select �� insert or update ���� ���Ѱ� merge ��


SELECT *
FROM emp_test
ORDER BY empno;

--7���� ��������.
--emp���̺� �����ϴ� �����͸� emp_test ���̺�� ����.
--���� empno�� ������ �����Ͱ� �����ϸ�
--ename update : ename || '_merge'
--���� empno�� ������ �����Ͱ� �������� ���� ���
--emp���̺��� empno, ename emp_test �����ͷ� insert �� ���̴�.

----Ÿ�뽺 js

--emp_test �� �����Ϳ��� ������ �����͸� ����
DELETE emp_test
WHERE empno >= 7788;

--emp ���̺��� 14���� �����Ͱ� ����
--emp_test ���̺��� ����� 7788���� ���� 7���� �����Ͱ� ����
--emp���̺��� �̿��ϸ� emp_test ���̺��� �����ϰ� �Ǹ�
--emp���̺��� �����ϴ� ���� (����� 7788���� ũ�ų� ���� ����) 7����
--emp_test�� ���Ӱ� insert�� �� ���̰�
--emp, emp_test �� �����ȣ�� �����ϰ� �����ϴ� 7��(����� 7788���� ���� ����)�� �����ʹ�
--ename �÷��� ename || 'modify' �� ������Ʈ�� �Ѵ�.
--�������� �����:
/*
MERGE INTO ���̺��
USING ������� ���̺� Ȥ�� �� Ȥ�� ��������
ON (���̺��� ��������� �������)
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
--��� : 14���� ���� ���յǾ����ϴ�. ��� ��µȴ�.

-- emp_test ���̺� ����� 9999�� �����Ͱ� �����ϸ� ename �� 'brown'���� update
--�������� ���� ��� empno, ename VALUES (9999, 'brown') ���� insert.
-- ���� �ó������� merge ������ Ȳ���� �ѹ��� sql�� ����.
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

--���� �����ϴ�
--���� 2�������� 1������ ����

--���� merge ���� ���ٸ� 
--1. empno = 9999�� �����Ͱ� �����ϴ��� Ȯ��
--2-1 1�� ���׿��� �����Ͱ� �����ϸ� update
--2-2 1�� ���׿��� �����Ͱ� �������������� insert

--<< reprot �Լ� >>

--�׷캰 �հ�, ��ü�԰踦 ������ ���� ���Ϸ���? table : emp

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


-- �μ��� sal
SELECT deptno, SUM(sal) a
FROM emp
GROUP BY deptno;

-- �μ��� sal�� ��
SELECT null, SUM(a)
FROM
(SELECT SUM(sal) a
FROM emp
GROUP BY deptno);



--�ǽ� AD1UNION----------------------------------------
SELECT deptno, SUM(sal) sal
FROM emp
GROUP BY deptno

UNION

SELECT null, SUM(sal)
FROM emp;
----------------------------------------------

--JOIN ������� Ǯ��
--emp���̺��� 14���� �����͸� 28������ ����
--������(1 14��, 2 14��)�� �ϳ� �༭ �� �������� group by 
--������ 1 : �μ���ȣ ��������
--������ 2 : ��ü (������ 2������ = 14��)row��
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
--ROLLIP ���� ����� �÷��� �����ʿ������� ���� �����
--����׷��� ���� �������� GROUP BY ���� �ϳ��� Sql���� ����ǵ��� �Ѵ�.
GROUP BY ROLLUP(job, deptno)
--group by job, deptno
--group by job
--group by --> ��ü���� ������� group by


--emp���̺��� �̿��Ͽ� �μ���ȣ��, ��ü������ �޿����� ���ϴ� ������ rollip����� �̿��Ͽ� �ۼ�

--�ǽ� AD1
SELECT deptno, SUM(sal) sal
FROM emp
GROUP BY ROLLUP(deptno);

--��........

--emp���̺��� �̿��Ͽ� job, deptno �� sal + comm �հ�
--job�� sal + comm�հ� , ��ü������ sal _ comm�հ�

SELECT job, deptno, SUM(sal + NVL(comm,0)) sal_sum
FROM EMP
GROUP BY ROLLUP(job, deptno);
--������ !!
--ROLLUP �� �÷�������  SELECT ��ȸ ����� ������ ��ģ��.

--<< grouping >>

--�ǽ� AD2
SELECT DECODE(GROUPING (job),1,'�Ѱ�',job) job, deptno, SUM(sal) sal 
FROM emp
GROUP BY ROLLUP(job, deptno)
;

--�ǽ� AD 2-1
SELECT DECODE(GROUPING(job),1,'��',job) job,
       DECODE(GROUPING(deptno)+ GROUPING(job), 1, '�Ұ�',2,'��', deptno ) dept ,
       SUM(sal + NVL(comm,0)) sal_sum ,       
        --grouping(job)�� 1�϶��� �Ѱ��� �Ұ谡 null�̳��;���.
        --grouping(dept)+ gouping(job) = 2 �϶� null     
        CASE--�̰ŵ� dept �� �Ұ豸�ϴºκ�.
            WHEN deptno IS NULL AND job IS NULL THEN '��'
            WHEN deptno IS NULL AND job IS NOT NULL THEN '�Ұ�'
            ELSE '' || deptno--TO_CHAR(deptno)
        END deptno
        --,DECODE(GROUPING(deptno), 1, DECODE(GROUPING(job),1 '��', '�Ұ�'), deptno) �̰Ź���??��ư DECODE ��ø�ؼ���
        
FROM emp
GROUP BY ROLLUP(job, deptno)
;

--�ǽ� AD3
SELECT deptno,job, SUM(sal + NVL(comm,0)) sal
FROM emp
GROUP BY ROLLUP(deptno, job);

--�ǽ� 3�� UNION����
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

--�ϴ� �ϱ⸦ �սô�.
--rollup �� �׷������ �Լ��ΰų�??

--�ǽ� AD4
SELECT dname,job, SUM(sal + NVL(comm,0)) sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP(dname, job);
--�ٸ����
SELECT dept.dname, a.job, a.sal 
FROM
    (SELECT deptno, job, SUM(sal + NVL(comm,0)) sal
    FROM emp
    GROUP BY ROLLUP(deptno, job)) a
WHERE a.deptno = dept.deptno(+);
--���� �߸��Ƴ�...




--�ǽ� AD5
SELECT DECODE(GROUPING(dname),1,'����',dname) dname,job, SUM(sal + NVL(comm,0)) sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP(dname, job);

