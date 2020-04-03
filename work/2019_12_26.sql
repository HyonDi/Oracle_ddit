-- << EXEPTION >>
-- ���� �߻��� ���α׷��� �����Ű�� �ʰ�
-- �ش� ���ܿ� ���� �ٸ� ������ ���� ��ų �� �ְԲ� ó���Ѵ�.

-- ���ܰ� �߻��ߴµ� ����ó���� ���� ��� : pl/sql ����� ������ �Բ� ����ȴ�.
-- �������� SELECT ����� �����ϴ� ��Ȳ���� ��Į�󺯼��� ���� �ִ� ��Ȳ

-- emp ���̺��� ��� �̸��� ��ȸ
SET SERVEROUTPUT ON;
DECLARE
    -- ��� �̸��� ������ �� �ִ� ����
    v_ename emp.ename%TYPE;
BEGIN
    -- 14���� SELECT ����� ������ sql --> ��Į�� ������ ������ �Ұ��ϴ�.(����)
    SELECT ename
    INTO v_ename
    FROM emp;
    
EXCEPTION
--    WHEN TOO_MANY_ROWS THEN
--        DBMS_OUTPUT.PUT_LINE('�������� SELECT ����� ����');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('WHEN OTHERS');
END;
/

-- ����� ���� ����
-- ����Ŭ���� ������ ������ ���� �̿ܿ��� �����ڰ� �ش� ����Ʈ���� �����Ͻ� ��������
-- ������ ���ܸ� ����, ����� �� �ִ�.
-- ���� ��� SELECT ����� ���� ��Ȳ���� ����Ŭ������ NO_DATA_FOUND ���ܸ� ������
-- �ش� ���ܸ� ��� NO_EMP��� �����ڰ� ������ ���ܷ� ������ �Ͽ� ���ܸ� ���� �� �ִ�.

--üũ���ͼ����� Ʈ����ĳġ���ؼ� ... ���ο�..�Ѵ�..

DECLARE
     -- emp ���̺� ��ȸ ����� ���� �� ����� ����� ���� ����
     no_emp EXCEPTION;
     v_ename emp.ename%TYPE;
BEGIN

    -- NO_DATAFOUND
    BEGIN
        SELECT ename
        INTO v_ename
        FROM emp
        WHERE empno = 7000;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RAISE no_emp; --java throw new NoEmpException() �� ����.
        
    END;
EXCEPTION
    WHEN no_emp THEN
        DBMS_OUTPUT.PUT_LINE('NO_EMP');
END;
/

--  << �Լ� >>
-- ����� �Է¹޾Ƽ� �ش� ������ �̸��� �����ϴ� �Լ�
-- getEmpName(7369) --> SMITH

CREATE OR REPLACE FUNCTION getEmpName (p_empno emp.empno%TYPE)
RETURN VARCHAR2 IS
--�����
    v_ename emp.ename%TYPE;
BEGIN
    SELECT ename
    INTO v_ename
    FROM emp
    WHERE empno = p_empno;
    
    return v_ename;
END;
/

SELECT getempname(empno)
FROM emp;

--�ǽ� 1
--�μ���ȣ�� �Ķ���ͷ� �Է¹ް� �ش� �μ� �̸��� �����ϴ� �Լ� getdeptname
CREATE OR REPLACE FUNCTION getdeptname( p_deptno emp.deptno%TYPE)
RETURN VARCHAR2 IS
    v_dname dept.dname%TYPE;
BEGIN
    SELECT dname
    INTO v_dname
    FROM dept
    WHERE deptno = p_deptno;
    return v_dname;
END;
/
SELECT getdeptname(deptno)
FROM emp;

-- cache : ����Ʈ 20��
-- ������ ������ : �����Ͱ� �󸶳� �����ִ���. 
-- deptno : �ߺ��߻� ����. = �������� ���� ���ϴ�. 
-- empno : �ߺ��� ����. = �������� ����.

-- emp ���̺��� �����Ͱ� 100������ ���
-- 100���� deptno�� ������ 4��(10~40)
SELECT getdeptname(deptno), -- 4����
        getempname(empno) -- row ����ŭ �����Ͱ� ����
