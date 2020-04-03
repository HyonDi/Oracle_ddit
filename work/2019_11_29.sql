--실습 join 0_3
SELECT empno, ename, sal, emp. deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno 
AND emp.sal > 2500 
AND emp.empno > 7600;
--
SELECT empno,ename, sal, deptno, dname
FROM emp NATURAL JOIN dept
WHERE emp.sal > 2500
AND emp.empno > 7600;

--exerd 다운받았다. 설치하고
--선생님이주신 model 폴더 배경화면에넣고
--exerd켠다음 새로만들기>일반>프로젝트에서 model 프로젝트만든후
--폴더에있는것을 이 프로젝트속에 붙여넣음.


--exerd 보면 scott 폴더에서 사원테이블과 부서테이블을 볼 수 있다.
--관계선이 있는 것, 없는 것.
--관계선이 있으면 관계가 있으니 수정.변경에 제한이 있음.
--
--실습 join_1
SELECT *
FROM prod;

SELECT *
FROM LPROD;

SELECT lprod_gu, lprod_nm, prod_id,prod_name
FROM prod, lprod
WHERE prod.prod_lgu = lprod.lprod_gu;
--
SELECT lprod_gu, lprod_nm, prod_id,prod_name
FROM prod JOIN lprod ON(prod.prod_lgu = lprod.lprod_gu);

--
SELECT prod_lgu
FROM prod;

SELECT lprod_gu
FROM lprod;
--실습 join_2

SELECT buyer_id, buyer_name, prod_id,prod_name
FROM prod, buyer
WHERE prod_buyer = buyer_id ;
--
SELECT buyer_id, buyer_name, prod_id,prod_name
FROM prod JOIN buyer ON (prod_buyer = buyer_id);

--실습 join_3-------------------------------------------------------------------------???
SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member, cart, prod
WHERE member.mem_id = cart.cart_member
AND cart.cart_prod = prod.prod_id;

--
SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member JOIN cart ON(member.mem_id = cart.cart_member) 
        JOIN prod ON(cart.cart_prod = prod.prod_id);
        
SELECT cart_prod
FROM cart;

SELECT prod_id
FROM prod;

SELECT mem_id, mem_name, cart_member, cart_prod
FROM member, cart
WHERE member.mem_id = cart.cart_member;

--실습4
SELECT customer.cid, cnm, pid, day, cnt
FROM customer, cycle
WHERE customer.cid = cycle.cid
AND cnm IN('brown', 'sally');
--
SELECT cid, cnm, pid, day, cnt
FROM customer NATURAL JOIN cycle
WHERE cnm IN('brown', 'sally');

--실습5
SELECT customer.cid, cnm, cycle.pid, pnm, day, cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
AND cycle.pid = product.pid
AND cnm IN('brown', 'sally');
--
SELECT cid, cnm, pid, pnm, day, cnt
FROM customer NATURAL JOIN cycle NATURAL JOIN product
WHERE cnm IN('brown', 'sally');


--실습6
SELECT customer.cid, cnm, cycle.pid, pnm, SUM(cnt)
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
AND cycle.pid = product.pid 
GROUP BY customer.cid, cnm, cycle.pid, pnm;
--
--고객이름이랑 pid로만 그룹바이해도 애용제품별 건수를 만들어낼 수 있음
--왜냐면  cid 랑 cnm이랑 1:1매칭이니까.
--cid 1: 브라운, 2: sally 로.똑같음. (아래)
SELECT a.cid, customer.cnm, a.pid, a.pid, product.pnm, a.cnt
FROM
    (SELECT cid, pid, SUM(cnt) cnt
    FROM cycle
    GROUP BY cid, pid) a, customer, product
WHERE a.cid = customer.cid
AND a.pid = product.pid;

--
SELECT cid, cnm, pid, pnm, SUM(cnt)
FROM customer NATURAL JOIN cycle NATURAL JOIN product
GROUP BY cid, cnm, pid, pnm;

--실습7
SELECT cycle.pid, pnm, SUM(cnt) 
FROM cycle, product
WHERE cycle.pid = product.pid
GROUP BY  cycle.pid, pnm;
--
SELECT pid, pnm, SUM(cnt)
FROM cycle NATURAL JOIN product
GROUP BY pid, pnm;

--오라클문법에서는 셀렉에 컬럼명 적어야해.
--안시sql 문법에서는 컬럼명 적으면 안돼
--연습을 더 해보자.
--과제 8~13

select a.EMPLOYEE_ID, a.first_name, a.last_name 
, b.EMPLOYEE_ID, b.MANAGER_ID, b.first_name, b.last_name
from employees a, employees b
where a.employee_id = b.manager_id
  and b.EMPLOYEE_ID=108;
  
select * from EMPLOYEES;

-- a : 매니져, b : 사원

SELECT mng_id, a. first_name || a. last_name mgr_name, employee_id, b. first_name || b. last_name name, jobs.job_id, job_title
FROM employees a, employees b, jobs
WHERE jobs. job_id = employees.job_id
AND a.employee_id = b.manager_id;
