--ROWNUM�� ���� ���� ���� �����ʹ� ��ȸ �Ұ���!!
/*
ī�信 ���ü��� �ڹٰ����ϴ¹��?

*/
--emp ���̺��� empo, ename �� ���ľ��� �ο���� 1~10�� �ุ ��ȸ.
SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 1 AND 10;


--11~14�� �ุ ��ȸ

SELECT ROWNUM, b.*  --*�� ����Ʈ�� ������ ����, �տ� �޸��� �� �� ����. 
FROM
(SELECT ROWNUM a, empno, ename
FROM emp
) b
WHERE a BETWEEN 11 AND 14;


--emp ���̺��� ��� ������ �̸��÷����� �������� �������� ����
--11~14��° ���� ������ ���� ��ȸ�ϴ� ������ �ۼ��غ�����.

SELECT ROWNUM,  c.*
FROM
(SELECT ROWNUM b, a.*
FROM
(SELECT *
FROM emp
ORDER BY ename)a) c
WHERE b BETWEEN 11 AND 14; 



/*
�Լ� : function
single row function :
���� ���� �������� �۾��ϰ�, ��� �ϳ��� ����� ��ȯ.
Ư�� �÷��� ���ڿ� ���� : length(ename)

multi row function : 
���� ���� �������� �۾��ϰ�, �ϳ��� ����� ��ȯ. �׷��Լ� : count, sum, avg


 -character
 ��ҹ���
 LOWER, UPPER, INITCAP(ù�ܾ �빮�ڷ�.)
 ���ڿ� ����
CONCAT, SUBSTR(���ڿ����� �Ϻκ� ����), LENGTH
INSTR(���ڿ��� Ư�� ���ڿ��� ����ִ���(�ش� ���ڿ��� �ε��� ��ȯ), LPAD(���ڿ� ����, �����ʿ� Ư�� ���ڿ� ����),
RPAD, TRIM(���ڿ� �յڷ� ����,Ȥ�� Ư������ ����, REPLACE

-DUAL table
sys ������ �ִ� ���̺�. ������ ��� ����. DUMMY �÷� �ϳ��� �����ϸ� ���� 'X' �̸� �����ʹ� �� �ุ ����.
��� �뵵 : �����Ϳ� ���þ��� �Լ�����, ������ ����
merge ������, ������ ������
*/

SELECT *
FROM dual;
--SINGLE ROW FUNCTION : ��� �ѹ��� FUNCTION�� ����.
--1���� ���� INPUT --> 1���� ������ OUTPUT (COLUMN)
--'Hello, World'
SELECT LOWER ('Hello, World') low, UPPER ('Hello, World') upper,
    INITCAP ('Hello, World') init
FROM dual;


--emp���̺��� �� 14���� ������(����)�� ����.(14���� ��)
--���� 14���� ���� ���´�. ��� �ѹ��� ������ �ƴ�.
SELECT LOWER ('Hello, World') low, UPPER ('Hello, World') upper,
    INITCAP ('Hello, World') init
FROM emp;

--�÷��� function ����.
SELECT empno, LOWER (ename) low_enm
FROM emp;

--���� �̸��� smith�� ����� ��ȸ�Ϸ��� �빮��/�ҹ���?
--�빮��. �ֳĸ� �����Ҷ����� �Լ� lower �� ������� �������⿡�� �ҹ�������,
--���� ��ϵ��ִ� �����ʹ� �빮�ڴ�. �ٲ���� �ƴ�.
SELECT empno, LOWER (ename) low_enm
FROM emp
WHERE ename = 'SMITH' ;

--�Լ��� where�������� ��� �����ϴ�.
SELECT empno, LOWER (ename) low_enm
FROM emp
WHERE ename = UPPER ('smith') ;

