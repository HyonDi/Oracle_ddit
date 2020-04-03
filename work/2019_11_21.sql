
/*
11/21
SQL

git source Tree -> 가 유명한데, 인증절차가 까다롭대
이클립스..이딧?

크라켄
-> 오픈 파일! work 누른다 (로컬저장소)

+ 버튼 누르면 커밋안한거 찾을 수 있음.
올렸다, 내렸다 할 수 있음. 
git cached - 로 지우던것

1. 깃헙에서 새 레파지토리 만들기
2. 크라켄에서 앧, 커밋, 푸시한다.
(우리 sql 내용폴더)


이클립스 공유시******************
관리자로 실행 후 파일 위치알아본다

위치 폴더를 연다.
src 폴더와 .classpath, .project 는 공유에서 제외해야한다.

이클립스 위해 크라켄에 래파지토리 새로만든다. 워크스페이스부분 넣어서.(자바)

.git ignore (메모장? 혹은 노트패드)라는 폴더를 워크스페이스폴더의의 베이직자바폴더 속에 만든다.(로컬저장소)
 그 속에 파일, 폴더이름을 적어 저장시킨다.


*뭘 ignore 시켜야할지 모르겠으면
gitignore.io 페이지에 들어간다.
검색창에 eclipse 친다. 
생성 누르고 열린 창 전체복사 후 ignore 파일속에 붙여넣기하면
지워야할 내용이 지워져있다.!
반드시 커밋하기전에 이그노어파일을 준비하자.


*github md
깔끔한 안내서만들기 가능.

*이클립스에서 직접 다운내려받기
맨왼쪽칸에 우클릭 > import > 
유알엘, 계정정보 넣고 git 검색.>
project from git > clone URI
:교육원컴퓨터로는 불가

*크라켄에서 내려받자
파일>클론> 유알엘쓰고(깃헙유알엘),
이클립스에서 

*윈도우
> 쇼뷰>  other> git 검색> git 레파지토리> 창이하나떴다
>add 로 시작하는거 누르고 자바 워크스페이스>자바베이직 폴더> 피니시
>뜬거 프로젝트에 추가하면 돼.> 우클릭> 임포트프로젝트>옵션 체크박스 맨마지막것.
>프로젝트(아래칸 좀전에 추가한거=다운받은거) 우클릭> 컨피규어> 컨버트 투..??? 맨위에거> 확인

*드롭박스? 파일을 공유하기위한것. 형상관리는 아님.

*집에서 수정한 내용 크라켄들어가면 변경사항이 있다고 나옴. 그거애드하고 커밋함.
커밋메세지도 적고. : 로컬까지 된것.
이후 푸시함. 그럼 원격저장소에 잘 올라갔어.

개발원쪽에서는 변경사항을 pull 눌러서 내려받는다.
:어렵..다시....

*이클립스 debug 라는 퍼스펙티브가 있다.

*에프 12 : 에디터에 커서.
*컨트롤 시프트 에프8, 에프7 : 퍼스펫티브 이동, 에디터랑 다른화면들 이동.
*컨트롤 엠 : 현재 창 크겜보기
*컨트롤 페이지 업, 다운 누르면 파일이동 가능.
*컨트롤 시프트 r : 파일이름 아는거 열기
*탭 닫기 : 컨트롤 더블유
*컨트롤 시프트 더블유 : 다닫고 처음부터
*에프3키 누르면??

-------------------------------------------------------------------------------------------------------------

*이제 sql 을 켠다
*/




--IN 연산자
--col IN(value2 ...) 
--col 의 값이 IN 연산자 안에 나열된 값중에 포함될 때 참으로 판점.
SELECT *
FROM emp
WHERE deptno IN (10,20);
--emp 테이블의 직원의 소속부서가 10번 "이거나" 20번인 직원 정보만 조회.

--RDBMS : 집합의 개념.
--1. 순서가 없다.
--(1,5,7),=(5,7,1)
--2. 중복이 없다.
--(1,1,5,7) = (5,1,7)

--이거나 --> or
--이고--> And

--*IN 연산자 OR로 바꿀 수 있다.
--BETWEEM And ---> AND 산수비교 처럼

SELECT *
FROM emp
WHERE deptno = 10 
OR deptno = 20;

--실습
DESC users;
SELECT userid 아이디, usernm 이름, alias 별명
FROM users
WHERE userid IN ('brown', 'cony', 'sally');




--LIKE연산자 : 문자열 매칭 연산 ( % _ )

--% 문자가 없거나 여러문자열
--_ 하나의 문자



--emp 테이블에서 사원 이름( ename) 이 s로 시작하는 사원 정보만 조회.
SELECT *
FROM emp 
WHERE ename LIKE 'S%';

--Smith, Scott 를 패턴으로 검색해보자. (언더바 사용으로)
--LIKE 패턴
SELECT *
FROM emp
WHERE ename LIKE 'S__T_';

SELECT *
FROM emp
WHERE ename LIKE 'S%T_';
--위 두개가 같은가? 다름. 
--S%T 는 STE. STTTTT STESTS 등 S와 T 사이에 아무것도 안 올수도 있고, 20개 올 수도 있다.


--실습
-- member 에서 회원 성이 신씨인 사람의 mem_id, mem_name 을 조회하는 쿼리를 작성하시오.
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '신%';

--member 테이블에서 회원이름에 글자 '이'가 들어가는 모든사람의 mem_id, mem_name 조회.
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE'%이%';


--컬럼 값이 Null인 데이터 조회하기
--emp 테이블의 MGR 컬럼이 NULL 데이터가 존재.
SELECT *
FROM emp
WHERE MGR = 7698; 
--이거랑 비슷하게 값이 NULL인 사원정보 조회해보자

SELECT *
FROM emp
WHERE MGR = NULL;
-- 널값 확인이 조회되지 않는다. IS NULL  연산자를 사용해야 한다.

SELECT *
FROM emp
WHERE MGR IS NULL;
-- 이렇게 확인해야함.


UPDATE emp SET comm = 0
WHERE empno = 7844;
COMMIT;
--왜한거지??행을 업데이트함. 문제 정답이 달라져서?

-- emp에서 상여(comm)가 있는 회원정보 조회
--UPDATE emp SET comm = 0
--WHERE empno = 7844;

SELECT *
FROM emp
WHERE comm IS NOT NULL;


--논리연산(AND, OR,NOT)
--AND : 조건을 동시에 만족(많이 쓰일수록 데이터가 줄어든다.)
--OR :  조건을 한개만 충족하면 만족. (많이 쓰일수록 데이터가 늘어난다.)

--emp 테이블에서 mgr 가 7698 이고, 급여가 1000보다 큰 사람.
SELECT *
FROM emp
WHERE mgr = 7698
AND sal > 1000;

--emp 테이블에서 mgr 가 7698 이거나, 급여가 1000보다 큰 사람.
SELECT *
FROM emp
WHERE mgr = 7698
OR sal > 1000;

--NOT
--emp 테이블에서 관리자 사번이 7698, 7839 가 아닌 직원 정보 조회
SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839);
--= 같음
SELECT *
FROM emp
WHERE mgr != 7698
AND mgr != 7839;

--매니저값이 없는 정보 조회까지 통합하려면 
SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839)
OR mgr IS NOT NULL;

--emp테이블 job 이 SALESMAN, 입사일자가 1981.06.01 이후인 직원 정보 조회.
SELECT *
FROM emp
WHERE job = 'SALESMAN'
AND hiredate > TO_DATE('1981.06.01','yyyy.mm.dd');

--소스정리하는 것에 시간 할당할것.
--이후 깃헙에 올림.








