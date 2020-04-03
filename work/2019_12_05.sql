INSERT INTO dept Values (99, 'ddit', 'daejeon');
COMMIT;

--실습 sub4
--문제뜻 : empno 가 가진 deptno 가 아닌거 조회

SELECT *
FROM dept
WHERE  deptno NOT IN (SELECT deptno
                      FROM emp);
---선생님 답안
SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                        FROM emp);
--
SELECT dept.*
FROM dept, emp
WHERE dept.deptno = emp.deptno(+)
AND emp.deptno IS NULL;

--실습5
--cid=1 인 고객이 애음하지 않는 제품
SELECT *
FROM product
WHERE pid NOT IN(SELECT pid
                  FROM cycle
                  WHERE cid = 1
                    );

--실습 6
SELECT *
FROM cycle
WHERE cid = 1
AND pid IN (SELECT pid
            FROM cycle
            WHERE cid = 2);

--실습 7 --sub6 의 결과에서 고개명, 제품명을 추가.
--sql 은 실행하기가 펴언해. 피드백을 빠르게 받음.

SELECT cycle.*, customer.cnm, product.pnm
FROM cycle, customer, product
WHERE customer.cid = cycle.cid 
AND product.pid = cycle.pid
AND cycle.cid = 1
AND cycle.pid IN (SELECT pid
            FROM cycle
            WHERE cid = 2);


SELECT *
FROM cycle
WHERE cid = 1
AND pid IN(SELECT pid
           FROM cycle
           WHERE cid = 2);


SELECT *
FROM cycle;
SELECT *
FROM product;
SELECT *
FROM customer;


--<<EXISTS 연산자>>
--조건을 만족하는 서브쿼리의 결과값이 존재하는지 체크.
--조건을 만족하는 데이터를 찾으면 서브쿼리에서 값을 찾지 않는다.
--여러개가 존재해도 한건만 찾으면 끝냄. 
--존재여부를 확인하는것 뿐임.

--ECISTS 는 연산할 컬럼을 왼쪽에 적지 않음. 
--상호연관컬럼형태로 작성된 쿼리.

--매니저가 존재하는 직원 조회
SELECT *
FROM emp a
WHERE EXISTS (SELECT 'x'
            FROM emp b
            WHERE b.empno = a.mgr);
--x ???숫자든 문자든 상관없지만 x 가 약속?처럼 두루두루 쓰임.
--킹은 매니저컬럼이 널이어서 조회 안됨. 13건 나왔음.

--매니저가 존재하는 직원 정보 조회
SELECT *
FROM emp e
WHERE EXISTS (SELECT '메롱'
                FROM emp m
                WHERE m.empno = e.mgr);
                
--실습 8
--매니저가 존재하는 직원 정보조회. 서브쿼리를 사용하지 않고 작성하세요.
SELECT *
FROM emp
WHERE mgr IS NOT NULL;
--
SELECT *
FROM emp e, emp m
WHERE e.mgr = m.empno;

--실습 9
SELECT product.*
FROM product
WHERE EXISTS (SELECT cycle.pid
                FROM cycle,product
                WHERE cid = 1
                AND cycle.pid = product.pid);

--아이디 1이 가지지 않는 싸이클 pid의 프로덕트 피아이디

SELECT *
FROM product
WHERE EXISTS (SELECT 'x'
                FROM cycle
                WHERE cid = 1
                AND cycle.pid = product.pid);
--싸이클에서 이사람이 먹는 제품을 체크하고싶은 것. 제품아이디가 있는지 확인해봐야하.
--프롬절에 프로덕트 안써도 되는건가?? 참과 거짓으로 나뉠수있어야함. EXISTS뒤에 오는건
--
-- 실습 10
SELECT *
FROM product
WHERE NOT EXISTS (SELECT 'x'
                FROM cycle
                WHERE cid = 1
                AND cycle.pid = product.pid);




--<<집합연산>>
--컬럼 확장(가로로 확장) : JOIN
--지금 할건 행의 확장
--1. UNION/UNION ALL
--: UNION 은 우리가 알고있던 합집합 동시에 만족하는 부분은 제거됨.
--교집합부분을 알아내기위해 정렬을 하고, 한번만 등장시키려고 한다. 속도가 다소 느림.
--:UNION ALL은 중복을 검사하지않음. 중복이 나올 수 있음.
--보통 데이터들의 교집합이 있을 확률이 적음. 개발자에게 제어권을 넘겨준것. 유니온에 비해 속도 빠름.
--2. INTERSECT
--: 교집합.
--3. MINUS
--:차집합. A-B 는 에이에서 비를 뺀거. 교집합부분도 뺐다.

--집합연산은 중복이나 순서가 없음!
--집합연산은 위아래로 행을 확장해. 그러려면 위아래 집합의col의 개수와 타입이 일치행야한다.

--

--UNION :  합집합, 두 집합의 중복건은 제거한다.
--담당업무가 SALES 인 직원의 직원번호, 직원 이름 조회해라.
--위, 아래 결과셋이 동일하기때문에 합집합연산을 하게 될 경우 중복되는 데이터는 한번만 표현한다.

SELECT empno,ename
FROM emp
WHERE job = 'SALESMAN'

UNION

SELECT empno,ename
FROM emp
WHERE job = 'SALESMAN';

--UNION ALL
--합집합 연산시 중복 제거를 하지 않는다. 위 아래 결과셋을 붙여주기만 한다.
SELECT empno,ename
FROM emp
WHERE job = 'SALESMAN'

UNION ALL

SELECT empno,ename
FROM emp
WHERE job = 'SALESMAN';


