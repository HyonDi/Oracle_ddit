--PAIRWISE : ���� ����.
--����� PRIMARY KEY ���� ������ ��� �ϳ��� �÷��� ���������� ����.
--������ ���� �÷��� �������� PRIMARY KEY �������� ������ �� �ִ�.
--�ش� ����� ���� �� ���� ���� ó�� �÷� ���������� ������ �� ����.
----> TABLE LEVEL ���� ���� ����.

--������ ������ dept_test ���̺� ����(drop)
DROP table dept_test;

-- �÷������� �ƴ�, ���̺� ������ �������� ����.
CREATE TABLE dept_test(
    deptno NUMBER(2) ,
    dname VARCHAR2(14),
    loc VARCHAR(13), --������ �÷� ���� �� �ĸ� ������ �ʱ�
    
    --deptno�� dname �÷��� ���� �� ������(�ߺ���) �����ͷ� �ν�.
    CONSTRAINT pk_dept_test PRIMARY KEY ( deptno, dname) 
    );

--�μ����� �ٸ��Ƿ� ���� �ٸ� �����ͷ� �ν� --> INSERT ����.    
INSERT INTO dept_test Values(99, 'ddit', 'daejeon');
INSERT INTO dept_test Values (99, '���', '����');

SELECT *
FROM dept_test;

--�ι�° INSERT  ������ Ű���� �ߺ��ǹǷ� ����.
INSERT INTO dept_test VALUES(99, '���', 'û��');
--�̷���� Ű�÷�(��ȣ����) �� ���� ����� �־����� �����Ѵ�.

--�����̸Ӹ�Ű�� �÷������� ���̺����� ���� ����.
--

--
CONSTRAINT pk_dept_test PRIMARY KEY ( deptno, dname),
loc2 VARCHAR2(13)
    );
--�̷��� �ص� ������ �Ǿ����ϴ�!


--<<NOT NULL ��������>>
--�ش� �÷��� NULL���� ������ ���� ������ �� ���.
--�����÷����� �Ÿ��� �ִ�.
--dept_test �����ϰ� �����ϴ�.
--dname �÷��� null���� ������ ���ϵ��� NOT NULL ���� ���� ����.
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14) NOT NULL,
    loc VARCHAR(13)
    );

INSERT INTO dept_test Values(99, 'ddit', NULL);
--> ��� : 1�� insert �� �� ����. pk ���࿡ ���ݵ��� �ʴ´�.
-- deptno �÷��� primary key ���࿡ �ɸ��� �ʰ� loc �÷��� nullable �̱� ������
-- null���� �Էµ� �� �ִ�.
INSERT INTO dept_test Values (98, NULL, '����');
--> ��� : --2�� insert �� ����. 
--deptno �÷��� priamry key ���������� �ɸ��� �ʰ�(�ߺ��� ���� �ƴϴϱ�)
--dname �÷��� NOT  NULL ���������� ����.


--NOT NULL �������ǵ� �̸��� ���� �� �ִ�.
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    --deptno NUMBER(2) CONSTRAINT pk_dept_test PRIMARY KEY,  (���)
    dname VARCHAR2(14) CONSTRAINT NN_dname NOT NULL,
    loc VARCHAR(13)
    );
--CONSTRAINT ��� �����̸�!!!
--���������� ���̺� �� �ϳ��� �ɼ� �ִ°� �ƴ�.

--���̺����� ����� �����?
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR(13),
    CONSTRAINT NN_dname NOT NULL (dname)
    );
--NOT NULL �� ����ؼ� �� �� ����. ����������.


--1. �÷�����, 2. �÷����� + �������� �̸����̱�, 3. ���̺���
--��  ���������� �ɾ����ϴ�. [4. ���̺� ������ ���������� ����.]�� ���Ҵ�.


--UNIQUE ���� ����
--�ش� �÷��� ���� �ߺ��Ǵ� ���� ����.
--�� NULL ���� ���.
--GLOBAL solution �� ��� ������ ���� ���� ������ �ٸ��� ������
--pk ���� ���ٴ� UNIQUE ������ ����ϴ� ���̸�,
--������ ���� ������ APPLICATION �������� üũ�ϵ��� �����ϴ� ������ �ִ�.

