--�ǽ� join 0_3
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

--exerd �ٿ�޾Ҵ�. ��ġ�ϰ�
--���������ֽ� model ���� ���ȭ�鿡�ְ�
--exerd�Ҵ��� ���θ����>�Ϲ�>������Ʈ���� model ������Ʈ������
--�������ִ°��� �� ������Ʈ�ӿ� �ٿ�����.


--exerd ���� scott �������� ������̺�� �μ����̺��� �� �� �ִ�.
--���輱�� �ִ� ��, ���� ��.
--���輱�� ������ ���谡 ������ ����.���濡 ������ ����.
--
--�ǽ� join_1
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
--�ǽ� join_2

SELECT buyer_id, buyer_name, prod_id,prod_name
FROM prod, buyer
WHERE prod_buyer = buyer_id ;
--
SELECT buyer_id, buyer_name, prod_id,prod_name
FROM prod JOIN buyer ON (prod_buyer = buyer_id);

--�ǽ� join_3-------------------------------------------------------------------------???
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

--�ǽ�4
SELECT customer.cid, cnm, pid, day, cnt
FROM customer, cycle
WHERE customer.cid = cycle.cid
AND cnm IN('brown', 'sally');
--
SELECT cid, cnm, pid, day, cnt
FROM customer NATURAL JOIN cycle
WHERE cnm IN('brown', 'sally');

--�ǽ�5
SELECT customer.cid, cnm, cycle.pid, pnm, day, cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
AND cycle.pid = product.pid
AND cnm IN('brown', 'sally');
--
SELECT cid, cnm, pid, pnm, day, cnt
FROM customer NATURAL JOIN cycle NATURAL JOIN product
WHERE cnm IN('brown', 'sally');


--�ǽ�6
SELECT customer.cid, cnm, cycle.pid, pnm, SUM(cnt)
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
AND cycle.pid = product.pid 
GROUP BY customer.cid, cnm, cycle.pid, pnm;
--
--���̸��̶� pid�θ� �׷�����ص� �ֿ���ǰ�� �Ǽ��� ���� �� ����
--�ֳĸ�  cid �� cnm�̶� 1:1��Ī�̴ϱ�.
--cid 1: ����, 2: sally ��.�Ȱ���. (�Ʒ�)
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

--�ǽ�7
SELECT cycle.pid, pnm, SUM(cnt) 
FROM cycle, product
WHERE cycle.pid = product.pid
GROUP BY  cycle.pid, pnm;
--
SELECT pid, pnm, SUM(cnt)
FROM cycle NATURAL JOIN product
GROUP BY pid, pnm;

--����Ŭ���������� ������ �÷��� �������.
--�Ƚ�sql ���������� �÷��� ������ �ȵ�
--������ �� �غ���.
--���� 8~13

select a.EMPLOYEE_ID, a.first_name, a.last_name 
, b.EMPLOYEE_ID, b.MANAGER_ID, b.first_name, b.last_name
from employees a, employees b
where a.employee_id = b.manager_id
  and b.EMPLOYEE_ID=108;
  
select * from EMPLOYEES;

-- a : �Ŵ���, b : ���

SELECT mng_id, a. first_name || a. last_name mgr_name, employee_id, b. first_name || b. last_name name, jobs.job_id, job_title
FROM employees a, employees b, jobs
WHERE jobs. job_id = employees.job_id
AND a.employee_id = b.manager_id;