--집합연산지 집합셋의 컬럼이 동일해야한다.
--컬럼개수가 다를경우 임의의 값을 넣는 방식으로 개수를 맞춰준다.
SELECT empno,ename, ''
FROM emp
WHERE job = 'SALESMAN'

UNION ALL

SELECT empno,ename, job
FROM emp
WHERE job = 'SALESMAN';




--서로다른 집합의 합집합
--중복되지 않는 결과 두개를 합쳐 데이터가 2배가 됨.
SELECT empno,ename
FROM emp
WHERE job = 'SALESMAN'

UNION

SELECT empno,ename
FROM emp
WHERE job = 'CLERK';


--교집합 INTERSECT
--두 집합간 공통적인 데이터만 조회
--위 집합에 아래 집합이 완전히 포함된.
--따라서 아래집합만 나올것이다.
SELECT empno, ename, job
FROM emp
WHERE job IN ('SALESMAN', 'CLERK')

INTERSECT

SELECT empno, ename, job
FROM emp
WHERE job IN ('SALESMAN');



--마이너스 차집합
--위, 아래 집합의 교집합을 위 집합에서 제거한 집합을 조회
-- 차집합의 경우 합집합, 교집합과 다르게 집합의 선언 순서가 결과 집합에 영향을 준다.
--공통된 부분 빼고 CLERK 만 조회가 될 것이다.
SELECT empno, ename, job
FROM emp
WHERE job IN ('SALESMAN', 'CLERK')

MINUS

SELECT empno, ename, job
FROM emp
WHERE job IN ('SALESMAN');
--집합연산자 자체를 잘 안씀. 쓰게되면 UNION ALL 을 씀.

--<<집합연산자의 특징>>
--열의 이름은 첫번째 쿼리의 컬럼을 따른다.
--ORDER BY절은 집합연산자의 가장 마지막 집합 이후에 적용될 수 있다.
SELECT empno, ename, job
FROM
(SELECT empno, ename, job
FROM emp
WHERE job IN ('SALESMAN', 'CLERK')
ORDER BY job)

UNION ALL

SELECT empno, ename, job
FROM emp
WHERE job IN ('SALESMAN')
ORDER BY ename;

--유니온 올 제외하고 중복은 제거된다.
--이전에는 기본적으로 오름차순으로 정렬되나, 이제 정렬을 보장하지 않는다.
--중복을 제거하는 과정에서 정렬연산이 이루어짐.
--유니온 올은 제외
--ORDER BY 는 뒤컬럼에 써줘야한다.


--여태까지해온건 원본데이터를 전혀 건들지 않았지만
--아래 DML 은 데이터의 원본내용을 수정한다. 


--<<DML>>
--((WHEN)) 
--데이터를 신규로 추가할 때
--기존데이트럴 수정할 때
--기존데이터를 삭제할 때

--1. insert
--테이블에 새로운 데이터를 입력.
--INSERT INTO tanle[(컬럼 컬럼...)]
--values(value[, value]);
DESC emp;
--INSERT 시 컬럼을 나열한 경우 :
--값나열한 컬럼에 맞춰 입력한 값을 동일한 순서로 기술한다. DESC로 알아본 컬럼의 순서대로 기술해야한다는 뜻.
--대괄호는 필수가 아닌 선택임. 필요할때와 필요없을때를 알아보렴.
--

SELECT *
FROM dept;

DELETE dept
WHERE deptno = 99;

--데이터를 수정한 후에는 COMMIT 으로 수정을 확정짓거나, ROLLBACK 으로 수정을 취소하거나.
--둘 중 하나를 해야한다.


--dept 테이블에 99번 부서번호, ddit 조직명, daejeon 지역명을 갖는 데이터 입력
--
INSERT INTO dept(deptno, dname, loc)
            VALUES (99, 'ddit', 'daejeon');
            
--컬럼을 기술할 경우 테이블의 컬럼 정의 순서와 다르게 나열해도 상관이 없다.
INSERT INTO dept(loc, deptno, dname)
            VALUES ('daejeon', 99, 'ddit');
ROLLBACK;

SELECT *
FROM dept;

-- 컬럼을 기술하지 않는 경우 : 테이블의 컬럼 정의 순서에 맞춰 값을 기술한다.
INSERT INTO dept VALUES ('daejeon', 99, 'ddit');

--값을 입력하지 않으면 NULL이 입력됨.

--INSERT DATE 타입.
--1. SYSDATE
DESC emp;
INSERT INTO emp VALUES (9998, 'sally', 'SALESMAN', NULL, SYSDATE, 500, NULL, NULL);

SELECT *
FROM emp;
--2. 사용자로부터 받은 문자열을 DATE 타입으로 변경하여 입력.
DESC emp;
INSERT INTO emp VALUES (9997, 'james', 'CLERK', NULL, TO_DATE('20191202','yyyymmdd'), 500, NULL, NULL);
--바인드변수도 되는거지?? 해보렴

ROLLBACK;

SELECT *
FROM emp;

--insert 여러건의 데이터를 한번에 입력
--SELECT 결과를 테이블에 입력할 수 있다.
INSERT INTO emp
SELECT 9998, 'sally', 'SALESMAN', NULL, SYSDATE, 500, NULL, NULL
FROM dual
UNION ALL
SELECT 9997, 'james', 'CLERK', NULL, TO_DATE('20191202','yyyymmdd'), 500, NULL, NULL
FROM dual;

ROLLBACK;
--테이블 결과에 영향을 미치지 않도록 계속 rollback해주는중!





