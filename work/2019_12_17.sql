--with �� .
--with ����̸� AS(
--      ��������
--  )
-- SELECT *
-- FROM ����̸�

--deptno, avg(sal) avg_(sal)
--�ش�μ��� �޿������ ��ü������ �޿���պ��� ���� �μ��� ���� ��ȸ/.
SELECT deptno, avg(sal) avg_sal
FROM emp
GROUP BY deptno
HAVING avg(sal) > (SELECT avg(sal) FROM emp);

--�� ������ with�� ����� �ۼ�.
WITH dept_sal_avg AS (
    SELECT deptno, avg(sal) avg_sal
    FROM emp
    GROUP BY deptno),
    emp_sal_avg AS(
        SELECT avg(sal)avg_sal FROM emp    
    )
SELECT *
FROM dept_sal_avg
WHERE dept_sal_avg.avg_sal > (SELECT avg_sal FROM emp_sal_avg);

--with ���? : 
-- �׽�Ʈ��. ��¥ ���̺� ����� ��������. ȸ�������� �����ټ�������.

--<<  ��������  >>
--�޷¸����
--CONNECT BY LEVERL <=N
--���̺��� row �Ǽ��� N��ŭ �ݺ��Ѵ�.
--CONNECT BY LEVEL ���� ����� ����������
--select  ������ level �̶�� Ư�� �÷��� ����� �� �ִ�.
--������ ǥ���ϴ� Ư���÷����� 1���� �����ϸ� ROWNUM�� �����ϴ�
--���� ���Ե� START WITH, CONNECT BY ������ �ٸ����� ���� �ȴ�.

--�ش� ����� ��¥�� ���ϱ��� �����ϴ°�?? �� �˾Ƴ��� �Ѵ�.


--201911
--�Ʒ��� 12���� �̻��� �޷�. ����� ������ �غ���.
SELECT /*dt, d,*/
    MAX(DECODE(d,1,dt)) sun, MAX(DECODE(d,2,dt))m,MAX(DECODE(d,3,dt))t,MAX(DECODE(d,4,dt))w,MAX(DECODE(d,5,dt))th,MAX(DECODE(d,6,dt))f,MAX(DECODE(d,7,dt))sat
FROM
(SELECT TO_DATE(:YYYYMM, 'yyyymm') + (level-1) dt,
        TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level-1),'D') d,
        TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level),'iw') iw
from DUAL  
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'yyyymm')), 'DD'))
GROUP BY iw
ORDER BY iw;


-- 1�����ε� dd�� 23�̻��̸� 60������ �ٲٱ�? iw = 1 && dd>23 ->iw+59 X
SELECT CASE 
        WHEN TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level),'iw') = '1' AND TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level-1),'DD') > 23 
        THEN iw = iw+59 
        DEFAULT iw 
        END,
    MAX(DECODE(d,1,dt)) sun, MAX(DECODE(d,2,dt))m,MAX(DECODE(d,3,dt))t,MAX(DECODE(d,4,dt))w,MAX(DECODE(d,5,dt))th,MAX(DECODE(d,6,dt))f,MAX(DECODE(d,7,dt))sat
FROM
(SELECT TO_DATE(:YYYYMM, 'yyyymm') + (level-1) dt,
        TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level-1),'D') d,
        TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level),'iw') iw
from DUAL  
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'yyyymm')), 'DD'))
GROUP BY iw
ORDER BY iw;

--12�� && 1������ �ο�� 6���� ����. X
SELECT a.*, DECODE(ROWNUM,1,6, ROWNUM) aa
FROM
(SELECT /*dt, d,*/
    MAX(DECODE(d,1,dt)) sun, MAX(DECODE(d,2,dt))m,MAX(DECODE(d,3,dt))t,MAX(DECODE(d,4,dt))w,MAX(DECODE(d,5,dt))th,MAX(DECODE(d,6,dt))f,MAX(DECODE(d,7,dt))sat
FROM
(SELECT TO_DATE(:YYYYMM, 'yyyymm') + (level-1) dt,
        TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level-1),'D') d,
        TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level),'iw') iw
from DUAL  
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'yyyymm')), 'DD'))
GROUP BY iw
ORDER BY iw)a
ORDER BY aa;


--�ش����ڰ� ���� �Ͽ����� ���ؼ� �װŷ� �׷�����Ѵ�.
SELECT /*dt, d,*/  
    MAX(DECODE(d,1,dt)) sun, MAX(DECODE(d,2,dt))m,MAX(DECODE(d,3,dt))t,MAX(DECODE(d,4,dt))w,MAX(DECODE(d,5,dt))th,MAX(DECODE(d,6,dt))f,MAX(DECODE(d,7,dt))sat
