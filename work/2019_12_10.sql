--�������� Ȱ������/��Ȱ��ȭ
--�׽�Ʈ���� ��
--ALTER TABLE ���̺�� ENABLE OR DISABLE CONSTRAINTS �������Ǹ�;

--�������� �̸� ã�¹� 1. ���̺������� CONSTRAINT Ȯ��
-- 2. SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'DEPT_TEST';(DEPT������� ��Ȱ��ȭ�ҰŴϱ�)


SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'DEPT_TEST';

--DEPT_TEST�� PRIMARY KEY �� ��Ȱ��ȭ��.
ALTER TABLE dept_test DISABLE CONSTRAINT sys_c007119;

--��Ȱ��ȭ�� DEPT_TEST �� ���� �־��.
--dept_test ���̺��� deptno�÷��� ����� PRIMARY KEY ���������� 
--��Ȱ��ȭ �Ͽ� ������ �μ���ȣ�� ���� �����͸� �Է��� �� �ִ�.
INSERT INTO dept_test VALUES (99,'ddit','daejeon');
INSERT INTO dept_test VALUES (99,'DDIT','����');

--�ٽ� Ȱ��ȭ�غ���.
ALTER TABLE dept_test ENABLE CONSTRAINT sys_c007119;
--�̹� ������ ������ 2���� insert ������ ���� ���� �μ���ȣ�� ���� �����Ͱ� �����ϱ� ������
--PRIMARY KEY ��������� Ȱ��ȭ �Ҽ� ����. 
--Ȱ��ȭ�Ϸ��� �ߺ������͸� �����ؾ��Ѵ�.

--�ߺ������� �����Ϸ��� �ߺ������͸� ã�´�.
--�ش� �����Ϳ� ���� ���� �� PRIMARY KEY ��������� Ȱ��ȭ �� �� �ִ�.
SELECT deptno, COUNT(*)
FROM dept_test
GROUP BY deptno
HAVING COUNT(*) >= 2;

--
SELECT *
FROM user_constraints;
--
SELECT *
FROM user_constraints
WHERE table_name = 'BUYER';

SELECT *
FROM user_cons_columns
WHERE table_name = 'BUYER';

--���� �����غ���. TABLE,_NAME, CONSTRAINT_NAME, COLUMN_NAME
--�������� POSITION ����(asc)

SELECT *
FROM user_cons_columns, user_constraints
WHERE 
????
;

--���̺� ���� ���� (�ּ�) VIEW
SELECT *
FROM USER_TAB_COMMENTS;
--���⿡ ������ COMMENTS �޾ƺ���.
--���̺� �ּ�:
--COMMENT ON TABLE ���̺�� IS '�ּ�';
COMMENT ON TABLE dept IS '�μ�';

--�÷��ּ� :
--COMMENT ON COLUMN ���̺��. �÷��� IS'�ּ�';
SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'DEPT';

COMMENT ON COLUMN dept.deptno IS '�μ���ȣ';
COMMENT ON COLUMN dept.dname IS '�μ���';
COMMENT ON COLUMN dept.loc IS '�μ� ��ġ ����';

--�ǽ� commet1
SELECT t.table_name, table_type,t.comments TAB_COMMENT, column_name
        , c.comments COL_COMMENT
FROM user_tab_comments t,user_col_comments c
WHERE t.table_name = c.table_name
AND t.table_name IN ('CUSTOMER','PRODUCT','CYCLE','DAILY');

SELECT *
FROM user_tab_comments;
SELECT *
FROM user_col_comments;

--<<view>>
--emp ���̺��� �޿������� ���Ը� �����ְ�;�. hr�ý��۴���ϸ� �����̶�Ŵ�. ��������ȵ�..
--������ sql�� ����� ���� �Ը� ūȸ�絵 ����. 
--�÷� ����, ���ֻ���ϴ� ������� ��Ȱ��, ���� ���� ����. �� �������� �����.
--������ ����� ��� �������� �� �ִ�.

