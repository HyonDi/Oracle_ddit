--FOR LOOP 에서 명시적 커서 사용하기
--부서테이블의 모든 행의 부서이름, 위치 지역 정보를 출력 (CURSOR를 이용)

SET SERVEROUTPUT ON;
DECLARE
--커서 선언!
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
--커서 선언!
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


-- FORLOOP  인라인커서
--FOR LOOP 구문에서 커서를 직접 선언.
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



-- 실습3
--커서, 테이블타입으로 해도 돼. 자바로한건 테이블타입에 가깝다.
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

--분석함수사용한 sql 로
--sql 로 할 수 있는 방법 ㅣ 1. rownum 2. 분석함수 3. ? 
SELECT AVG(sum_avg) sum_avg
FROM
(SELECT LEAD(dt) OVER (ORDER BY dt) - dt sum_avg
FROM dt);

SELECT a.*, b.*
FROM dt a,dt b;

SELECT (MAX(dt) - MIN(dt)) / (COUNT(*)-1) avg_sum
FROM dt;

--실습4
--달력, record
--과정1
CREATE OR REPLACE PROCEDURE CREATE_DAILY_SALES
(v_yyyymm IN VARCHAR2) IS
BEGIN
--생성하기전에 해당년월에 해당하는 일실적 데이터를 삭제한다.
    DELETE daily
    WHERE dt LIKE v_yyyymm || '%';
    
    --애음주기 정보를 읽는다.
    FOR daily IN (SELECT * FROM cycle) LOOP
        DBMS_OUTPUT.PUT_LINE(daily.cid || ', '||daily.day);
    END LOOP;
END;
/

exec create_daily_sales('201912');


--과정2----------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE CREATE_DAILY_SALES
(v_yyyymm IN VARCHAR2) IS
    TYPE cal_row_type IS RECORD (
        dt VARCHAR2(8),
        day NUMBER);
    TYPE cal_tab IS TABLE OF cal_row_type INDEX BY BINARY_INTEGER;
    v_cal_tab cal_tab;
BEGIN
--생성하기전에 해당년월에 해당하는 일실적 데이터를 삭제한다.
    DELETE daily
    WHERE dt LIKE v_yyyymm || '%';
   --달력정보를 table 변수에 저장한다.
   --반복적인 sql 실행을 방지하기 위해 한번만 실행하여변수에 저장. *핵심!
   SELECT TO_CHAR(TO_DATE(v_yyyymm,'YYYYMM') + (LEVEL-1),'YYYYMMDD') dt,
        TO_CHAR(TO_DATE(v_yyyymm,'YYYYMM') + (LEVEL-1), 'D') day
    BULK COLLECT INTO v_cal_tab
    FROM dual
    CONNECT BY LEVEL <=TO_CHAR(LAST_DAY(TO_DATE(v_yyyymm,'YYYYMM')), 'DD');

    --애음주기 정보를 읽는다.
    FOR daily IN (SELECT * FROM cycle) LOOP
        --12월 일자 달력 : cycle row 건수 만큼 반복.
        FOR i IN 1..v_cal_tab.COUNT LOOP
            IF daily.day = v_cal_tab(i).day THEN
                --cid, pid, 일자, 수량
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


--달력
SELECT TO_CHAR(TO_DATE('201912','YYYYMM') + (LEVEL-1),'YYYYMMDD') dt,
    TO_CHAR(TO_DATE('201912','YYYYMM') + (LEVEL-1), 'D') day
FROM dual
CONNECT BY LEVEL <=TO_CHAR(LAST_DAY(TO_DATE('201912','YYYYMM')), 'DD');


--'20191255' 이런거도 논리적으로 들어갈 수 있다는 것. 이런 이유로 날짜타입을 문자로 바꿀때 로직을 잘짜야한다.
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

--dba(유지보수쪽에가깝다고?), da ( 컨설턴트), 모델러, sap(아밥? 이라는 언어를써야한대)