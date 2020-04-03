-- << ���պ��� >>
-- << %rowtype >>
-- Ư�� ���̺��� row������ ���� �� �ִ� ���� Ÿ��
-- TYPE : ���̺��. ���̺��÷��� %TYPE
-- ROWTYPE : ���̺��%ROWTYPE

SET SERVEROUTPUT ON;
DECLARE--�̸��ִ� ���ν����� ������ �ʰڴٴ� ��
--dept ���̺��� row ������ ���� �� �ִ� ROWTYPE ��������.
    dept_row dept%ROWTYPE;
BEGIN
    SELECT *
    INTO dept_row
    FROM dept
    WHERE DEPTNO = 10;
    
    DBMS_OUTPUT.PUT_LINE(dept_row.dname || ', ' || dept_row.loc);
END;
/

--<< ���պ��� RECORD >>
--�����ڰ� �÷��� ���� ����. Ÿ���� ���� �����.
--�����ڰ� �÷��� ���� �����Ͽ� ���߿� �ʿ��� TYPE�� ����

--TYPE Ÿ���̸� IS RECORD(�÷�1 �÷�1TYPE, �÷�2 �÷�2TYPE);
--Ŭ��������� ����ϴ�. 
DECLARE
    -- �μ��̸�, loc ������ ������ �� �ִ� record TYPE ����
    TYPE dept_row IS RECORD(
        dname dept.dname%TYPE,
        loc dept.loc%TYPE);
    -- TYPE ������ �Ϸ�. TYPE �� ���� ������ ����
    -- java : class ���� �� �ش� class�� �ν��Ͻ��� ����(new) �ϴ°Ͱ� ����.
    -- plsql ���� ���� : �����̸� ����Ÿ�� / dname IN dept.dname%TYPE;
    dept_row_data dept_row;
BEGIN
    SELECT dname, loc
    INTO dept_row_data
    FROM dept
    WHERE deptno = 10;
    DBMS_OUTPUT.PUT_LINE(dept_row_data.dname || ', ' || dept_row_data.loc);
END;
/
-- Ÿ�Ծȿ� �������� �÷����� ������ �� �ִٴ� �������� �־���.


-- << ���պ��� tabletype >>
-- INDEX BY BINARY INTEGER : 

--TABLE TYPE : �������� ROWTYPR�� ������ �� �ִ� TYPE
-- col --> row --> table
--TYPE ���̺�Ÿ�Ը� IS TABLE OF ROWTYPE/RECORD INDEX BY �ε���Ÿ��(BIANARY_INTEGER)
-- JAVA �� �ٸ��� PLSQL ������ ARRAY ������ �ϴ� TABLE TYPE �� �ε����� ���ڻӸ��ƴ϶� ���ڿ� ���µ� �����ϴ�.
--�׷��⶧���� INDEX�� ���� Ÿ���� ����Ѵ�.
-- �Ϲ������� ARRAY(LIST) ������ ����� INDEX BY BINARY_INTEGER �� �ַ� ����Ѵ�.
-- ARR(1).NAME = 'BROWN'
-- ARR('PERSON').NAME = 'BROWN'


--DEPT ���̺��� ROW�� ������ ������ �� �ִ� DEPT_TAB TABLE TYPE �����Ͽ� 
--SELECT * FROM dept; �� ���(������)�� ������ ��´�.
DECLARE
    TYPE dept_tab IS TABLE OF  dept%ROWTYPE INDEX BY BINARY_INTEGER;
    v_dept dept_tab;
BEGIN
    --�� row�� ���� ������ ���� : INTO
    --���� row�� ���� ������ ���� : BULK 
    SELECT *
    BULK COLLECT INTO v_dept
    FROM dept;
    
    FOR i IN 1..v_dept.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE(v_dept(i).deptno);
    END LOOP;
END;
/


-- << �������� IF >>
-- IF condition THEN
--      statement
-- ELSIF condition THEN
--      statement
-- ELSE
--      statement
-- END IF;

-- PL/SQL IF �ǽ�
-- ���� P (NUMBER)�� 2��� ���� �Ҵ��ϰ�
-- IF ������ ���� P�� ���� 1, 2 �׹��� ���� �� �ؽ�Ʈ ���

