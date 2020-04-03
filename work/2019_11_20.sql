--Ư�� ���̺��� �÷� ��ȸ
--1. DESC ���̺��
--2. SELECT * FROM user_tab_columns;

--prod ���̺��� �÷���ȸ
DESC prod;

VARCHAR2, CHAR --> ���ڿ�. variable character(character) : �ִ������ 4000byte
Number --> ����
CLOB --> character Large Object --> �ִ������ 4GB
DATE --> ��¥(�Ͻ� = ��, ��, �� + �ð�, ��, ��)

--date Ÿ�Կ� ���� ������ �����?
'2019/11/20 09:16:20' + 1 = ?

--USERS ���̺��� ��� Ŀ���� ��ȸ �غ�����.
SELECT userid, usernm, reg_dt
FROM USERS;

--����ڰ� ���������̺� ����� ��ȸ�غ���





--USERS ���̺��� ��� Ŀ���� ��ȸ �غ�����.
--������ ���� ���ο� �÷� ����(reg_dt�� ���� ������ �� ���ο� ���� �÷�)
--��¥ + ���� ���� ==> ���ڸ� ���� ��¥Ÿ���� ����� ���´�.
SELECT userid, usernm, reg_dt regdate, reg_dt+5 after5day
FROM USERS;

--reg_dt+5 ������ ��Ī�� �ຸ�� �ڿ� As �� ���� ��Ī�̸��� ����. As �� ���� ����
--��Ī : ���� �÷����̳� ������ ���� ������ ���� �÷��� ������ �÷��̸��� �ο�.
--col : express [As] ��Ī��


DESC users
--���� ���, ���ڿ� ��� (����Ŭ���� ���ڿ��� ' ' �� ���)
--table �� ���� ���� ���Ƿ� �÷����� ����
--���ڿ� ���� ����
--���ڿ� ���� ���� ( + �� �������� ����!!!,==> ||)
SELECT 10+5*2, 'DB_SQL ����', userid || '_modified', usernm, reg_dt
FROM users;

--Null : ���� �𸣴� ��.
--NULL �� ���� ���� ����� �׻� NULL �̴�.
--DESC ���̺�� : NOT NULL �� �����Ǿ��ִ� �÷����� ���� �ݵ�� ���� �Ѵ�.

--users ���ʿ��� ������ ����
--
SELECT *
FROM users;

DELETE users
WHERE userid NOT IN ('brown', 'sally', 'cony', 'moon', 'james');

rollback;

commit;
--commit �ϸ� �ѹ��ص� �ȸԴ´� �̤� Ȯ��.

SELECT userid, usernm, reg_dt
FROM users;

--null ������ �����غ��� ���� moon�� reg_dt �÷��� null�� ����
UPDATE users SET reg_dt = NULL
WHERE userid = 'moon';

COMMIT;
ROLLBACK;

--users ���̺��� reg_dt �÷����� 5���� ���� ���ο� �÷��� ����
SELECT userid, usernm, reg_dt, reg_dt +5
FROM users;
--��� : NULL ���� ������ �ϸ� NULL �̴�.
--���߿� NULL�� ó���ϴ� �Լ��� ���ž�~!


--�ǽ�2
--1.
SELECT prod_id id, prod_name name
FROM prod;

--2.
SELECT lprod_gu gu, lprod_nm nm
FROM lprod;

--2.
SELECT buyer_id as "���̾� ���̵�", buyer_name �̸�
FROM buyer;


-------------------------------------------------------���� �� ����ǥ�� ��ǰ�̸� �����ϰ������ ����ؾ���??

--���ڿ� �÷��� ����   (�÷� || �÷�, '���ڿ����' || �÷�)
--(CONCAT (�÷�, �÷�) )- CONCAT �� ���ڸ� 24���ۿ� ������ ����.
--3���̻� �������� CONCAT��ȣ �ӿ� CONCAT�� �ٽ� �־� ���´�!

SELECT userid, usernm, 
        userid || usernm AS id_nm, 
        CONCAT(userid, usernm) con_id_nm,
        userid || usernm || pass id_nm_pass     
