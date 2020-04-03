CREATE INDEX emp 
;
EXPLAIN PLAN FOR
SElECT *
FROM EMP
WHERE EMPNO = :EMPNO;

SELECT *
FROM TABLE (dbms_xplan.display);

SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO
AND EMP.DEPTNO = :DEPTNO
AND EMP.EMPNO LIKE :EMPNO ||'%';


-EMPNO, DEPTNO, 
CREATE INDEX IDX_N_EMP_01 EMP (EMPNO) ;
CREATE INDEX IDX_N_EMP_02 EMP (DEPTNO) ;




--1. �Է¹��� EMPNO ��� *��ȸ
2. �Է¹��� ENAME �� ��� *��ȸ--ENAME --?? 
--3. EMP, DEPT �Է¹޾Ƽ� ��ġ�Ұ�� *��ȸ
4. �Է��� ������ ������ ������ �Է��� DEPTNO���� ���  ��ȸ --SA//L
5. �Է��� DEPTNO �� �Ŵ����� ��ȸ --MGR
6. �μ��� �Ի糯�ں� / �μ���ȣ�� �Ի糯¥�� �Ǽ�.. --deptno-HIREDATE1
;
SELECT *
FROM emp;

--