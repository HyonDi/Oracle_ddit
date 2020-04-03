
--��Ī : ���̺�, �÷��� �ٸ��̸����� ����
--  [AS] ��Ī��
-- SELECT empno [AS] eno
-- FROM emp e

-- SYNONIM (���Ǿ�)
--����Ŭ ��ü�� �ٸ� �̸����� �θ� �� �ֵ��� �ϴ� ��
-- ���࿡ emp ���̺��� e��� �ϴ� synonym(���Ǿ�)�� ������ �ϸ�
-- ������ ���� sql�� �ۼ��� �� �ִ�.
-- SELECT *
-- FROM e;
--����Ŭ�� ��ü~!!!
--synonuym ���� - �ý��۱��� ����ڸ� ���� �� �ִ�.
--CREATE [PUBLIC] SYNONYM synonym_name for object;

--emp ���̺��� ����Ͽ� synonym ����

--����! �ý������� �����ؼ� ���ΰ����� �������� �ο��ϱ�
--GRANT CREATE SYNONYM TO �������̸�;
--�������� �ý��۰��� �������� �� ������!!

CREATE PUBLIC SYNONYM E FOR EMP;
--���� EMP ���̺�� ��� E ��� �ϴ� �ó���� ����Ͽ� ������ �ۼ��� �� �ֵ�!

SELECT *
FROM emp;

SELECT *
FROM e;

--SYSTEM�������� �Ʒ������� �غ��� ������������ �߳���. �̰ŷ��ؾ���.
SELECT *
FROM DBA_USERTS;

--���Ѻο� ȸ�� ���� �����ڰ� �ϴ� ���� �ƴ϶�� �����ϽŴ�.
--grant dcl!


--DML
--SELECT/ INSERT/ UPDATE/ DELETE/ INSERT ALL/ MERGE

--TCL
--COMMIT/ ROLLBACK/ SAVEPOINT

--DDL
--CREATE/ ALTER/ DROP

--DCL
--GRAMT / REVOKE
--����Ŭ�� �����ϱ����� �ʿ��� ����, ��ü�� �����ϱ����� �ʿ��� ����, ����Ŭ ����ڸ� �űԷ� ����.
-- CONNECT                          RESOURCE                       GRANT CONNECT, RESOURCE TO user_name

--����Ŭ���� ������ ũ�� 2������ �����ϴ�.
--1. �ý��۱���(�ý��� ����, ����), 2. ��ü���� (��ü����)
--��Ű�� ��ü���� ����(tables, views, indexes...)
--����Ŭ���� ��Ű���� �����?��� �ϸ�ȴٰ�?
--sem���ִ� ��, �ε���. ��Ű��, ���ν��� �̷���???
--��Ű�� = ����� �� ���� ���յ�. ��ü��.

--������й�ȣ �ٲٱ�
--alter user sem idntified by ��й�ȣ;

--����Ŭ �ý��۱��� ã�ư��� �ϸ� �ȴ�.

--grant privilege to user | role;
GRANT CONNECT, RESOURCE TO sem;
--> ������ ���.
REVOKE RESOURCE FROM sem;
--> ������ ������.

--�����ڿ��� ���������� ���ִ� ȸ�絵 �ִ�. 


GRANT CONNECT, INSERT ON emp TO sem;
-->�������� ��.

--�ɼ� �ý��۱���, ��ü���� / �ý��۱����� ���� �������.
WITH ADMIN OPTION : ������ �ο����� ����ڰ� �ٸ� ����ڿ��� ���� �ο� ����.
WITH GRANT OPTION
--�������� ���°ű���?

ROLE : ���尰���ų� ���Ѱ����� ����.

;

--�ý��� ������ ��ȸ�� �� �ִ� ��. DATA DICTIONARY

--�����ڰ� ����� ���̺���� ���������Ͷ�� �θ�. 
--���ΰ����Ǵ� ���� DATA DICTIONARY

--DATA DICTIONARY CATEGORY
--USER, ALL, DVA, V%
--����� ���� ��ü ��, ����ڰ� �����Ҽ��ִ� ��, DB������ ��, ����, �ý��۰��� ��


SELECT *
FROM DICTIONARY;

--�ε��������� �ε����÷������� �� Ȯ���غ���.
--

--������ SQL �� ���信 ������..
SELECT * FROM emp;
--��
SELECT * FROM EMP;
--��
SELECt * FROM emp;
--�� ���� �ٸ���. ������ �����ȹ�� ���� ��������.

