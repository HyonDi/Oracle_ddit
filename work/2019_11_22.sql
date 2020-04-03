-- ��ü�̸� 30�� �̳�, ������ ���ĺ�����, ���ĺ�, ����, _,$ 
-- ��ü�̸��� ������ �빮�ڷ� �����. 

--ppt 60p �ǽ� where8 emp ���̺� �μ���ȣ 10�ƴϰ� 
--�Ի糯¥ ������ ���� ���� ��ȸ.
SELECT *
FROM emp
WHERE deptno != 10
AND hiredate > To_DATE('19810601','yyyymmdd');

--NOT IN ���
SELECT *
FROM emp
WHERE deptno NOT IN (10)
AND hiredate > TO_DATE('19810601','yyyymmdd');

-- �ǽ� where 10
--NOT IN ���X, IN���. deptno sms 10,20,30 �ۿ� ���ٰ� ����.
SELECT *
FROM emp
WHERE deptno IN (20, 30)
AND hiredate > TO_DATE('19810601','yyyymmdd');

-- �ǽ� where 11
--job �� SALESMAN �̰ų�  �Ի糯¥ ---���� ��ȸ.
SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR hiredate > TO_DATE('19810601','yyyymmdd');

--�ǽ� where 12
SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR empno LIKE '78%';

--�ǽ� where 13
--��������  :  empno �� ���ڿ����Ѵ�. desk �� Ÿ���� ..
--desk �˻��غ��� empno�� number-> �������� (4) -> 4���ڷ� �̷���������� �� �� �ִ�.

SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR empno > 7800 
AND empno < 7900 ;
--||���� && �� �켱���� ����!

-- *dbms �� ����Ŭ�� ������ �б����ϰ� �ٲٴµ� �� �������� LIKE�����ڻ�� �� % �� _�� �Ƚ�������
-- ������ �м����ʿ䰡 ��� = ���� �����Ѵ�. �ű��Ѱ� ����.


--<<������ �켱����!>>
--1, ���������(*, /, +, -)
--2. ���ڿ� ����(||)
--3. �񱳿���(=, <=, <, >=, >)
--4. IS, [NOT]NULL, LIKE, [NOT] IN
--5. [NOT] BETWEEN
--6. NOT
--7. AND
--8. OR
--�Ϲ� ���а� ���������� ��ȣ�� ���� �켱������ ������ �� �ִ�.

--������ �켱���� (AND > OR)
--���� �̸��� SMITH �̰ų�, ���� �̸��� ALLEN�̸鼭 ������ SALESMAN �� ���� ã��.
SELECT *
From emp
WHERE ename = 'SMITH'
OR ename = 'ALLEN'
AND job = 'SALESMAN';
--������ �켱������ AND �κ��� ���� ���� �� �� OR�� ������ �򰥸����ʰ� �ٲ㺸��
SELECT *
From emp
WHERE ename = 'SMITH'
OR (ename = 'ALLEN' AND job = 'SALESMAN');
--��ȣ�� ���� �򰥸��� �ʰ���.


--���� �̸��� SMITH �̰ų� ALLEN �̸鼭 ������ SALESMAN�� ���
SELECT *
From emp
WHERE (ename = 'ALLEN' OR ename = 'SMITH')
AND job = 'SALESMAN';--???????????�� ���ö�

--where 14
--job �� SALESMAN �̰ų� �����ȣ�� 78�� �����ϸ鼭, �Ի����ڰ� 1981�� 6�� 1�� ����.
SELECT *
FROM emp
WHERE job ='SALESMAN'
OR empno LIKE '78%'
AND hiredate > TO_DATE('19810601','yyyy.mm.dd');

--����������
--TABLE ��ü���� �����͸� ����/��ȸ�� ������ �������� �ʴ´�.
--���������� �����Ͱ� �Էµ� ������� ��ȸ��.
--�����Ͱ� �׻� ������ ������ ��ȸ�Ǵ� ���� �������� ����.

--ORDER BY
--ASC : �������� (�⺻) = ���������� �����ö󰡴� ����. (ǥ����� ����� �⺻����.)
--DESC : �������� = ū������. ���� �������� ����. (������������ ���� ���ʹٸ�, �ݵ�� ǥ���ؾ��Ѵ�.)

--ORDER BY {���ı��� �÷� OR �÷���ȣ}[ASC OR DESC]....
--ORDER BY ename
--ORDER BY enam desc
--ORDER by ename desc, mgr
/*
SELECT col1, col2, col3...
FROM ���̺��
WHERE col1 = '��'
ORDER BY ���ı��� �÷�1, [ASC / DESK], ���ı����÷�2...[ASC / DESK]
*/

