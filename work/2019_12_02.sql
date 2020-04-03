--JOIN 의 종류
--Outer join
--컬럼 연결이 실패해도(조인이 실패해도) 기준이 되는 테이블의 데이터가 나오도록 하는 join
--left outer join : (테이블 1 LEFT OUTER FOIN 테이블2) : 테이블 1과 테이블2를 조인할때 조인에 실패하더라도 테이블 1쪽의 데이터는 
--                      조회가 되도록 한다. 조인에 실패한 행에서 테이블2의 컬럼값은 존재하지 않으므로 NULL로 표시된다.
--right outher join : 
--full outer join(left + right)( left한거 right한거 합치고 중복제거인데 중복 제거되는 경우가 거의 없음.) 이렇게 3종류 있음.
--기준이 되는 테이블이 왼쪽이냐 오른쪽이냐. 순서가있음.
--값이 null인 데이터 조회

--left outer join 
SELECT e.ename, e.empno, m.ename, m.empno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno);
--null 값도 나왔다~!

--join 조건을 where절에 넣는것과 on절에 넣는것이 어떻게 다를까?
SELECT e.ename, e.empno, m.ename, m.empno
FROM emp e LEFT OUTER JOIN emp m 
        ON (e.mgr = m.empno AND m.deptno = 10);
--부서번호가 10번인 애들만 조인을 하라는 조건을 On절에 넣었다.
SELECT e.ename, e.empno, e.deptno, m.ename, m.empno, m.deptno
FROM emp e LEFT OUTER JOIN emp m 
        ON (e.mgr = m.empno AND m.deptno = 10);
        --deptno 확인을 해보았다.
        
--
SELECT e.ename, e.empno, e.deptno, m.ename, m.empno, m.deptno
FROM emp e LEFT OUTER JOIN emp m 
        ON (e.mgr = m.empno)
WHERE m.deptno=10;
--on절에 포함했을때의 데이터가 나오지않는다. 웨어절에서 에초에 잘라버렸기때문.
 --on절에 기술하는것과where절에 기술하는것이 다르다.
 
 
 --오라클문법으로는?
--일단 아래는 안시.
 SELECT e.ename, e.empno, m.ename, m.empno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno);
--이걸 바꿔보자
--일반조인과 차이점은 컬럼명에 (+) 표시.
--(+)표시 : 데이터가 존재하지 않는데 나와야하는 테이블의 컬럼에다가 표시한다.
--직원 left outer join 매니저
--on(직원.매니저번호 = 매니저.직원번호)
--오라클 아우터
--where 직원.매니저번호 = 매니저.직원번호(+) --매니저쪽에 데이터가 존재하지 않으므로.
--아래 오라클
SELECT e.ename, e.empno, m.ename, m.empno
FROM emp e ,emp m
WHERE e.mgr = m.empno(+);

--매니저 부서번호 제한
--안시에서 웨어절에 기술했던 것.
--아우터조인이 적용되지 않은 상황. 
--아우터 조인이 적용되어야 하는 모든 컬럼에 (+)가 붙어야 아우터조인이 적용된다.
SELECT e.ename, e.empno, m.ename, m.empno
FROM emp e ,emp m
WHERE e.mgr = m.empno(+)
AND m.deptno = 10;
--아웃조인이 적용되어ㅇ야하는 테이블의 모든 컬럼에 (+)붙여조야해. (+)붙여보자
--아래가 on절에 넣었을때와 동일한 결과를 출력한다.
SELECT e.ename, e.empno, m.ename, m.empno
FROM emp e ,emp m
WHERE e.mgr = m.empno(+)
AND m.deptno(+) = 10;

--시일습을 해애봅시다아아
--emp 테이블에는 14명의 직원이 있고 14명은 10,20,40 부서중 한 부서에 속한다.
--하지만 dept 테이블에는 10,20,30,40 번 부서가 존재.
--부서번호, 부서명, 해당부서에 속한 직원 수가 나오도록 쿼리를 작성해보세요.
--안시 * 왼쪽에 중심이되는 테이블을 써야해!!! emp를 앞에쓰면 안돼!
SELECT dept.deptno, dept.dname, COUNT(emp.deptno)
FROM dept LEFT OUTER JOIN emp ON (dept.deptno = emp.deptno) 
GROUP BY dept.deptno, dept.dname;
--오라클
SELECT dept.deptno, dept.dname, NVL(COUNT(emp.deptno),0)
FROM emp, dept
WHERE emp.deptno(+) = dept.deptno
GROUP BY dept.deptno, dept.dname;

----------------------선생님 답
SELECT dept.deptno, dept.dname, NVL(emp_cnt.cnt, 0) cnt
FROM
dept,
(SELECT deptno, COUNT(*) cnt
FROM emp
GROUP BY deptno) emp_cnt
WHERE dept.deptno = emp_cnt.deptno(+);
--안시
SELECT dept.deptno, dept.dname, NVL(emp_cnt.cnt, 0) cnt
FROM
dept LEFT OUTER JOIN
                    (SELECT deptno, COUNT(*) cnt
                    FROM emp
                    GROUP BY deptno) emp_cnt
                ON(dept.deptno = emp_cnt.deptno);

--
--혹시 새폴더여서 새이름..?


