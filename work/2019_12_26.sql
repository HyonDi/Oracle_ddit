-- << EXEPTION >>
-- 에러 발생시 프로그램을 종료시키지 않고
-- 해당 예외에 대해 다른 로직을 실행 시킬 수 있게끔 처리한다.

-- 예외가 발생했는데 예외처리가 없는 경우 : pl/sql 블록이 에러와 함께 종료된다.
-- 여러건의 SELECT 결과가 존재하는 상황에서 스칼라변수에 값을 넣는 상황

-- emp 테이블에서 사원 이름을 조회
SET SERVEROUTPUT ON;
DECLARE
    -- 사원 이름을 저장할 수 있는 변수
    v_ename emp.ename%TYPE;
BEGIN
    -- 14건의 SELECT 결과가 나오는 sql --> 스칼라 변수에 저장이 불가하다.(에러)
    SELECT ename
    INTO v_ename
    FROM emp;
    
EXCEPTION
--    WHEN TOO_MANY_ROWS THEN
--        DBMS_OUTPUT.PUT_LINE('여러건의 SELECT 결과가 존재');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('WHEN OTHERS');
END;
/

-- 사용자 정의 예외
-- 오라클에서 사전에 정의한 예외 이외에도 개발자가 해당 사이트에서 비지니스 로직으로
-- 정의한 예외를 생성, 사용할 수 있다.
-- 예를 들어 SELECT 결과가 없는 상황에서 오라클에서는 NO_DATA_FOUND 예외를 던지면
-- 해당 예외를 잡아 NO_EMP라는 개발자가 정의한 예외로 재정의 하여 예외를 던질 수 있다.

--체크드익셉션을 트라이캐치로해서 ... 쓰로우..한대..

DECLARE
     -- emp 테이블 조회 결과가 없을 때 사용할 사용자 정의 예외
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
        RAISE no_emp; --java throw new NoEmpException() 와 같다.
        
    END;
EXCEPTION
    WHEN no_emp THEN
        DBMS_OUTPUT.PUT_LINE('NO_EMP');
END;
/

--  << 함수 >>
-- 사번을 입력받아서 해당 직원의 이름을 리턴하는 함수
-- getEmpName(7369) --> SMITH

CREATE OR REPLACE FUNCTION getEmpName (p_empno emp.empno%TYPE)
RETURN VARCHAR2 IS
--선언부
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

--실습 1
--부서번호를 파라미터로 입력받고 해당 부서 이름을 리턴하는 함수 getdeptname
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

-- cache : 디폴트 20개
-- 데이터 분포도 : 데이터가 얼마나 퍼져있는지. 
-- deptno : 중복발생 가능. = 분포도가 좋지 못하다. 
-- empno : 중복이 없다. = 분포도가 좋다.

-- emp 테이블의 데이터가 100만건인 경우
-- 100건중 deptno의 종류는 4건(10~40)
SELECT getdeptname(deptno), -- 4가지
        getempname(empno) -- row 수만큼 데이터가 존재
FROM emp;
-- 함수는 분포도가 좋지 못한경우 함수를 쓰는게 좋다.
-- 분포도가 좋은 경우에는 조인이 더 좋을 수 있다.
--성별같은거 할 때에 함수가 유리. 

-- 실습2
SELECT deptcd, LPAD(' ',(LEVEL-1)*4,' ') || deptnm deptnm
FROM dept_h
START WITH p_deptcd IS NULL
CONNECT BY PRIOR deptcd = p_deptcd;

--레벨이랑 부서명만 받아서 해봅니다.
CREATE OR REPLACE FUNCTION indent(p_lv NUMBER, p_dname VARCHAR2)
RETURN VARCHAR2 IS
    v_dname VARCHAR2(200);
BEGIN
--     SELECT LPAD(' ',(p_lv-1)*4,' ') || p_dname
--     INTO v_dname
--     FROM dual;
--     RETURN v_dname;
--혹은
--    v_dname := LPAD(' ',(p_lv-1)*4,' ') || p_dname;
--    RETURN v_dname;
--혹은     
     RETURN LPAD(' ',(p_lv-1)*4,' ') || p_dname;
END;
/

SELECT deptcd, indent(LEVEL, deptnm) deptnm
FROM dept_h
START WITH p_deptcd IS NULL
CONNECT BY PRIOR deptcd = p_deptcd;


-- << 패키지 >>
-- 비슷한 기능들의 함수, 프로시져 등등 들을 모아놓은 것.
-- 인터페이스(선언부)와 클래스(구현부) 로 나누어놓은것과 비슷함.


-- << trigger >>
SELECT *
FROM users;

--users 테이블의 비밀번호컬럼이 변경이 생겼을 때
-- 기존에 사용하던 비밀번호 컬럼 이력을 관리하기 위한 테이븜.
CREATE TABLE users_history(
--    his_seq 를 넣어도됨
    userid  VARCHAR2(20),
    pass VARCHAR2(100),
    mod_dt date
);

CREATE OR REPLACE TRIGGER make_history
    -- timing
    BEFORE UPDATE ON users
    FOR EACH ROW --행트리거. 행의 변경이 있을 때 마다 실행한다.
    -- 현재 데이터 참조 : :OLD
    -- 갱신 데이터 참조 : :NEW
    BEGIN
    -- users 테이블의 pass 컬럼을 변경할 때 trigger 실행.
        IF :OLD.pass != :NEW.pass THEN
            INSERT INTO users_history
                VALUES (:OLD.userid, :OLD.pass,sysdate);
        END IF;
        
        --다른 컬럼에 대해서는 무시한다.
    END;
    /
    
--users 테이블의 pass 컬럼을 변경 했을 때
-- trigger 에 의해서 users_history 테이블에 이력이 생성되는지 확인.
SELECT *
FROM users_history;

UPDATE users SET pass = '123456'
WHERE userid = 'brown';

SELECT *
FROM users_history;

-- trigger 시스템이 운영되기 전에 개발하는 사람이 좋아합니다.

--식별자 : 누가, 언제, 뭐를??

게시판
        - 게시판 아이디(게시판 번호) : 오라클 시퀀스, 게시판이름, 활성화/비활성화, 등록자, 등록일시
게시글
        - 게시글 번호 : 오라클시퀀스, 게시글제목, 게시글 내용, 삭제구분, 작성자, 작성일시
            첨부파일 5개까지
            -첨부파일명
댓글     -500자-> 한글 1글자가 3바이트. 1500바이트
        - 댓글번호 : 오라클 시퀀스, 댓글내용, 작성자, 작성일시







exerd 만들 때 dhfkzmf 9i~12c 로 dbms 수정!

