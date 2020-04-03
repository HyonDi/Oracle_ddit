SELECT *
FROM lprod;

delete from lprod where lprod_id in (101,102,103);
commit;

CREATE TABLE guest (
    roomNum VARCHAR2(30),
    name VARCHAR2(30)  
);
commit;


SELECT *
FROM guest;

delete from guest;
commit;

select max(lprod_id)
FROM lprod;

create table mymember(
    mem_id varchar2(8) not null,  -- 회원ID
    mem_name varchar2(100) not null, -- 이름
    mem_tel varchar2(50) not null, -- 전화번호
    mem_addr varchar2(128)    -- 주소
);

SELECT *
FROM mymember;

SELECT name
FROM guest
WHERE roomNum = 101;

create table jdbc_board(
    board_no number not null,  -- 번호(자동증가)
    board_title varchar2(100) not null, -- 제목
    board_writer varchar2(50) not null, -- 작성자
    board_date date not null,   -- 작성날짜
    board_content clob,     -- 내용
    constraint pk_jdbc_board primary key (board_no)
);

SELECT *
FROM jdbc_board;

SELECT TO_DATE(TO_CHAR(SYSDATE,'YY/MM/DD HH:mi:ss'),'YY/MM/DD HH:mi:ss')
FROM dual;

SELECT TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD HH:mi:ss' )) bdate
FROM dual;

SELECT *
FROM
;

SELECT *
FROM jdbc_board;
commit;
create sequence board_seq1
    start with 1   -- 시작번호
    increment by 1; -- 증가값
    
INSERT INTO jdbc_board(noard_no) values(board_seq1.nextval);

delete from jdbc_board where board_no =1;

SELECT TO_CHAR(BOARD_DATE,'YY/MM/DD HH:mi:ss') board_date
FROM jdbc_board;

desc jdbc_board;



;

SELECT * 
FROM jdbc_board 
WHERE 1=1 

bod.getBoard_title().equals("") ;

---------------------------------------------------------------------
SELECT *
FROM jdbc_board;

SELECT *
FROM lprod;

SELECT *
FROM prod;






