FROM emp;
-- �Լ��� �������� ���� ���Ѱ�� �Լ��� ���°� ����.
-- �������� ���� ��쿡�� ������ �� ���� �� �ִ�.
--���������� �� ���� �Լ��� ����. 

-- �ǽ�2
SELECT deptcd, LPAD(' ',(LEVEL-1)*4,' ') || deptnm deptnm
FROM dept_h
START WITH p_deptcd IS NULL
CONNECT BY PRIOR deptcd = p_deptcd;

--�����̶� �μ��� �޾Ƽ� �غ��ϴ�.
CREATE OR REPLACE FUNCTION indent(p_lv NUMBER, p_dname VARCHAR2)
RETURN VARCHAR2 IS
    v_dname VARCHAR2(200);
BEGIN
--     SELECT LPAD(' ',(p_lv-1)*4,' ') || p_dname
--     INTO v_dname
--     FROM dual;
--     RETURN v_dname;
--Ȥ��
--    v_dname := LPAD(' ',(p_lv-1)*4,' ') || p_dname;
--    RETURN v_dname;
--Ȥ��     
     RETURN LPAD(' ',(p_lv-1)*4,' ') || p_dname;
END;
/

SELECT deptcd, indent(LEVEL, deptnm) deptnm
FROM dept_h
START WITH p_deptcd IS NULL
CONNECT BY PRIOR deptcd = p_deptcd;


-- << ��Ű�� >>
-- ����� ��ɵ��� �Լ�, ���ν��� ��� ���� ��Ƴ��� ��.
-- �������̽�(�����)�� Ŭ����(������) �� ����������Ͱ� �����.


-- << trigger >>
SELECT *
FROM users;

--users ���̺��� ��й�ȣ�÷��� ������ ������ ��
-- ������ ����ϴ� ��й�ȣ �÷� �̷��� �����ϱ� ���� ���̺�.
CREATE TABLE users_history(
--    his_seq �� �־��
    userid  VARCHAR2(20),
    pass VARCHAR2(100),
    mod_dt date
);

CREATE OR REPLACE TRIGGER make_history
    -- timing
    BEFORE UPDATE ON users
    FOR EACH ROW --��Ʈ����. ���� ������ ���� �� ���� �����Ѵ�.
    -- ���� ������ ���� : :OLD
    -- ���� ������ ���� : :NEW
    BEGIN
    -- users ���̺��� pass �÷��� ������ �� trigger ����.
        IF :OLD.pass != :NEW.pass THEN
            INSERT INTO users_history
                VALUES (:OLD.userid, :OLD.pass,sysdate);
        END IF;
        
        --�ٸ� �÷��� ���ؼ��� �����Ѵ�.
    END;
    /
    
--users ���̺��� pass �÷��� ���� ���� ��
-- trigger �� ���ؼ� users_history ���̺� �̷��� �����Ǵ��� Ȯ��.
SELECT *
FROM users_history;

UPDATE users SET pass = '123456'
WHERE userid = 'brown';

SELECT *
FROM users_history;

-- trigger �ý����� ��Ǳ� ���� �����ϴ� ����� �����մϴ�.

--�ĺ��� : ����, ����, ����??

�Խ���
        - �Խ��� ���̵�(�Խ��� ��ȣ) : ����Ŭ ������, �Խ����̸�, Ȱ��ȭ/��Ȱ��ȭ, �����, ����Ͻ�
�Խñ�
        - �Խñ� ��ȣ : ����Ŭ������, �Խñ�����, �Խñ� ����, ��������, �ۼ���, �ۼ��Ͻ�
            ÷������ 5������
            -÷�����ϸ�
���     -500��-> �ѱ� 1���ڰ� 3����Ʈ. 1500����Ʈ
        - ��۹�ȣ : ����Ŭ ������, ��۳���, �ۼ���, �ۼ��Ͻ�







exerd ���� �� dhfkzmf 9i~12c �� dbms ����!