--������̺�(emp) ���� ������ ������ ���� �̸����� �������� �����϶�.
SELECT *
FROM emp
ORDER BY ename ASC; --���ı����� �ۼ����� ���� ��� �������� ����.

--������̺��� ������ ������ ���� �̸�(ename) ���� �������� ����.
SELECT *
FROM emp
ORDER BY ename DESC;

--��� ���̺��� ������ ������ �μ���ȣ�� �������� �����ϰ�, 
--�μ���ȣ�� �������� sal �������� �����϶�.
SELECT *
FROM emp
ORDER BY deptno, sal DESC ;

--��� ���̺��� ������ ������ �μ���ȣ�� �������� �����ϰ�, 
--�μ���ȣ�� �������� sal ��������, �޿��� �������� �̸����� �������������϶�.
SELECT *
FROM emp
ORDER BY deptno, sal DESC, ename ;

--���� �÷��� ALIAS�� ǥ��
SELECT deptno, sal, ename nm
FROM emp
ORDER BY nm;

--��ȸ�ϴ� �÷��� ��ġ �ε����� ǥ�� ����.
SELECT empno, deptno, sal, ename nm
FROM emp
ORDER BY 3; --��õ��������. �ش������� �������� �ʴ´ٴ� ���������Ͽ��� ��� ������.
--�÷� ������ �ǵ����� ���� ��� ���.


--�ǽ� orderby1

DESC dept;

SELECT *
FROM dept
ORDER BY dname;

SELECT *
FROM dept
ORDER BY loc DESC;

--�ǽ� orderby2
--emp���̺��� ��comm������ �ִ»���� ��ȸ ��,
--�� ���� �޴� ����� ���� ��ȸ�ǵ����ϰ�, �󿩰� ���� ��� ������� ��������.
--�� 0�λ���� ���°����� ������.
DESC emp;
SELECT *
FROM emp
WHERE comm IS NOT NULL 
AND comm !=0
ORDER BY comm DESC, empno;

--orderby 3
--emp ���̺��� �����ڰ� �ִ� ����鸸 ��ȸ,
--job ������ �������� ����, ������ ���� ��� ����� ū ����� ���� ��ȸ.
SELECT *
FROM emp
WHERE mgr IS NOT NULL
ORDER BY job, empno desc;

--order by 4
--emp ���̺��� 10�� �μ� Ȥ�� 30�� �μ� ����� �޿��� 1500�� �Ѵ� ����鸸 ��ȸ.
--�� �̸����� �������� ����.
SELECT *
FROM emp
WHERE deptno IN (10,30)
AND sal > 1500
ORDER BY ename desc;

--��ȣ!
--**tool���� �������ִ� ���� ��ȣ�� �÷����� ���� �� ������?
--SELECT query �� ��ȸ�� ������� �ο��� ���� ���� �÷�.
SELECT ROWNUM, deptno, ename -- SELECT ROWNUM ������ �÷�. HIGHNUM �� �ֳ�
FROM emp
ORDER BY deptno;
--���Ľ�Ų �� �ο���� �޾ƺ���
SELECT ROWNUM, a.*
FROM
(SELECT deptno, ename
FROM emp
ORDER BY deptno) a;



--ROWNUM�� �̹� ���� �����Ϳ� ������ �ο��ϴ� ��.
--���� ���� ���� �����Ͱ� �����ϴ� ���ǿ����� ��� �Ұ�.

SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM = 1;
--ROWNUM = equal �񱳴� 1�� ����.2 �ȵ�.
--������ ���� ���� ����
--WHERE ROWNUM =1;
--WHERE ROWNUM <= 2;
--WHERE ROWNUM < 4;
--BETWEEM 1 AND 10; //���� ���۸� �����ϴ�.

SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 1 AND 5;
--1���� �����ϴ� ��� ����.

--SELECT ���� ORDER BY ������ ���� ����
--SELECT -> ROWNUM -> ORDER BY
SELECT ROWNUM, empno, ename
FROM emp
ORDER BY ename;

SELECT ROWNUM snum, a.*
FROM
(SELECT ROWNUM fnum, empno, ename
FROM emp
ORDER BY ename) a;


--INLINE VIEW�� ���� ������ ���� �����ϰ�, �ش� ����� ROWNUM�� ������ �� �ִ�.

SELECT empno, ename
FROM emp
ORDER BY ename;
---------------------------------���⼭ ���� �̻���
SELECT ROWNUM, empno, ename
FROM (SELECT empno, ename
    FROM emp
    ORDER BY ename);
    
    emp_ord
    (SELECT empno, ename
    FROM emp
    ORDER BY ename);
  --�������̺��� ������ε�. 

