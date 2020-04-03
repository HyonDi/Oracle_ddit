-- 객체이름 30자 이내, 무조건 알파벳시작, 알파벳, 숫자, _,$ 
-- 객체이름은 무조건 대문자로 저장됨. 

--ppt 60p 실습 where8 emp 테이블 부서번호 10아니고 
--입사날짜 이후인 직원 정보 조회.
SELECT *
FROM emp
WHERE deptno != 10
AND hiredate > To_DATE('19810601','yyyymmdd');

--NOT IN 사용
SELECT *
FROM emp
WHERE deptno NOT IN (10)
AND hiredate > TO_DATE('19810601','yyyymmdd');

-- 실습 where 10
--NOT IN 사용X, IN사용. deptno sms 10,20,30 밖에 없다고 가정.
SELECT *
FROM emp
WHERE deptno IN (20, 30)
AND hiredate > TO_DATE('19810601','yyyymmdd');

-- 실습 where 11
--job 이 SALESMAN 이거나  입사날짜 ---이후 조회.
SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR hiredate > TO_DATE('19810601','yyyymmdd');

--실습 where 12
SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR empno LIKE '78%';

--실습 where 13
--전제조건  :  empno 가 숫자여야한다. desk 로 타입을 ..
--desk 검색해보면 empno가 number-> 숫자유형 (4) -> 4글자로 이루어져있음을 알 수 있다.

SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR empno > 7800 
AND empno < 7900 ;
--||보다 && 이 우선순위 높음!

-- *dbms 가 오라클을 받으면 읽기편하게 바꾸는데 이 과정에서 LIKE연산자사용 후 % 나 _가 안써있으면
-- 범위로 분석할필요가 없어서 = 으로 생각한대. 신기한게 많다.


--<<연산자 우선순위!>>
--1, 산술연산자(*, /, +, -)
--2. 문자열 결합(||)
--3. 비교연산(=, <=, <, >=, >)
--4. IS, [NOT]NULL, LIKE, [NOT] IN
--5. [NOT] BETWEEN
--6. NOT
--7. AND
--8. OR
--일반 수학과 마찬가지로 괄호를 통해 우선순위를 변경할 수 있다.

--연산자 우선순위 (AND > OR)
--직원 이름이 SMITH 이거나, 직원 이름이 ALLEN이면서 역할이 SALESMAN 인 직원 찾기.
SELECT *
From emp
WHERE ename = 'SMITH'
OR ename = 'ALLEN'
AND job = 'SALESMAN';
--연산자 우선순위로 AND 부분이 먼저 실행 된 후 OR가 될테이 헷갈리지않게 바꿔보자
SELECT *
From emp
WHERE ename = 'SMITH'
OR (ename = 'ALLEN' AND job = 'SALESMAN');
--괄호로 묶어 헷갈리지 않게함.


--직원 이름이 SMITH 이거나 ALLEN 이면서 역할이 SALESMAN인 사람
SELECT *
From emp
WHERE (ename = 'ALLEN' OR ename = 'SMITH')
AND job = 'SALESMAN';--???????????다 못봤땅

--where 14
--job 이 SALESMAN 이거나 사원번호가 78로 시작하면서, 입사일자가 1981년 6월 1일 이후.
SELECT *
FROM emp
WHERE job ='SALESMAN'
OR empno LIKE '78%'
AND hiredate > TO_DATE('19810601','yyyy.mm.dd');

--데이터정렬
--TABLE 객체에는 데이터를 저장/조회시 순서를 보장하지 않는다.
--보편적으로 데이터가 입력된 순서대로 조회됨.
--데이터가 항상 동일한 순서로 조회되는 것을 보장하지 않음.

--ORDER BY
--ASC : 오름차순 (기본) = 작은값부터 점점올라가는 형태. (표기안할 경우의 기본값임.)
--DESC : 내림차순 = 큰값부터. 점점 내려가는 형태. (내림차순으로 값을 얻고싶다면, 반드시 표기해야한다.)

--ORDER BY {정렬기준 컬럼 OR 컬럼번호}[ASC OR DESC]....
--ORDER BY ename
--ORDER BY enam desc
--ORDER by ename desc, mgr
/*
SELECT col1, col2, col3...
FROM 테이블명
WHERE col1 = '값'
ORDER BY 정렬기준 컬럼1, [ASC / DESK], 정렬기준컬럼2...[ASC / DESK]
*/