SELECT /*201911_205*/ * FROM emp;
SELECT /*201911_205*/ * FROM EMP;
SELECt /*201911_205*/ * FROM emp;

SELECT /*201911_205*/ * FROM emp WHERE empno = :empno;
--> �̷��Ծ��� ���ε庯�����ٸ��� ������������. �����ȹ ����.
--�ϳ��ϳ� ����ξ���ٸ�����.

--SELECT /*201911_205*/ * FROM emp WHERE empno = ?;
--�ڹٿ��� �̷��� �ؼ�..��..��...sql.ó����..
--��� ������ ����.. �db���� �ϴ� �ൿ�� dbms���Դ� ������ ������ ��ĥ���ִٴ°� �˾Ƶ���.
--���� ũ���� ����Ʈ

--part2 ��!!
--�ǽ� 4 ������ �ؿ���! ���� : 25�ϱ����

--sql ���� ppt �� ���ϴ�.

--multiple insert
--1. undonditional
--2. conditional all
--3. conditional first

DROP TABLE emp_test;
--�ؿ��� ���θ���Ŵϱ�.
SELECT *
FROM emp_test;

--emp ���̺��� empno, ename �÷����� emp_test, emp_test2 ���̺��� ����.
-- (CTAS, �����͵� ���� ����.)
CREATE TABLE emp_test AS
SELECT empno, ename
FROM emp;

CREATE TABLE emp_test2 AS
SELECT empno, ename
FROM emp;

--Ȯ��
SELECT *
FROM emp_test1 

--unconditional insert : ���� ���̺� �����͸� ���ÿ� �Է��Ѵ�.
--brown , cony �� emp_test, emp_test2 ���̺� ���ÿ� �Է��ض�.
INSERT ALL
    INTO emp_test
    INTO emp_test2
SELECT 9999, 'brown'  FROM dual
UNION ALL
SELECT 9998, 'cony' FROM dual;
--4���� ���� �Էµƴٰ� �˷���.

SELECT *
FROM emp_test
WHERE empno > 9000;
SELECT *
FROM emp_test2
WHERE empno > 9000;
ROLLBACK;

--���̺� �ԷµǴ� �������� �÷��� ����, ���� ����.

INSERT ALL
    INTO emp_test (empno, ename)  VALUES(eno, enm)
    INTO emp_test2 (empno) VALUES (eno)
SELECT 9999 eno, 'brown' enm  FROM dual UNION ALL
SELECT 9998, 'cony' FROM dual;

--Ȯ��
SELECT *
FROM emp_test
WHERE empno > 9000

UNION ALL

SELECT *
FROM emp_test2
WHERE empno > 9000;

--> TEST 2 �� ENAME �� NULL�� ǥ�õǴ� ���� �� �� �ִ�.
--����. ���̺��� �ߺ�..?
ROLLBACK;

--CONDITIONAL INSERT : ���ǿ� ���� ���̺� �����͸� �Է�. �������ΰ�
INSERT ALL
    WHEN eno > 9000 THEN ~~ --case ������ �߾���.
        INTO EMP_TEST (eno, ename) VALUES (eno, enm)
        
    ELSE
        INTO EMP_TEST2 (eno) VALUES (eno)
SELECT 9999 eno, 'brown' enm  FROM dual UNION ALL
SELECT 8998, 'cony' FROM dual;

--Ȯ��
SELECT *
FROM emp_test
WHERE empno > 9000 UNION ALL
SELECT *
FROM emp_test2
WHERE empno > 8000;

ROLLBACK;
--
INSERT ALL
    WHEN eno > 9000 THEN 
        INTO EMP_TEST (eno, ename) VALUES (eno, enm)
    
    WHEN eno > 9500 THEN 
        INTO EMP_TEST (eno, ename) VALUES (eno, enm)
        
    ELSE
        INTO EMP_TEST2 (eno) VALUES (eno)
SELECT 9999 eno, 'brown' enm  FROM dual UNION ALL
SELECT 8998, 'cony' FROM dual;
ROLLBACK;


--
INSERT FIRST
    WHEN eno > 9000 THEN  
        INTO EMP_TEST (eno, ename) VALUES (eno, enm)
    
    WHEN eno > 9500 THEN  
        INTO EMP_TEST (eno, ename) VALUES (eno, enm)
        
    ELSE
        INTO EMP_TEST2 (eno) VALUES (eno)
SELECT 9999 eno, 'brown' enm  FROM dual UNION ALL
SELECT 8998, 'cony' FROM dual;
--���� ó���������͸�!!!