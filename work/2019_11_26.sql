--날짜관련 함수
--ROUND, TRUNC
--(MONTHS_BETWEEN) ADD_MONTHS, NEXT_DAY
--LAST_DAY : 해당 날짜가 속한 월의 마지막 일자(DATE)

--월 : 1,3,5,7,8,10,12 : 31일
--   : 2 - 윤년 여부 28,29
--   : 4,6,9,11 : 30일
--이지만 라스트데이를 통해 쉽게 마지막날짜를 구할 수 있따.
SELECT SYSDATE, LAST_DAY(SYSDATE)
FROM dual;

SELECT :yyyymm PARAM, TO_CHAR(LAST_DAY (TO_DATE (:yyyymm,'yyyymm')), 'DD') DT
FROM dual;
--바인드변수(툴마다 방식이 다름.) 여기(오라클sqpl)서는 :yyyymm 으로 하면 된다.

--SYSDATE 를 yyyy/mm/dd 포맷의 문자열로 변경.
--
SELECT TO_CHAR(TO_DATE(TO_CHAR(SYSDATE, 'yyyy-mm-dd HH24:MI:SS'), 'yyyy-mm-dd HH24:MI:SS'), 'YYYY-MM-DD HH24:MI:SS')
FROM dual;
--왜 시간이 00:00:00 이지?? 문자로 바꿀때에 시간이 잘려나갔었음. 그래서 안나옴!!
--처음 sysdate 를 챠로 바꿀때에 HH24:MI:SS 를 써서 시간정보를 가지고있게 해야한다.

SELECT TO_CHAR(sysdate,'yyyy-mm-dd hh24:MI:ss')
FROM dual;

SELECT TO_DATE(TO_CHAR(SYSDATE, 'yyyy-mm-dd'),'yyymmddhh') 
FROM dual;
--TO_DATE 로 표현되는거랑 TO_CHAR 로 표현되는걸 알아야할듯
--HH24:MI:SS  는 문자열에서만 되는건가?ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ
--------------------------------------------------------------------------------------------------------

--<<형변환>>
--명시적 형변환
--TO_NUMBER
--TO_DATE
--TO_CHAR

--묵시적 형변환
--VARCHAR2 or CHAR -> NUMBER
--CARCHAR2 or CHAR -> DATE
--NUMBER -> VARCHAR2
--DATE -> VARCHAR2
-- 묵시적 형변환이 일어나지 않도록 데이터 타입을 잘 적어야 한다.

--empno가 7369인 직원 정보 조회하기
SELECT *
FROM emp
WHERE empno =  '7369';
--여기서 자동적으로 형변환이 일어났음. 왜냐면 empno 의 값들은 NUMBER 타입인데 문자열 검색을 했는데도
--정상적으로 나오기 때문.
SELECT *
FROM emp
WHERE empno =  TO_NUMBER('7369');
--이렇게하면 문자열을 숫자로 형변환한거니까 되긴하는데 되는지 안되는지는 모름.
--EXPLAIN PLAN FOR  하는 키워드를 적어주면 어떻게 실행계획? 을 가진건지 알 수 있음.
--그 밑에는     SELECT *
--             FROM TABLE(dbms_xplan.display);    이걸 써야함.

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno =  TO_NUMBER('7369');

SELECT *
FROM TABLE(dbms_xplan.display);
--실행계획보기
--위에서 아래로 읽는다.
--자식모드가 있으면 자식모드부터 읽는다고?
--sqlde?시험목록중 하나래.

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE TO_CHAR(empno) = '7369';
SELECT *
FROM TABLE(dbms_xplan.display);

--
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7300 + '69' ;
SELECT *
FROM TABLE(dbms_xplan.display);

--
SELECT *
FROM emp
WHERE empno = 7300 + '69' ;

--
SELECT *
FROM emp
WHERE hiredate >= '1981/06/01';
--날짜 특히 조심해야해. DATE 타입의 묵시적 형변환은 사용을 권하지 않는다.
--우리가 사용하는 dbms 가 우리나라로 설정돼있어서 동작하긴 함.
--
SELECT *
FROM emp
WHERE hiredate >= TO_DATE ('1981/06/01', 'YY/MM/DD');
--YY -> 19
--RR --> 50 /19, 20 은 두자릿수의 연도를 봤을 때에 50이상이면 1900년대로, 50미만이면 2000년대로 본다.
--네자리수일때는 상관 없음.


--개발자 칠거지약?

--형변환 숫자--> 문자열, 문자--> 숫자
--많이 쓰이진 않아. db까지 안 오고 어플리케이션레벨에서제어해주는 것이 있기때문.
--국제화?굉장히 쉽게 로케일?
--숫자 : 1000000 --> 1,000,000.00 (얘는 문자래.. 뭐지)(이건 한국의 경우.)
-- 독일에서는 1.000.000,00 이라고함.

--날짜 포맷 - YYYY,MM,DD,HH24, MI, SS 가 있었음.
--숫자 포맷 - 숫자 표현 : 9, 자리 맞춤을 위한 0 표시 : 0, 화폐단위 : L
--              1000자리 구분 : , 소수점 : . 

