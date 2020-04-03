INSERT INTO dept Values (99, 'ddit', 'daejeon');
COMMIT;

--�ǽ� sub4
--������ : empno �� ���� deptno �� �ƴѰ� ��ȸ

SELECT *
FROM dept
WHERE  deptno NOT IN (SELECT deptno
                      FROM emp);
---������ ���
SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                        FROM emp);
--
SELECT dept.*
FROM dept, emp
WHERE dept.deptno = emp.deptno(+)
AND emp.deptno IS NULL;

--�ǽ�5
--cid=1 �� ���� �������� �ʴ� ��ǰ
SELECT *
FROM product
WHERE pid NOT IN(SELECT pid
                  FROM cycle
                  WHERE cid = 1
                    );

--�ǽ� 6
SELECT *
FROM cycle
WHERE cid = 1
AND pid IN (SELECT pid
            FROM cycle
            WHERE cid = 2);

--�ǽ� 7 --sub6 �� ������� ����, ��ǰ���� �߰�.
--sql �� �����ϱⰡ �����. �ǵ���� ������ ����.

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


--<<EXISTS ������>>
--������ �����ϴ� ���������� ������� �����ϴ��� üũ.
--������ �����ϴ� �����͸� ã���� ������������ ���� ã�� �ʴ´�.
--�������� �����ص� �ѰǸ� ã���� ����. 
--���翩�θ� Ȯ���ϴ°� ����.

--ECISTS �� ������ �÷��� ���ʿ� ���� ����. 
--��ȣ�����÷����·� �ۼ��� ����.

--�Ŵ����� �����ϴ� ���� ��ȸ
SELECT *
FROM emp a
WHERE EXISTS (SELECT 'x'
            FROM emp b
            WHERE b.empno = a.mgr);
--x ???���ڵ� ���ڵ� ��������� x �� ���?ó�� �η�η� ����.
--ŷ�� �Ŵ����÷��� ���̾ ��ȸ �ȵ�. 13�� ������.

--�Ŵ����� �����ϴ� ���� ���� ��ȸ
SELECT *
FROM emp e
WHERE EXISTS (SELECT '�޷�'
                FROM emp m
                WHERE m.empno = e.mgr);
                
--�ǽ� 8
--�Ŵ����� �����ϴ� ���� ������ȸ. ���������� ������� �ʰ� �ۼ��ϼ���.
SELECT *
FROM emp
WHERE mgr IS NOT NULL;
--
SELECT *
FROM emp e, emp m
WHERE e.mgr = m.empno;

--�ǽ� 9
SELECT product.*
FROM product
WHERE EXISTS (SELECT cycle.pid
                FROM cycle,product
                WHERE cid = 1
                AND cycle.pid = product.pid);

--���̵� 1�� ������ �ʴ� ����Ŭ pid�� ���δ�Ʈ �Ǿ��̵�

SELECT *
FROM product
WHERE EXISTS (SELECT 'x'
                FROM cycle
                WHERE cid = 1
                AND cycle.pid = product.pid);
--����Ŭ���� �̻���� �Դ� ��ǰ�� üũ�ϰ���� ��. ��ǰ���̵� �ִ��� Ȯ���غ�����.
--�������� ���δ�Ʈ �Ƚᵵ �Ǵ°ǰ�?? ���� �������� �������־����. EXISTS�ڿ� ���°�
--
-- �ǽ� 10
SELECT *
FROM product
WHERE NOT EXISTS (SELECT 'x'
                FROM cycle
                WHERE cid = 1
                AND cycle.pid = product.pid);




--<<���տ���>>
--�÷� Ȯ��(���η� Ȯ��) : JOIN
--���� �Ұ� ���� Ȯ��
--1. UNION/UNION ALL
--: UNION �� �츮�� �˰��ִ� ������ ���ÿ� �����ϴ� �κ��� ���ŵ�.
--�����պκ��� �˾Ƴ������� ������ �ϰ�, �ѹ��� �����Ű���� �Ѵ�. �ӵ��� �ټ� ����.
--:UNION ALL�� �ߺ��� �˻���������. �ߺ��� ���� �� ����.
--���� �����͵��� �������� ���� Ȯ���� ����. �����ڿ��� ������� �Ѱ��ذ�. ���Ͽ¿� ���� �ӵ� ����.
--2. INTERSECT
--: ������.
--3. MINUS
--:������. A-B �� ���̿��� �� ����. �����պκе� ����.

--���տ����� �ߺ��̳� ������ ����!
--���տ����� ���Ʒ��� ���� Ȯ����. �׷����� ���Ʒ� ������col�� ������ Ÿ���� ��ġ����Ѵ�.

--

--UNION :  ������, �� ������ �ߺ����� �����Ѵ�.
--�������� SALES �� ������ ������ȣ, ���� �̸� ��ȸ�ض�.
--��, �Ʒ� ������� �����ϱ⶧���� �����տ����� �ϰ� �� ��� �ߺ��Ǵ� �����ʹ� �ѹ��� ǥ���Ѵ�.

SELECT empno,ename
FROM emp
WHERE job = 'SALESMAN'

UNION

SELECT empno,ename
FROM emp
WHERE job = 'SALESMAN';

--UNION ALL
--������ ����� �ߺ� ���Ÿ� ���� �ʴ´�. �� �Ʒ� ������� �ٿ��ֱ⸸ �Ѵ�.
SELECT empno,ename
FROM emp
WHERE job = 'SALESMAN'

UNION ALL

SELECT empno,ename
FROM emp
WHERE job = 'SALESMAN';