--
DROP TABLE dept_test;

--1. �÷����� UNIQUE ���� ����.

CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14) UNIQUE,
    loc VARCHAR(13),
    );

--�ΰ��� insert ������ ���� dname�� ���� ���� �Է��ϱ� ������
--dname �÷��� ����� UNQUE ���࿡ ���� �ι�° ������ ���������� ����� �� ����.
--
INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (98, 'ddit', '����');


--�̸��� �ٿ����ϴ�.
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14) CONSTRAINT IDX_U_dept_test_01 UNIQUE,
    loc VARCHAR(13),
    );

INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (98, 'ddit', '����');

--�������ǿ� �츮�� �̸����� �̸��� ���´�. ���������� ���� �� ���� ã�� �� ����.

--2. ���̺��� UNIQUE ���� ����
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14) CONSTRAINT,
    loc VARCHAR(13), --���̺��� ������ �޸� �� �����!!!
    
    CONSTRAINT IDX_U_dept_test_01 UNIQUE(dname)
    );
INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (98, 'ddit', '����');


--<<Foreign key>>!!
--�ܷ�Ű, ����Ű.

--FOREIGN KEY ��������!
--�ٸ� ���̺� �����ϴ� ���� �Էµ� �� �ֵ��� ����.
--emp_test.deptno - > dept_test.deptno �÷��� �����ϵ��� �ҰŴ�.
--����Ű������ �� ���̺� ������ ����ϱ�.

--DEPT_TEST ���̺� ���� (DROP)
DROP TABLE dept_test;

--dept_test ���̺� ���� (deptNO �÷� primary key ����)
--dept ���̺�� �÷��̸�, Ÿ�� �����ϰ� �����ض�.
CREAT TABLE dept_test (
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR(14),
    loc VARCHAR(13) );

SELECT *
FROM dept;

--���� �����͸� �־�ô�.
INSERT INTO dept_test VALUES(99, 'DDIT','daejeon');

--emp_test ���̺��� ����ϴ�.
--empno, ename, deptno : emp_test
--empno PRIMARY KEY
--eptno dept_test.deptno FOREIGN KEY

CREAT TABLE emp_test(
    empno  NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    deptno NUMBER(2) REFERENCES dept_test (deptno)
);
--����Ű��� �����ʰ� ���۷������ ���. 

--dept_test ���̺� �����ϴ� deptno�� ���� �Է��غ���.
INSERT INTO emp_test VALUES(9999, 'brown', 99);
--> �������� �۵��Ѵ�.


--dept_test ���̺� ���������ʴ� deptno�� ���� �Է��غ���.
INSERT INTO emp_test VALUES(9998, 'brown', 98);
-->98���� �������� �ʴ´�. ���������Ϳ�. 
--> 98�� 99�� �ٲٰ� �����ϸ� �� �ɰŴ�.


--�÷����� ����Ű(�������Ǹ� �߰�)
--�÷��������� �Ұ���. (NOT NULL ó��. ���̺������� �ؾ��Ѵ�.)
CREAT TABLE emp_test(
    empno  NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    deptno NUMBER(2),
    
    CONSTRAINT FK_dept_test FOREIGN KEY (deptno) 
    REFERENCES dept_test (deptno) );

--dept_test ���̺� �����ϴ� deptno�� ���� �Է��غ���.
INSERT INTO emp_test VALUES(9999, 'brown', 99);
--> �������� �۵��Ѵ�.

--dept_test ���̺� ���������ʴ� deptno�� ���� �Է��غ���.
INSERT INTO emp_test VALUES(9998, 'brown', 98);
--> �ȵȴ�. 98�� �����ϱ�.

--���̺��� �÷������� �غô�.

--�ѹ�,Ŀ�� ���� �ؾ��ϴ°��� ���ص��Ǵ°�츦 �˾ƺ���.
--CREAT TABLE �� Ŀ���� ���ص� �Ǵ°ǰ�?
--INSERT �� �������ǵ���?

