--11/28
--EXPLAIN PLAN FOR
SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno != dept.deptno
AND emp.deptno=10;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

SELECT ename, deptno
FROM emp;

SELECT deptno, dname
FROM dept;


--순서지정안함. 실행계획을 보면 뭐부터 읽었는지 알 수 있다.
--위에서 아래로, 안에서 바깥으로 읽음.
--ID 2-3-1-0 순으로 읽음.
--1번이 0번의 자식임.
--2번,3번이 1번의 자식임. operation의 들여쓰기를 보면 알 수 있음.
--두컬럼값이 같을떄 조인하는것이 이퀄조인. 반대는 논이퀄조인.
--이퀄조인이 일반적임. 


--조인은 안시sql이래.
--안시 sql배우고 오라클문법 배울고야..

--natural join : 조인 테이블간 같은 타입, 같은 이름의 컬럼으로
--              같은 값을 갖을 경우 조인.

DESC emp;
DESC dept;

--안시sql 문법
SELECT *
FROM emp NATURAL JOIN dept;
--두 테이블중 한 쪽에만 있는 컬럼이나, 조인되고 있는 컬럼은
--컬럼이름. 에베베  이렇게 안하고 그냥 에베베만 쓰면 됨

ALTER TABLE emp DROP COLUMN dname;


--오라클 문법
SELECT emp. deptno, emp.empno, ename
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.dname = dept.dname;

--여기서 별칭주는 것도 가능함. 
SELECT a.deptno, empno, ename
FROM emp a, dept b
WHERE a.deptno = b.deptno;
--이로케

--조인 을 쓰는게 안시 에스큐엘문법임.
--오라클문법은 from절에 조인할 컬럼을 , 로 구분해 적고
--WHERE 절에 그 조건을 써야해.

--컬럼이름이 다를경우에는 내츄럴조인을 사용할수 없다. ( ex) emp의 deptno 랑 dept 의
--deptno 이름이 달랐으면 조인할수없었다는 것. 이때는 오라클문법으로 합쳐야함.

--JOIN USING
--join 하려고 하는 테이블간 동일한 이름의 컬럼이 두개 이상일 떄
--join 컬럼을 하나만 사용하고 싶을 때
--using 절을 사용하지만 자주쓰이진 않음.

--ANSI SQL
SELECT *
FROM emp JOIN dept USING (deptno);

--위에걸 오라클 sql로 하면?
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;
--약간의 차이가 있긴함..무슨차이..?

SELECT *
FROM emp, dept;
--조건없이 조인을하면 가능한 경우의 수를 모두 출력시킴.
SELECT *
FROM emp, dept
WHERE 1=1;
--얘도.
--크로스조인? 카텐셜..?뭐...
--안시sql은 조금씩 변하는데 오라클 sql은 변함없음.


--ansi JOIN whit ON
--조인하고자 하는 테이블의 컬럼 이름이 다를 때
--개발자가 조인 조건을 직접 제어할 때.

--
SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno);
--조인이 정상적으로 됐으면 14건의 데이터가 나온다.
SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE emp.deptno = 10; 
--요로케도 된다.

--위에걸 오라클로 바꿔봅시다
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;



--SELF JOIN : 같은 테이블간 조인
--emp테이블간 조인할만한 사항 : 직원의 관리자 정보 조회
--계층구조.  상위, 하위내용을 한 테이블에서 관리하는 내용
--직원의 관리자 정보를 조회. 직원이름, 관리자이름

SELECT empno, mgr, ename
FROM emp
WHERE mgr, empno???? 안되네..;
--ANSIsql

SELECT e.ename, m.ename
FROM emp e JOIN emp m ON(e.mgr = m.empno);

--위에거 오라클sql로 써보자
SELECT e.ename, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;


--
--직원이름, 직원의 상급자이름, 직원의 상급자의 상급자이름 나오게 해볼까?

SELECT e.ename, m.ename
FROM emp e JOIN emp m ON(e.mgr = m.empno);


