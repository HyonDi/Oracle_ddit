--ROWNUM은 아직 읽지 않은 데이터는 조회 불가능!!
/*
카페에 남궁성씨 자바공부하는방법?

*/
--emp 테이블에서 empo, ename 을 정렬없이 로우넘이 1~10인 행만 조회.
SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 1 AND 10;


--11~14인 행만 조회

SELECT ROWNUM, b.*  --*이 셀렉트에 나왔을 때에, 앞에 콤마가 올 수 없음. 
FROM
(SELECT ROWNUM a, empno, ename
FROM emp
) b
WHERE a BETWEEN 11 AND 14;


--emp 테이블의 사원 정보를 이름컬럼으로 오름차순 정용했을 때의
--11~14번째 행을 다음과 같이 조회하는 쿼리를 작성해보세요.

SELECT ROWNUM,  c.*
FROM
(SELECT ROWNUM b, a.*
FROM
(SELECT *
FROM emp
ORDER BY ename)a) c
WHERE b BETWEEN 11 AND 14; 



/*
함수 : function
single row function :
단일 행을 기준으로 작업하고, 행당 하나의 결과를 반환.
특정 컬럼의 문자열 길이 : length(ename)

multi row function : 
여러 행을 기준으로 작업하고, 하나의 결과를 반환. 그룹함수 : count, sum, avg


 -character
 대소문자
 LOWER, UPPER, INITCAP(첫단어만 대문자로.)
 문자열 조작
CONCAT, SUBSTR(문자열에서 일부분 추출), LENGTH
INSTR(문자열에 특정 문자열이 들어있는지(해당 문자열의 인덱스 반환), LPAD(문자열 왼쪽, 오른쪽에 특정 문자열 삽입),
RPAD, TRIM(문자열 앞뒤로 공백,혹은 특정문자 제거, REPLACE

-DUAL table
sys 계정에 있는 테이블. 누구나 사용 가능. DUMMY 컬럼 하나만 존재하며 값은 'X' 이며 데이터는 한 행만 존재.
사용 용도 : 데이터와 관련없이 함수실행, 시퀀스 실행
merge 문에서, 데이터 복제시
*/

SELECT *
FROM dual;
--SINGLE ROW FUNCTION : 행당 한번의 FUNCTION이 실행.
--1개의 행이 INPUT --> 1개의 행으로 OUTPUT (COLUMN)
--'Hello, World'
SELECT LOWER ('Hello, World') low, UPPER ('Hello, World') upper,
    INITCAP ('Hello, World') init
FROM dual;


--emp테이블에는 총 14건의 데이터(직원)가 존재.(14개의 행)
--따라서 14개의 열이 나온다. 행당 한번씩 실행이 됐다.
SELECT LOWER ('Hello, World') low, UPPER ('Hello, World') upper,
    INITCAP ('Hello, World') init
FROM emp;

--컬럼에 function 적용.
SELECT empno, LOWER (ename) low_enm
FROM emp;

--직원 이름이 smith인 사람을 조회하려면 대문자/소문자?
--대문자. 왜냐면 셀렉할때에만 함수 lower 를 적용시켜 보여지기에는 소문자지만,
--실제 등록돼있는 데이터는 대문자다. 바뀐것이 아님.
SELECT empno, LOWER (ename) low_enm
FROM emp
WHERE ename = 'SMITH' ;

--함수는 where절에서도 사용 가능하다.
SELECT empno, LOWER (ename) low_enm
FROM emp
WHERE ename = UPPER ('smith') ;

--함수를 테이블에 적용했다. 이건 쓰면 안되는 방식이래. 왜?
--좌변을 가공하면 안된다. 가공하지말고 치환시켜 변수부분을 가공해라.
--인덱스 활용이 안된다. 실제 테이블의 원본을 가공해줘야 결과가 나오는데,
--소문자로 만드려면 그 테이블을 전체 다 읽어야해. ...
--테이블 컬럼을 가공해도 동일한 결과를 얻을 수 있지만, 테이블 컬럼보다는 상수쪽을 가공하는 것이 속도면에서 유리.
--해당 컬럼에 인덱스가 존재하더라도 함수를 적용하게 되면 값이 달라지게 되어
--인덱스를 활용 할 수 없게 된다.
-- 예외 : FBI (Function Based Index)
SELECT empno, LOWER (ename) low_enm
FROM emp
WHERE LOWER(ename) = 'smith' ;

--집합적!!!!

--ppt 99p

