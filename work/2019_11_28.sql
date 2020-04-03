--11/28
--EXPLAIN PLAN FOR
SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno != dept.deptno
AND emp.deptno=10;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

SELECT ename, deptno
FROM emp;

SELECT deptno, dname
FROM dept;


--������������. �����ȹ�� ���� ������ �о����� �� �� �ִ�.
--������ �Ʒ���, �ȿ��� �ٱ����� ����.
--ID 2-3-1-0 ������ ����.
--1���� 0���� �ڽ���.
--2��,3���� 1���� �ڽ���. operation�� �鿩���⸦ ���� �� �� ����.
--���÷����� ������ �����ϴ°��� ��������. �ݴ�� ����������.
--���������� �Ϲ�����. 


--������ �Ƚ�sql�̷�.
--�Ƚ� sql���� ����Ŭ���� �����..

--natural join : ���� ���̺� ���� Ÿ��, ���� �̸��� �÷�����
--              ���� ���� ���� ��� ����.

DESC emp;
DESC dept;

--�Ƚ�sql ����
SELECT *
FROM emp NATURAL JOIN dept;
--�� ���̺��� �� �ʿ��� �ִ� �÷��̳�, ���εǰ� �ִ� �÷���
--�÷��̸�. ������  �̷��� ���ϰ� �׳� �������� ���� ��

ALTER TABLE emp DROP COLUMN dname;


--����Ŭ ����
SELECT emp. deptno, emp.empno, ename
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.dname = dept.dname;

--���⼭ ��Ī�ִ� �͵� ������. 
SELECT a.deptno, empno, ename
FROM emp a, dept b
WHERE a.deptno = b.deptno;
--�̷���

--���� �� ���°� �Ƚ� ����ť��������.
--����Ŭ������ from���� ������ �÷��� , �� ������ ����
--WHERE ���� �� ������ �����.

--�÷��̸��� �ٸ���쿡�� ���������� ����Ҽ� ����. ( ex) emp�� deptno �� dept ��
--deptno �̸��� �޶����� �����Ҽ������ٴ� ��. �̶��� ����Ŭ�������� ���ľ���.

--JOIN USING
--join �Ϸ��� �ϴ� ���̺� ������ �̸��� �÷��� �ΰ� �̻��� ��
--join �÷��� �ϳ��� ����ϰ� ���� ��
--using ���� ��������� ���־����� ����.

--ANSI SQL
SELECT *
FROM emp JOIN dept USING (deptno);

--������ ����Ŭ sql�� �ϸ�?
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;
--�ణ�� ���̰� �ֱ���..��������..?

SELECT *
FROM emp, dept;
--���Ǿ��� �������ϸ� ������ ����� ���� ��� ��½�Ŵ.
SELECT *
FROM emp, dept
WHERE 1=1;
--�굵.
--ũ�ν�����? ī�ټ�..?��...
--�Ƚ�sql�� ���ݾ� ���ϴµ� ����Ŭ sql�� ���Ծ���.


--ansi JOIN whit ON
--�����ϰ��� �ϴ� ���̺��� �÷� �̸��� �ٸ� ��
--�����ڰ� ���� ������ ���� ������ ��.

--
SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno);
--������ ���������� ������ 14���� �����Ͱ� ���´�.
SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE emp.deptno = 10; 
--����ɵ� �ȴ�.

--������ ����Ŭ�� �ٲ㺾�ô�
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;



--SELF JOIN : ���� ���̺� ����
--emp���̺� �����Ҹ��� ���� : ������ ������ ���� ��ȸ
--��������.  ����, ���������� �� ���̺��� �����ϴ� ����
--������ ������ ������ ��ȸ. �����̸�, �������̸�

SELECT empno, mgr, ename
FROM emp
WHERE mgr, empno???? �ȵǳ�..;
--ANSIsql

SELECT e.ename, m.ename
FROM emp e JOIN emp m ON(e.mgr = m.empno);

--������ ����Ŭsql�� �Ẹ��
SELECT e.ename, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;


--
--�����̸�, ������ ������̸�, ������ ������� ������̸� ������ �غ���?

SELECT e.ename, m.ename
FROM emp e JOIN emp m ON(e.mgr = m.empno);


