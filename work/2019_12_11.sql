--index�� ��ȸ�Ͽ� ������� �䱸���׿� �����ϴ� �����͸� ���� �� �ִ� ���

SELECT *
FROM emp;

SELECT rowid
FROM emp;

SELECT empno, rowid
FROM emp;

--emp���̺��� ��� �÷��� ��ȸ.
SELECT *
FROM emp
WHERE empno = 7782;

--�� �����ȹ������.
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE((dbms_xplan.display));


--emp���̺��� empno�÷��� ��ȸ
SELECT *
FROM emp
WHERE empno=7782;

SELECT empno
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE((dbms_xplan.display));
--> �ε����� �ϰ� ���� ���� �ִ�!!! ����Ŭ�� �Q���ϤӴϱ�!~!!~!

--���� �ε��� ���� -> pk_emp �������� ���� -> ���� ���� -> pk_emp �ε��� ����
ALTER TABLE emp DROP CONSTRAINT pk_emp;
--�ε����� ���� (�÷� �ߺ����ο� ����)
--UNIQUE INDEX  : �ε��� �÷��� ���� �ߺ��� �� ���� �ε���. (emp.empno, dept.deptno)
-- NON-UNIQUE INDEX : �ε��� �÷��� ���� �ߺ��� �� �ִ� �ε���  (EMP.JOB) = �갡 ����Ʈ!!

CREATE INDEX index_n_emp_01 ON emp (empno);
CREATE UNIQUE INDEX index_n_emp_01 ON emp (empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno=7782;

SELECT *
FROM TABLE((dbms_xplan.display));

--> ���� ��Ȱ�̶��޸������� empno�÷����� ������ �ε����� UNIQUE -> NONUNIQUE �ε����� �����.

EXPLAIN PLAN FOR
SELECT *
FROM EMP;

--7782 
INSERT INTO emp(empno, ename) VALUES (7782, 'brown');
COMMIT;

--emp ���̺� job�÷����� non-unique �ε��� ����
-- �ε�����  : idx_n_emp_02

CREATE INDEX idx_n_emp_02 ON emp (job);
EXPLAIN PLAN FOR
SELECT job, rowid
FROM emp
ORDER BY JOB;
SELECT *
FROM TABLE((dbms_xplan.display));


--emp ���̺� �ε����� 2���� �Ǿ���.
--1. empno �� ����.
--2. job ���� ����.
--

SELECT *
FROM emp
WHERE empno= 7369;

--�߸����ε���������ϸ� �ӵ��� �� ��������~!
--����!
--�ε������ִ��������ؼ�����°� �ɷ��̷�.
--�ϳ����ε����� ����sql���� Ȱ���Ҽ��ֵ���.

--����, �ű��Է½� ���̺�� �ε��� ��� ���ľ��ϴϱ� �Ҹ��ϴ�.dml�Ҷ��� �ε����� ������ ������.
--��� �� �ϰ�ã��? job�÷��о���ϴ°žƳ�?

--idx_02 �ε���
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';
--job�ε����� ��ü�а�, c�ν��������ʴ°� �а� �Ÿ�.

--�����͸� �����ϰ� �ϴ°� access predicate, �Ÿ��� �����°� filter predicate.
--filter predicate �� �а� �����°������ϱ� ��ü������ ����������. 
--������ ��� ������ ȿ�������� �ϱ�����..

--�÷����� ��� �ε����� ��������ִ뤿.
--idx_n_emp_03
--emp ���̺���job, ename �÷����� non-unique �ε��� ����.
CREATE INDEX idx_n_emp_03 ON emp (job, ename);
--job�ε����� ename �ε����� ���� ������ �߿���.
--�̷����ؼ� ���� ���� �������޴�. ������ ����.
--C�� �����ϴ°͵� �о���� �ƴ°žƳ�?(ename �� ����)

--idx_n_emp_04
--enam, job �÷����� emp ���̺� non_uique �ε��� ����.
CREATE INDEX idx_n_emp_04 ON emp (ename, job);
--=
SELECT ename, job, rowid
FROM emp
ORDER BY ename, job;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
OR ename LIKE 'J%';
SELECT *
FROM TABLE((dbms_xplan.display));

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'J%';
SELECT *
FROM TABLE((dbms_xplan.display));

--�����ܰ��ġ�°ͺ��� �׳� �� �д°� ����������

--JOIN ���������� �ε���
--emp. empno �÷����� primary key ���������� ����.
--dept ���̺��� deptno�÷����� primary key ���������� ����.
--EMP���̺��� PRIMARY KEY ������ ������ �����̹Ƿ� �����.
--
DELETE emp
WHERE ename = 'brown';

SELECT *
FROM emp
WHERE ename = 'brown';

ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY(empno);

EXPLAIN PLAN FOR
SELECT ename, dname, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.empno = 7788;

SELECT *
FROM TABLE(dbms_xplan.display);


--�ε����б�� ���̺� Ǯ�������� ������ �����԰�?������ �ε��������� �� �Ⱥ��� ������ �ۼ��Ѵ�.
--Ư���κи� �����ٴ� ������ ������ �׺κп����ؼ��� ã�ƺ����Ѵ�.
--�ε���������κ���dba�� ���Ǹ� �ؾ���.

--�ǽ�idx1
DROP TABLE DEPT_TEST;

CREATE TABLE DEPT_TEST AS 
SELECT *
FROM DEPT 
WHERE 1=1;
--deptno �÷��� �������� unique �ε��� ����
CREATE UNIQUE INDEX idx_u_dept_test_01 ON DEPT_TEST (deptno);
--dname �÷��� �������� non-unique �ε��� ����
CREATE  INDEX idx_n_dept_test_02 ON DEPT_TEST (dename);
--deptno,dname �÷��� �������� non-unique �ε��� ����
CREATE INDEX idx_n_dept_test_03 ON DEPT_TEST (deptno, dname);

--�ǽ� idx2
DROP INDEX idx_u_dept_test_01;
DROP INDEX idx_n_dept_test_02;
DROP INDEX idx_n_dept_test_03;

--�ǽ� idx3