FROM
(SELECT TO_DATE(:YYYYMM, 'yyyymm') + (level-1) dt,
        TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level-1),'D') d,
        TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level),'iw') iw
FROM DUAL  
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'yyyymm')), 'DD'))
GROUP BY dt-(d-1)
ORDER BY dt-(d-1);


--
SELECT /*dt, d,*/  
    MAX(DECODE(d,1,dt)) sun, MAX(DECODE(d,2,dt))m,MAX(DECODE(d,3,dt))t,MAX(DECODE(d,4,dt))w,MAX(DECODE(d,5,dt))th,MAX(DECODE(d,6,dt))f,MAX(DECODE(d,7,dt))sat
FROM
(SELECT TO_DATE(:YYYYMM, 'yyyymm') + (level-1) dt,
        TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level-1),'D') d,
        TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level),'iw') iw
FROM DUAL  
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'yyyymm')), 'DD'))
GROUP BY iw
ORDER BY sat;


-- NULL ���� ����, �Ŀ� ��¥ �������ϱ�. ����.........................�̤̤̤̤̤̤̤�
SELECT /*dt, d,*/  
    MAX(DECODE(d,1,dt)) sun, MAX(DECODE(d,2,dt))m,MAX(DECODE(d,3,dt))t,MAX(DECODE(d,4,dt))w,MAX(DECODE(d,5,dt))th,MAX(DECODE(d,6,dt))f,MAX(DECODE(d,7,dt))sat
FROM
    (SELECT TO_DATE(:YYYYMM, 'yyyymm') + (level-1) dt,
            TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level-1),'D') d,
            TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level),'iw') iw
    FROM DUAL  
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'yyyymm')), 'IW'))
GROUP BY dt-(d-1)
ORDER BY dt-(d-1);
--NVL�� �� �ڸ�ä��¹��

--level�� �ٲٴ� ���
--201910 : 35, ù ���� �Ͽ��� : 20190929 , ������ ���� ����� : 20191102

SELECT /*dt, d,*/  
    MAX(DECODE(d,1,dt)) sun, MAX(DECODE(d,2,dt))m,MAX(DECODE(d,3,dt))t,MAX(DECODE(d,4,dt))w,MAX(DECODE(d,5,dt))th,MAX(DECODE(d,6,dt))f,MAX(DECODE(d,7,dt))sat
FROM
    (SELECT TO_DATE(:YYYYMM, 'yyyymm') + (level-1) dt,
            TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level-1),'D') d,
            TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level),'iw') iw
    FROM DUAL  
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'yyyymm')), 'IW'))
GROUP BY dt-(d-1)
ORDER BY dt-(d-1);
---------------------------------------------------------------------------------------------------
SELECT LDT-FDT+1
FROM
(SELECT LAST_DAY(TO_DATE(:yyyymm,'yyyymm')) dt,

       LAST_DAY(TO_DATE(:yyyymm,'yyyymm')) + 7 - TO_CHAR(LAST_DAY(TO_DATE(:yyyymm,'yyyymm')),'D') ldt,
       
        TO_DATE(:yyyymm,'YYYYMM') - (TO_CHAR(TO_DATE(:yyyymm,'yyyymm'),'D')-1) fdt        
FROM dual);


--


SELECT /*dt, d,*/  
    MAX(DECODE(d,1,dt)) sun, MAX(DECODE(d,2,dt))m,
    MAX(DECODE(d,3,dt))t,MAX(DECODE(d,4,dt))w,
    MAX(DECODE(d,5,dt))th,MAX(DECODE(d,6,dt))f,
    MAX(DECODE(d,7,dt))sat
FROM
    (SELECT TO_DATE(:yyyymm,'YYYYMM') - (TO_CHAR(TO_DATE(:yyyymm,'yyyymm'),'D')-1) + (level-1) dt, --�ش� ���� 1��?�Ͽ���?��¥
            TO_CHAR(TO_DATE(:yyyymm,'YYYYMM') - (TO_CHAR(TO_DATE(:yyyymm,'yyyymm'),'D')-1) + (level-1),'D') d,
            TO_CHAR(TO_DATE(:yyyymm,'YYYYMM') - (TO_CHAR(TO_DATE(:yyyymm,'yyyymm'),'D')-1) + (level),'iw') iw                                 
    FROM DUAL  
    CONNECT BY LEVEL <= (SELECT ldt - fdt +1
                            FROM 
                            (SELECT LAST_DAY(TO_DATE(:yyyymm,'YYYYMM')) dt,
                                     LAST_DAY(TO_DATE(:yyyymm,'yyyymm')) + 7 - TO_CHAR(LAST_DAY(TO_DATE(:yyyymm,'yyyymm')),'D') ldt,
                                    TO_DATE(:yyyymm,'YYYYMM') - (TO_CHAR(TO_DATE(:yyyymm,'yyyymm'),'D')-1) fdt        
                             FROM dual)))                         