--*ǥ���ϰ�, �ٸ� �÷� Ȥ�� ǥ������ ���� ��� *�տ� ���̺� ���̳�, ���̺� ��Ī�� �����ؾ��Ѵ�.
SELECT ROWNUM, a.empno
FROM (SELECT empno, ename
    FROM emp
    ORDER BY ename) a;

--�÷� �� �ƴ϶� ���̺��� ��Ī�� �� �� �ִ�. ���̺� �ڿ� ����, ��Ī �ָ� �ȴ�.
SELECT ROWNUM, a.*  --empno, ename
FROM (SELECT empno, ename
    FROM emp
    ORDER BY ename) a ;
--��ȣ�� ����ϴ°� �ζ��� �װǰ���    
    
SELECT empno, ename
FROM emp
ORDER BY ename;


--*�� ��Ī�� ��簡 �ʿ�. 
SELECT ROWNUM, a.*
FROM emp e;b  ?????????????

--==================================================
SELECT *
FROM emp;

SELECT ROWNUM snum, a.* 
FROM
(SELECT ROWNUM fnum, empno, ename, sal
FROM emp
ORDER BY sal) a;
--�÷�?�̶�°� ���̺� �� ���� �� ���ǰ�?
--========================================================
--ROWNUM, �������? : ����¡ó����� ����� �ִµ�,
--���̹�ī�� �Խ����� ����, �۵��� �ѹ��� ���������ʰ� 15���� �߶� �����ش�.
--
--

--ROW1
--emp���̺��� ROWNUM ���� 1~10�� ���� ��ȸ�ϴ� ������ �ۼ��غ�����.
--���ľ��� �����ϼ���, ����� ȭ��� �ٸ� �� �ֽ��ϴ�.
SELECT *
FROM emp;

SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM <= 12;


--row2
--rownum ���� 11~20(11~14)�� ���� ��ȸ�ϴ� ������ �ۼ��غ�����.
--��Ʈ: inline view �� ����ؾ��Ѵ�.
SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 11 AND 20;--�̰� ����. 1���� ���������� �ؾ߸� ����.
------------------------------------------------------------------------------
--row2 Ǯ��
SELECT ROWNUM, empno, ename
FROM emp;

SELECT a.*
FROM
(SELECT ROWNUM A , empno, ename
FROM emp) a
WHERE A BETWEEN 11 AND 20;
--���ʿ��� �� ��Ī�� �ٱ����� �����ϴ°��� �ٽ��̴�.
--�� ��Ī ���ָ� �ȵǴµ�?
--�Ŀ�..�𸣰ڴ�.

SELECT a.*
FROM
(SELECT ROWNUM sa, empno, ename
FROM emp) a
WHERE sa BETWEEN 11 AND 20;

SELECT ROWNUM sa, empno, ename
FROM emp
WHERE sa BETWEEN 11 AND 20;


--row3
--emp���̺��� ename ���� ������ ����� 11~14��° �ุ ��ȸ�ϴ� ������ �ۼ��ض�.
SELECT f.*
FROM (SELECT ROWNUM qw, ename
        FROM emp) f
ORDER BY ename
WHERE qw BETWEEN 11 AND 14;   

--ROWNUM�� �ű�� ������ ���� ���ϰ� �ҷ�������, �ҷ����� ������ �ű�ڴ����� ���� �˱�
--�������� ���� ���̺� f(emp ���̺� �ӿ��� �ο��, ename �� ����) �� 


--����! emp���̺��� ename ���� �������� ������ ����� 11~14��° �ุ ��ȸ�ϴ� ������ �ۼ��ض�.
--1. emp���̺� ��� ������ �̸��÷� ������������ ����.
--2. 1���� �ο�� ����.
--3. 2������ 11~14�� �̱�.

SELECT a.*
FROM
(SELECT ROWNUM qw, ename
FROM emp
ORDER BY ename) a
WHERE qw BETWEEN 11 AND 20
ORDER BY qw;
--
SELECT;

SELECT ROWNUM , e.*
FROM
(SELECT ROWNUM w, ename
FROM emp
ORDER BY ename) e
WHERE w BETWEEN 11 AND 14;


--2.���� �� �ο�� �ű⵵�� �ٲ���

SELECT ROWNUM, ename
FROM;


SELECT a.*
FROM
(SELECT ROWNUM qw, empno, ename
FROM emp) a
WHERE qw BETWEEN 2 AND 14;

SELECT *FROM(
SELECT ROWNUM AS rn, a.*
FROM(
SELECT *
FROM
(SELECT empno, ename
FROM emp
ORDER BY qw) a
)b
WHERE b.rn BETWEEN 11 AND 14;
_








SELECT * FROM
( 
SELECT ROWNUM AS RNUM ,a.*
FROM (
SELECT *
FROM emp
order by ename
)a
)b
where b.rnum   BETWEEN 11 AND 14;








