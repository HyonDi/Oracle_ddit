--JOIN �� ����
--Outer join
--�÷� ������ �����ص�(������ �����ص�) ������ �Ǵ� ���̺��� �����Ͱ� �������� �ϴ� join
--left outer join : (���̺� 1 LEFT OUTER FOIN ���̺�2) : ���̺� 1�� ���̺�2�� �����Ҷ� ���ο� �����ϴ��� ���̺� 1���� �����ʹ� 
--                      ��ȸ�� �ǵ��� �Ѵ�. ���ο� ������ �࿡�� ���̺�2�� �÷����� �������� �����Ƿ� NULL�� ǥ�õȴ�.
--right outher join : 
--full outer join(left + right)( left�Ѱ� right�Ѱ� ��ġ�� �ߺ������ε� �ߺ� ���ŵǴ� ��찡 ���� ����.) �̷��� 3���� ����.
--������ �Ǵ� ���̺��� �����̳� �������̳�. ����������.
--���� null�� ������ ��ȸ

--left outer join 
SELECT e.ename, e.empno, m.ename, m.empno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno);
--null ���� ���Դ�~!

--join ������ where���� �ִ°Ͱ� on���� �ִ°��� ��� �ٸ���?
SELECT e.ename, e.empno, m.ename, m.empno
FROM emp e LEFT OUTER JOIN emp m 
        ON (e.mgr = m.empno AND m.deptno = 10);
--�μ���ȣ�� 10���� �ֵ鸸 ������ �϶�� ������ On���� �־���.
SELECT e.ename, e.empno, e.deptno, m.ename, m.empno, m.deptno
FROM emp e LEFT OUTER JOIN emp m 
        ON (e.mgr = m.empno AND m.deptno = 10);
        --deptno Ȯ���� �غ��Ҵ�.
        
--
SELECT e.ename, e.empno, e.deptno, m.ename, m.empno, m.deptno
FROM emp e LEFT OUTER JOIN emp m 
        ON (e.mgr = m.empno)
WHERE m.deptno=10;
--on���� ������������ �����Ͱ� �������ʴ´�. ���������� ���ʿ� �߶���ȱ⶧��.
 --on���� ����ϴ°Ͱ�where���� ����ϴ°��� �ٸ���.
 
 
 --����Ŭ�������δ�?
--�ϴ� �Ʒ��� �Ƚ�.
 SELECT e.ename, e.empno, m.ename, m.empno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno);
--�̰� �ٲ㺸��
--�Ϲ����ΰ� �������� �÷��� (+) ǥ��.
--(+)ǥ�� : �����Ͱ� �������� �ʴµ� ���;��ϴ� ���̺��� �÷����ٰ� ǥ���Ѵ�.
--���� left outer join �Ŵ���
--on(����.�Ŵ�����ȣ = �Ŵ���.������ȣ)
--����Ŭ �ƿ���
--where ����.�Ŵ�����ȣ = �Ŵ���.������ȣ(+) --�Ŵ����ʿ� �����Ͱ� �������� �����Ƿ�.
--�Ʒ� ����Ŭ
SELECT e.ename, e.empno, m.ename, m.empno
FROM emp e ,emp m
WHERE e.mgr = m.empno(+);

--�Ŵ��� �μ���ȣ ����
--�Ƚÿ��� �������� ����ߴ� ��.
--�ƿ��������� ������� ���� ��Ȳ. 
--�ƿ��� ������ ����Ǿ�� �ϴ� ��� �÷��� (+)�� �پ�� �ƿ��������� ����ȴ�.
SELECT e.ename, e.empno, m.ename, m.empno
FROM emp e ,emp m
WHERE e.mgr = m.empno(+)
AND m.deptno = 10;
--�ƿ������� ����Ǿ���ϴ� ���̺��� ��� �÷��� (+)�ٿ�������. (+)�ٿ�����
--�Ʒ��� on���� �־������� ������ ����� ����Ѵ�.
SELECT e.ename, e.empno, m.ename, m.empno
FROM emp e ,emp m
WHERE e.mgr = m.empno(+)
AND m.deptno(+) = 10;

--���Ͻ��� �ؾֺ��ôپƾ�
--emp ���̺��� 14���� ������ �ְ� 14���� 10,20,40 �μ��� �� �μ��� ���Ѵ�.
--������ dept ���̺��� 10,20,30,40 �� �μ��� ����.
--�μ���ȣ, �μ���, �ش�μ��� ���� ���� ���� �������� ������ �ۼ��غ�����.
--�Ƚ� * ���ʿ� �߽��̵Ǵ� ���̺��� �����!!! emp�� �տ����� �ȵ�!
SELECT dept.deptno, dept.dname, COUNT(emp.deptno)
FROM dept LEFT OUTER JOIN emp ON (dept.deptno = emp.deptno) 
GROUP BY dept.deptno, dept.dname;
--����Ŭ
SELECT dept.deptno, dept.dname, NVL(COUNT(emp.deptno),0)
FROM emp, dept
WHERE emp.deptno(+) = dept.deptno
GROUP BY dept.deptno, dept.dname;