--view ����. �䵵 ��ü�� creat �� �����. ���̺�� �ٸ����� �ɼ��� ����!
 --create [replace] view v_emp AS 
 --subquery;
 --view �� �����̴�. (o)
 --view �� ���̺��̴�. (x)
 --view �� ���̺�ó�� �����Ͱ� ���������� �����ϴ� ���� �ƴϴ�.
 --�ణ ����ƽ�޼��尰�� �����̳�
 --���� �����ͼ� = query
 
--CREATE OR REPLACE VIEW ���̸� [(�÷���Ī1, �÷���Ī2....)]AS
--SUBQUERY
 
--emp ���̺��� sal,. comm�÷��� ������ ������ 6�� �÷��� ��ȸ�� �Ǵ� view �� v_emp �̸����� �����غ���.
CREATE OR REPLACE VIEW v_emp AS 
SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp;

--���������� ����. VIEW ���� ������ �ʿ�. SYSTEM �������� ����.*****
--GRANT  CREATE VIEW TO ����(SYSTEM ���� ���� ������ΰ�) (GRANT �����ߴٰ� ������!!)

--view �� ���� �����͸� ��ȸ�ߴ�.
SELECT *
FROM v_emp;

--inline view �� ���·� view �� ǥ���ϸ�?(view �������� view �� ������)
SELECT*
FROM (SELECT empno, ename, job, mgr, hiredate, deptno
        FROM emp);
--����� �����ذ��������� �並 �������� ���� ���뼺�� ����.

--interface! ����

--emp ���̺��� �����ϸ� view �� ������ ������?
--view �� ������. ���������ʹ� ���̺��� �������°�. 
--���� ���̺��� �ٲ�� �䵵 �ٲﵥ���Ϳ� ������ �޴´�.

--KING �μ���ȣ�� ���� 10��. emp���̺��� KING�� �μ���ȣ �����͸� 30������ ����.
-- v_emp ���̺��� KING �� �μ���ȣ�� ����.
UPDATE emp set deptno = 30
WHERE ename = 'KING';

SELECT *
FROM emp
WHERE ename = 'KING';

--
SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--���� view�� �����غ���
CREATE OR REPLACE VIEW v_emp_dept AS
SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--���Ǻ� ��ȸ
SELECT *
FROM v_emp_dept;

--emp ���̺��� KING ������ ����.(������ �ٽ� king ����ؾ���. ddl �� ����Ŀ�Ե�.)
DELETE emp
WHERE ename = 'KING';
--Ȯ��
SELECT *
FROM emp
WHERE enmae = 'KING';
--ŷ ������ ��ٽ� ��ȸ
SELECT *
FROM v_emp_dept;

--inline view �� ǥ���غ���.
SELECT *
FROM (SELECT emp.empno, emp.ename, dept.deptno, dept.dname
        FROM emp, dept
        WHERE emp.deptno = dept.deptno);


--emp ���̺��� �÷��̸��� �ٲٸ� (empno->eno)
ALTER TABLE emp RENAME COLUMN empno TO eno;
--�������� ��� ��Եɱ�?
SELECT *
FROM v_emp_dept;
--���� ����â������ �並 ���� ���� ������ ������.������. �ٽ� ��Ƴ�������.
--�丸��� ��ũ��Ʈ�� �ٽ� �����ϸ� �ȴ�.
--�̹��� CREATE OR REPLACE ���� REPLACE �κ��� ����Ǿ�����ɰ��̴�.

--v_emp �����غ���.
DROP VIEW v_emp;
--����â���� ������.

--view �ععؿ� ��üȭ�� ��. ��� ����(������ �Ʒ�). �����������͸� ���� ��.�� �ֱ�� �ϴ�.
--�ٸ� dbms���� �Ƹ� �������̴�.

--view �� ����
--1. simple view
--: from ���� ������ table���� 1��, �Լ����� ���� �׷�����Լ� ���� view ���� dml ���డ��.
--2,complex view
--: from ���� ������ table�� 1���̻�. �Լ�, �׷�����Լ� ����. view�� ���� dml ���� �Ϲ������� �ȵ�.
--���⼭ ���ϴ� dml = (select ���� insert �� update ��)