--사원테이블(emp) 에서 직원의 정보를 직원 이름으로 오름차순 정렬하라.
SELECT *
FROM emp
ORDER BY ename ASC; --정렬기준을 작성하지 않을 경우 오름차순 적용.

--사원테이블에서 직원의 정보를 직원 이름(ename) 으로 내림차순 정렬.
SELECT *
FROM emp
ORDER BY ename DESC;

--사원 테이블에서 직원의 정보를 부서번호로 오름차순 정렬하고, 
--부서번호가 같을때는 sal 내림차순 정렬하라.
SELECT *
FROM emp
ORDER BY deptno, sal DESC ;

--사원 테이블에서 직원의 정보를 부서번호로 오름차순 정렬하고, 
--부서번호가 같을때는 sal 내림차순, 급여가 같을때는 이름으로 오름차순정렬하라.
SELECT *
FROM emp
ORDER BY deptno, sal DESC, ename ;

--정렬 컬럼을 ALIAS로 표현
SELECT deptno, sal, ename nm
FROM emp
ORDER BY nm;

--조회하는 컬럼의 위치 인덱스로 표현 가능.
SELECT empno, deptno, sal, ename nm
FROM emp
ORDER BY 3; --추천하지않음. 해당쿼리가 수정되지 않는다는 전재조건하에는 사용 괜찮음.
--컬럼 수정시 의도하지 않은 결과 출력.


--실습 orderby1

DESC dept;

SELECT *
FROM dept
ORDER BY dname;

SELECT *
FROM dept
ORDER BY loc DESC;

--실습 orderby2
--emp테이블에서 상여comm정보가 있는사람들 조회 후,
--상여 많이 받는 사람이 먼저 조회되도록하고, 상여가 같을 경우 사번으로 오름차순.
--상여 0인사람은 없는것으로 간주함.
DESC emp;
SELECT *
FROM emp
WHERE comm IS NOT NULL 
AND comm !=0
ORDER BY comm DESC, empno;

--orderby 3
--emp 테이블에서 관리자가 있는 사람들만 조회,
--job 순으로 오름차순 정렬, 직업이 같을 경우 사번이 큰 사원이 먼저 조회.
SELECT *
FROM emp
WHERE mgr IS NOT NULL
ORDER BY job, empno desc;

--order by 4
--emp 테이블에서 10번 부서 혹은 30번 부서 사람중 급여가 1500이 넘는 사람들만 조회.
--후 이름으로 내림차순 정렬.
SELECT *
FROM emp
WHERE deptno IN (10,30)
AND sal > 1500
ORDER BY ename desc;

--야호!
--**tool이제 제공해주는 행의 번호를 컬럼으로 갖을 수 없을까?
--SELECT query 에 조회된 순서대로 부여된 가상 숫자 컬럼.
SELECT ROWNUM, deptno, ename -- SELECT ROWNUM 가상의 컬럼. HIGHNUM 도 있남
FROM emp
ORDER BY deptno;
--정렬시킨 후 로우넘을 달아보자
SELECT ROWNUM, a.*
FROM
(SELECT deptno, ename
FROM emp
ORDER BY deptno) a;



--ROWNUM은 이미 읽은 데이터에 순서를 부여하는 것.
--아직 읽지 않은 데이터가 존재하는 조건에서는 사용 불가.

SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM = 1;
--ROWNUM = equal 비교는 1만 가능.2 안돼.
--다음과 같은 형태 가능
--WHERE ROWNUM =1;
--WHERE ROWNUM <= 2;
--WHERE ROWNUM < 4;
--BETWEEM 1 AND 10; //부터 시작만 가능하다.

SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 1 AND 5;
--1부터 시작하는 경우 가능.

--SELECT 절과 ORDER BY 구문의 실행 순서
--SELECT -> ROWNUM -> ORDER BY
SELECT ROWNUM, empno, ename
FROM emp
ORDER BY ename;

SELECT ROWNUM snum, a.*
FROM
(SELECT ROWNUM fnum, empno, ename
FROM emp
ORDER BY ename) a;


--INLINE VIEW를 통해 정렬을 먼저 실행하고, 해당 결과에 ROWNUM을 적용할 수 있다.

SELECT empno, ename
FROM emp
ORDER BY ename;
---------------------------------여기서 부터 이상함
SELECT ROWNUM, empno, ename
FROM (SELECT empno, ename
    FROM emp
    ORDER BY ename);
    
    emp_ord
    (SELECT empno, ename
    FROM emp
    ORDER BY ename);
  --가상테이블을 만든셈인듯. 