--����Ű���������� �����Ϸ��� �÷��� �ε����� �����Ǿ� �־�� �Ѵ�.
--��?
--���̺��� �����Ϳ��� ������ ����.
--�ε����� ���ٸ� ���̺��� ��絥���͸� �˻��ؾ��Ѵ�. �ε����� ���� �ӵ� ���� ����.
--����Ŭ������ �ӵ����� �̽��� �ε����� �ݵ�� �����ϵ��� �����Ѵ�.
--�׷��� �ε����� �� �־����. �����Ϸ��� �÷��ʿ�.
--����ũ�������� ������ �ش� �÷����� ����ũ�ε����� �ڵ������ȴ�.
--����ũ���������� ������ �ʿ��ϱ⶧��. �ߺ��Ȼ����� �ִ��� ������.



--<<����Ű�� �ɼ�!>> ���±����� ��� ����Ʈ�� ����ؿ���.


SELECT *
FORm emp_test;

DELETE dept_test
WHERE deptno=99;
--��������. emp�� dept �� �����ϰ��ֱ⶧��.
--�μ������� �������, ��������ϴ� �μ���ȣ�� �����ϴ� ���������� ���� 
--�Ǵ� deptno �÷��� NULL ó��.
--emp �۾� �� dept �۾��� �ؾ���. �����͸� ����µ����� ������ �ִ�.


OPTION
1. ON DELETE CASCADE : �θ� ������ �����ϰ��ִ� �ڽ� �÷��� �����͵� ���� ����.
2. ON DELETE SET NULL : �θ������ �����ϰ� �ִ� �ڽ��÷��� �����͸� null�� ����.
3. �ɼ��� �ƹ��͵� �� �ִ� ��.
--���ϱ�� 1,2���� ���� ���� ������ 3���� ���� �����ϴ�.
--�����ڴ� �����͸� �� ������ �� �־�� ��.



--foreign key OPTIION - ON DELETE CASCADE.

CREAT TABLE emp_test(
    empno  NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    deptno NUMBER(2),
    
    CONSTRAINT FK_dept_test FOREIGN KEY (deptno) 
    REFERENCES dept_test (deptno) ON DELETE CASCADE );

INSERT INTO emp_test VALUES(9999, 'brown', 99);
COMMIT;
--������ �Է� Ȯ��.
SELECT *
FROM emp_test;

--�ɼǿ� ������ ã���ϰ��ִ� ������̺� ���� ������ �Ǿ���Ѵ�.

DELECT dept_test
WHERE deptno = 99;
--������.emp�� ���󰬴�.
--ON DELETE CASCADE �ɼǿ� ���� DEPT �����͸� ������ ���
--�ش� �����͸� �����ϰ� �ִ� EMP ���̺��� ��� �����͵� �����ȴ�.


--
--�������̺� ����
DROP TABLE emp_test;

--FOREIGN KEY OPTION _ ON DELETE SET NULL.
CREAT TABLE emp_test(
    empno  NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    deptno NUMBER(2),
    
    CONSTRAINT FK_dept_test FOREIGN KEY (deptno) 
    REFERENCES dept_test (deptno) ON DELETE SET NULL );

--������ �Է�.
INSERT INTO emp_test VALUES(9999, 'brown', 99);
COMMIT;

--������ �Է� Ȯ��.
SELECT *
FROM emp_test;

--SET NULL �� �Ǿ��� �����غ��ϴ�.
--dept �����͸� ������ ���
--�ش� �����͸� �����ϰ� �ִ� emp���̺��� deptno �÷��� null�� ����.
DELETE dept_test
WHERE deptno = 99;
ROLLBACK;

--CASCADE �� �����Ͱ� ������������� SET NULL �� ���������ʰ� 
--�����ϰ��ִ� deptno �� ���� null�� �ٲ����.


--���̺����3���ϰ� �ѹ��ϸ� ���� �� �ǵ�������?


--<<CHECK ��������>>
--�ش��÷��� ���� ���� �� ���� �����ϰų�, ���� ��������� üũ�� �����ϴ�.
--�÷��� ���� ���� ������ ��
--EX : �޿� �÷����� ���� 0���� ū ���� ������ üũ
--      �����÷����� ��/�� Ȥ�� F/M ���� ������ ����.

--emp_test ���̺� ����.
DROP TABLE emp_test;