--�μ��� ������ �޿��հ�
SELECT *
FROM emp;

SELECT deptno, SUM(sal) sum_sal
FROM emp
GROUP BY deptno;
--���� ��� ������.
CREATE OR REPLACE VIEW v_emp_sal AS
SELECT deptno, SUM(sal) sum_sal
FROM emp
GROUP BY deptno;
--
SELECT *
FROM v_emp_sal
WHERE deptno = 20;
--���� �ζ��κ��.
SELECT *
FROM (SELECT deptno, SUM(sal) sum_sal
        FROM emp
        GROUP BY deptno;
        )
WHERE deptno = 20;
--�̰�
SELECT *
FROM (SELECT deptno, SUM(sal) sum_sal
        FROM emp
        WHERE deptno = 20
        GROUP BY deptno);
--group by�� wehre .....�� ��¡ (�䰡 �������.)�������� ���߸� �� �� �ִ�. ���� ����.
--����������������� ���������ѵ��� �Ȱǰ�? ����. �׷�����ƴ�.
--�ζ��κ�ȿ��� �ο�ѻ��� ���¡�� �Ͼ�� �ʴ´�.

--��.. group by ���� having ������ �װ�.. �׷�����Լ��� �������� �ü����ٴ� ��!

SELECT *
FROM (SELECT deptno, sal, rownum FROM emp)
WHERE deptno = 20;
--> �������� ������������ �� �� ���Եȴ�.
--�ο���� �����鼭 ���������� �ζ��κ並 ���������Ҽ��ֵ��� �ϴ� ��.Ʃ��.







--<<������>>�������� ��ü��.
--�����Ϳ� key �÷��� ���� �����ؾ���.
--������ ���� ����� ���? 1. key table 2. UUID/Ȥ�� ������ ���̺귯�� 3.  sequence
--for update�� ��ȸ ���Ƴ���.......??�ڹٿ����� uuid ��� Ŭ������ �ִ�.

