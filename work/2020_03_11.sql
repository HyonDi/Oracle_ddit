
insert into ADOPT_REVIEWBOARD
values(1, 'asd', 1, sysdate, '제목제목', '내용내용',1);

INSERT INTO USER_ADMIN
VALUES('guswl123', 'qweqwe123', '강현지', '현지현지', '12312331234','2020-03-11','대전 중구 선화동 18번길 30','qweqwe@naver.com',1, 1,1,'대전','청주','광명');

INSERT INTO USER_ADMIN
VALUES('guswl123', 'qweqwe123', '강현지', '현지현지', '12312331234','2020-03-11','대전 중구 선화동 18번길 30','qweqwe@naver.com',1, 1,1,'대전','청주','광명');


INSERT INTO USER_ADMIN
VALUES('dlfqks123', 'qweqwe123', '이일반', '일반일반', '12312331234','2020-03-11','서울 광진구 능동 18번길 30','asdasd@naver.com',1, 1,1,'서울','인천','제천');

INSERT INTO E_USER
VALUES('rldjq123',100,'qweqwe123','12312341234','깁담당','zxczxc@naver.com','대전보호소','깁대표','12345-12345-12345','대전 서구 둔산동 117-3',2342342344,200,0,1, 'qweiop@naver.com','사랑으로 돌보는 보호소입니다.');


INSERT INTO STATUS_CODE
VALUES(100,'승인완료');

INSERT INTO STATUS_CODE
VALUES(200,'보호소');

INSERT INTO STATUS_CODE
VALUES(300,'입양대기');

INSERT INTO STATUS_CODE
VALUES(400,'입양진행중');



INSERT INTO ADOPT_REVIEWBOARD
VALUES(1, 'guswl123', 1,sysdate,'대전보호소에서 만난 꽁꽁이','오늘 대전보호소에서 꽁꽁이를 데려왔습니다. 깔끔한 환경에서 자상한 보호소 직원분들과 함께 자라 건강하고 활기찹니다. 감사합니다.',1);

INSERT INTO ADOPT_REVIEWBOARD
VALUES(2, 'dlfqks123', 1,sysdate,'대전보호소 맹맹이','오늘 대전보호소에서 맹맹이를 데려왔습니다. 깔끔한 환경에서 자상한 보호소 직원분들과 함께 자라 건강하고 활기찹니다. 감사합니다.',1);
---
INSERT INTO ADOPT_REVIEWBOARD
VALUES(SEQ_FOR_ADOP_REVIEW_NUM.nextval, 'dlfqks123', sysdate,'대전보호소 맹맹이','오늘 대전보호소에서 맹맹이를 데려왔습니다. 깔끔한 환경에서 자상한 보호소 직원분들과 함께 자라 건강하고 활기찹니다. 감사합니다.',0,26,'일반일반');
commit;



commit;

-- adopt app num 을 넣으려면 입양부터해야대...
INSERT INTO ADOPT_APP
VALUES(1, 1, 'guswl123',303, 1,sysdate,sysdate,'가족들 모두 입양에 동의하십니까? 네.');

INSERT INTO ADOPT_APP
VALUES(ADOPTAPPLY.nextval, 1, 'guswl123',307, 1,sysdate,sysdate,'가족들 모두 입양에 동의하십니까? 네.');
commit;

INSERT INTO ADOPT_APP
VALUES(ADOPTAPPLY.nextval, 5, 'dlfqks123',307, 1,sysdate,sysdate,'가족들 모두 입양에 동의하십니까? 네.');
commit;

