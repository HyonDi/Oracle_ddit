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
CONNECT BY PRIOR deptcd = p_deptcd;
    --�̹� ���� PRIOR deptcd(= �ֻ������� XXȸ��dml deptcd)
    --p_deptcd =  ������ ���� �������� p_deptcd. (=XXȸ�� ������ �� �μ�.)
    --�� �������� �����̾ �� �����а� ���������ϱ� �� ��ü �� ����ȴ�. �ڽ����� �Ѱ� ����������.
    --prior �� ��� �ٲ�鼭 ���� ����������.

SELECT LPAD('XXȸ��', 15, '*'),
        LPAD('XXȸ��', 15)
FROM dual;
--�����Ÿ� deptnm�鿩����� ���⽱���غ���.
SELECT dept_h.*, LEVEL, LPAD(' ', (LEVEL-1)*3) || deptnm --LEVEL �� �������������� �ߺ��� ���ڰ� ���� �� �ִ�.
FROM dept_h
START WITH deptcd='dept0' --=�������� DEPTCD = 'DEPT0' --> XXȸ��(�ֻ�������)
CONNECT BY PRIOR deptcd = p_deptcd;

--�������� �ǽ�2 (�����ý��ۺ� ����)
SELECT LEVEL lv,deptcd, LPAD(' ', (LEVEL-1)*3) || deptnm deptnm, p_deptcd
FROM dept_h
START WITH deptcd = 'dept0_02'
CONNECT BY PRIOR deptcd = p_deptcd;

--�����(����ĺ��� �����Ͱ� ���Գ����� ���� �Ϲ���.)
SELECT *
FROM dept_h;
--���������� �������� ����� �������� �ۼ�.
--�ڱ� �μ��� �θ�μ��� ������ �Ѵ�.
SELECT dept_h.*, LEVEL lv, LPAD(' ', (LEVEL-1)*3) || deptnm deptnm --������ ������ 1�� �ȴ�.
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY deptcd = PRIOR p_deptcd; --PRIOR �� �÷� �տ� �ٴ� ��.!
--������� �ΰ��� �Ǵ� ��쵵 �ִ�.
SELECT dept_h.*, LEVEL --������ ������ 1�� �ȴ�.
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY deptcd = PRIOR p_deptcd AND col = PRIOR col2;

--���������� ������ �����Ѱ�ó��. WHERE ��ó�� ������ ����.
SELECT dept_h.*, LEVEL --������ ������ 1�� �ȴ�.
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY deptcd = PRIOR p_deptcd AND PRIOR deptnm LIKE'������%';
--����γ��°� ����Ž���� ������ ����. (������ 1 ���� ǥ�õȴ�. ����� ����� ���.)

--��� = ����Ʈ�� ���??
--�ڹٿ���..�ڷᱸ�������??

--�ǽ�4
SELECT *
FROM h_sum;

DESC h_sum;

SELECT LPAD(' ', (LEVEL-1)*5)||s_id s_id, value --h_sum.*, level, LPAD(' ', (LEVEL-1)*5)||s_id
FROM h_sum
START WITH s_id = '0'
CONNECT BY PRIOR s_id = ps_id;

--�ǽ� 5
SELECT *
FROM no_emp;

DESC no_emp;

SELECT LPAD(' ', (level-1)*4) || org_cd,no_emp
FROM no_emp
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;





-- << ����ġ�� >> = pruing branch
--where ���� �������� ���� ����.
--�� �ٸ� ���̺���� ���� �������� �̿�Ǿ��� ��� ���ο� ����.
--������ connect by ���� ���̾���, �ƴϸ� �ۿ� ���� where ���� ���Ŀ� ���� ����� �ٸ�.
--connect by ���� ���� ���ǿ� �ȸ´¾ֵ��� �ƿ� ���� ��ü�� �ȵǰ�
-- where �������� ���� �� �߶󳻱�.

--���������� ���� ����
--FROM -> START WITH ~ CONNECT BY -> WHERE