--숫자를 문자열로 바꿀 때 : TO_CHAR(숫자, '포맷')
--숫자 포맷이 길어질 경우 숫자 자리수를 충분히 표현해야 한다.
SELECT empno, ename, sal,TO_CHAR (sal,'9,999L') fm_sal
FROM emp;

SELECT TO_CHAR(10000000000000, '999,999,999,999,999,999')
FROM dual;
--큰 숫자의 경우 9 를 많이 써줘야해.



--NULL 처리 함수 : NVL, NVL2, NULLIF, COALESCE

--NVL(expr1, expr2) : 함수 인자 두개임.
--expr1 이 NULL 이면 expr2 를 반환.
--expr1 이 NULL 이 아니면 expr1 을 반환.
--NULL일 때에 대체할 값을 인자로 가지고 있는 것.
SELECT empno, ename, comm, NVL(comm, -1) nvl_comm
FROM emp;

--NVL2(expr1, expr2, expr3)
--expr1 IS NOT NULL expr2 리턴
--expr1 IS NULL expr3 리턴
--이거는 expr1 을 리턴하지 못함.
SELECT empno, ename, comm, NVL2 (comm, comm, -1) nv2_comm
FROM emp;
--이렇게하면 NVL 이랑 같은 결과.

--NULLIF(expr1, expr2)
--expr1 = expr2     NULL 리턴.
--expr1 != expr2    expr1을 리턴.

--NULL 값을 만들고 있다.
--comm 이 NULL 일때 comm+500 : NULL 
--NULLIF(NULL,NULL) : NULL
--comm 이 NULL 이 아닐 때 comm+500 : comm +500
--NULL IF(comm, comm+500) : comm

SELECT empno, ename, comm, NULLIF(comm, comm + 500) NULLIF_comm
FROM emp;

--COALESCE(expr1, expr2, expr3.....)
--인자 중에 첫번째로 등장하는 NULL이 아닌 expr N을 리턴.
--expr1 IS NOT NULL     expr1 을 리턴.
--expr1 IS NULL COALESECE (expr2, expr3.....) 중에 널이 아닌 첫번째 값을 리턴.
--



SELECT empno, ename, comm, sal, COALESCE(comm, sal) coal_sal
FROM emp;

--실숩 fn
SELECT empno, ename, mgr, NVL(mgr, 9999) mgr_n, 
        NVL2(mgr, mgr, 9999) mgr_n_1,
        COALESCE(mgr, 9999) mgr_n_2
FROM emp;
--전자정부과정? 뒤에배우는게 좀더 나아? 잊어버리지 마렴. 수업이후에도 선생님 찾아가렴.
--정리!

--실습 fn 5
SELECT userid, usernm, reg_dt,NVL(reg_dt, SYSDATE) n_reg_dt
FROM users
WHERE userid NOT IN('brown');


--Condition
--1. case 2. decode

--1. case
--case 로 시작해서 end 로 끝남.
--when 절이 가운데에 들어감. 여러번 쓸 수 있음.
--디폴트 : else 
--emp.job 컬럼 기준으로 'SALESMAN'이면 sal 에 *1.05 값 리턴하라.
--'MANAGER' 면 sal 에 * 1.10
--'PRESIDENT' 이면 *1.20 리턴.
--empno, ename, job, sal 도 같이.
--위 세 직군이 아닐 경우 sal 리턴.
--AS bonus

SELECT empno, ename, job, sal,
        CASE
            WHEN job = 'SALESMAN' THEN sal * 1.05
            WHEN job = 'MANAGER' THEN sal * 1.10
            WHEN job = 'PRESIDENT' THEN sal * 1.20
            ELSE sal
        END bonus,
        comm,
        --NULL 처리 함수 사용하지 않고 CASE 절을 이용하여
        --comm이 NULL일 경우 -10을 리턴하도록 구성해라.
        CASE
            WHEN comm IS NULL THEN -10 
            ELSE comm
        END case_null
        
FROM emp;
--case 문의 단점? sql 같지 않다. 로직이 있다.


--2. decode
--decode(기준값, 서치1, 리턴1, 서치2, 리턴2.....마지막에 디폴트)

--if 문으로 바꾸면?
--피피티참조


SELECT empno, ename, sal, job,
    DECODE(job, 'SALESMAN', sal*1.05), 'MANAGER', sal*1.10, 'PRESIDENT', sal*1.20, sal) bonus
FROM emp;
--decode 는 사실 한줄에 많이 쓴다.

--숙제 con 144p, 145p. 1번, 2번.
--14번
SELECT empno, ename, deptno,
    CASE
        WHEN deptno = 10 THEN 'ACCOUNTING'
        WHEN deptno = 20 THEN 'RESEARCH'
        WHEN deptno = 30 THEN 'SALES'
        WHEN deptno = 40 THEN 'OPERATIONS'
        ELSE 'DDIT'
    END DNAME
FROM emp;

--con1
--CASE
-- WHEN conditon THEN return1
--END
--DECODE(col1|expr, serch1, return1, sheach2, return2.....default)