INSERT INTO ADOPT_APP
VALUES(ADOPTAPPLY.nextval, 9, 'dlfqks123',307, 1,sysdate,sysdate,'가족들 모두 입양에 동의하십니까? 네.');
commit;
----------------
INSERT INTO ADOPT_APP
VALUES(ADOPTAPPLY.nextval, 7, 'dlfqks123',307, 1,sysdate,sysdate,'가족들 모두 입양에 동의하십니까? 네.');
INSERT INTO ADOPT_APP
VALUES(ADOPTAPPLY.nextval, 4, 'dlfqks123',307, 1,sysdate,sysdate,'가족들 모두 입양에 동의하십니까? 네.');
INSERT INTO ADOPT_APP
VALUES(ADOPTAPPLY.nextval, 3, 'dlfqks123',307, 1,sysdate,sysdate,'가족들 모두 입양에 동의하십니까? 네.');
INSERT INTO ADOPT_APP
VALUES(ADOPTAPPLY.nextval, 9, 'dlfqks123',307, 1,sysdate,sysdate,'가족들 모두 입양에 동의하십니까? 네.');
INSERT INTO ADOPT_APP
VALUES(ADOPTAPPLY.nextval, 9, 'dlfqks123',307, 1,sysdate,sysdate,'가족들 모두 입양에 동의하십니까? 네.');
INSERT INTO ADOPT_APP
VALUES(ADOPTAPPLY.nextval, 9, 'dlfqks123',307, 1,sysdate,sysdate,'가족들 모두 입양에 동의하십니까? 네.');
INSERT INTO ADOPT_APP
VALUES(ADOPTAPPLY.nextval, 9, 'dlfqks123',307, 1,sysdate,sysdate,'가족들 모두 입양에 동의하십니까? 네.');
INSERT INTO ADOPT_APP
VALUES(ADOPTAPPLY.nextval, 9, 'dlfqks123',307, 1,sysdate,sysdate,'가족들 모두 입양에 동의하십니까? 네.');
INSERT INTO ADOPT_APP
VALUES(ADOPTAPPLY.nextval, 9, 'dlfqks123',307, 1,sysdate,sysdate,'가족들 모두 입양에 동의하십니까? 네.');
INSERT INTO ADOPT_APP
VALUES(ADOPTAPPLY.nextval, 9, 'dlfqks123',307, 1,sysdate,sysdate,'가족들 모두 입양에 동의하십니까? 네.');
INSERT INTO ADOPT_APP
VALUES(ADOPTAPPLY.nextval, 9, 'dlfqks123',307, 1,sysdate,sysdate,'가족들 모두 입양에 동의하십니까? 네.');
INSERT INTO ADOPT_APP
VALUES(ADOPTAPPLY.nextval, 9, 'dlfqks123',307, 1,sysdate,sysdate,'가족들 모두 입양에 동의하십니까? 네.');
INSERT INTO ADOPT_APP
VALUES(ADOPTAPPLY.nextval, 9, 'dlfqks123',307, 1,sysdate,sysdate,'가족들 모두 입양에 동의하십니까? 네.');
INSERT INTO ADOPT_APP
VALUES(ADOPTAPPLY.nextval, 9, 'dlfqks123',307, 1,sysdate,sysdate,'가족들 모두 입양에 동의하십니까? 네.');





commit;

-- adopt num 을 넣으려면 입양공고부터해야대..
INSERT INTO ADOPT_ANIMAL_BOARD
VALUES(1, 'rldjq123', 300, 'd2020031101','개','골든리트리버','수',3,1,sysdate,'대전 중구 은행동 목척교');
commit;

ALTER TABLE COMMENTS DROP COLUMN COMMENTS_TITLE;
commit;

select * 
from adopt_reviewboard 
where 
user_id like '%dlfqks%' or
ADOPT_REVIEW_TITLE like '%dlfqks%';

--시퀀스이름.nextval;
--seq_for_adop_review_num.nextval;

CREATE SEQUENCE seq_for_adop_review_num
START WITH 1 INCREMENT BY 1 NOMAXVALUE;
----------------------------------------------------
ALTER TABLE ADOPT_REVIEWBOARD DROP COLUMN ADOPT_APP_NUM;
commit;

INSERT INTO ADOPT_REVIEWBOARD(ADOPT_APP_NUM) values(seq_for_adop_review_num);

insert into adopt_reviewboard (adopt_review_num, user_id,     
adopt_review_date, adopt_review_title,adopt_review_cont,adopt_review_hits)   
values (0, 'guswl123', sysdate,         seq_for_adop_review_num.nextval, 'ss', 0)           ;

--To_CHAR(날짜형컬럼쓰렴,'yyyy-MM-dd');
--VO String으로 변경
--select문 ibatis로 만들고 db날짜랑 동일한지 확인 / 오라클에있는거 VO에 담을때 잘 담기나?

--AlTER TABLE 테이블명 ADD컬럼이름 컬럼타입 [null]
rollback;
commit;

SELECT *
FROM ADOPT_REVIEWBOARD;

ALTER TABLE ADOPT_REVIEWBOARD ADD(user_nick VARCHAR2(50)); 
commit;

select * from adopt_reviewboard;