----------------------������ ��
SELECT dept.deptno, dept.dname, NVL(emp_cnt.cnt, 0) cnt
FROM
dept,
(SELECT deptno, COUNT(*) cnt
FROM emp
GROUP BY deptno) emp_cnt
WHERE dept.deptno = emp_cnt.deptno(+);
--�Ƚ�
SELECT dept.deptno, dept.dname, NVL(emp_cnt.cnt, 0) cnt
FROM
dept LEFT OUTER JOIN
                    (SELECT deptno, COUNT(*) cnt
                    FROM emp
                    GROUP BY deptno) emp_cnt
                ON(dept.deptno = emp_cnt.deptno);

--
--Ȥ�� ���������� ���̸�..?


--righr outer join
SELECT e.ename, e.empno, m.ename, m.empno
FROM emp e RIGHT OUTER JOIN emp m ON (e.mgr = m.empno);


--fullouter : left outer+righr outer - �ߺ������ʹ� �ѰǸ� �����..
--����Ŭsql�� �̿��� full outer foin������ �������� �ʴ´�!
SELECT e.ename, e.empno, m.ename, m.empno
FROM emp e FULL OUTER JOIN emp m ON (e.mgr = m.empno);

--���� Ȯ���ϴ°� : ���տ����� union ��������.
--����Ʈ�ƿ��Ͷ� ����Ʈ�ƿ����� ���Ͽ¿� ���̳ʽ� Ǯ�ƿ��ʹ� 0�̵�.
--���ͼ�Ʈ(������)
--����Ʈ�ƿ��� ���Ͽ� ����Ʈ�ƿ��� ���ͳ�Ʈ Ǯ�ƿ��;���� Ǯ�ƿ��������̶� ��������� ���ð���.

--�ǽ� outerjoin1
SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty
FROM prod LEFT OUTER JOIN buyprod 
ON (prod.prod_id = buyprod.buy_prod
    AND buyprod.buy_date = TO_DATE('20050125','yyyymmdd')) ;


--�ǽ� 2
SELECT NVL(buy_date,TO_DATE('20050125','yyyymmdd')) buy_date, 
        buy_prod, prod_id, prod_name, buy_qty
FROM prod LEFT OUTER JOIN buyprod 
ON (prod.prod_id = buyprod.buy_prod
    AND buyprod.buy_date = TO_DATE('20050125','yyyymmdd')) ;

--�ǽ�3
SELECT NVL(buy_date,TO_DATE('20050125','yyyymmdd')) buy_date, 
        buy_prod, prod_id, prod_name, NVL(buy_qty, 0) buy_qty
FROM prod LEFT OUTER JOIN buyprod 
ON (prod.prod_id = buyprod.buy_prod
    AND buyprod.buy_date = TO_DATE('20050125','yyyymmdd')) ;
    
    ----------
    
SELECT TO_DATE(:yyyymmdd, 'YYYYMMDD') buydate, buyprod.buy_prod,
prod.buy_
;


--�ǽ�4  --�̷����ϴ°� �³�??? cid �κ� null �ΰ͵�...
SELECT product.pid, pnm, NVL(cid, 1) cid, NVL(day, 0) day, NVL(cnt,0) cnt
FROM product LEFT OUTER JOIN cycle 
ON (product.pid = cycle.pid
AND cid = 1)
ORDER BY pid;

-----������ ���
--100,400�� ����.
SELECT *
FROM cycle
WHERE cid=1;

--200,300 ����.
SELECT *
FROM product;

SELECT product.pid, product.pnm, :cid, NVL(cycle.day,0),NVL(cycle.cnt,0)
FROM cycle, product
WHERE cycle.cid(+)=1
AND cycle.pid(+) = product.pid;



--��������
SELECT product.pid, pnm, cid,day, cnt
FROM product LEFT OUTER JOIN cycle 
ON (product.pid = cycle.pid
AND cid = 1);


--�ǽ�5
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

--����Ŭ���� �������� �ƿ������� ���ȵ�. �ζ��κ����ؾ��� �Ʒ������� ���ľ��Ѵ�.

SELECT a.pid, a.pnm, a.cid, customer.cnm, a.day, a.cnt
FROM
(SELECT product.pid, product.pnm, :cid cid, NVL(cycle.day,0) day, NVL(cycle.cnt, 0) cnt
FROM cycle, product
WHERE cycle.cid(+) = :cid
AND cycle.pid(+) = product.pid) a, customer
WHERE a.cid = customer.cid;



--�̷��Դ� �ȵǳ���.
SELECT product.pid, pnm, NVL(cycle.cid,'1')cycle, NVL(cnm, 'brown') cnm, 
        NVL(day,0) day, NVL(cnt,0) cnt
FROM product LEFT OUTER JOIN cycle ON(product.pid = cycle.pid)
        LEFT JOIN customer ON(cycle.cid = customer.cid);
        
--hash outer?
--�ƿ��������� ���������̺��� �����Ͱ� ������ ���ɸ鿡�� ������ ����
--����Ŭ���� �����÷��� �ؽ��Լ��� ������ �ؽ��Լ��� ���� ���� �����س���.
--����Ŭ 10g ���ķδ� ���������̺���� �����ʰ� �������ʺ��� ����.
--�ؽ��Լ��� �����ϸ� �����Ͱ� ��������. �˰������...?
--��й�ȣ����Ҷ��� �ؽ��Լ� ����.
--��ȣȭ

--������Ʈ?������?