--���տ����� ���ռ��� �÷��� �����ؾ��Ѵ�.
--�÷������� �ٸ���� ������ ���� �ִ� ������� ������ �����ش�.
SELECT empno,ename, ''
FROM emp
WHERE job = 'SALESMAN'

UNION ALL

SELECT empno,ename, job
FROM emp
WHERE job = 'SALESMAN';




--���δٸ� ������ ������
--�ߺ����� �ʴ� ��� �ΰ��� ���� �����Ͱ� 2�谡 ��.
SELECT empno,ename
FROM emp
WHERE job = 'SALESMAN'

UNION

SELECT empno,ename
FROM emp
WHERE job = 'CLERK';


--������ INTERSECT
--�� ���հ� �������� �����͸� ��ȸ
--�� ���տ� �Ʒ� ������ ������ ���Ե�.
--���� �Ʒ����ո� ���ð��̴�.
SELECT empno, ename, job
FROM emp
WHERE job IN ('SALESMAN', 'CLERK')

INTERSECT

SELECT empno, ename, job
FROM emp
WHERE job IN ('SALESMAN');



--���̳ʽ� ������
--��, �Ʒ� ������ �������� �� ���տ��� ������ ������ ��ȸ
-- �������� ��� ������, �����հ� �ٸ��� ������ ���� ������ ��� ���տ� ������ �ش�.
--����� �κ� ���� CLERK �� ��ȸ�� �� ���̴�.
SELECT empno, ename, job
FROM emp
WHERE job IN ('SALESMAN', 'CLERK')

MINUS

SELECT empno, ename, job
FROM emp
WHERE job IN ('SALESMAN');
--���տ����� ��ü�� �� �Ⱦ�. ���ԵǸ� UNION ALL �� ��.

--<<���տ������� Ư¡>>
--���� �̸��� ù��° ������ �÷��� ������.
--ORDER BY���� ���տ������� ���� ������ ���� ���Ŀ� ����� �� �ִ�.
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

--���Ͽ� �� �����ϰ� �ߺ��� ���ŵȴ�.
--�������� �⺻������ ������������ ���ĵǳ�, ���� ������ �������� �ʴ´�.
--�ߺ��� �����ϴ� �������� ���Ŀ����� �̷����.
--���Ͽ� ���� ����
--ORDER BY �� ���÷��� ������Ѵ�.


--���±����ؿ°� ���������͸� ���� �ǵ��� �ʾ�����
--�Ʒ� DML �� �������� ���������� �����Ѵ�. 


--<<DML>>
--((WHEN)) 
--�����͸� �űԷ� �߰��� ��
--��������Ʈ�� ������ ��
--���������͸� ������ ��

--1. insert
--���̺� ���ο� �����͸� �Է�.
--INSERT INTO tanle[(�÷� �÷�...)]
--values(value[, value]);
DESC emp;
--INSERT �� �÷��� ������ ��� :
--�������� �÷��� ���� �Է��� ���� ������ ������ ����Ѵ�. DESC�� �˾ƺ� �÷��� ������� ����ؾ��Ѵٴ� ��.
--���ȣ�� �ʼ��� �ƴ� ������. �ʿ��Ҷ��� �ʿ�������� �˾ƺ���.
--

SELECT *
FROM dept;

DELETE dept
WHERE deptno = 99;

--�����͸� ������ �Ŀ��� COMMIT ���� ������ Ȯ�����ų�, ROLLBACK ���� ������ ����ϰų�.
--�� �� �ϳ��� �ؾ��Ѵ�.


--dept ���̺� 99�� �μ���ȣ, ddit ������, daejeon �������� ���� ������ �Է�
--
INSERT INTO dept(deptno, dname, loc)
            VALUES (99, 'ddit', 'daejeon');
            
--�÷��� ����� ��� ���̺��� �÷� ���� ������ �ٸ��� �����ص� ����� ����.
INSERT INTO dept(loc, deptno, dname)
            VALUES ('daejeon', 99, 'ddit');
ROLLBACK;

SELECT *
FROM dept;

-- �÷��� ������� �ʴ� ��� : ���̺��� �÷� ���� ������ ���� ���� ����Ѵ�.
INSERT INTO dept VALUES ('daejeon', 99, 'ddit');

--���� �Է����� ������ NULL�� �Էµ�.

--INSERT DATE Ÿ��.
--1. SYSDATE
DESC emp;
INSERT INTO emp VALUES (9998, 'sally', 'SALESMAN', NULL, SYSDATE, 500, NULL, NULL);

SELECT *
FROM emp;
--2. ����ڷκ��� ���� ���ڿ��� DATE Ÿ������ �����Ͽ� �Է�.
DESC emp;
INSERT INTO emp VALUES (9997, 'james', 'CLERK', NULL, TO_DATE('20191202','yyyymmdd'), 500, NULL, NULL);
--���ε庯���� �Ǵ°���?? �غ���

ROLLBACK;

SELECT *
FROM emp;

--insert �������� �����͸� �ѹ��� �Է�
--SELECT ����� ���̺� �Է��� �� �ִ�.
INSERT INTO emp
SELECT 9998, 'sally', 'SALESMAN', NULL, SYSDATE, 500, NULL, NULL
FROM dual
UNION ALL
SELECT 9997, 'james', 'CLERK', NULL, TO_DATE('20191202','yyyymmdd'), 500, NULL, NULL
FROM dual;

ROLLBACK;
--���̺� ����� ������ ��ġ�� �ʵ��� ��� rollback���ִ���!





