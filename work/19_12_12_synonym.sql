SELECT *
FROM sem.users;
--��ȸ�ȵȴ�.

SELECT *
FROM jobs;
-- �߳��´�.

SELECT *
FROM USER_TABLES;
--����ڰ� ������ ���̺��� ����.

SELECT *
FROM ALL_TABLES 
WHERE OWNER = 'SEM';
--�Ʒ� �н�ƮǪ������� ����� ���̺���� �ϳ� �þ��!!
--���ٱ��� ���� �޾Ƽ� ��� ���̺��� �� �� �ִ� �� ����.

SELECT *
FROM sem. fastfood;

SELECT *
FROM DBA_TABLES;
--DBA���� �� ����.....

--SEM2 ������ FASTFOOD ���̺��� HR ���������� �� �� �ֵ��� ���̺� ��ȸ ������ �ο��غ���.

GRANT SELECT ON fastfood TO hr;

--SEM.FASTFOOD --> FASTFOOD �� �ٲ㺸��.
--hr������ �ó�Ի��������� �־ ����������.
CREATE SYNONYM fastfood FOR sem.fastfood;
DROP SYNONYM fastfood;

SELECT *
FROM fastfood;
--���� : �ڵ尡 ���������. ����: ��� �°��� ��.
--���̾���������. 
--�ó�Ը��鶧 hr�������ִ� �÷������� �ߺ����� �Ұ���.