--�Լ��� ���̺� �����ߴ�. �̰� ���� �ȵǴ� ����̷�. ��?
--�º��� �����ϸ� �ȵȴ�. ������������ ġȯ���� �����κ��� �����ض�.
--�ε��� Ȱ���� �ȵȴ�. ���� ���̺��� ������ ��������� ����� �����µ�,
--�ҹ��ڷ� ������� �� ���̺��� ��ü �� �о����. ...
--���̺� �÷��� �����ص� ������ ����� ���� �� ������, ���̺� �÷����ٴ� ������� �����ϴ� ���� �ӵ��鿡�� ����.
--�ش� �÷��� �ε����� �����ϴ��� �Լ��� �����ϰ� �Ǹ� ���� �޶����� �Ǿ�
--�ε����� Ȱ�� �� �� ���� �ȴ�.
-- ���� : FBI (Function Based Index)
SELECT empno, LOWER (ename) low_enm
FROM emp
WHERE LOWER(ename) = 'smith' ;

--������!!!!

--ppt 99p

--HELLO
-- ,
--WORLD
--HELLO, WORLD (�� ������ ���ڿ� ����� �̿�, CONCAT �Լ��� ����Ͽ� ���ڿ� ����
SELECT CONCAT (CONCAT ('HELLO', ', '), 'WORLD'),
        'HELLO' || ', ' || 'WORLD',
        SUBSTR ('HELLO, WORLD', 1, 5)--SUBSTR(���ڿ�, �����ε���, �����ε���.)
        --�����ε����� 1����, �����ε��� ���ڿ����� �����Ѵ�.
        --�ڹٿ����� �Ǵٸ�. 0���� ����, �����ε��� ���ڿ� ������.
FROM dual;


--INSTR : ���ڿ��� Ư�� ���ڿ��� �����ϴ���, ������ ��� ������ �ε����� ����.
SELECT INSTR('HELLO, WORLD','O')
FROM dual;

--���ڿ��� Ư�� �ε��� ���ĺ��� �˻��ϵ��� �ɼ�.
SELECT INSTR('HELLO, WORLD','O', 6)
FROM dual;   --'HELLO, WORLD' ���ڿ��� 6��° �ε��� ���Ŀ� �����ϴ� 'O'���ڿ��� �ε��� ����

--��ø�ؼ� ���?
SELECT INSTR('HELLO, WORLD', 'O',INSTR('HELLO, WORLD','O') + 1)
FROM dual; 

--L/RPAD Ư�����ڿ��� ����/�����ʿ� ������ ���ڿ� ���̺��� ������ ��ŭ ���ڿ��� ä�� �ִ´�.
SELECT
LPAD ('HELLO, WORLD', 15, '*')L1,
RPAD ('HELLO, WORLD', 15, '*')R1,
LPAD ('HELLO, WORLD', 15)L2 --DEFAULT ä�� ���ڴ� �����̴�.
FROM dual;

--REPLACE (��� ���ڿ�, �˻����ڿ�, ������ ���ڿ�)
--����ڿ����� �˻� ���ڿ��� ������ ���ڿ��� ġȯ.
SELECT 
REPLACE('HELLO, WORLD', 'HELLO', 'hello') rep1
FROM dual;


--TRIM : ���ڿ� ��, ���� ������ ����.
SELECT
'   HELLO, WORLD   ' before_trim,
TRIM ('   HELLO, WORLD   ') after_trim,
TRIM ('H' FROM 'HELLO, WORLD') after_trim2
FROM dept;

--���� ���� �Լ�
--ROUND : �ݿø�. ROUND (����, �ݿø� �ڸ�)
--TRUNC : ���� - TRUNC (����, �����ڸ�)
--MOD : ������ ���� MOD (������, ����) ex) MOD (5, 2) : 1.  
SELECT ROUND(105.54, 1) R1, --�ݿø� ����� �Ҽ��� ���ڸ����� ��������(�Ҽ��� ��°�ڸ����� �ݿø�)
        ROUND(10.55, 1) R2,
        ROUND(10.55, 0) R3, --�Ҽ��� ù���� �ڸ����� �ݿø�.
        ROUND(105.54, -1) R4 --���� ù��° �ڸ����� �ݿø�.        
