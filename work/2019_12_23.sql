-- << 복합변수 >>
-- << %rowtype >>
-- 특정 테이블의 row정보를 담을 수 있는 참조 타입
-- TYPE : 테이블명. 테이블컬럼명 %TYPE
-- ROWTYPE : 테이블명%ROWTYPE

SET SERVEROUTPUT ON;
DECLARE--이름있는 프로시져를 만들지 않겠다는 뜻
--dept 테이블의 row 정보를 담을 수 있는 ROWTYPE 변수선언.
    dept_row dept%ROWTYPE;
BEGIN
    SELECT *
    INTO dept_row
    FROM dept
    WHERE DEPTNO = 10;
    
    DBMS_OUTPUT.PUT_LINE(dept_row.dname || ', ' || dept_row.loc);
END;
/

--<< 복합변수 RECORD >>
--개발자가 컬럼을 직접 고른다. 타입을 직접 만든다.
--개발자가 컬럼을 직접 선언하여 개발에 필요한 TYPE을 생성

--TYPE 타입이름 IS RECORD(컬럼1 컬럼1TYPE, 컬럼2 컬럼2TYPE);
--클래스선언과 비슷하다. 
DECLARE
    -- 부서이름, loc 정보를 저장할 수 있는 record TYPE 선언
    TYPE dept_row IS RECORD(
        dname dept.dname%TYPE,
        loc dept.loc%TYPE);
    -- TYPE 선언이 완료. TYPE 을 갖고 변수를 생성
    -- java : class 생성 후 해당 class의 인스턴스를 생성(new) 하는것과 같다.
    -- plsql 변수 생성 : 변수이름 변수타입 / dname IN dept.dname%TYPE;
    dept_row_data dept_row;
BEGIN
    SELECT dname, loc
    INTO dept_row_data
    FROM dept
    WHERE deptno = 10;
    DBMS_OUTPUT.PUT_LINE(dept_row_data.dname || ', ' || dept_row_data.loc);
END;
/
-- 타입안에 여러개의 컬럼값을 저장할 수 있다는 공통점이 있었다.


-- << 복합변수 tabletype >>
-- INDEX BY BINARY INTEGER : 

--TABLE TYPE : 여러개의 ROWTYPR을 저장할 수 있는 TYPE
-- col --> row --> table
--TYPE 테이블타입명 IS TABLE OF ROWTYPE/RECORD INDEX BY 인덱스타입(BIANARY_INTEGER)
-- JAVA 와 다르게 PLSQL 에서는 ARRAY 역할을 하는 TABLE TYPE 의 인덱스를 숫자뿐만아니라 문자열 형태도 가능하다.
--그렇기때문에 INDEX에 대한 타입을 명시한다.
-- 일반적으로 ARRAY(LIST) 형태인 경우라면 INDEX BY BINARY_INTEGER 를 주로 사용한다.
-- ARR(1).NAME = 'BROWN'
-- ARR('PERSON').NAME = 'BROWN'


--DEPT 테이블의 ROW를 여러건 저장할 수 있는 DEPT_TAB TABLE TYPE 선언하여 
--SELECT * FROM dept; 의 결과(여러건)을 변수에 담는다.
DECLARE
    TYPE dept_tab IS TABLE OF  dept%ROWTYPE INDEX BY BINARY_INTEGER;
    v_dept dept_tab;
BEGIN
    --한 row의 값을 변수에 저장 : INTO
    --복수 row의 값을 변수에 저장 : BULK 
    SELECT *
    BULK COLLECT INTO v_dept
    FROM dept;
    
    FOR i IN 1..v_dept.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE(v_dept(i).deptno);
    END LOOP;
END;
/


-- << 로직제어 IF >>
-- IF condition THEN
--      statement
-- ELSIF condition THEN
--      statement
-- ELSE
--      statement
-- END IF;

-- PL/SQL IF 실습
-- 변수 P (NUMBER)에 2라는 값을 할당하고
-- IF 구문을 통해 P의 값이 1, 2 그밖의 값일 때 텍스트 출력

DECLARE
    p NUMBER := 2; --변수 선언과 동시에 할당. 한문장에서 진행한다.
BEGIN
--    P := 2; --할당연산자!! :=
    IF p = 1 THEN
        DBMS_OUTPUT.PUT_LINE('P=1');
     ELSIF p = 2 THEN --자바와 다르게 ELSE IF 에서 뒤 E 도빠지고 붙여써야한다.
        DBMS_OUTPUT.PUT_LINE('P=2');
    ELSE
        DBMS_OUTPUT.PUT_LINE(p);
    END IF; --자바와 다르게 END IF 로 IF절을 끝낸다.
END;
/

-- FOR LOOP
-- FOR 인덱스변수 IN [REVERSE] START..END LOOP
--      반복실행문
-- END LOOP;
-- 0~5까지 루프 변수를 이용하여 반복문 실행

DECLARE

BEGIN
    FOR i IN 0..5 LOOP 
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
END;
/

-- 1~10까지의 합을 loop를 이용하여 계산, 결과를 s_val 이라는 변수에 담아
-- DBMS_OUTPUT.PUT_LINE 함수를 통해 화면에 출력

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
-- 0부터 5까지 WHILE 문을 이용하여 출력.
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
-- 자바의 dowhile 비슷?  
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








-- << CURSOR >>  : SQL을 개발자가 제어할 수 있는 객체.
-- 묵시적 : 개발자가 별도의 커서명을 기술하지 않은 형태, ORACLE에서 자동으로 OPEN, 실행, FETCH, CLOSE 를 관리한다.
-- 명시적 : 개발자가 이름을 붙인 커서. 개발자가 직접 제어하며
--           선언, OPEN, FETCH, CLOSE 단계가 존재.
-- CURSOR 커서이름 IS --커서 선언.
--    QUERY;
--OPEN 커서이름; -- 커서 OPEN
--FETCH 커서이름 INTO 변수1, 변수2.....-- 커서 FETCH(행 인출)
-- CLOSE 커서이름; --  커서 CLOSE

-- 부서테이블의 모든 행의 부서이름, 위치 지역 정보를 출력 ( cursor 를 이용)
DECLARE
--커서 선언!
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

--위를 ,loop로 모두 나오게 해보자.
DECLARE
--커서 선언!
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




