--righr outer join
SELECT e.ename, e.empno, m.ename, m.empno
FROM emp e RIGHT OUTER JOIN emp m ON (e.mgr = m.empno);


--fullouter : left outer+righr outer - 중복데이터는 한건만 남기기..
--오라클sql을 이용한 full outer foin문법은 존재하지 않는다!
SELECT e.ename, e.empno, m.ename, m.empno
FROM emp e FULL OUTER JOIN emp m ON (e.mgr = m.empno);

--행을 확장하는거 : 집합연산자 union 합집합임.
--레프트아우터랑 라이트아우터의 유니온에 마이너스 풀아우터는 0이됨.
--인터섹트(교집합)
--레프트아우터 유니온 라이트아우터 인터넷트 풀아우터어느은 풀아우터조인이랑 같은결과가 나올것임.

--실습 outerjoin1
SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty
FROM prod LEFT OUTER JOIN buyprod 
ON (prod.prod_id = buyprod.buy_prod
    AND buyprod.buy_date = TO_DATE('20050125','yyyymmdd')) ;


--실습 2
SELECT NVL(buy_date,TO_DATE('20050125','yyyymmdd')) buy_date, 
        buy_prod, prod_id, prod_name, buy_qty
FROM prod LEFT OUTER JOIN buyprod 
ON (prod.prod_id = buyprod.buy_prod
    AND buyprod.buy_date = TO_DATE('20050125','yyyymmdd')) ;

--실습3
SELECT NVL(buy_date,TO_DATE('20050125','yyyymmdd')) buy_date, 
        buy_prod, prod_id, prod_name, NVL(buy_qty, 0) buy_qty
FROM prod LEFT OUTER JOIN buyprod 
ON (prod.prod_id = buyprod.buy_prod
    AND buyprod.buy_date = TO_DATE('20050125','yyyymmdd')) ;
    
    ----------
    
SELECT TO_DATE(:yyyymmdd, 'YYYYMMDD') buydate, buyprod.buy_prod,
prod.buy_
;


--실습4  --이렇게하는게 맞나??? cid 부분 null 인것들...
SELECT product.pid, pnm, NVL(cid, 1) cid, NVL(day, 0) day, NVL(cnt,0) cnt
FROM product LEFT OUTER JOIN cycle 
ON (product.pid = cycle.pid
AND cid = 1)
ORDER BY pid;

-----선생님 답안
--100,400번 먹음.
SELECT *
FROM cycle
WHERE cid=1;

--200,300 없음.
SELECT *
FROM product;

SELECT product.pid, product.pnm, :cid, NVL(cycle.day,0),NVL(cycle.cnt,0)
FROM cycle, product
WHERE cycle.cid(+)=1
AND cycle.pid(+) = product.pid;



--이전과정
SELECT product.pid, pnm, cid,day, cnt
FROM product LEFT OUTER JOIN cycle 
ON (product.pid = cycle.pid
AND cid = 1);


--실습5
SELECT product.pid, pnm, NVL(cycle.cid,'1')cycle, NVL(cnm, 'brown') cnm, 
        NVL(day,0) day, NVL(cnt,0) cnt
FROM cycle, product, customer
WHERE product.pid = cycle.pid (+)
AND cycle.cid = customer.cid (+)
AND cycle.cid (+)= 1
ORDER BY pid DESC, DAY DESC;
--
SELECT product.pid, pnm, NVL(cycle.cid,'1')cycle, NVL(cnm, 'brown') cnm, 
        NVL(day,0) day, NVL(cnt,0) cnt
FROM cycle, product, customer
WHERE product.pid = cycle.pid (+)
AND cycle.cid = customer.cid (+)
AND cycle.cid (+)= 1
ORDER BY pid DESC, DAY DESC;

--오라클에선 연속으로 아우터조인 허용안됨. 인라인뷰사용해야해 아래것으로 고쳐야한다.

SELECT a.pid, a.pnm, a.cid, customer.cnm, a.day, a.cnt
FROM
(SELECT product.pid, product.pnm, :cid cid, NVL(cycle.day,0) day, NVL(cycle.cnt, 0) cnt
FROM cycle, product
WHERE cycle.cid(+) = :cid
AND cycle.pid(+) = product.pid) a, customer
WHERE a.cid = customer.cid;



--이렇게는 안되나봐.
SELECT product.pid, pnm, NVL(cycle.cid,'1')cycle, NVL(cnm, 'brown') cnm, 
        NVL(day,0) day, NVL(cnt,0) cnt
FROM product LEFT OUTER JOIN cycle ON(product.pid = cycle.pid)
        LEFT JOIN customer ON(cycle.cid = customer.cid);
        
--hash outer?
--아우터조인이 마스터테이블이 데이터가 많을때 성능면에서 문제가 생겨
--오라클에서 조인컬럼을 해쉬함수를 돌려서 해쉬함수를 만들어내 값을 저장해놓음.
--오라클 10g 이후로는 마스터테이블부터 읽지않고 유리한쪽부터 읽음.
--해쉬함수를 적용하면 데이터가 섞여있음. 알고리즘관련...?
--비밀번호사용할때도 해쉬함수 사용됨.
--암호화

--컨설턴트?개발자?