FROM dual;
--�� �������� �ʴ� �κ� ������̺� ����� �����غ���.

--TRUNC
SELECT TRUNC(105.54, 1) R1, --���� ����� �Ҽ��� ���ڸ����� ��������(�Ҽ��� ��°�ڸ����� ����)
        TRUNC(105.55, 1) R2,
        TRUNC(105.55, 0) R3, --�Ҽ��� ù���� �ڸ����� ����.
        TRUNC(105.54, -1) R4 --���� ù��° �ڸ����� ����. (���� = �����ε�)       
FROM dual;

--MOD (������, ����) �������� ������ ���� ������ ��.
--MOD(M,2) �� ��� ���� : (0),(1) : (0 ~ (����-1) ���� ��� ������ �ִ�.)

SELECT MOD (5, 2) M1, --5/2 = ���� 2,[ �������� 1.]
        MOD (142,23) M2
FROM dual;

--emp ���̺��� sal �÷��� 1000���� ������ �� ����� ������ ���� ��ȸ�ϴ� sql �ۼ�
--ename, sal, sal/1000 �� ���� ��, sal/1000�� ���� ������.

SELECT ename, sal, TRUNC(sal/1000, 0), MOD(sal, 1000) sal1,
    TRUNC(sal/1000, 0) * 1000 + MOD(sal, 1000) sal2
FROM emp;
--??????????


--��¥. DATE : �����, �ð�, ��, �� 
SELECT ename, TO_CHAR(hiredate, 'YYYY/MM/DD hh24-mi:ss')--yyyy/mm/dd
FROM emp;
--����-ȯ�漳��-�����ͺ��̽�-NLS : ��¥������ �⺻������ �ٲ� �� �ִ�.


--SYSDATE : ������ ���� DATE�� �����ϴ� �����Լ�, Ư���� ���ڰ� ����.
--��¥���� : DATE +/- ���� : ������ŭ DATE�� N����ĭŭ ���Ѵ�.
--�ð� ���� : DATE +/- (����/24)
SELECT TO_CHAR(SYSDATE,'YYYY-MM_DD hh24:mi:ss')
FROM dual;
--SYSDATE �� ����ƮŸ��. ���� = ����.
SELECT  TO_CHAR(SYSDATE,'YYYY-MM_DD hh24:mi:ss') NOW,
        TO_CHAR(SYSDATE + 5,'YYYY-MM_DD hh24:mi:ss') AFTER5_DAYS,
        TO_CHAR(SYSDATE + 5/24,'YYYY-MM_DD hh24:mi:ss') AFTER5_HOURS,
        TO_CHAR(SYSDATE + 5/24/60,'YYYY-MM_DD hh24:mi:ss') AFTER5_MIN
FROM dual;
--���ڸ� 1~1������ ���ϴ°ͺ��� 1��(1,000,000,000,000)�� ���°� �� ������
--1�ð� = 3600��
--�ʴ� �ϳ����� ���ص� 3���� �ɸ��� ��


--date �ǽ� fn1
--1. 2019�� 12�� 31���� date������ ǥ��
SELECT TO_DATE('2019-12-31', 'yyyy-mm-dd')
FROM dual;
--2. 2019�� 12�� 31���� date ������ ǥ���ϰ� 5�� ������¥.
SELECT TO_DATE('2019-12-31', 'yyyy-mm-dd') - 5
FROM dual;
--3. ���糯¥
SELECT SYSDATE
FROM dual;
--4. ���糯¥���� 3���� ��.
SELECT SYSDATE-3
FROM dual;
--1,2,3,4 ����
SELECT TO_DATE('2019-12-31', 'yyyy-mm-dd') LASTDAY, 
        TO_DATE('2019-12-31', 'yyyy-mm-dd') - 5 LASTDAY_BEFORE5, 
        SYSDATE NOW, SYSDATE-3 NOW_BEFORE3
FROM dual;



