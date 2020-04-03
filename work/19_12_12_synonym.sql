SELECT *
FROM sem.users;
--조회안된다.

SELECT *
FROM jobs;
-- 잘나온다.

SELECT *
FROM USER_TABLES;
--사용자가 소유한 테이블의 정보.

SELECT *
FROM ALL_TABLES 
WHERE OWNER = 'SEM';
--아래 패스트푸드권한을 줬더니 테이블수가 하나 늘어났다!!
--접근권한 등을 받아서 모든 테이블을 볼 수 있는 것 조사.

SELECT *
FROM sem. fastfood;

SELECT *
FROM DBA_TABLES;
--DBA권한 의 무언가.....

--SEM2 계정의 FASTFOOD 테이블을 HR 계정에서도 볼 수 있도록 테이블 조회 권한을 부여해보자.

GRANT SELECT ON fastfood TO hr;

--SEM.FASTFOOD --> FASTFOOD 로 바꿔보렴.
--hr계정은 시노님생성권한이 있어서 딱히뭐안함.
CREATE SYNONYM fastfood FOR sem.fastfood;
DROP SYNONYM fastfood;

SELECT *
FROM fastfood;
--장점 : 코드가 간단해잰다. 단점: 어디서 온건지 모름.
--많이쓰이진않음. 
--시노님만들때 hr계정에있는 컬럼명으로 중복생성 불가능.


