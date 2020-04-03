--계층쿼리
--FROM  다음에 CONNECT BY 가 온다.
--최상위에서 시작하는것(혹은 어쨋든 아래로향할때)을 하향식. 자기 밑의 모든 노드를 따라감. 대체로 하향식 많이 씀.
--중간 혹은 최하위에서 시작하는 것을 상향식. 부모만 따라감.

--시작점이 제대로 됐는지 먼저 확인한다.
SELECT *
FROM dept_h
WHERE deptcd='dept0';

--
SELECT dept_h.*, LEVEL --LEVEL 은 계층구조에따라 중복된 숫자가 나올 수 있다.
FROM dept_h
START WITH deptcd='dept0' --=시작점은 DEPTCD = 'DEPT0' --> XX회사(최상위조직)
CONNECT BY PRIOR deptcd = p_deptcd;
    --이미 읽은 PRIOR deptcd(= 최상위조직 XX회사dml deptcd)
    --p_deptcd =  앞으로 읽을 데이터의 p_deptcd. (=XX회사 하위로 둘 부서.)
    --한 번만쓰면 프라이어가 그 다음읽고 다음읽으니까 쭉 전체 다 연결된다. 자식으로 둘게 없을때까지.
    --prior 가 계속 바뀌면서 죽죽 내려갈것임.

SELECT LPAD('XX회사', 15, '*'),
        LPAD('XX회사', 15)
FROM dual;
--위에거를 deptnm들여쓰기로 보기쉽게해보자.
SELECT dept_h.*, LEVEL, LPAD(' ', (LEVEL-1)*3) || deptnm --LEVEL 은 계층구조에따라 중복된 숫자가 나올 수 있다.
FROM dept_h
START WITH deptcd='dept0' --=시작점은 DEPTCD = 'DEPT0' --> XX회사(최상위조직)
CONNECT BY PRIOR deptcd = p_deptcd;

--계층쿼리 실습2 (정보시스템부 부터)
SELECT LEVEL lv,deptcd, LPAD(' ', (LEVEL-1)*3) || deptnm deptnm, p_deptcd
FROM dept_h
START WITH deptcd = 'dept0_02'
CONNECT BY PRIOR deptcd = p_deptcd;

--상향식(하향식보다 테이터가 적게나오는 것이 일반적.)
SELECT *
FROM dept_h;
--디자인팀을 기준으로 상향식 계층쿼리 작성.
--자기 부서의 부모부서와 연결을 한다.
SELECT dept_h.*, LEVEL lv, LPAD(' ', (LEVEL-1)*3) || deptnm deptnm --시작점 레벨이 1이 된다.
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY deptcd = PRIOR p_deptcd; --PRIOR 는 컬럼 앞에 붙는 것.!
--연결고리가 두개가 되는 경우도 있다.
SELECT dept_h.*, LEVEL --시작점 레벨이 1이 된다.
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY deptcd = PRIOR p_deptcd AND col = PRIOR col2;

--조인조건이 여러개 가능한것처럼. WHERE 절처럼 순서도 없다.
SELECT dept_h.*, LEVEL --시작점 레벨이 1이 된다.
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY deptcd = PRIOR p_deptcd AND PRIOR deptnm LIKE'디자인%';
--결과로나온게 계층탐색한 순서와 같다. (레벨이 1 부터 표시된다. 상향식 하향식 모두.)

--노드 = 이진트리 라고??
--자바에서..자료구조만들기??

--실습4
SELECT *
FROM h_sum;

DESC h_sum;

SELECT LPAD(' ', (LEVEL-1)*5)||s_id s_id, value --h_sum.*, level, LPAD(' ', (LEVEL-1)*5)||s_id
FROM h_sum
START WITH s_id = '0'
CONNECT BY PRIOR s_id = ps_id;

--실습 5
SELECT *
FROM no_emp;

DESC no_emp;

SELECT LPAD(' ', (level-1)*4) || org_cd,no_emp
FROM no_emp
START WITH org_cd = 'XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd;