--X
SELECT NVL(a.mgr, 'N')
FROM
(SELECT e.ename, m.ename, mm.ename
FROM emp e, emp m, emp mm
WHERE e.mgr = m.empno
AND m.mgr = mm.empno) a, emp mmm
WHERE a.mgr = mmm.empno;

--??
SELECT e.ename, m.ename, mm.ename
FROM emp e, emp m, emp mm
WHERE e.mgr = m.empno
AND m.mgr = mm.empno;

--??
SELECT e.ename, m.ename, mm.ename, mmm.ename
FROM emp e, emp m, emp mm, emp mmm
WHERE e.mgr = m.empno
AND m.mgr = mm.empno
AND mm.mgr = mmm.empno;

--ANSISQL로 해보자 여러개 묶어보자(pt에 없음.)

SELECT e. ename, m.ename, mm.ename, mmm.ename
FROM emp e JOIN emp m ON ( e.mgr = m.empno)
    JOIN emp mm ON (m.mgr = mm.empno)
    JOIN emp mmm ON (mm.mgr = mmm.empno);

--직원의 이름과, 해당 직원의 상사이름을 조회
--단, 직원의 사번지 7369~7698 인 직원을 대상으로 조회

SELECT e.ename, m.ename
FROM emp e JOIN emp m ON ( e.mgr = m.empno)
WHERE e.empno BETWEEN 7369 AND 7698;
-------------------------------이건 왜 안돼ㅠㅠ

SELECT *
FROM emp e, emp m
WHERE e.empno BETWEEN 7369 AND 7698
AND e.mgr = m.empno;

---ANSI로
SELECT e.ename, m.ename
FROM emp e JOIN emp m ON ( e.mgr = m.empno)
WHERE e.empno BETWEEN 7369 AND 7698;

--NONEQUAL JOIN

SELECT *
FROM salgrade;
SELECT empno, ename, sal
FROM emp;


SELECT emp.ename, emp.sal, salgrade.grade
FROM emp JOIN salgrade ON (emp.sal BETWEEN salgrade.losal AND salgrade.hisal);
--ON 뒤에 트루, 폴스가 와야해??

SELECT salgrade.grade, emp.ename, emp.sal 
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;
--true, false 에따라값이나오는것뿐. 이퀄이 아니어도 조인이 가능하다.

--실습 join0
--오라클
SELECT empno, ename,dept.deptno,dname 
FROM emp, dept
WHERE emp.deptno = dept.deptno
ORDER BY deptno;
--안시
SELECT emp.empno, emp.ename,deptno,dept.dname 
FROM emp NATURAL JOIN dept;

--실습 join 0_1
--오라클
SELECT empno, ename,dept.deptno,dname 
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND(emp.deptno = 10 
OR emp.deptno = 30)
ORDER BY deptno;
--안시
SELECT emp.empno, emp.ename,deptno,dept.dname 
FROM emp NATURAL JOIN dept
WHERE deptno = 10 OR deptno = 30;

--실습 join 0_2
SELECT empno, ename, sal, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno 
AND emp.sal > 2500;
--
SELECT empno, ename, sal, deptno, dname
FROM emp NATURAL JOIN dept
WHERE emp.sal > 2500;

--실습 join 0_3
SELECT empno, ename, sal, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND sal > 2500 AND empno > 7600;
--
SELECT empno, ename, sal, deptno, dname
FROM emp NATURAL JOIN dept
WHERE sal > 2500 AND empno > 7600;

--실습 join 0_4
SELECT empno, ename, sal, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND sal > 2500 AND empno > 7600 
AND dname = 'RESEARCH';
--
SELECT empno, ename, sal, deptno, dname
FROM emp NATURAL JOIN dept
WHERE sal > 2500 AND empno > 7600
AND dname = 'RESEARCH';

--공유폴더의 eXERD_INSTALLER  다운받아놓기.
--피티의 이상한 그림같은거 = ERD 테이블을 설계하는 툴이다.
--요거를 설계도면을 보는 연습을 할거야.
--와~!