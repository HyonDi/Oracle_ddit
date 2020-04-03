--과제 3개:
--1. exerd  hr계정을 본인계정에 테이블 만드는 ddl 스크립트를 작성해주세요. 데이터는 안넣고.
--키랑 포린키랑 다같이. 데이터를 넣는건 같이 할거야. 다음주 월요일까지. 19/12/16일.
--2. 실행계획의 nested roop 정확히는 네스티드루프 조인이다.
--조인이 물리적으로 데이터를 찾아가는 방법이 3가지가 있다.
--nested loop join, hash join, sort merge join. 조사해서 발표. 누군가.
--설명할 수 있어야해. 가능하면 샘플데이터를 이용해서 실행계획을 돌렸을때 나오는것도 같이 설명해주느것도 좋고
--개념이라도 조사해서 가져와라.19/12/20 까지.
-- 미


--내일 할 실습. 인덱스 3번, 4번 패턴분석? 작성된여러개의쿼리가 효율적으로 작동할수있도록
--인덱스를 짜는거. 쿼리를 바꿀수도있다. 지금은 눈으로 보시는건 괜찮. 인덱스개념이 잘 안잡혀있으면 복습해라.
--논란의 여지가 많다.
--테이블레벨로 제약조건 생성하는 DDL
--테이블생성시에 같이 만들어라.

--part2 끝!!
--3. 실습 4 과제로 해오기! 기한 : 25일까아지

--employees 랑 departments 포린키...?랑 employees 자기참조하는부분 순서가..있어야할것
--altertable 이 1번 쓰여야한다고 합니다,.


--과제 1 HR 생성
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