--HELLO
-- ,
--WORLD
--HELLO, WORLD (위 세가지 문자열 상수릉 이용, CONCAT 함수를 사용하여 문자열 결합
SELECT CONCAT (CONCAT ('HELLO', ', '), 'WORLD'),
        'HELLO' || ', ' || 'WORLD',
        SUBSTR ('HELLO, WORLD', 1, 5)--SUBSTR(문자열, 시작인덱스, 종료인덱스.)
        --시작인덱스는 1부터, 종료인덱스 문자열까지 포함한다.
        --자바에서는 또다름. 0부터 시작, 종료인덱스 문자열 미포함.
FROM dual;


--INSTR : 문자열에 특정 문자열이 존재하는지, 존재할 경우 문자의 인덱스를 리턴.
SELECT INSTR('HELLO, WORLD','O')
FROM dual;

--문자열의 특정 인덱스 이후부터 검색하도록 옵션.
SELECT INSTR('HELLO, WORLD','O', 6)
FROM dual;   --'HELLO, WORLD' 문자열의 6번째 인덱스 이후에 등항하는 'O'문자열의 인덱스 리턴

--중첩해서 사용?
SELECT INSTR('HELLO, WORLD', 'O',INSTR('HELLO, WORLD','O') + 1)
FROM dual; 

--L/RPAD 특정문자열의 왼쪽/오른쪽에 설정한 문자열 길이보다 부족한 만큼 문자열을 채워 넣는다.
SELECT
LPAD ('HELLO, WORLD', 15, '*')L1,
RPAD ('HELLO, WORLD', 15, '*')R1,
LPAD ('HELLO, WORLD', 15)L2 --DEFAULT 채움 문자는 공백이다.
FROM dual;

--REPLACE (대상 문자열, 검색문자열, 변경할 문자열)
--대상문자열에서 검색 문자열을 변경할 문자열로 치환.
SELECT 
REPLACE('HELLO, WORLD', 'HELLO', 'hello') rep1
FROM dual;


--TRIM : 문자열 앞, 뒤의 공백을 제거.
SELECT
'   HELLO, WORLD   ' before_trim,
TRIM ('   HELLO, WORLD   ') after_trim,
TRIM ('H' FROM 'HELLO, WORLD') after_trim2
FROM dept;

--숫자 조작 함수
--ROUND : 반올림. ROUND (숫자, 반올림 자리)
--TRUNC : 졸석 - TRUNC (숫자, 절삭자리)
--MOD : 나머지 연산 MOD (피제수, 제수) ex) MOD (5, 2) : 1.  
SELECT ROUND(105.54, 1) R1, --반올림 결과가 소수점 한자리까지 나오도록(소수점 둘째자리에서 반올림)
        ROUND(10.55, 1) R2,
        ROUND(10.55, 0) R3, --소수점 첫번재 자리에서 반올림.
        ROUND(105.54, -1) R4 --정수 첫번째 자리에서 반올림.        
FROM dual;
--잘 생각나지 않는 부분 듀얼테이블 만들고 생각해보자.

--TRUNC
SELECT TRUNC(105.54, 1) R1, --절삭 결과가 소수점 한자리까지 나오도록(소수점 둘째자리에서 절삭)
        TRUNC(105.55, 1) R2,
        TRUNC(105.55, 0) R3, --소수점 첫번재 자리에서 절살.
        TRUNC(105.54, -1) R4 --정수 첫번째 자리에서 절삭. (절삭 = 내림인듯)       
FROM dual;

--MOD (피제수, 제수) 피제수를 제수로 나눈 나머지 값.
--MOD(M,2) 의 결과 종류 : (0),(1) : (0 ~ (제수-1) 개의 결과 종류가 있다.)

SELECT MOD (5, 2) M1, --5/2 = 몫이 2,[ 나머지가 1.]
        MOD (142,23) M2
FROM dual;

--emp 테이블의 sal 컬럼을 1000으로 나눴을 때 사원별 나머지 값을 조회하는 sql 작성
--ename, sal, sal/1000 을 때의 몫, sal/1000을 때의 나머지.

SELECT ename, sal, TRUNC(sal/1000, 0), MOD(sal, 1000) sal1,
    TRUNC(sal/1000, 0) * 1000 + MOD(sal, 1000) sal2
FROM emp;
--??????????


--날짜. DATE : 년월일, 시간, 분, 초 
SELECT ename, TO_CHAR(hiredate, 'YYYY/MM/DD hh24-mi:ss')--yyyy/mm/dd
FROM emp;
--도구-환경설정-데이터베이스-NLS : 날짜에대한 기본설정을 바꿀 수 있다.


--SYSDATE : 서버의 현재 DATE를 리턴하는 내장함수, 특별한 인자가 없다.
--날짜연산 : DATE +/- 정수 : 정수만큼 DATE에 N일자칸큼 더한다.
--시간 연산 : DATE +/- (정수/24)
SELECT TO_CHAR(SYSDATE,'YYYY-MM_DD hh24:mi:ss')
FROM dual;
--SYSDATE 가 데이트타입. 정수 = 일자.
SELECT  TO_CHAR(SYSDATE,'YYYY-MM_DD hh24:mi:ss') NOW,
        TO_CHAR(SYSDATE + 5,'YYYY-MM_DD hh24:mi:ss') AFTER5_DAYS,
        TO_CHAR(SYSDATE + 5/24,'YYYY-MM_DD hh24:mi:ss') AFTER5_HOURS,
        TO_CHAR(SYSDATE + 5/24/60,'YYYY-MM_DD hh24:mi:ss') AFTER5_MIN