--������ CONNECT BY ���� ����� ���.
-- . ���ǿ� ���� ���� ROW�� ������ �ȵǰ� ����.

--������ WHERE ���� ����� ���
-- . START WITH ~CONNECT BY ���� ���� ���������� ���� �����
-- WHERE ���� ����� ��� ���� �ش��ϴ� �����͸� ��ȸ.


--�ֻ��� ��忡�� ��������� Ž��.
SELECT *
FROM dept_h;

--CONNECTE BY ���� deptnm != '������ȹ��' ������ ����� ���.
SELECT *
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd AND deptnm != '������ȹ��' ;
--��ȹ�� �ؿ��ִ°͵��� ���� �ȳ��ðž�. ������� ������.
--�� 6�� ������ ��ȹ�ο� ���õȰ� ����!

--WHERE ���� deptnm != '������ȹ��' ������ ����� ���.
--
SELECT *
FROM dept_h
WHERE deptnm != '������ȹ��'
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;
--�� 8�� ���´�.  �̸��� ������ȹ�ΰ� �ƴ� ���� ����.


--����Ŭ���� �ִ� Ư���Լ�
--������������ ��� ������ Ư�� �Լ�.

--1. CONNECT _BY_ROOT(col) ���� �ֻ��� row�� col ���� �� ��ȸ.
--�ֻ�����尡 �ϳ��� �ƴѰ�쵵 �ִ�. ����� ����������.
--
SELECT deptcd, LPAD(' ', 4*(LEVEL-1)) || deptnm deptnm,
        CONNECT_BY_ROOT(deptnm) c_root
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

--2. SYS_CONNECT_BY_PATH(col, ������) : �ֻ��� row ���� ���� �ο���� col ���� �����ڷ� �������� ���ڿ�.
--�����ڷ� �������� ���ڿ� (EX : XXȸ�� - �����κε�������) . �溸����. 
SELECT deptcd, LPAD(' ', 4*(LEVEL-1)) || deptnm deptnm,
        LTRIM(SYS_CONNECT_BY_PATH(deptnm, '-'), '-') sys_path --LTRIM ���� �� ���� - �� �������״�. 
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

--3. CONNECT_BY_ISLEAF : �ش� ROW �� ������ ������� ( LEAF NODE)
-- LEAF NOD �� 1 ��ȯ. �Ϲ� ���� 0 ��ȯ.
SELECT deptcd, LPAD(' ', 4*(LEVEL-1)) || deptnm deptnm,
        CONNECT_BY_ISLEAF isleaf 
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

--�ǽ� 6
SELECT *
FROM BOARD_TEST;

SELECT seq, LPAD(' ',(level-1)*4)||title title
FROM BOARD_TEST
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq;

--�ǽ� 7
SELECT seq, LPAD(' ',(level-1)*4)||title title
FROM BOARD_TEST
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER BY seq DESC;

-- 
SELECT seq, LPAD(' ',(level-1)*4)||title title
FROM BOARD_TEST
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq DESC;

--
SELECT seq, LPAD(' ',(level-1)*4)||title title, level
FROM BOARD_TEST
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq DESC;

--��������
SELECT seq, LPAD(' ',(level-1)*4)||title title, level
FROM BOARD_TEST
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq DESC, seq;

--�� :
SELECT seq, LPAD(' ',(level-1)*4)||title title
FROM BOARD_TEST
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER BY CONNECT_BY_ROOT(seq)DESC, seq asc;

--�Ǵٸ��� :
SELECT seq,LPAD(' ', 4*(LEVEL-1)) || title ti,LEVEL
FROM board_test
START WITH  parent_seq  IS NULL 
CONNECT BY  PRIOR seq =  parent_seq
ORDER SIBLINGS BY NVL(parent_seq,seq) DESC;

--�븶���ڴ�?????


--������ 2�̻��ΰ͵���ʹ� seq ������ �����ϰ� �ؾ���.
--plsql �� ����