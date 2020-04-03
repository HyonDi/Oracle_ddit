--hash 함수
SELECT *
FROM dept, emp
WHERE dept.deptno = emp.deptno;
--dept 먼저 읽는 형태.
-- join컬럼을 hash 함수로 돌려서 해당 해쉬 함수에 해당하는 bucket 에 데이터를 넣는다.
--값이 해쉬함수 (어떤 값이 들어가면 중복되지 않는 값으로 변환시키는 해쉬함수.)
--가 적용된 값을 bucket 데이터에 넣는다. 
-- 그리고 where 절에 작성된 조건에 맞는 데이터
-- 백단에서 볼 수 있는 형태. 1~2시간 걸리는 형태의 작업에서 보여진다.

--Sort merge join 이 실행계획에나오면 쿼리를 되게 못짠거래..ㅜㅠㅜㅠ
--힌트 : /*+인덱스명||힌트명*/
--오라클한테 이렇게이렇게 풀어조ㅛ. 하는거.

--전체범위 처리
SELECT COUNT(*)
FROM emp;
-->인덱스만있어도 결과를 낼 수 있음.
-- 없으면 전체 다 읽어보고 수를 세야함.

------------------------------------------------------------------------------------------------
--사원번호, 사원이름, 부서번호, 급여, 부서원의 전체 급여 합.
--WINDOWIMG!
SELECT empno, ename, deptno, sal,
        SUM(sal) OVER(ORDER BY sal 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum--가장 처음부터 현재행까지. 라는 범위를 줘야해.
FROM emp
ORDER BY sal;

--바로 이전행이랑 현재행까지의 급여합
SELECT empno, ename, deptno, sal,
        SUM(sal) OVER(ORDER BY sal 
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) c_sum--가장 처음부터 현재행까지. 라는 범위를 줘야해.
FROM emp
ORDER BY sal;

--이렇게써도 된다. 위위와 같음
SELECT empno, ename, deptno, sal,
        SUM(sal) OVER(ORDER BY sal 
        ROWS UNBOUNDED PRECEDING) c_sum
FROM emp
ORDER BY sal;

--실습7
SELECT empno, ename, deptno, sal,
    SUM(sal) OVER(PARTITION BY deptno ORDER BY sal, empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum
FROM emp;

--분석함수/윈도우함수  rows /range/no windowing
--rows 와 range 의 차이
SELECT empno, ename, deptno, sal,
        SUM(sal) OVER (ORDER BY sal ROWS UNBOUNDED PRECEDING) row_sum,
        SUM(sal) OVER (ORDER BY sal RANGE UNBOUNDED PRECEDING) row_sum,
        SUM(sal) OVER (ORDER BY sal) c_sum
FROM emp;
--windowing 은 집계함수쪽에서만 사용할 수 있다.
--orderby 절 뒤에 아무것도 적지 않을경우 오라클에서 디폴트로 RANGE UNBOUNDED PRECEDING 를 적어준다.

-- sal 값이 동일한 곳에서 다른 부분이 나온다.
-- RANGE 는 같은 값을 하나로 본다.
-- rows 는 범위지정이 명확하지만 range 는 같은 값을 가지면 
-- 같은거로보고 범위를 벗어난것까지 포함을 시킨다.(= 같은값을 가지는것까지 포함을 시킨다.)

-------------------------------------------------------------------------------------<<응용 sql 끝!>>
--pl/sql
--Procedueal Language/ sql structured query language
--오라클에서 제공하는 프로그래밍 언어.
--집합정 성향이 강한 sql에 일반 프로그래밍 언어요소를 추가했다. --데이터를 절차적으로 처리하는데 목적이있다.

--[declare (선언부)] : 변수를 선언하는 부분.
--Begin (실행부) : PL/SQL 의 로직이 들어가는 부분
--[Exeption (예외처리부)] : 옵션.예외처리

--!! plsql 에서는 변수가 등장한다. 대입연산자는:  :=
--변수선언은 DECLARE 선언부에서만 할 수있다. BRGIN 에서는 못해.

--set serveroutput ON; = 콘솔창에 출력기능 활성화.
--dbms.output.Put_line() = sysout 느낌.

 -- DBMS_OUTPUT.PUT.LINE 함수가 출력하는 결과를 화면에 부여주도록 활성화한다.
SET SERVEROUTPUT ON;
DECLARE --선언부
            -- java : 타입 변수명;
            --pl/sql : 변수명 타입;
--    v_dname VARCHAR2(14);
--    v_loc  VARCHAR2(13);
    --테이블 컬럼의 정의를 참조하여 데이터 타입을 선언한다.
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
BEGIN
    --DEPT 테이블에서 10번 부서의 부서이름, LOC 정보를 조회
    SELECT dname, loc
    INTO v_dname, v_loc --변수, 변수2
    FROM dept
    WHERE deptno = 10;
    
    DBMS_OUTPUT.PUT_LINE(v_dname || v_loc);
END;
/ 
--  / = PLSQL 블록을 실행하라는 뜻.

desc dept;

--레퍼런스타입!!
--10번 부서의 부서이름, 위치지역을 조회해서 변수에 담고 변수를 EBMS_OUTPUT.PUT_LINE함수를 이용해 CONSOLE에 출력
CREATE OR REPLACE PROCEDURE printdept IS 
--선언부(옵션)
    dname dept.dname%TYPE;
    loc dept.loc%TYPE;
    
--실행부
BEGIN
    SELECT dname, loc
    INTO dname, loc
    FROM dept
    WHERE deptno = 10;

    DBMS_OUTPUT.PUT_lINE(dname ||' '|| loc);
--예외처리부(옵션)
END;
/

exec printdept;


--
CREATE OR REPLACE PROCEDURE printdept 
--파라미터명 IN/OUT 타입
--파라미터를 선언할때는 대체로 p_ 로 시작한다. (안헷갈리게)
( p_deptno IN dept.deptno%TYPE )
IS 
--선언부(옵션)
    dname dept.dname%TYPE;
    loc dept.loc%TYPE;
    
--실행부
BEGIN
    SELECT dname, loc
    INTO dname, loc --한 행의 데이터 처리뿐이 못한다.
    FROM dept
    WHERE deptno = p_deptno;

    DBMS_OUTPUT.PUT_lINE(dname ||' '|| loc);
--예외처리부(옵션)
END;
/

exec printdept(50);

-- 실습 pro_1
CREATE OR REPLACE PROCEDURE printtemp 
( p_empno IN emp.empno%TYPE ) --파라미터 선언
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

--실습2
CREATE OR REPLACE PROCEDURE registdept_test
(p_deptno IN dept.deptno%TYPE, p_dname IN dept.dname%TYPE, p_loc IN dept.loc%TYPE)
IS
    v_deptno emp.deptno%TYPE;--레퍼런스타입!
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

--prodedure 랑 function 차이 : 리턴타입이 있나/없나(procedure 는 없음.)



--실습3
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

