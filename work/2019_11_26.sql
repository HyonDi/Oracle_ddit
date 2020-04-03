--��¥���� �Լ�
--ROUND, TRUNC
--(MONTHS_BETWEEN) ADD_MONTHS, NEXT_DAY
--LAST_DAY : �ش� ��¥�� ���� ���� ������ ����(DATE)

--�� : 1,3,5,7,8,10,12 : 31��
--   : 2 - ���� ���� 28,29
--   : 4,6,9,11 : 30��
--������ ��Ʈ���̸� ���� ���� ��������¥�� ���� �� �ֵ�.
SELECT SYSDATE, LAST_DAY(SYSDATE)
FROM dual;

SELECT :yyyymm PARAM, TO_CHAR(LAST_DAY (TO_DATE (:yyyymm,'yyyymm')), 'DD') DT
FROM dual;
--���ε庯��(������ ����� �ٸ�.) ����(����Ŭsqpl)���� :yyyymm ���� �ϸ� �ȴ�.

--SYSDATE �� yyyy/mm/dd ������ ���ڿ��� ����.
--
SELECT TO_CHAR(TO_DATE(TO_CHAR(SYSDATE, 'yyyy-mm-dd HH24:MI:SS'), 'yyyy-mm-dd HH24:MI:SS'), 'YYYY-MM-DD HH24:MI:SS')
FROM dual;
--�� �ð��� 00:00:00 ����?? ���ڷ� �ٲܶ��� �ð��� �߷���������. �׷��� �ȳ���!!
--ó�� sysdate �� í�� �ٲܶ��� HH24:MI:SS �� �Ἥ �ð������� �������ְ� �ؾ��Ѵ�.

SELECT TO_CHAR(sysdate,'yyyy-mm-dd hh24:MI:ss')
FROM dual;

SELECT TO_DATE(TO_CHAR(SYSDATE, 'yyyy-mm-dd'),'yyymmddhh') 
FROM dual;
--TO_DATE �� ǥ���Ǵ°Ŷ� TO_CHAR �� ǥ���Ǵ°� �˾ƾ��ҵ�
--HH24:MI:SS  �� ���ڿ������� �Ǵ°ǰ�?�ФФФФФФФФФФФФФФФ�
--------------------------------------------------------------------------------------------------------

--<<����ȯ>>
--����� ����ȯ
--TO_NUMBER
--TO_DATE
--TO_CHAR

--������ ����ȯ
--VARCHAR2 or CHAR -> NUMBER
--CARCHAR2 or CHAR -> DATE
--NUMBER -> VARCHAR2
--DATE -> VARCHAR2
-- ������ ����ȯ�� �Ͼ�� �ʵ��� ������ Ÿ���� �� ����� �Ѵ�.

--empno�� 7369�� ���� ���� ��ȸ�ϱ�
SELECT *
FROM emp
WHERE empno =  '7369';
--���⼭ �ڵ������� ����ȯ�� �Ͼ��. �ֳĸ� empno �� ������ NUMBER Ÿ���ε� ���ڿ� �˻��� �ߴµ���
--���������� ������ ����.
SELECT *
FROM emp
WHERE empno =  TO_NUMBER('7369');
--�̷����ϸ� ���ڿ��� ���ڷ� ����ȯ�ѰŴϱ� �Ǳ��ϴµ� �Ǵ��� �ȵǴ����� ��.
--EXPLAIN PLAN FOR  �ϴ� Ű���带 �����ָ� ��� �����ȹ? �� �������� �� �� ����.
--�� �ؿ���     SELECT *
--             FROM TABLE(dbms_xplan.display);    �̰� �����.

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno =  TO_NUMBER('7369');

SELECT *
FROM TABLE(dbms_xplan.display);
--�����ȹ����
--������ �Ʒ��� �д´�.
--�ڽĸ�尡 ������ �ڽĸ����� �д´ٰ�?
--sqlde?�������� �ϳ���.

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE TO_CHAR(empno) = '7369';
SELECT *
FROM TABLE(dbms_xplan.display);

--
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7300 + '69' ;
SELECT *
FROM TABLE(dbms_xplan.display);