UPDATE ADOPT_REVIEWBOARD SET adopt_app_num = 1;
UPDATE ADOPT_REVIEWBOARD SET user_nick = '현지현지';

UPDATE report set UPLOADDATE = sysdate;
commit;


select * from comments
	 		where adopt_review_num = 1;
            
-- 일반회원이면 유저닉에서 가져오고, 기업회원이면 컴네임 가져오기.
SELECT *
FROM comments;


UPDATE comments SET writer = '현지현지';
commit;


select comments_num,user_id,com_id,comments_date,comments_cont,adopt_review_num,writer
	 		from comments
	 		where adopt_review_num = 1
            ORDER BY comments_num desc;
            
ALTER TABLE report ADD(status_code_num number); 
commit;

ALTER TABLE comments ADD(report_num number); 
commit;

--댓글갯수
select count(*)
from comments
where adopt_review_num = 1;

select count(*) cnt from adopt_reviewboard;
--adopt_app_num 을 입력해서 그에해당하는 리뷰들 보여지기

SELECT *
FROM ADOPT_REVIEWBOARD, ADOPT_APP, ADOPT_ANIMAL_BOARD
WHERE ADOPT_REVIEWBOARD.ADOPT_APP_NUM = ADOPT_APP.ADOPT_APP_NUM
AND adopt_app.adopt_num = ADOPT_ANIMAL_BOARD.ADOPT_NUM
AND ADOPT_ANIMAL_BOARD.COM_ID = 'rldjq123';


SELECT ADOPT_ANIMAL_BOARD.COM_NAME
FROM ADOPT_REVIEWBOARD, ADOPT_APP, ADOPT_ANIMAL_BOARD
WHERE ADOPT_REVIEWBOARD.ADOPT_APP_NUM = ADOPT_APP.ADOPT_APP_NUM
AND ADOPT_APP.ADOTP_NUM = ADOPT_ANIMAL_BOARD.ADOPT_NUM
AND ADOPT_REVIEWBOARD.ADOPT_REVIEW_NUM = 85;

-- 입양완료상태코드를 가지는 입양신청글 갯수(회원아이디로 검색한다.)
SELECT count(*)
FROM ADOPT_APP
WHERE STATUS_CODE_NUM=307
AND user_id='dlfqks123';

-- 아직 쓰지 않은 후기를 보는 방법은??
SELECT *
FROM ADOPT_APP,ADOPT_REVIEWBOARD
WHERE ADOPT_REVIEWBOARD.ADOPT_APP_NUM = ADOPT_APP.ADOPT_APP_NUM;

SELECT *
FROM adopt_app;

SELECT *
FROM ADOPT_REVIEWBOARD;

-- 입양신청글번호(app_num)가 입양후기글에 없으면 후기작성 가능.


--내가 쓴 후기 갯수
SELECT count(*)
FROM ADOPT_REVIEWBOARD
WHERE user_id='dlfqks123';

-- 내가 쓴 후기에있는 글번호가 입양글번호에도 있나?
SELECT *
FROM ADOPT_REVIEWBOARD,adopt_app
WHERE ADOPT_REVIEWBOARD.ADOPT_APP_NUM = adopt_app.adopt_app_num
AND ADOPT_REVIEWBOARD.user_id='dlfqks123';

SELECT *
FROM ADOPT_REVIEWBOARD
WHERE USER_ID='dlfqks123';

SELECT *
FROM adopt_app
WHERE USER_ID='dlfqks123';-- dlfqks123이 신청한 adopt_app_num = 5,6

-- 입양완료된 입양신청글번호 - 내가 작성한 입양신청글후기의 입양신청글번호

-- 1. 완료된 입양신청글번호 
SELECT *
FROM adopt_app
WHERE USER_ID='dlfqks123'
AND status_code_num = 307;
-- 2. 

-- 입양신청글번호
SELECT adopt_app.adopt_app_num, adopt_app.adopt_num, adopt_reviewboard.ADOPT_REVIEW_NUM, adopt_reviewboard.user_id
FROM adopt_app, adopt_reviewboard
WHERE adopt_app.ADOPT_APP_NUM = adopt_reviewboard.ADOPT_APP_NUM;

-- 현지가 입양신청 완료글 2개, 입양신청완료되지 않은 글 1개를 가지고 있다.
-- 현지는 입양신청완료글 중 1개를 작성했다.
-- 나머지 1개를 작성하려면?
-- 1. 현지가 작성한 입양신청완료글의 글번호를 가져온다.
-- 2. 현지가 작성한 입양후기글의 신청완료글번호를 가져온다.
-- 3. 1이 2에 있으면 작성불가능. 1이 2에 없으면 작성 가능.


