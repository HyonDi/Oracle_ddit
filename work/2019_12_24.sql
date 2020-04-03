--FOR LOOP ���� ����� Ŀ�� ����ϱ�
--�μ����̺��� ��� ���� �μ��̸�, ��ġ ���� ������ ��� (CURSOR�� �̿�)

SET SERVEROUTPUT ON;
DECLARE
--Ŀ�� ����!
    CURSOR dept_cursor IS 
        SELECT dname, loc
        FROM dept;
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
BEGIN
    FOR record_row IN dept_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(record_row.dname||', '|| record_row.loc);
    END LOOP;
    
END;
/



--
DECLARE
--Ŀ�� ����!
    CURSOR dept_cursor(p_deptno dept.deptno%TYPE) IS 
        SELECT dname, loc
        FROM dept
        WHERE deptno = p_deptno;
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
BEGIN
    FOR record_row IN dept_cursor(10) LOOP
        DBMS_OUTPUT.PUT_LINE(record_row.dname||', '|| record_row.loc);
    END LOOP;
    
END;
/


-- FORLOOP  �ζ���Ŀ��
--FOR LOOP �������� Ŀ���� ���� ����.
DECLARE
BEGIN
    FOR record_row IN (SELECT dname, loc FROM dept) LOOP
        DBMS_OUTPUT.PUT_LINE(record_row.dname||', '|| record_row.loc);
    END LOOP;
    
END;
/


--
DECLARE
    CURSOR dt_cursor IS 
        SELECT *
        FROM dt;
    v_dt dt.dt%TYPE;
    i NUMBER := 0;
    
BEGIN
    FOR i IN dt_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(record_row.dt);
        
    END LOOP;
    
    
    
END;
/



-- �ǽ�3
--Ŀ��, ���̺�Ÿ������ �ص� ��. �ڹٷ��Ѱ� ���̺�Ÿ�Կ� ������.
--
CREATE OR REPLACE PROCEDURE AVGDT IS
    TYPE dt_tab IS TABLE OF dt%ROWTYPE INDEX BY BINARY_INTEGER;
    v_dt_tab dt_tab;
    v_sum NUMBER := 0;
BEGIN
    SELECT *
    BULK COLLECT INTO v_dt_tab
    FROM dt
    ORDER BY dt;
    
    FOR i IN 1..(v_dt_tab.count-1) LOOP
        v_sum := v_sum + v_dt_tab(i+1).dt - v_dt_tab(i).dt;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(v_sum / (v_dt_tab.count-1));
END;
/

exec AVGDT;

--�м��Լ������ sql ��
--sql �� �� �� �ִ� ��� �� 1. rownum 2. �м��Լ� 3. ? 
SELECT AVG(sum_avg) sum_avg
FROM
(SELECT LEAD(dt) OVER (ORDER BY dt) - dt sum_avg
FROM dt);

SELECT a.*, b.*
FROM dt a,dt b;

SELECT (MAX(dt) - MIN(dt)) / (COUNT(*)-1) avg_sum
FROM dt;

--�ǽ�4
--�޷�, record
--����1
CREATE OR REPLACE PROCEDURE CREATE_DAILY_SALES
(v_yyyymm IN VARCHAR2) IS
BEGIN
--�����ϱ����� �ش����� �ش��ϴ� �Ͻ��� �����͸� �����Ѵ�.
    DELETE daily
    WHERE dt LIKE v_yyyymm || '%';
    
    --�����ֱ� ������ �д´�.
    FOR daily IN (SELECT * FROM cycle) LOOP
        DBMS_OUTPUT.PUT_LINE(daily.cid || ', '||daily.day);
    END LOOP;
END;
/

exec create_daily_sales('201912');


--����2----------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE CREATE_DAILY_SALES
(v_yyyymm IN VARCHAR2) IS
    TYPE cal_row_type IS RECORD (
        dt VARCHAR2(8),
        day NUMBER);
    TYPE cal_tab IS TABLE OF cal_row_type INDEX BY BINARY_INTEGER;
    v_cal_tab cal_tab;
BEGIN
--�����ϱ����� �ش����� �ش��ϴ� �Ͻ��� �����͸� �����Ѵ�.
    DELETE daily
    WHERE dt LIKE v_yyyymm || '%';
   --�޷������� table ������ �����Ѵ�.
   --�ݺ����� sql ������ �����ϱ� ���� �ѹ��� �����Ͽ������� ����. *�ٽ�!
   SELECT TO_CHAR(TO_DATE(v_yyyymm,'YYYYMM') + (LEVEL-1),'YYYYMMDD') dt,
        TO_CHAR(TO_DATE(v_yyyymm,'YYYYMM') + (LEVEL-1), 'D') day
    BULK COLLECT INTO v_cal_tab
    FROM dual
    CONNECT BY LEVEL <=TO_CHAR(LAST_DAY(TO_DATE(v_yyyymm,'YYYYMM')), 'DD');

    --�����ֱ� ������ �д´�.
    FOR daily IN (SELECT * FROM cycle) LOOP
        --12�� ���� �޷� : cycle row �Ǽ� ��ŭ �ݺ�.
        FOR i IN 1..v_cal_tab.COUNT LOOP
            IF daily.day = v_cal_tab(i).day THEN
                --cid, pid, ����, ����
                INSERT INTO daily VALUES (daily.cid, daily.pid, v_cal_tab(i).dt , daily.cnt);
            END IF;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(daily.cid || ', '||daily.day);
    END LOOP;
    
    COMMIT;
    
END;
/
exec create_daily_sales('201912');
---------------------------------------------------------------------------------------------------------------------
SELECT *
FROM daily;


--�޷�
SELECT TO_CHAR(TO_DATE('201912','YYYYMM') + (LEVEL-1),'YYYYMMDD') dt,
    TO_CHAR(TO_DATE('201912','YYYYMM') + (LEVEL-1), 'D') day
FROM dual
CONNECT BY LEVEL <=TO_CHAR(LAST_DAY(TO_DATE('201912','YYYYMM')), 'DD');


--'20191255' �̷��ŵ� �������� �� �� �ִٴ� ��. �̷� ������ ��¥Ÿ���� ���ڷ� �ٲܶ� ������ ��¥���Ѵ�.
SELECT *
FROM daily
WHERE day BETWEEN '201911' || '01' AND '201911' || '31';

DESC daily;


-------------------
INSERT DAILY; 
SELECT cycle.cid, cycle.pid,cal.dt, cycle.cnt
FROM cycle,
    (SELECT TO_CHAR(TO_DATE(:v_yyyymm,'YYYYMM') + (LEVEL-1),'YYYYMMDD') dt,
        TO_CHAR(TO_DATE(:v_yyyymm,'YYYYMM') + (LEVEL-1), 'D') day
    FROM dual
    CONNECT BY LEVEL <=TO_CHAR(LAST_DAY(TO_DATE(:v_yyyymm,'YYYYMM')), 'DD')) cal
WHERE cycle.day = cal.day;

--dba(���������ʿ������ٰ�?), da ( ������Ʈ), �𵨷�, sap(�ƹ�? �̶�� ������Ѵ�)