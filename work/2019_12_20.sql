--hash �Լ�
SELECT *
FROM dept, emp
WHERE dept.deptno = emp.deptno;
--dept ���� �д� ����.
-- join�÷��� hash �Լ��� ������ �ش� �ؽ� �Լ��� �ش��ϴ� bucket �� �����͸� �ִ´�.
--���� �ؽ��Լ� (� ���� ���� �ߺ����� �ʴ� ������ ��ȯ��Ű�� �ؽ��Լ�.)
--�� ����� ���� bucket �����Ϳ� �ִ´�. 
-- �׸��� where ���� �ۼ��� ���ǿ� �´� ������
-- ��ܿ��� �� �� �ִ� ����. 1~2�ð� �ɸ��� ������ �۾����� ��������.

--Sort merge join �� �����ȹ�������� ������ �ǰ� ��§�ŷ�..�̤Ф̤�
--��Ʈ : /*+�ε�����||��Ʈ��*/
--����Ŭ���� �̷����̷��� Ǯ������. �ϴ°�.

--��ü���� ó��
SELECT COUNT(*)
FROM emp;
-->�ε������־ ����� �� �� ����.
-- ������ ��ü �� �о�� ���� ������.

------------------------------------------------------------------------------------------------
--�����ȣ, ����̸�, �μ���ȣ, �޿�, �μ����� ��ü �޿� ��.
--WINDOWIMG!
SELECT empno, ename, deptno, sal,
        SUM(sal) OVER(ORDER BY sal 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum--���� ó������ ���������. ��� ������ �����.
FROM emp
ORDER BY sal;

--�ٷ� �������̶� ����������� �޿���
SELECT empno, ename, deptno, sal,
        SUM(sal) OVER(ORDER BY sal 
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) c_sum--���� ó������ ���������. ��� ������ �����.
FROM emp
ORDER BY sal;

--�̷��Խᵵ �ȴ�. ������ ����
SELECT empno, ename, deptno, sal,
        SUM(sal) OVER(ORDER BY sal 
        ROWS UNBOUNDED PRECEDING) c_sum
FROM emp
ORDER BY sal;

--�ǽ�7
SELECT empno, ename, deptno, sal,
    SUM(sal) OVER(PARTITION BY deptno ORDER BY sal, empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum
FROM emp;

--�м��Լ�/�������Լ�  rows /range/no windowing
--rows �� range �� ����
SELECT empno, ename, deptno, sal,
        SUM(sal) OVER (ORDER BY sal ROWS UNBOUNDED PRECEDING) row_sum,
        SUM(sal) OVER (ORDER BY sal RANGE UNBOUNDED PRECEDING) row_sum,
        SUM(sal) OVER (ORDER BY sal) c_sum
FROM emp;
--windowing �� �����Լ��ʿ����� ����� �� �ִ�.
--orderby �� �ڿ� �ƹ��͵� ���� ������� ����Ŭ���� ����Ʈ�� RANGE UNBOUNDED PRECEDING �� �����ش�.

-- sal ���� ������ ������ �ٸ� �κ��� ���´�.
-- RANGE �� ���� ���� �ϳ��� ����.
-- rows �� ���������� ��Ȯ������ range �� ���� ���� ������ 
-- �����ŷκ��� ������ ����ͱ��� ������ ��Ų��.(= �������� �����°ͱ��� ������ ��Ų��.)

-------------------------------------------------------------------------------------<<���� sql ��!>>
--pl/sql
--Procedueal Language/ sql structured query language
--����Ŭ���� �����ϴ� ���α׷��� ���.
--������ ������ ���� sql�� �Ϲ� ���α׷��� ����Ҹ� �߰��ߴ�. --�����͸� ���������� ó���ϴµ� �������ִ�.

--[declare (�����)] : ������ �����ϴ� �κ�.
--Begin (�����) : PL/SQL �� ������ ���� �κ�
--[Exeption (����ó����)] : �ɼ�.����ó��

--!! plsql ������ ������ �����Ѵ�. ���Կ����ڴ�:  :=
--���������� DECLARE ����ο����� �� ���ִ�. BRGIN ������ ����.

--set serveroutput ON; = �ܼ�â�� ��±�� Ȱ��ȭ.
--dbms.output.Put_line() = sysout ����.

 -- DBMS_OUTPUT.PUT.LINE �Լ��� ����ϴ� ����� ȭ�鿡 �ο��ֵ��� Ȱ��ȭ�Ѵ�.
SET SERVEROUTPUT ON;
DECLARE --�����
            -- java : Ÿ�� ������;
            --pl/sql : ������ Ÿ��;
--    v_dname VARCHAR2(14);
--    v_loc  VARCHAR2(13);
    --���̺� �÷��� ���Ǹ� �����Ͽ� ������ Ÿ���� �����Ѵ�.
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
BEGIN
    --DEPT ���̺��� 10�� �μ��� �μ��̸�, LOC ������ ��ȸ
    SELECT dname, loc
    INTO v_dname, v_loc --����, ����2
    FROM dept
    WHERE deptno = 10;
    
    DBMS_OUTPUT.PUT_LINE(v_dname || v_loc);
END;
/ 
--  / = PLSQL ����� �����϶�� ��.

desc dept;

--���۷���Ÿ��!!
--10�� �μ��� �μ��̸�, ��ġ������ ��ȸ�ؼ� ������ ��� ������ EBMS_OUTPUT.PUT_LINE�Լ��� �̿��� CONSOLE�� ���
CREATE OR REPLACE PROCEDURE printdept IS 
--�����(�ɼ�)
    dname dept.dname%TYPE;
    loc dept.loc%TYPE;
    
--�����
BEGIN
    SELECT dname, loc
    INTO dname, loc
    FROM dept
    WHERE deptno = 10;

    DBMS_OUTPUT.PUT_lINE(dname ||' '|| loc);
--����ó����(�ɼ�)
END;
/

exec printdept;


--
CREATE OR REPLACE PROCEDURE printdept 
--�Ķ���͸� IN/OUT Ÿ��
--�Ķ���͸� �����Ҷ��� ��ü�� p_ �� �����Ѵ�. (���򰥸���)
( p_deptno IN dept.deptno%TYPE )
IS 
--�����(�ɼ�)
    dname dept.dname%TYPE;
    loc dept.loc%TYPE;
    
--�����
BEGIN
    SELECT dname, loc
    INTO dname, loc --�� ���� ������ ó������ ���Ѵ�.
    FROM dept
    WHERE deptno = p_deptno;

    DBMS_OUTPUT.PUT_lINE(dname ||' '|| loc);
--����ó����(�ɼ�)
END;
/

exec printdept(50);

-- �ǽ� pro_1
CREATE OR REPLACE PROCEDURE printtemp 
( p_empno IN emp.empno%TYPE ) --�Ķ���� ����
IS
    v_ename emp.ename%TYPE;
    v_dname dept.dname%TYPE;
    
BEGIN
    SELECT emp.ename, dept.dname
    INTO v_ename,v_dname
    FROM emp, dept
    WHERE emp.empno = p_empno
    AND emp.deptno = dept.deptno;
    DBMS_OUTPUT.PUT_lINE(v_ename ||' / '|| v_dname);
END;
/
exec printtemp(7369);

--�ǽ�2
CREATE OR REPLACE PROCEDURE registdept_test
(p_deptno IN dept.deptno%TYPE, p_dname IN dept.dname%TYPE, p_loc IN dept.loc%TYPE)
IS
    v_deptno emp.deptno%TYPE;--���۷���Ÿ��!
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
BEGIN
    INSERT INTO dept_test(deptno, dname, loc) VALUES (p_deptno, p_dname, p_loc);
    SELECT deptno, dname, loc
    INTO v_deptno, v_dname, v_loc
    FROM dept_test
    WHERE dept_test.deptno = p_deptno AND dept_test.dname = p_dname AND dept_test.loc = p_loc;
    DBMS_OUTPUT.PUT_LINE(v_deptno || '/' || v_dname ||'/'||v_loc);
END;
/
exec registdept_test(99, 'ddit', 'daejeon');

--prodedure �� function ���� : ����Ÿ���� �ֳ�/����(procedure �� ����.)



--�ǽ�3
CREATE OR REPLACE PROCEDURE UPDATEdept_test
(p_deptno IN dept.deptno%TYPE, p_dname IN dept.dname%TYPE, p_loc IN dept.loc%TYPE)
IS
BEGIN
    UPDATE dept_test SET dname = p_dname, deptno = p_deptno, loc = p_loc WHERE deptno = p_deptno;
END;
/
exec UPDATEDEPT_TEST(99, 'ddit_m', 'daejeon_m');

select *
FROM dept_test;
COMMIT;