--uuid(��Ŭ������ �ƴ�)
--	public static void main(String[] args) {
--		System.out.println(UUID.randomUUID().toString());
--		System.out.println(UUID.randomUUID().toString());

--sequence : ������ �������� �������ִ� ����Ŭ ��ü. pk�÷��� ������ ������ �� ����. 
--ĳ������� ���� �ӵ����.

--�������. ����..
CREATE SEQUENCE seq_emp
INCREMENT BY 1
START WITH 1
NOCYCLE
NOCACHE;
--�ƽ������� �������������� ������ ū���� ����.
--����Ŭ�� �����ϸ� ��ȣ�� �ߺ��� �� �ִ�.

--NEXTVAL : �������� ���� ���� ��ȸ
--CURRVAL : ���� ������ ���� ��ȸ NEXTVAL�� ���� ���� ������ �ڿ� ��� ����.

CREATE OR REPLACE SEQUENCE seq_board;
--�������� �������. ����غ���. ��������. nextval
SELECT seq_board.nextval
FROM dual;
--���� ������ ��ȣ.
SELECT seq_board.currval
FROM dual;

--�������� ���� ����. ����������.�޸𸮻󿡼� ���� �����ϴ� ���� cache��.  �޸𸮿� 20�����������ٳ���
--ĳ���� Ŭ���� ��������?
--�߰����������� ���������� �ؾ��ϴ°�� ĳ���� �������������� ..rownum���� ����Ҽ��ֳ���.
--�޸𸮿��÷��а��� ����ڰ� nextval ���� �ʾƵ� ������ ��⵿�ϸ� ĳ�̵Ǿ��� ������ ���� ��������.
--rollback �ص� �������� �ʴ´�.

-- ������ ALTER , ������ DROP

--������-����
SELECT TO_CHAR(SYSDATE, 'yyyymmdd')||'-'||seq_board.nextval
FROM dual;










--<<index>> ����. ����
--����Ŭ����
--���̺�(table)�� ��(heap)���ְ�
--�ε���(index)�� Ʈ��(tree)������.
--stack : Fist In Last Out = ����������°� ���� ���߿�������.
--����!
--����Ʈ��/..�α��Լ�������� �����Ͱ��������� �ð�������ȭ������.
--��ǻ�ʹ� ���ֻ����~!
--�ð����۵�??
--������ / ��� n�� ���. ����2���� ��������� n����.
--tree(index) ??? iot??? �����������̵�...


--index
--���̺��� �Ϻ��÷��� �������� �����͸� ������ ��ü. = �ε����� Ʈ�������̴�.
--���̺���row�� ����Ű�� �ּҸ� ���� �ִ�. (rowid)
SELECT rowid, rownum, emp.*
FROm emp;
--rowid �� �࿡���� �ּ���.

--���� emp���̺� �������� ����. ���� ����ϴ�. empno -> primary key : pk_emp
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY(empno);

--dept ���̺� deptno�÷����� primary key, : pk_dept
ALTER TABLE dept ADD CONSTRAINT pk_dept PRIMARY KEY(deptno);

--emp ���̺��� deptno�÷��� dept ���̺��� deptno �÷��� �����ϵ���.
--foreign key ���� �߰� : fk_dept_deptno
ALTER TABLE emp ADD CONSTRAINT fk_dept_deptno FORIGN KEY (deotbi) REFERENCES dept(deptno);

SELECT rowid, rownum, emp.*
FROM emp;

--�񱳸����� emp_test �� �����ͺ��ϴ�. (emp���� �����غ��ô�.)
--emp_test ����
DROP TABLE emp_test;

--emp ���̺��� �̿��ؼ� emp_test ���̺� ����
CREATE TABLE emp_test AS
SELECT *
FROM emp;
--��Ÿ���� ����� ���������� (NOT NULL�����) ��������ʾ�. 
--����ũ������ ����ũ�ε����� �����.


--emp_test ���̺��� �ε����� ���� ����.
--���ϴ� �����͸� ã�� ���ؼ��� ���̺��� �����͸� ��� �о���� �Ѵ�.
SELECT *
FROM emp_test
WHERE empno = 7369;
--�����ȹ�� ����.
EXPLAIN PLAN FOR
SELECT *
FROM emp_test
WHERE empno = 7369;
SELECT *
FROM table(dbms_xplan.display);
-->�����ȹ�� ����(TABLE ACCES FULL �κ�)7369����� ���� ���� ������ ��ȸ�ϱ����� ���̺��� ��絥����
--�� �о ������ ����� 7369�� �����͸� �����Ͽ� ����ڿ��� ��ȯ.
--**13���� �����ʹ� �Ҥ������ϰ� ��ȸ �� ����.

--�̹����� emp �� �о��. (emp_test���� �ٸ���  : emp �� empno�� �ε����� �����Ǿ�����. 
--�׻� �ε����� ����ϴ°��� �ƴϴ�.
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7369;

SELECT *
FROM table(dbms_xplan.display);

--index�� �׻�  rowid�� ������ �ٴѴ�.

--�����ȹ�� ���� �м��� �ϸ�
--empno �� 7369�� ������ index�� ���� �ſ� ������ �ε����� ����.
--���� ����Ǿ� �ִ� rowid ���� ���� table�� �����Ѵ�.(rowid ���̺��� ���� �ּ�!!)
--table���� ���� �����ʹ� 7369��� ������ �ѰǸ� ��ȸ�� �ϰ� ������ 13�ǿ� ���ؼ��� ���� �ʰ� ó��.
--emp_terst 14--> 1    emp 1--> 1
--index �� ������ ����ϴ� ������ �ϱ��� ������ ������� �ȵ�.

--rowid ���˸� ���������� ��뵵 �����ϴ�.
EXPLAIN PLAN FOR
SELECT rowid, 
FROM emp
WHERE empno = 7369;

SELECT *
FROM table(dbms_xplan.display);