DECLARE
    p NUMBER := 2; --���� ����� ���ÿ� �Ҵ�. �ѹ��忡�� �����Ѵ�.
BEGIN
--    P := 2; --�Ҵ翬����!! :=
    IF p = 1 THEN
        DBMS_OUTPUT.PUT_LINE('P=1');
     ELSIF p = 2 THEN --�ڹٿ� �ٸ��� ELSE IF ���� �� E �������� �ٿ�����Ѵ�.
        DBMS_OUTPUT.PUT_LINE('P=2');
    ELSE
        DBMS_OUTPUT.PUT_LINE(p);
    END IF; --�ڹٿ� �ٸ��� END IF �� IF���� ������.
END;
/

-- FOR LOOP
-- FOR �ε������� IN [REVERSE] START..END LOOP
--      �ݺ����๮
-- END LOOP;
-- 0~5���� ���� ������ �̿��Ͽ� �ݺ��� ����

DECLARE

BEGIN
    FOR i IN 0..5 LOOP 
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
END;
/

-- 1~10������ ���� loop�� �̿��Ͽ� ���, ����� s_val �̶�� ������ ���
-- DBMS_OUTPUT.PUT_LINE �Լ��� ���� ȭ�鿡 ���

DECLARE
    s_val NUMBER := 0;
BEGIN
    FOR i IN 1..10 LOOP
        s_val := s_val + i;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(s_val);
END;
/

-- << while loop >>
-- WHILE condition LOOP
--      statement
-- END LOOP;
-- 0���� 5���� WHILE ���� �̿��Ͽ� ���.
DECLARE
    i NUMBER := 0;
BEGIN
    WHILE i <=5 LOOP 
        DBMS_OUTPUT.PUT_LINE(i);
        i := i + 1;
    END LOOP;
END;
/


-- << LOOP >>
-- �ڹ��� dowhile ���?  
--LOOP
--LOOP
--    STATEMETN;
--      EXIT [WHEN condition];  
--END LOOP;

DECLARE  i NUMBER : =0;
BEGIN 
    LOOP
        DMBS.OUTPUT.PUTPUT_LINE


DECLARE
    i NUMBER := 0;
BEGIN
    WHILE i >=5 LOOP 
        DBMS_OUTPUT.PUT_LINE(i);
        i := i + 1;
    END LOOP;
END;
/








-- << CURSOR >>  : SQL�� �����ڰ� ������ �� �ִ� ��ü.
-- ������ : �����ڰ� ������ Ŀ������ ������� ���� ����, ORACLE���� �ڵ����� OPEN, ����, FETCH, CLOSE �� �����Ѵ�.
-- ����� : �����ڰ� �̸��� ���� Ŀ��. �����ڰ� ���� �����ϸ�
--           ����, OPEN, FETCH, CLOSE �ܰ谡 ����.
-- CURSOR Ŀ���̸� IS --Ŀ�� ����.
--    QUERY;
--OPEN Ŀ���̸�; -- Ŀ�� OPEN
--FETCH Ŀ���̸� INTO ����1, ����2.....-- Ŀ�� FETCH(�� ����)
-- CLOSE Ŀ���̸�; --  Ŀ�� CLOSE

-- �μ����̺��� ��� ���� �μ��̸�, ��ġ ���� ������ ��� ( cursor �� �̿�)
DECLARE
--Ŀ�� ����!
    CURSOR dept_cursor IS 
        SELECT dname, loc
        FROM dept;
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
BEGIN
    OPEN dept_cursor;
    FETCH dept_cursor INTO v_dname, v_loc;
    CLOSE dept_cursor;
    
    DBMS_OUTPUT.PUT_LINE(v_dname || ', ' || v_loc);
END;
/

--���� ,loop�� ��� ������ �غ���.
DECLARE
--Ŀ�� ����!
    CURSOR dept_cursor IS 
        SELECT dname, loc
        FROM dept;
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
BEGIN
    OPEN dept_cursor;
    
    LOOP
    FETCH dept_cursor INTO v_dname, v_loc;
    DBMS_OUTPUT.PUT_LINE(v_dname || ', ' || v_loc);
    DEPT_CURSOR&notfound;
    END LOOP;
    
    CLOSE DEPT_CUSTOMER;
    CLOSE dept_cursor;
    
    
END;
/




