FROM dual;
--숫자를 1~1조까지 말하는것보다 1조(1,000,000,000,000)를 버는게 더 빠르대
--1시간 = 3600초
--초당 하나씩만 말해도 3만년 걸린대 헥


--date 실습 fn1
--1. 2019년 12월 31일을 date형으로 표현
SELECT TO_DATE('2019-12-31', 'yyyy-mm-dd')
FROM dual;
--2. 2019년 12월 31일을 date 형으로 표현하고 5일 이전날짜.
SELECT TO_DATE('2019-12-31', 'yyyy-mm-dd') - 5
FROM dual;
--3. 현재날짜
SELECT SYSDATE
FROM dual;
--4. 현재날짜에서 3일전 값.
SELECT SYSDATE-3
FROM dual;
--1,2,3,4 묶음
SELECT TO_DATE('2019-12-31', 'yyyy-mm-dd') LASTDAY, 
        TO_DATE('2019-12-31', 'yyyy-mm-dd') - 5 LASTDAY_BEFORE5, 
        SYSDATE NOW, SYSDATE-3 NOW_BEFORE3
FROM dual;



--형변환 DATE -> CHAR : TO_CHAR(DATE, '포맷')
--CHAR -> DATE : TO_DATE(날짜 문자열, '포맷')

--포맷
--YYYY, MM, DD, 
--D(요일을 숫자로 : 일요일 1, 월요일 2, 화요일 3...토요일 7)
--IW(주차 : 1~53) : 1년이 52주 혹은 53주 임. IM, HH, MI, SS

SELECT TO_CHAR(SYSDATE, 'YYYY') YY, --현재 연도.
        TO_CHAR(SYSDATE, 'MM') MM, --현재 월
        TO_CHAR(SYSDATE, 'DD') DD, --현재 일
        TO_CHAR(SYSDATE, 'D') D, --현재 요일(주간일자 1~7)
        TO_CHAR(SYSDATE, 'IW') IW, --현재 일자의 주차. (해당 주의 목요일을 주차의 기준으로.)
--2019년 12월 31일은 몇주차가 나오는가?
        TO_CHAR(TO_DATE('2019-12-31', 'yyyy-mm-dd'),'IW') IW_20191231
        -- 1주차 나옴. 이 주 목요일이 내년 첫째주이기 때문.
FROM dual;


--실습 fn2
--오늘날짜를 다음과 같은 포맷으로 조회하는 쿼리를 작성하시오.
--1. 년-월-일
--2. 년-월-일-시간(24)-분-초
--3. 일-월-년
SELECT TO_CHAR(SYSDATE, 'yyyy-mm-dd') DT_DASH,
        TO_CHAR (SYSDATE, 'yyyy-mm-dd hh24-mi-ss') DT_DASH_WITH_TIME,
        TO_CHAR (SYSDATE, 'dd-mm-yyyy') DT_DD_MM_YYYY
FROM dual;

--날짜 조작. date 타입의 ROUND, TRUNC 적용.
--ROUND(DATE, format)
--TRUNC(DATE, format)

--MM에서 반올림(11월 -> 1년)
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD hh24:mi:ss') now,
        --MM에서 반올림(11월 -> 1년)
        TO_CHAR(ROUND (SYSDATE, 'YYYY'),'YYYY-MM-DD hh24:mi:ss') NOW_YYYY,
        
        TO_CHAR(TRUNC(SYSDATE, 'MM'), 'yyyy-mm-dd hh24:mi:ss') NOW_MM,
         TO_CHAR(TRUNC(SYSDATE, 'DD'), 'yyyy-mm-dd hh24:mi:ss') NOW_DD
        --절삭도 마찬가지.

FROM dual;
-- ppt 116p



--날짜조작함수
--MONTHS_BETWEEN (date1, date2) : date1와 date 2사이의 개월 수.
--ADD_MONTHS(date,가감할 개월수) : date에서 특정 개월수를 더하거나 뺀 남짜.
--NEXT_DAY(date, weekday(1~7) : dqte 이후 첫 번째 위클리 날짜
--LEST_DAY(date) : date가 속한 월의 마지막 날짜

--ㅡMONTHS_BETWEEN(date1, date2)
SELECT MONTHS_BETWEEN(TO_DATE('2019-11-25','yyyy-mm-dd'),
       TO_DATE('2019-3-31','yyyy-mm-dd')) m_bet,
    TO_DATE('2019-11-25','YYYY-MM-DD') - 
    TO_DATE('2019-03-241','yyyy-mm-dd')d_m --두 날짜 사이의 일자수.
FROM dual;


--ADD_MONTHS(date, number(+, - ))
SELECT ADD_MONTHS(TO_DATE('20191125', 'yyyymmdd'), 5) NOW_AFTER5M,
     ADD_MONTHS(TO_DATE('20191125', 'yyyymmdd'), -5) NOW_BEFORE5M,
        SYSDATE +100 --100일 뒤의 날짜(월 개념 3-31, 2-28,29)
FROM dual;

SELECT--nextday, lastday 등을 한 듯 함.
FROM dual;
--?????????????????
