--
SELECT *
FROM emp
WHERE empno = 7300 + '69' ;

--
SELECT *
FROM emp
WHERE hiredate >= '1981/06/01';
--��¥ Ư�� �����ؾ���. DATE Ÿ���� ������ ����ȯ�� ����� ������ �ʴ´�.
--�츮�� ����ϴ� dbms �� �츮����� �������־ �����ϱ� ��.
--
SELECT *
FROM emp
WHERE hiredate >= TO_DATE ('1981/06/01', 'YY/MM/DD');
--YY -> 19
--RR --> 50 /19, 20 �� ���ڸ����� ������ ���� ���� 50�̻��̸� 1900����, 50�̸��̸� 2000���� ����.
--���ڸ����϶��� ��� ����.


--������ ĥ������?

--����ȯ ����--> ���ڿ�, ����--> ����
--���� ������ �ʾ�. db���� �� ���� ���ø����̼Ƿ��������������ִ� ���� �ֱ⶧��.
--����ȭ?������ ���� ������?
--���� : 1000000 --> 1,000,000.00 (��� ���ڷ�.. ����)(�̰� �ѱ��� ���.)
-- ���Ͽ����� 1.000.000,00 �̶����.

--��¥ ���� - YYYY,MM,DD,HH24, MI, SS �� �־���.
--���� ���� - ���� ǥ�� : 9, �ڸ� ������ ���� 0 ǥ�� : 0, ȭ����� : L
--              1000�ڸ� ���� : , �Ҽ��� : . 

--���ڸ� ���ڿ��� �ٲ� �� : TO_CHAR(����, '����')
--���� ������ ����� ��� ���� �ڸ����� ����� ǥ���ؾ� �Ѵ�.
SELECT empno, ename, sal,TO_CHAR (sal,'9,999L') fm_sal
FROM emp;

SELECT TO_CHAR(10000000000000, '999,999,999,999,999,999')
FROM dual;
--ū ������ ��� 9 �� ���� �������.



--NULL ó�� �Լ� : NVL, NVL2, NULLIF, COALESCE

--NVL(expr1, expr2) : �Լ� ���� �ΰ���.
--expr1 �� NULL �̸� expr2 �� ��ȯ.
--expr1 �� NULL �� �ƴϸ� expr1 �� ��ȯ.
--NULL�� ���� ��ü�� ���� ���ڷ� ������ �ִ� ��.
SELECT empno, ename, comm, NVL(comm, -1) nvl_comm
FROM emp;

--NVL2(expr1, expr2, expr3)
--expr1 IS NOT NULL expr2 ����
--expr1 IS NULL expr3 ����
--�̰Ŵ� expr1 �� �������� ����.
SELECT empno, ename, comm, NVL2 (comm, comm, -1) nv2_comm
FROM emp;
--�̷����ϸ� NVL �̶� ���� ���.

--NULLIF(expr1, expr2)
--expr1 = expr2     NULL ����.
--expr1 != expr2    expr1�� ����.

--NULL ���� ����� �ִ�.
--comm �� NULL �϶� comm+500 : NULL 
--NULLIF(NULL,NULL) : NULL
--comm �� NULL �� �ƴ� �� comm+500 : comm +500
--NULL IF(comm, comm+500) : comm

SELECT empno, ename, comm, NULLIF(comm, comm + 500) NULLIF_comm
FROM emp;

--COALESCE(expr1, expr2, expr3.....)
--���� �߿� ù��°�� �����ϴ� NULL�� �ƴ� expr N�� ����.
--expr1 IS NOT NULL     expr1 �� ����.
--expr1 IS NULL COALESECE (expr2, expr3.....) �߿� ���� �ƴ� ù��° ���� ����.
--



SELECT empno, ename, comm, sal, COALESCE(comm, sal) coal_sal
FROM emp;

--�Ǽ� fn
SELECT empno, ename, mgr, NVL(mgr, 9999) mgr_n, 
        NVL2(mgr, mgr, 9999) mgr_n_1,
        COALESCE(mgr, 9999) mgr_n_2