--        CONCAT(CONCAT(userid, usernm), pass) con_id_nm_pass
--�߿��ѰžƴϷ� ������ ������. ���̱������� �� �Ⱦ���
FROM users;

--�ǽ�!
SELECT 'SELECT * ' || 'FROM  ' || table_name || ';' query
FROM user_tables;
--��Ī�� ū����ǥ. �÷��� �׳�, ���ڿ��� ��������ǥ �ӿ� �ִ´�!!

--�ǽ�!

SELECT CONCAT ( , CONCAT(CONCAT('SELECT * FROM ', table_name ), ';'))
FROM user_tables;

SELECT CONCAT(CONCAT('SELECT * FROM ', table_name ), ';')
FROM user_tables;

SELECT * FROM LPROD;


--------------------------------------------------------------------------------------------------
DELETE users
WHERE userid NOT IN ('brown', 'sally', 'cony', 'moon', 'james');

UPDATE users SET reg_dt = NULL
WHERE userid = 'moon';

---------------------------------------------------------------------------------------------------------
-- WHERE : ������ ��ġ�ϴ� �ุ ��ȸ�ϱ� ���� ���
--          �࿡ ���� ��ȸ ������ �ۼ�

--WHERE �� ������ : 
SELECT userid, usernm, alias, reg_dt
FROM users;

--WHERE�� ������ :
SELECT userid, usernm, alias, reg_dt
FROM users
WHERE userid = 'brown'; --userid �÷�(��) �� 'brown'�� ��(row)�� ��ȸ. �࿭(�ο�, �÷�)


--EMP ���̺��� ��ü������ ��ȸ�ض�.((��� ��, ��) = WHERE���� ������ ���� �ʰڴ�.)
SELECT *
FROM EMP;


SELECT *
FROM dept;

--20������ �μ���ȣ(DEPTINO)�� ũ�ų� ���� ���� ���� ��ȸ
SELECT *
FROM emp
WHERE deptno >= 20;

--�����ȣ�� 7700���� ũ�ų� ���� ����� ������ ��ȸ
SELECT *
FROM emp
WHERE empno >= 7700;

----��� �Ի� ����(HIREDATE)�� 1982�� 1�� 1�� ������ ��� ���� ��ȸ
--���ڿ�--> ��¥ Ÿ������ ���� TO_DATE('��¥���ڿ�', '��¥���ڿ�����')
--�ѱ� ��¥ ǥ�� : ��,��,��
--�̱� ��¥ ǥ�� : ��, ��, �� (01-01-2020)

SELECT empno, ename, hiredate,
        2000 no, '���ڿ����' str, TO_DATE('19820101', 'yyyymmdd')
FROM emp
WHERE hiredate >= To_DATE('19820101', 'yyyymmdd');


--������ȸ (BETWEEM ���۱��� AND ��������)
--���۱���, ��������� ����.
--����߿��� �޿�(SAL)�� 1000���� ũ�ų� ����, 2000���� �۰ų� ���� ��� ���� ��ȸ.
---------------------------------------------ToDate  �� �ֽ���ϴ��� �𸣰ڴ�.

SELECT *
FROM emp;


SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;
--BETWEEN AND �����ڴ� �ε�ȣ �����ڷ� ��ü ����.

SELECT *
FROM emp
WHERE sal >=1000
AND sal <=2000


SELECT empno, ename, hiredate,
        2000 no, '���ڿ����' str, TO_DATE('19820101', 'yyyymmdd')
FROM emp
WHERE hiredate >= TO_DATE('19820101', 'yyyymmdd');


--�ǽ� where
SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('19820101','yyyymmdd') AND TO_DATE('19830101','yyyymmdd');


SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('19820101','yymmdd') AND TO_DATE('19830101','yymmdd');
--TO_DATE �� ���ڿ��� ��¥�� �ٲ��ִ� ����.
--TO_CHAR (hiredate, 'yy-mm-yy') ? ���ڸ� ���ڿ��� �ٲ��ش�????

--�ǽ� wehre
SELECT ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE('19820101','yymmdd')
AND hiredate <= TO_DATE('19830101','yymmdd');

Ŀ���� ��������!
�𸣰����� ���� ��� �ٽ� Ǯ���.
������ �ϰ�.

  