--emp_test ���̺� �÷�
--empno NUMBER(4)
--ename VARCHAR2(10)
--sal NUMBER(7,2) --0���� ū ���ڸ� �Էµǵ��� ����.
--emp_gb VARCHAR2(2) --���� ����. 01: ������  02: ����. 01, 02�� �� �� �ֵ��� �ؾ��Ѵ�.

CREATE TABLE emp_test(
    empno  NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    sal NUMBER(7,2) CHECK (sal > 0),
    gmp_gb VARCHAR2(2) CHECK (emp_gb IN ('01', '02'))) ;
    
--�����͸� �Է��غ��ϴ�. emp_test��.
--sal �÷� check �������� (sal > 0)�� ���ؼ� ���� ���� �Է� �� �� ����.
INSERT INTO emp_test VALUES (9999, 'brown', -1, '01');

--check ���������� �������� �����Ƿ� ���� �Է�.(sal, emp_gb)
INSERT INTO emp_test VALUES (9999, 'brown', 1000, '01');

--���� emp_gb �� 03���� �־��.
--emp_gb üũ���ǿ� ����(emp_gb IN('01','02')) !
--01, 02 �� �ϳ��� �����ϸ� �� ����.
INSERT INTO emp_test VALUES (9999, 'sally', 1000, '03');

--check �������� ���������̸� ����.
CREATE TABLE emp_test(
    empno  NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    sal NUMBER(7,2) CONSTRAINT C_SAL CHECK (sal > 0),
    gmp_gb VARCHAR2(2) CONSTRAINT C_EMP_GB CHECK (emp_gb IN ('01', '02'))) ;



--
DROP TABLE emp_test;
--���̺����� check �������� �̸�����.
CREATE TABLE emp_test(
    empno  NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    sal NUMBER(7,2) ,
    gmp_gb VARCHAR2(2), 
    
    CONSTRAINT C_SAL CHECK (sal > 0),
    CONSTRAINT C_EMP_GB CHECK (emp_gb IN ('01', '02'))
    ) ;

--NOT NULL �� CHECK //..�����Ե�..
CONSTRAINT nn_ename CHECK (ename IS NOT NULL)

--NOT NULL���� ���� ������ Ű����� �����и��Ѱ�. üũ��.
--�̸��ȸ���� ��ü�� �÷����� ��.

--���̺� ���� : CREAT TABLE  ���̺�� (�÷� �÷�Ÿ��.....);
--���� ���̺��� Ȱ���ؼ� ���̺� ���� : 
--CREATE TABLE AS: STAS ��Ÿ��
--CREATE TABLE ���̺� �� (�÷�,�÷�,�÷�.....��������) AS SELECT coll1, col2, col13..
--                                                    FROM �ٸ� ���̺��
--                                                    WHERE ����

DROP table emp_test;

--emp ���̺��� �����͸� ���Ի��� emp_test �̺��� ����.
CREATE TABLE emp _ test AS
SELECT *
FROM emp;

--�����ͱ��� ������ �����ϴ�.



--�����ϴµ� �÷����� �ٲ㺾�ô�. �̷����ִ������θ� �˾Ƶ� ������.
DROP table emp_test;

--emp ���̺��� �����͸� ���Ի��� emp_test ���̺��� �÷����� �����Ͽ� ����.
CREATE TABLE emp _ test(c1,c2, c3, c4, c5, c6,c7, c8), AS
SELECT *
FROM emp;

--������ Ȯ���غ��ô�.
SELECT *
FROM emp_test;
--���־��� ���´� �ƴϴ�.

--���̺��� ����µ�, �������� Ʋ�� ������ �� ������?
--�÷�������!
CREATE TABLE emp_test AS 
SELECT *
FROM emp
WHERE 1=2;
SELECT *
FROM emp_test;

DROP table emp_test;

--����س��� ���! ���ó�¥�� �� ���̺��� ����
--���� ������ ���� ���ó�¥�� ���ƿü�����.
--NOT NULL ���� ���� �̿��� ���������� ������� �ʴ´�.( primary, uique �̷���.����ȵǴϱ� ������ �����ؾ��Ѵ�.)
CREATE TABLE emp_20191209 AS
SELECT *
FROM emp;

--�׽�Ʈ���߽ÿ��� �����.