FROM emp;
--�������ΰ���? �ڿ����°� ���� ����? �ؾ������ ����. �������Ŀ��� ������ ã�ư���.
--����!

--�ǽ� fn 5
SELECT userid, usernm, reg_dt,NVL(reg_dt, SYSDATE) n_reg_dt
FROM users
WHERE userid NOT IN('brown');


--Condition
--1. case 2. decode

--1. case
--case �� �����ؼ� end �� ����.
--when ���� ����� ��. ������ �� �� ����.
--����Ʈ : else 
--emp.job �÷� �������� 'SALESMAN'�̸� sal �� *1.05 �� �����϶�.
--'MANAGER' �� sal �� * 1.10
--'PRESIDENT' �̸� *1.20 ����.
--empno, ename, job, sal �� ����.
--�� �� ������ �ƴ� ��� sal ����.
--AS bonus

SELECT empno, ename, job, sal,
        CASE
            WHEN job = 'SALESMAN' THEN sal * 1.05
            WHEN job = 'MANAGER' THEN sal * 1.10
            WHEN job = 'PRESIDENT' THEN sal * 1.20
            ELSE sal
        END bonus,
        comm,
        --NULL ó�� �Լ� ������� �ʰ� CASE ���� �̿��Ͽ�
        --comm�� NULL�� ��� -10�� �����ϵ��� �����ض�.
        CASE
            WHEN comm IS NULL THEN -10 
            ELSE comm
        END case_null
        
FROM emp;
--case ���� ����? sql ���� �ʴ�. ������ �ִ�.


--2. decode
--decode(���ذ�, ��ġ1, ����1, ��ġ2, ����2.....�������� ����Ʈ)

--if ������ �ٲٸ�?
--����Ƽ����


SELECT empno, ename, sal, job,
    DECODE(job, 'SALESMAN', sal*1.05), 'MANAGER', sal*1.10, 'PRESIDENT', sal*1.20, sal) bonus
FROM emp;
--decode �� ��� ���ٿ� ���� ����.

--���� con 144p, 145p. 1��, 2��.
--14��
SELECT empno, ename, deptno,
    CASE
        WHEN deptno = 10 THEN 'ACCOUNTING'
        WHEN deptno = 20 THEN 'RESEARCH'
        WHEN deptno = 30 THEN 'SALES'
        WHEN deptno = 40 THEN 'OPERATIONS'
        ELSE 'DDIT'
    END DNAME
FROM emp;

--con1
--CASE
-- WHEN conditon THEN return1
--END
--DECODE(col1|expr, serch1, return1, sheach2, return2.....default)


--con2. �ǰ�������� ��������� ��ȸ�ϴ� ������ �ۼ��ϼ���.
--���� �⵵�� ¦��/ Ȧ���� ����
--hiredate ���� �Ի�⵵�� ¦��/ Ȧ������

--1. MOD(TO_CHAR (SYSDATE, 'YYYY')), 2) --> ���س⵵ ����(0�̸� ¦����, 1�̸� Ȧ����)
--2. MOD(TO_CHAR(hiredatr, 'YYYY')), 2)--> hiredate�� �⵵ ����.

SELECT empno, ename, hiredate ,
       TO_NUMBER( TO_CHAR(hiredate, 'YY')) yy1,
       TO_NUMBER( TO_CHAR(SYSDATE, 'YY')) yy2,
-- TO_CHAR(sysdate, 'YY')+TO_CHAR(hiredate, 'YY') yy3,        
-- DECODE(MOD(TO_CHAR(sysdate,'YYYY')-TO_CHAR(hiredate,'YYYY'),2 ),0 ,'���������',1,'����������'),
        CASE
            WHEN MOD(TO_NUMBER( TO_CHAR(hiredate, 'YY')), 2) 
            = MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YY')),2) THEN '�ǰ����� �����'
             ELSE '�ǰ����� ������'
        END contact_to_doctor
FROM emp;




--        DECODE(�÷���,��1,��2)
--------------------------------
SELECT empno, ename,
CASE
    WHEN MOD(TO_CHAR (SYSDATE, 'YYYY'), 2) = MOD(TO_CHAR(hiredate, 'YYYY'), 2) 
    THEN '�ǰ����� �����' 
    ELSE '�ǰ����� ������'