--����ȯ DATE -> CHAR : TO_CHAR(DATE, '����')
--CHAR -> DATE : TO_DATE(��¥ ���ڿ�, '����')

--����
--YYYY, MM, DD, 
--D(������ ���ڷ� : �Ͽ��� 1, ������ 2, ȭ���� 3...����� 7)
--IW(���� : 1~53) : 1���� 52�� Ȥ�� 53�� ��. IM, HH, MI, SS

SELECT TO_CHAR(SYSDATE, 'YYYY') YY, --���� ����.
        TO_CHAR(SYSDATE, 'MM') MM, --���� ��
        TO_CHAR(SYSDATE, 'DD') DD, --���� ��
        TO_CHAR(SYSDATE, 'D') D, --���� ����(�ְ����� 1~7)
        TO_CHAR(SYSDATE, 'IW') IW, --���� ������ ����. (�ش� ���� ������� ������ ��������.)
--2019�� 12�� 31���� �������� �����°�?
        TO_CHAR(TO_DATE('2019-12-31', 'yyyy-mm-dd'),'IW') IW_20191231
        -- 1���� ����. �� �� ������� ���� ù°���̱� ����.
FROM dual;


--�ǽ� fn2
--���ó�¥�� ������ ���� �������� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�.
--1. ��-��-��
--2. ��-��-��-�ð�(24)-��-��
--3. ��-��-��
SELECT TO_CHAR(SYSDATE, 'yyyy-mm-dd') DT_DASH,
        TO_CHAR (SYSDATE, 'yyyy-mm-dd hh24-mi-ss') DT_DASH_WITH_TIME,
        TO_CHAR (SYSDATE, 'dd-mm-yyyy') DT_DD_MM_YYYY
FROM dual;

--��¥ ����. date Ÿ���� ROUND, TRUNC ����.
--ROUND(DATE, format)
--TRUNC(DATE, format)

--MM���� �ݿø�(11�� -> 1��)
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD hh24:mi:ss') now,
        --MM���� �ݿø�(11�� -> 1��)
        TO_CHAR(ROUND (SYSDATE, 'YYYY'),'YYYY-MM-DD hh24:mi:ss') NOW_YYYY,
        
        TO_CHAR(TRUNC(SYSDATE, 'MM'), 'yyyy-mm-dd hh24:mi:ss') NOW_MM,
         TO_CHAR(TRUNC(SYSDATE, 'DD'), 'yyyy-mm-dd hh24:mi:ss') NOW_DD
        --���赵 ��������.

FROM dual;
-- ppt 116p



--��¥�����Լ�
--MONTHS_BETWEEN (date1, date2) : date1�� date 2������ ���� ��.
--ADD_MONTHS(date,������ ������) : date���� Ư�� �������� ���ϰų� �� ��¥.
--NEXT_DAY(date, weekday(1~7) : dqte ���� ù ��° ��Ŭ�� ��¥
--LEST_DAY(date) : date�� ���� ���� ������ ��¥

--��MONTHS_BETWEEN(date1, date2)
SELECT MONTHS_BETWEEN(TO_DATE('2019-11-25','yyyy-mm-dd'),
       TO_DATE('2019-3-31','yyyy-mm-dd')) m_bet,
    TO_DATE('2019-11-25','YYYY-MM-DD') - 
    TO_DATE('2019-03-241','yyyy-mm-dd')d_m --�� ��¥ ������ ���ڼ�.
FROM dual;


--ADD_MONTHS(date, number(+, - ))
SELECT ADD_MONTHS(TO_DATE('20191125', 'yyyymmdd'), 5) NOW_AFTER5M,
     ADD_MONTHS(TO_DATE('20191125', 'yyyymmdd'), -5) NOW_BEFORE5M,
        SYSDATE +100 --100�� ���� ��¥(�� ���� 3-31, 2-28,29)
FROM dual;

SELECT--nextday, lastday ���� �� �� ��.
FROM dual;
--?????????????????
