--<<������ ����!!>>�̹̻����Ǿ��ִ� ���̺� ���ο� �÷� �߰�, �÷� ����/ ����
--������ Ÿ���� ������ �Ұ����ϴ�. NUMBER �� VARCHAR2 �̷��ŷ� ���� �Ұ���.
--���� �����Ͱ� �ȿ� ������ ������ ���氡����.
--�����Ͱ� �ִµ��� Ÿ���� �Ұ����Ѱ��� �������� ������̴�. �������� ��Ҵ� �� ������ ����. ������ ����.
--������ �׳� ���������� ��.
--�̸������� ����.
--���������� �߰��ϴ°͵� ����.

--ALTER

--emp_test ���̺� ����.
DROP TABLE emp_test;
--empno, ename, deptno �÷����� emp_test ���� (emp���� Ʋ�� �����ؿԴ�.)
CREATE TABLE emp_test AS
    SELECT empno, ename, deptno
    FROM emp
    WHERE 1=2;

--��ȸ
SELECT *
FROM emp_test;

--emp_test ���̺� �ű��÷� �߰�
--HP VARCHAR2(20) DEFAULT '010'
--ALTER TABLE ���̺�� ADD (�÷��� �÷�Ÿ�� [����Ʈ��]);
ALTER TABLE emp_test 
ADD (HP VARCHAR2(20) DEFAULT '010');

--�����Ͱ� ������ �����÷��������غ���.
--ALTER TABLE ���̺�� MODIFY (�÷� �÷�Ÿ��[DEFAULT value]);
--�츮�� hp�÷��� Ÿ���� varchar2(20)-> varchar2(30)
ALTER TABLE emp_test MODIFY(hp VARCHAR2(30));

----�츮�� hp�÷��� varchar2(30) -> NUMBER
--���� emp_test ���̺��� �����Ͱ� ���� ������ �÷� Ÿ���� �����ϴ� ���� �����ϴ�.
ALTER TABLE emp_test MODIFY(hp NUMBER);
--Ȯ��
DESC emp_test;

--�÷����� �����غ��ô�.
--�ش��÷��� PK, UNIQUE, NOT NULL, CHECK ���� ���ǽ� ����� �÷��� ���ؼ��� �ڵ������� ������ �ȴ�.
--hp�÷��̸��� hp_n
--ALTER TABLE ���̺�� RENAME COLUMN �����÷��� TO �����÷���;
ALTER TABLE emp_test RENAME COLUMN hp TO hp_n;
DESC emp_test;


--�÷� ����
--ALTER TABLE ���̺�� DROP (�÷�);
--ALTER TABLE ���̺�� DROP COLUMN �÷�;
ALTER TABLE emp_test DROP (hp_n);
ALTER TABLE emp_test DROP COLUMN hp_n;

--���������� �߰��غ��ô�.
--ALTER TABLE ���̺�� ADD --���̺� ���� �������� ��ũ��Ʈ.
--emp_test ���̺��� empno�÷��� PK �������� �߰��غ���.
ALTER TABLE emp_test ADD CONSTRAINT pk_emp_test PRIMARY KEY(empno);

--�������ǻ�����? 
--ALTER TABLE ���̺�� DROP CONSTRAINT ���������̸�;
--������ ���� pk_emp_test ���������� �����غ���.
ALTER TABLE emp_test DROP CONSTRAINT pk_emp_test;

--���̺� �÷�, Ÿ�� ������ ���������γ��� �����ϴ�.
--���̺� �÷��� ������ �����ϴ� ���� �Ұ����ϴ�.
--empno, ename, job ������ ���� �÷��� empno, job, ename ���� �ٲٴ°�
--�����ٰ� �ٽ� ����°ͻ��� ����� ����. ������ ���־��־�ƴ�. �Ǽ��ѹ��ϸ� ū�ϳ�..


--��Ÿ��?�� ������ �ٲ�µ� �̰� �������ԵǴ°Ŷ�Ŵ�.
CREATE TABLE emp_test AS
SELECT *
FROM emp
ORDER BY job ASC;


--�ű� SELECT ���� ALTER TABLE �̷��� �߰��س־ �����ϸ� �ణ �ѹ��� �ٲٴµ��� �ȴ�.