--
---------------------------------------------------
-- 1. 완료된 입양신청글번호 
SELECT adopt_app_num,user_id, rownum
FROM adopt_app
WHERE USER_ID='dlfqks123'
AND status_code_num = 307;
-- 입양신청번호가 1인 후기들
SELECT *
FROM adopt_reviewboard
WHERE ADOPT_APP_NUM = 5;

-- 1에서 이걸 빼자. 
SELECT adopt_app_num, user_id
FROM adopt_reviewboard;

SELECT count(*)
FROM
(SELECT adopt_app_num,user_id
FROM adopt_app
WHERE USER_ID='dlfqks123'
AND status_code_num = 307
MINUS
SELECT adopt_app_num, user_id
FROM adopt_reviewboard);
----------------------------------------------------

SELECT adopt_reviewboard.user_id,adopt_reviewboard.ADOPT_REVIEW_NUM,adopt_app.adopt_app_num, ADOPT_ANIMAL_BOARD.COM_NAME, ADOPT_ANIMAL_BOARD.SRNUM, ADOPT_ANIMAL_BOARD.KIND, 
        ADOPT_ANIMAL_BOARD.VARIERY,ADOPT_ANIMAL_BOARD.GENDER,ADOPT_ANIMAL_BOARD.ADOPT_AGE
FROM adopt_app, adopt_reviewboard, ADOPT_ANIMAL_BOARD
WHERE adopt_reviewboard.ADOPT_APP_NUM = adopt_app.adopt_app_num
AND adopt_app.ADOPT_NUM = ADOPT_ANIMAL_BOARD.ADOPT_NUM;
--AND adopt_app.ADOPT_NUM = 4;

select adopt_app_num
		from adopt_app
		where user_id= 'dlfqks123'
		and status_code_num = 307
		minus
		select adopt_app_num
		from adopt_reviewboard;
        
SELECT adopt_reviewboard.user_id,adopt_reviewboard.ADOPT_REVIEW_NUM,adopt_app.adopt_app_num, ADOPT_ANIMAL_BOARD.COM_NAME, ADOPT_ANIMAL_BOARD.SRNUM, ADOPT_ANIMAL_BOARD.KIND, 
        ADOPT_ANIMAL_BOARD.VARIERY,ADOPT_ANIMAL_BOARD.GENDER,ADOPT_ANIMAL_BOARD.ADOPT_AGE
FROM adopt_app, adopt_reviewboard, ADOPT_ANIMAL_BOARD
WHERE adopt_app.ADOPT_NUM = ADOPT_ANIMAL_BOARD.ADOPT_NUM
AND adopt_app.ADOPT_NUM = 4;

-- adoptappnum 이 4번인걸 알았음 => 저거에대한 후기를 작성해야함.
-- adoptappnum4번에 해당하는 adopt공고는?
SELECT ADOPT_ANIMAL_BOARD.*,adopt_app.adopt_app_num
FROM adopt_app, ADOPT_ANIMAL_BOARD
WHERE adopt_app.adopt_app_num IN
        (select adopt_app_num
                from adopt_app
                where user_id= 'dlfqks123'
                and status_code_num = 307
                minus
                select adopt_app_num
                from adopt_reviewboard) -- 입양후기가 작성되지않은 입양신청글번호.
AND adopt_app.adopt_num = ADOPT_ANIMAL_BOARD.adopt_num
AND ADOPT_ANIMAL_BOARD.srnum = '20-5-051';
------------------
-- 시리얼넘버가 내가선택한거인 입양신청서중 완료가된것 혹은 내가 작성된 완료된것
SELECT adopt_app_num
FROM adopt_app, ADOPT_ANIMAL_BOARD
WHERE adopt_app.ADOPT_NUM = ADOPT_ANIMAL_BOARD.adopt_num
AND ADOPT_ANIMAL_BOARD.srnum = '20-5-051'
AND adopt_app.status_code_num=307;
-------------------------------------------------
select adopt_app_num
	from adopt_app, adopt_animal_board
	where adopt_app.adopt_num = adopt_animal_board.adopt_num
	and adopt_animal_board.srnum = '20-2-089'
	and adopt_app.status_code_num=307;
    
    commit;