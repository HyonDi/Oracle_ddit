--<< report group function (grouping sets(col1, col2))  >>
--������ ����� ����. �����ڰ� GROUP BY �� ������ ���� ����Ѵ�.
--ROLL UP���� �޸� ���⼺�� ���� �ʴ´�.
--GROUPING SETS(COL1, COL2) = GROUPING SETS(COL2, COL1)
 
--GOUPR BU COL1
--UNION ALL
--GOUP BY COL2

--emp ���̺��� ������ job �� �޿�(sal) + ��(comm)��,
--deptno(�μ�)�� �޿�(sal)+ ��(comm) �� ���ϱ�.

--������� (group function) : 2���� SQL �ۼ� �ʿ�. (UNION/ UNION ALL)

SELECT job, null deptno, sum(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY job

UNION ALL

SELECT '',deptno, sum(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY deptno;

--GROUPING SETS ������ �̿��Ͽ� ���� SQL �� ���տ����� ������� �ʰ� ���̺��� �� �� �о ó���ض�.
SELECT job, deptno, sum(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY GROUPING SETS (job, deptno); 

--job, deptno�� �׷����� ��  sal+comm ��, mgr�� �׷������� sal+comm ��.
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
--�߾Ⱦ�...
--cube(col1, col2 ...)
--������ �÷��� ��� ������ �������� group by subset�� �����.
--cube�� ������ �÷��� 2���� ��� : ������ ���� 4��
--cube�� ������ �÷��� 3���� ��� : ������ ���� 8��
--cube�� ������ �÷����� 2�� ������ �� ����� ������ ���� ������ �ȴ�.(2^n)
--�÷��� ���ݸ� �������� ������ ������ ���ϱ޼������� �þ�� ������
--���� ������� �ʴ´�.

--job, deptno�� �̿��Ͽ� CUBE ����
SELECT job, deptno, sum(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY CUBE(job, deptno);
-- job, deptno
-- 1    1   -> GROUP BY job, deptno
-- 1    0   -> GROUP By job
-- 0    1   -> GROUP BY deptno
-- 0    0   -> GROUP BY --emp ���̺��� ��� �࿡ ���� GROUP BY.
--
--GROUP BY ����
--GROUP BY, ROLLUP, CUBE�� ���� ����ϱ�
-- ������ ������ �����غ��� ���� ����� ������ �� �ִ�.
-- GROUP BY JOB, rollup(deptno), cube(mgr)

SELECT job, deptno, mgr, SUM(sal + NVL(comm, 0)) SAL_comm
FROM emp
GROUP BY job, rollup(deptno), cube(mgr);
--job �� ����Ʈ�� �����س��⶧���� ��ü�Ѱ�� �ȳ���.



--
SELECT job, SUM(sal)
FROM emp
GROUP BY job, rollup(job);

--
SELECT job, deptno, mgr, SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY job, rollup(deptno), cube(mgr);
--�׼��� ĥ�غ���..

--ť��� ������ �������, �Ѿ��� �����ʺ���, �׷���� �����Է�.

--ADVANCED SUB QUERY

--�ǽ� SUB_A1
SELECT deptno, COUNT(deptno)
FROM dept_test
GROUP BY  deptno;

DROP TABLE dept_test;

--dept �� dept_test ����.
CREATE TABLE dept_test AS
    SELECT *
    FROM dept;
    
--empcnt �÷� �߰�
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

--�ǽ� sub_a2
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
                    
                    
--�ǽ� sub a3
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

--�μ��� �޿� ���
SELECT deptno, ROUND(AVG(sal),1) a
FROM emp
GROUP BY deptno;

SELECT empno, ename, deptno, sal
FROM emp;

SELECT ROUND(AVG(sal), 2)
FROM emp
WHERE deptno = 30;



--�޿���պ��� sal ���� ���
UPDATE emp_test SET sal = sal +200
WHERE sal < (SELECT ROUND(AVG(sal), 2)
                FROM emp
                WHERE deptno = emp_test.deptno);

SELECT empno, ename, deptno, sal
FROM emp_test;

--���� merge ������ �̿��� ������Ʈ�غ��ô�.

rollback;
--�μ��� �޿����
SELECT deptno, AVG(sal)
FROM emp_test
GROUP BY deptno;

--suing ���� �䵵 �� �� ����.
--on���� ���� �÷����� ������Ʈ�� �� ����.,,
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