--*표현하고, 다른 컬럼 혹은 표현식을 썼을 경우 *앞에 테이블 명이나, 테이블 별칭을 적용해야한다.
SELECT ROWNUM, a.empno
FROM (SELECT empno, ename
    FROM emp
    ORDER BY ename) a;

--컬럼 뿐 아니라 테이블에도 별칭을 줄 수 있다. 테이블 뒤에 공백, 별칭 주면 된다.
SELECT ROWNUM, a.*  --empno, ename
FROM (SELECT empno, ename
    FROM emp
    ORDER BY ename) a ;
--괄호를 사용하는게 인라인 그건가봐    
    
SELECT empno, ename
FROM emp
ORDER BY ename;


--*를 지칭할 명사가 필요. 
SELECT ROWNUM, a.*
FROM emp e;b  ?????????????

--==================================================
SELECT *
FROM emp;

SELECT ROWNUM snum, a.* 
FROM
(SELECT ROWNUM fnum, empno, ename, sal
FROM emp
ORDER BY sal) a;
--컬럼?이라는게 테이블 속 저거 속 저건가?
--========================================================
--ROWNUM, 언제사용? : 페이징처리라는 기술이 있는데,
--네이버카페 게시판을 보면, 글들이 한번에 보여지지않고 15개씩 잘라서 보여준다.
--
--

--ROW1
--emp테이블에서 ROWNUM 값이 1~10인 값만 조회하는 쿼리를 작성해보세요.
--정렬없이 진행하세요, 결과는 화면과 다를 수 있습니다.
SELECT *
FROM emp;

SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM <= 12;


--row2
--rownum 값이 11~20(11~14)인 값만 조회하는 쿼리를 작성해보세요.
--힌트: inline view 를 사용해야한다.
SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 11 AND 20;--이거 못써. 1부터 순차적으로 해야만 가능.
------------------------------------------------------------------------------
--row2 풀이
SELECT ROWNUM, empno, ename
FROM emp;

SELECT a.*
FROM
(SELECT ROWNUM A , empno, ename
FROM emp) a
WHERE A BETWEEN 11 AND 20;
--안쪽에서 준 별칭을 바깥에서 실행하는것이 핵심이다.
--왜 별칭 안주면 안되는데?
--후오..모르겠다.

SELECT a.*
FROM
(SELECT ROWNUM sa, empno, ename
FROM emp) a
WHERE sa BETWEEN 11 AND 20;

SELECT ROWNUM sa, empno, ename
FROM emp
WHERE sa BETWEEN 11 AND 20;


--row3
--emp테이블에서 ename 으로 정렬한 결과에 11~14번째 행만 조회하는 쿼리를 작성해라.
SELECT f.*
FROM (SELECT ROWNUM qw, ename
        FROM emp) f
ORDER BY ename
WHERE qw BETWEEN 11 AND 14;   

--ROWNUM을 매기는 순서를 순서 정하고 불러오느냐, 불러오고 순서를 매기겠느냐의 차이 알기
--가상으로 만든 테이블 f(emp 테이블 속에서 로우넘, ename 만 뺀것) 을 


--문제! emp테이블에서 ename 으로 오름차순 정렬한 결과에 11~14번째 행만 조회하는 쿼리를 작성해라.
--1. emp테이블 사원 정보를 이름컬럼 오름차순으로 적용.
--2. 1번에 로우넘 적용.
--3. 2번에서 11~14번 뽑기.

SELECT a.*
FROM
(SELECT ROWNUM qw, ename
FROM emp
ORDER BY ename) a
WHERE qw BETWEEN 11 AND 20
ORDER BY qw;
--
SELECT;

SELECT ROWNUM , e.*
FROM
(SELECT ROWNUM w, ename
FROM emp
ORDER BY ename) e
WHERE w BETWEEN 11 AND 14;


--2.정렬 후 로우넘 매기도록 바꾸자

SELECT ROWNUM, ename
FROM;


SELECT a.*
FROM
(SELECT ROWNUM qw, empno, ename
FROM emp) a
WHERE qw BETWEEN 2 AND 14;

SELECT *FROM(
SELECT ROWNUM AS rn, a.*
FROM(
SELECT *
FROM
(SELECT empno, ename
FROM emp
ORDER BY qw) a
)b
WHERE b.rn BETWEEN 11 AND 14;
_








SELECT * FROM
( 
SELECT ROWNUM AS RNUM ,a.*
FROM (
SELECT *
FROM emp
order by ename
)a
)b
where b.rnum   BETWEEN 11 AND 14;