GROUP BY dt-(d-1)
ORDER BY dt-(d-1);
--���� ���ظ� �غ���!
--�٤Ӹ����
SELECT /*dt, d,*/  
    MAX(DECODE(d,1,dt)) sun, MAX(DECODE(d,2,dt))m,
    MAX(DECODE(d,3,dt))t,MAX(DECODE(d,4,dt))w,
    MAX(DECODE(d,5,dt))th,MAX(DECODE(d,6,dt))f,
    MAX(DECODE(d,7,dt))sat
FROM
    (SELECT level, trunc((level-1)/7) m,
    TO_DATE(:yyyymm,'YYYYMM') - (TO_CHAR(TO_DATE(:yyyymm,'yyyymm'),'D')-1) + (level-1) dt, --�ش� ���� 1��?�Ͽ���?��¥
            TO_CHAR(TO_DATE(:yyyymm,'YYYYMM') - (TO_CHAR(TO_DATE(:yyyymm,'yyyymm'),'D')-1) + (level-1),'D') d,
            TO_CHAR(TO_DATE(:yyyymm,'YYYYMM') - (TO_CHAR(TO_DATE(:yyyymm,'yyyymm'),'D')-1) + (level),'iw') iw                                 
    FROM DUAL  
    CONNECT BY LEVEL <= (SELECT ldt - fdt +1
                            FROM 
                            (SELECT LAST_DAY(TO_DATE(:yyyymm,'YYYYMM')) dt,
                                     LAST_DAY(TO_DATE(:yyyymm,'yyyymm')) + 7 - TO_CHAR(LAST_DAY(TO_DATE(:yyyymm,'yyyymm')),'D') ldt,
                                    TO_DATE(:yyyymm,'YYYYMM') - (TO_CHAR(TO_DATE(:yyyymm,'yyyymm'),'D')-1) fdt        
                             FROM dual)))                         
GROUP BY m
ORDER BY m;












--�˾Ƶ־��ϴ°�. (2019_12_17_sales �� ����)
--1. CONNECT BY LEVEL �� ���� ���� �÷� �����.
--2. DECODE �� ���� ���� �÷����� �ٲ۰�. 
--3. GROUP �Լ��� �����ؼ� ������ �ֵ��� �� ������ ǥ�õǵ��� �����.
--************************************************************************************************************



--��������
--FROM  ������ CONNECT BY �� �´�.
--�ֻ������� �����ϴ°�(Ȥ�� ��¶�� �Ʒ������Ҷ�)�� �����. �ڱ� ���� ��� ��带 ����. ��ü�� ����� ���� ��.
--�߰� Ȥ�� ���������� �����ϴ� ���� �����. �θ� ����.

--�������� ����� �ƴ��� ���� Ȯ���Ѵ�.
SELECT *
FROM dept_h
WHERE deptcd='dept0';

--
SELECT dept_h.*, LEVEL --LEVEL �� �������������� �ߺ��� ���ڰ� ���� �� �ִ�.
FROM dept_h
START WITH deptcd='dept0' --=�������� DEPTCD = 'DEPT0' --> XXȸ��(�ֻ�������)
CONNECT BY PRIOR deptcd = p_deptcd
    --�̹� ���� PRIOR deptcd(= �ֻ������� XXȸ��dml deptcd)
    --p_deptcd =  ������ ���� �������� p_deptcd. (=XXȸ�� ������ �� �μ�.)
    --�� �������� �����̾ �� �����а� ���������ϱ� �� ��ü �� ����ȴ�. �ڽ����� �Ѱ� ����������.
    --prior �� ��� �ٲ�鼭 ���� ����������.
    
;

SELECT *
FROM Sales.Customer AS c
INNER LOOP JOIN Sales.CustomerAddress AS ca ON c.CustomerID = ca.CustomerID

SELECT *
FROM Sales.Customer AS c
INNER JOIN Sales.CustomerAddress AS ca ON c.CustomerID = ca.CustomerID 
OPTION (LOOP join);
------------------------------
SELECT *
FROM Sales.Customer AS c
     INNER MERGE JOIN Sales.CustomerAddress AS ca ON c.CustomerID = ca.CustomerID

SELECT *
FROM Sales.Customer AS c
  	INNER JOIN Sales.CustomerAddress AS ca ON c.CustomerID = ca.CustomerID
OPTION (MERGE join);
--
SELECT *
FROM Sales.Customer AS c
     INNER HASH JOIN Sales.CustomerAddress AS ca ON c.CustomerID = ca.CustomerID

SELECT *
FROM Sales.Customer AS c
     INNER JOIN Sales.CustomerAddress AS ca ON c.CustomerID = ca.CustomerID
OPTION (HASH join);