--X
SELECT NVL(a.mgr, 'N')
FROM
(SELECT e.ename, m.ename, mm.ename
FROM emp e, emp m, emp mm
WHERE e.mgr = m.empno
AND m.mgr = mm.empno) a, emp mmm
WHERE a.mgr = mmm.empno;

--??
SELECT e.ename, m.ename, mm.ename
FROM emp e, emp m, emp mm
WHERE e.mgr = m.empno
AND m.mgr = mm.empno;

--??
SELECT e.ename, m.ename, mm.ename, mmm.ename
FROM emp e, emp m, emp mm, emp mmm
WHERE e.mgr = m.empno
AND m.mgr = mm.empno
AND mm.mgr = mmm.empno;

--ANSISQL�� �غ��� ������ �����(pt�� ����.)

SELECT e. ename, m.ename, mm.ename, mmm.ename
FROM emp e JOIN emp m ON ( e.mgr = m.empno)
    JOIN emp mm ON (m.mgr = mm.empno)
    JOIN emp mmm ON (mm.mgr = mmm.empno);

--������ �̸���, �ش� ������ ����̸��� ��ȸ
--��, ������ ����� 7369~7698 �� ������ ������� ��ȸ

SELECT e.ename, m.ename
FROM emp e JOIN emp m ON ( e.mgr = m.empno)
WHERE e.empno BETWEEN 7369 AND 7698;
-------------------------------�̰� �� �ȵŤФ�

SELECT *
FROM emp e, emp m
WHERE e.empno BETWEEN 7369 AND 7698
AND e.mgr = m.empno;

---ANSI��
SELECT e.ename, m.ename
FROM emp e JOIN emp m ON ( e.mgr = m.empno)
WHERE e.empno BETWEEN 7369 AND 7698;

--NONEQUAL JOIN

SELECT *
FROM salgrade;
SELECT empno, ename, sal
FROM emp;


SELECT emp.ename, emp.sal, salgrade.grade
FROM emp JOIN salgrade ON (emp.sal BETWEEN salgrade.losal AND salgrade.hisal);
--ON �ڿ� Ʈ��, ������ �;���??

SELECT salgrade.grade, emp.ename, emp.sal 
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;
--true, false �������̳����°ͻ�. ������ �ƴϾ ������ �����ϴ�.

--�ǽ� join0
--����Ŭ
SELECT empno, ename,dept.deptno,dname 
FROM emp, dept
WHERE emp.deptno = dept.deptno
ORDER BY deptno;
--�Ƚ�
SELECT emp.empno, emp.ename,deptno,dept.dname 
FROM emp NATURAL JOIN dept;

--�ǽ� join 0_1
--����Ŭ
SELECT empno, ename,dept.deptno,dname 
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND(emp.deptno = 10 
OR emp.deptno = 30)
ORDER BY deptno;
--�Ƚ�
SELECT emp.empno, emp.ename,deptno,dept.dname 
FROM emp NATURAL JOIN dept
WHERE deptno = 10 OR deptno = 30;

--�ǽ� join 0_2
SELECT empno, ename, sal, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno 
AND emp.sal > 2500;
--
SELECT empno, ename, sal, deptno, dname
FROM emp NATURAL JOIN dept
WHERE emp.sal > 2500;

--�ǽ� join 0_3
SELECT empno, ename, sal, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND sal > 2500 AND empno > 7600;
--
SELECT empno, ename, sal, deptno, dname
FROM emp NATURAL JOIN dept
WHERE sal > 2500 AND empno > 7600;

--�ǽ� join 0_4
SELECT empno, ename, sal, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND sal > 2500 AND empno > 7600 
AND dname = 'RESEARCH';
--
SELECT empno, ename, sal, deptno, dname
FROM emp NATURAL JOIN dept
WHERE sal > 2500 AND empno > 7600
AND dname = 'RESEARCH';

--���������� eXERD_INSTALLER  �ٿ�޾Ƴ���.
--��Ƽ�� �̻��� �׸������� = ERD ���̺��� �����ϴ� ���̴�.
--��Ÿ� ���赵���� ���� ������ �Ұž�.
--��~!