-- << 가지치기 >> = pruing branch
--where 절은 계층쿼리 이후 적용.
--단 다른 테이블과의 조인 조건으로 이용되었을 경우 조인에 사용됨.
--조건을 connect by 절에 같이쓰냐, 아니면 밖에 따로 where 절에 쓰냐에 따라 결과가 다름.
--connect by 절에 쓰면 조건에 안맞는애들은 아예 연결 자체가 안되고
-- where 절에쓰면 연결 후 잘라내기.

--계층쿼리의 실행 순서
--FROM -> START WITH ~ CONNECT BY -> WHERE

--조건을 CONNECT BY 절에 기술한 경우.
-- . 조건에 따라 다음 ROW로 연결이 안되고 종료.

--조건을 WHERE 절에 기술한 경우
-- . START WITH ~CONNECT BY 절에 의해 계층형으로 나온 결과에
-- WHERE 절에 기술한 결과 값에 해당하는 데이터만 조회.


--최상위 노드에서 하향식으로 탐색.
SELECT *
FROM dept_h;

--CONNECTE BY 절에 deptnm != '정보기획부' 조건을 기술한 경우.
SELECT *
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd AND deptnm != '정보기획부' ;
--기획부 밑에있는것들은 전부 안나올거야. 연결고리가 끊어짐.
--총 6건 나오고 기획부에 관련된거 없음!

--WHERE 절에 deptnm != '정보기획부' 조건을 기술한 경우.
--
SELECT *
FROM dept_h
WHERE deptnm != '정보기획부'
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;
--총 8건 나온다.  이름이 정보기획부가 아닌 모든것 나옴.


--오라클에만 있는 특수함수
--계층쿼리에서 사용 가능한 특수 함수.

--1. CONNECT _BY_ROOT(col) 가장 최상위 row의 col 정보 값 조회.
--최상위노드가 하나가 아닌경우도 있다. 댓글이 계층형쿼리.
--
SELECT deptcd, LPAD(' ', 4*(LEVEL-1)) || deptnm deptnm,
        CONNECT_BY_ROOT(deptnm) c_root
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

--2. SYS_CONNECT_BY_PATH(col, 구분자) : 최상위 row 에서 현재 로우까지 col 값을 구분자로 연결해준 문자열.
--구분자로 연결해준 문자열 (EX : XX회사 - 디자인부디자인팀) . 길보여줌. 
SELECT deptcd, LPAD(' ', 4*(LEVEL-1)) || deptnm deptnm,
        LTRIM(SYS_CONNECT_BY_PATH(deptnm, '-'), '-') sys_path --LTRIM 으로 맨 왼쪽 - 를 삭제시켰다. 
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

--3. CONNECT_BY_ISLEAF : 해당 ROW 가 마지막 노드인지 ( LEAF NODE)
-- LEAF NOD 면 1 반환. 일반 노드면 0 반환.
SELECT deptcd, LPAD(' ', 4*(LEVEL-1)) || deptnm deptnm,
        CONNECT_BY_ISLEAF isleaf 
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

--실습 6
SELECT *
FROM BOARD_TEST;

SELECT seq, LPAD(' ',(level-1)*4)||title title
FROM BOARD_TEST
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq;

--실습 7
SELECT seq, LPAD(' ',(level-1)*4)||title title
FROM BOARD_TEST
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER BY seq DESC;

-- 
SELECT seq, LPAD(' ',(level-1)*4)||title title
FROM BOARD_TEST
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq DESC;

--
SELECT seq, LPAD(' ',(level-1)*4)||title title, level
FROM BOARD_TEST
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq DESC;

--과제과제
SELECT seq, LPAD(' ',(level-1)*4)||title title, level
FROM BOARD_TEST
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq DESC, seq;

--답 :
SELECT seq, LPAD(' ',(level-1)*4)||title title
FROM BOARD_TEST
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER BY CONNECT_BY_ROOT(seq)DESC, seq asc;

--또다른답 :
SELECT seq,LPAD(' ', 4*(LEVEL-1)) || title ti,LEVEL
FROM board_test
START WITH  parent_seq  IS NULL 
CONNECT BY  PRIOR seq =  parent_seq
ORDER SIBLINGS BY NVL(parent_seq,seq) DESC;

--노마드코더?????


--레벨이 2이상인것들부터는 seq 순으로 정렬하게 해야함.
--plsql 이 몰까