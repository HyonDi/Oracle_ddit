--���� 3��:
--1. exerd  hr������ ���ΰ����� ���̺� ����� ddl ��ũ��Ʈ�� �ۼ����ּ���. �����ʹ� �ȳְ�.
--Ű�� ����Ű�� �ٰ���. �����͸� �ִ°� ���� �Ұž�. ������ �����ϱ���. 19/12/16��.
--2. �����ȹ�� nested roop ��Ȯ���� �׽�Ƽ����� �����̴�.
--������ ���������� �����͸� ã�ư��� ����� 3������ �ִ�.
--nested loop join, hash join, sort merge join. �����ؼ� ��ǥ. ������.
--������ �� �־����. �����ϸ� ���õ����͸� �̿��ؼ� �����ȹ�� �������� �����°͵� ���� �������ִ��͵� ����
--�����̶� �����ؼ� �����Ͷ�.19/12/20 ����.
-- ��


--���� �� �ǽ�. �ε��� 3��, 4�� ���Ϻм�? �ۼ��ȿ������������� ȿ�������� �۵��Ҽ��ֵ���
--�ε����� ¥�°�. ������ �ٲܼ����ִ�. ������ ������ ���ô°� ����. �ε��������� �� ������������ �����ض�.
--����� ������ ����.
--���̺����� �������� �����ϴ� DDL
--���̺�����ÿ� ���� ������.

--part2 ��!!
--3. �ǽ� 4 ������ �ؿ���! ���� : 25�ϱ����

--employees �� departments ����Ű...?�� employees �ڱ������ϴºκ� ������..�־���Ұ�
--altertable �� 1�� �������Ѵٰ� �մϴ�,.


--���� 1 HR ����
--JOBS
CREATE TABLE jobs( 
job_id VARCHAR2(10),
job_title VARCHAR2(35),
min_salary NUMBER(6),
max_salary NUMBER(6),

CONSTRAINT JOB_ID_PK PRIMARY KEY (job_id),
CONSTRAINT JOB_TITLE_NN CHECK (job_title IS NOT NULL));

--EMPLOYEES
CREATE TABLE employees(
employee_id NUMBER(6),
first_name VARCHAR2(20),
last_name VARCHAR2(25),
email VARCHAR2(25),
phone_number VARCHAR2(20),
hire_date DATE,
job_id VARCHAR2(10),
salary NUMBER(8,2),
commission_pct NUMBER(2,2),
manager_id NUMBER(6),
department_id NUMBER(4),

CONSTRAINT EMP_FIRST_NAME_NN CHECK (first_name IS NOT NULL),
CONSTRAINT EMP_LAST_NAME_NN CHECK (last_name IS NOT NULL),
CONSTRAINT EMP_HIRE_DATE_NN CHECK (hire_date IS NOT NULL),
CONSTRAINT EMP_JOB_NN CHECK (job_id IS NOT NULL),

CONSTRAINT EMP_JOB_FK FOREIGN KEY (JOB_ID) REFERENCES JOBS(JOB_ID),
CONSTRAINT EMP_MANAGER_FK FOREIGN KEY (MANAGER_ID) REFERENCES EMPLOYEES(EMPLOYEE_ID),
CONSTRAINT EMP_DEPT_FK FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS(DEPARTMENT_ID),
CONSTRAINT EMP_EMP_ID_PK PRIMARY KEY (employee_id),
CONSTRAINT EMP_EMAIL_PK UNIQUE (email),
CONSTRAINT EMP_SALARY_MIN CHECK (SALARY > 0));

--JOB_HISTORY??
CREATE TABLE job_history(
employee_id NUMBER(6),
start_date DATE,
end_date DATE,
job_id VARCHAR2(10),
department_id NUMBER(4),

CONSTRAINT JHIST_END_DATE_NN CHECK (end_date IS NOT NULL),
CONSTRAINT JHIST_JOB_NN CHECK(job_id IS NOT NULL),

CONSTRAINT JHIST_JOB_FK FOREIGN KEY (JOB_ID) REFERENCES JOBS(JOB_ID),
CONSTRAINT JHIST_EMP_FK FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEES(EMPLOYEE_ID),
--CONSTRAINT JHIST_DEPT_FK FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS(DEPARTMENT_ID),
CONSTRAINT JHIST_EMP_ID PRIMARY KEY (employee_id),
CONSTRAINT JHIST_START_DATE CHECK(start_date IS NOT NULL),
CONSTRAINT JHIST_END_DATE_MIN CHECK (END_DATE > START_DATE)
);

--DEPARTMENTS
CREATE TABLE departments(
department_id NUMBER(4),
department_name VARCHAR2(30),
manager_id NUMBER(6),
location_id NUMBER(4),


CONSTRAINT DEPT_LOC_FK FOREIGN KEY (LOCATION_ID) REFERENCES LOCATIONS(LOCATION_ID),
--CONSTRAINT DEPT_MGR_FK FOREIGN KEY (MANAGER_ID) REFERENCES EMPLOYEES(EMPLOYEE_ID),
CONSTRAINT DEPT_ID_PK PRIMARY KEY (department_id),
CONSTRAINT DEPT_NAME_NN CHECK (department_name IS NOT NULL));

ALTER TABLE employees ADD CONSTRAINT JHIST_DEPT_FK 
FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS(DEPARTMENT_ID);
ALTER TABLE departments ADD CONSTRAINT DEPT_MGR_FK FOREIGN KEY (MANAGER_ID) REFERENCES EMPLOYEES(EMPLOYEE_ID);

--LOCATIONS
CREATE TABLE locations(
location_id NUMBER(4),
street_address VARCHAR2(40),
postal_code VARCHAR2(12),
city VARCHAR2(30),
state_province VARCHAR2(25),
country_id CHAR(2),
CONSTRAINT LOC_C_ID_FK FOREIGN KEY (COUNTRY_ID) REFERENCES COUNTRIES(COUNTRY_ID),
CONSTRAINT LOC_ID_PK PRIMARY KEY (location_id),
CONSTRAINT LOC_CITY_NN CHECK (city IS NOT NULL));

--COUNTRIES
CREATE TABLE countries(
country_id CHAR(2),
country_name VARCHAR2(40),
region_id NUMBER,
CONSTRAINT COUNTR_REG_FK FOREIGN KEY (region_id) REFERENCES REGIONS(region_id),
CONSTRAINT COUNTRY_C_ID_PK PRIMARY KEY (country_id)
);

--REGIONS
CREATE TABLE regions(
region_id NUMBER,
region_name VARCHAR2(25),
CONSTRAINT REG_ID_PK PRIMARY KEY (region_id));