END
FROM emp;

--���⵵ �ǰ����� ����ڸ� ��ȸ�ϴ� ���� �ۼ��ض�. (2020��)
SELECT empno, ename,
CASE
    WHEN MOD(TO_CHAR(hiredate, 'YYYY'),2) = MOD(2020,2)--NOD(TO_CHAR(SYSDATE, 'YYYY')+1, 2) �̰� �������� ���� ����.
    THEN '�ǰ����� �����'
    ELSE '�ǰ����� ������'
END
FROM emp;

--�ڵ带 �ٲ����ʾƵ� �ùٸ��� �۵��ϵ��� �ڵ带 �ۼ��ؾ��Ѵ�.

--�ǽ� cond3


SELECT userid, usernm, alias, reg_dt,
    CASE
        WHEN MOD(TO_CHAR(reg_dt,'YYYY'),2) = MOD(TO_CHAR(SYSDATE,'YYYY'),2)
        THEN '�ǰ����� �����'
        ELSE '�ǰ����� ������'
    END CONTACTTODOCTOR
FROM users;
------------------------------------------------------------------------------------------------
SELECT a.userid, a.usernm, a.alias, a.reg_dt,
        DECODE(mod(a.yyyy,2), mod(a.this_yyyy,2),'�ǰ��������', '�ǰ���������')
FROM
    (SELECT userid, usernm, alias, reg_dt, TO_CHAR(reg_dt, 'YYYY') yyyy,
        TO_CHAR(SYSDATE, 'YYYY') this_yyyy
        FROM users) a;
        --�ζ��κ�� �Ͻ�.





--TO_DATE ���� �Ұ�.  TO_CHAR �� ���ڶ� �����ϸ� ���ڷ� �ٲ�.������!
---------------------------------------------------------------------------------------------------------
--�����ڽ� : ����ȭ ����.
--�Ǿ��ȿ� ���ο� �Ǿ��� ����� ��.
--1. ��������
--2. �����ð�  ��Ȳ�� �׸� 4�Ⱑ ����..�������� �ֽ� ��. (=����Ŭ �𺧷��� ����)
--3. �������� ����.
--4. ��ġ�Ǵµ� ���� �ɸ�.
--5. ����Ŭ��.
--6. ������ �Ǹ� ����� ���̵�, ��й�ȣ ��� oracle �� ���´�.
--7. ������(�̸����� â �ְ� �� ��.)���� ����Ŭ�𺧷��۵��� ��Ŭ��> 
--����> ��Ʈ��ũ> ���� ��� > ��Ʈ ������ >  �Խ�Ʈ��Ʈ ���ڸ� ����. ȣ��Ʈ ��Ʈ(=1522)���� 1 ����.(=1521)
--�߸��� �����̶�� �� �� :

--8. �ý��ۿ� �ϵ���� ����ȭ üũ ����. ������. (������ ���� �ؾ��Ѵ�.
--9. �����ڽ�.org Ȩ������ ����.> �ٿ�ε� �����ڽ�(�ʷϹڽ�) Ŭ��.>
--�Ʒ�ĭ �ͽ��ټ� ��(Extension Pack ���� All supported platforms ������ 20�ް� ¥�� ������
--�ϳ� �ٿ�ε� �޴´�.
--10. ����> ȯ�漳������ Ȯ�� �̶�� ��ư ������. �÷��� ������ ��� �ٿ������ �����ؼ� ��ġ.
--

--����Ŭ���α׷� �Ѱ� ���� + �� �̸� : vm_scott, �̸� : scott, ��й�ȣ : oracle,
--������Ʈ:  1022, SID :orcle    �� �ٲٰ� �׽�Ʈ->    
--(������ �� �� ������ �����Ǿ��� �����ִ��� Ȯ������. �����־����.)
--�����Ǿ��� �ý��� ���� �����, ��� �� : �ٿ��ֱ��� ���� ����, ���������� �κ��� ���� ��ġ �ٲ�.
--����, �������ѿ� PCXX �κе� �ٲ�־����.