--con2. 건강보험검진 대상자인지 조회하는 쿼리를 작성하세요.
--올해 년도가 짝수/ 홀수년 인지
--hiredate 에서 입사년도가 짝수/ 홀수인지

--1. MOD(TO_CHAR (SYSDATE, 'YYYY')), 2) --> 올해년도 구분(0이면 짝수년, 1이면 홀순년)
--2. MOD(TO_CHAR(hiredatr, 'YYYY')), 2)--> hiredate의 년도 구분.

SELECT empno, ename, hiredate ,
       TO_NUMBER( TO_CHAR(hiredate, 'YY')) yy1,
       TO_NUMBER( TO_CHAR(SYSDATE, 'YY')) yy2,
-- TO_CHAR(sysdate, 'YY')+TO_CHAR(hiredate, 'YY') yy3,        
-- DECODE(MOD(TO_CHAR(sysdate,'YYYY')-TO_CHAR(hiredate,'YYYY'),2 ),0 ,'검진대상자',1,'검진비대상자'),
        CASE
            WHEN MOD(TO_NUMBER( TO_CHAR(hiredate, 'YY')), 2) 
            = MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YY')),2) THEN '건강검진 대상자'
             ELSE '건강검진 비대상자'
        END contact_to_doctor
FROM emp;




--        DECODE(컬럼명,값1,값2)
--------------------------------
SELECT empno, ename,
CASE
    WHEN MOD(TO_CHAR (SYSDATE, 'YYYY'), 2) = MOD(TO_CHAR(hiredate, 'YYYY'), 2) 
    THEN '건강검진 대상자' 
    ELSE '건강검진 비대상자'
END
FROM emp;

--내년도 건강검진 대상자를 조회하는 쿼리 작성해라. (2020년)
SELECT empno, ename,
CASE
    WHEN MOD(TO_CHAR(hiredate, 'YYYY'),2) = MOD(2020,2)--NOD(TO_CHAR(SYSDATE, 'YYYY')+1, 2) 이게 유지보수 가장 좋음.
    THEN '건강검진 대상자'
    ELSE '건강검진 비대상자'
END
FROM emp;

--코드를 바꾸지않아도 올바르게 작동하도록 코드를 작성해야한다.

--실습 cond3


SELECT userid, usernm, alias, reg_dt,
    CASE
        WHEN MOD(TO_CHAR(reg_dt,'YYYY'),2) = MOD(TO_CHAR(SYSDATE,'YYYY'),2)
        THEN '건강검진 대상자'
        ELSE '건강검진 비대상자'
    END CONTACTTODOCTOR
FROM users;
------------------------------------------------------------------------------------------------
SELECT a.userid, a.usernm, a.alias, a.reg_dt,
        DECODE(mod(a.yyyy,2), mod(a.this_yyyy,2),'건강검진대상', '건강검진비대상')
FROM
    (SELECT userid, usernm, alias, reg_dt, TO_CHAR(reg_dt, 'YYYY') yyyy,
        TO_CHAR(SYSDATE, 'YYYY') this_yyyy
        FROM users) a;
        --인라인뷰로 하심.





--TO_DATE 연산 불가.  TO_CHAR 는 숫자랄 연산하면 숫자로 바뀜.무조건!
---------------------------------------------------------------------------------------------------------
--버츄얼박스 : 가상화 도구.
--피씨안에 새로운 피씨를 만드는 것.
--1. 가져오기
--2. 가져올건  주황색 네모 4기가 파일..선생님이 주신 것. (=오라클 디벨로퍼 데이)
--3. 가져오기 누름.
--4. 설치되는데 조금 걸림.
--5. 더블클릭.
--6. 부팅이 되면 사용자 아이디, 비밀번호 모두 oracle 로 적는다.
--7. 관리자(미리보기 창 있고 한 곳.)에서 오라클디벨로퍼데이 우클릭> 
--설정> 네트워크> 에서 고급 > 포트 포워딩 >  게스트포트 숫자를 변경. 호스트 포트(=1522)보다 1 적게.(=1521)
--잘못된 설정이라고 뜰 때 :

--8. 시스템에 하드웨어 가상화 체크 뺀다. 위에꺼. (전원을 끄고 해야한다.
--9. 버츄얼박스.org 홈페이지 접속.> 다운로드 버츄얼박스(초록박스) 클릭.>
--아래칸 익스텐션 팩(Extension Pack 에서 All supported platforms 눌러서 20메가 짜리 파일을
--하나 다운로드 받는다.
--10. 파일> 환경설정에서 확장 이라는 버튼 누른다. 플러스 누르고 방금 다운받은거 선택해서 설치.
--

--오라클프로그램 켜고 접속 + 에 이름 : vm_scott, 이름 : scott, 비밀번호 : oracle,
--접속포트:  1022, SID :orcle    로 바꾸고 테스트->    
--(성공이 안 뜰 때에는 가상피씨가 켜져있는지 확인하자. 켜져있어야해.)
--가상피씨의 시스템 계정 만들고, 사용 시 : 붙여넣기할 내용 쓰고, 데이터파일 부분의 저장 위치 바꿈.
--접속, 생성권한에 PCXX 부분도 바꿔넣어야함.