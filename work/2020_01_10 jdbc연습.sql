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
    mem_id varchar2(8) not null,  -- ȸ��ID
    mem_name varchar2(100) not null, -- �̸�
    mem_tel varchar2(50) not null, -- ��ȭ��ȣ
    mem_addr varchar2(128)    -- �ּ�
);

SELECT *
FROM mymember;

SELECT name
FROM guest
WHERE roomNum = 101;

create table jdbc_board(
    board_no number not null,  -- ��ȣ(�ڵ�����)
    board_title varchar2(100) not null, -- ����
    board_writer varchar2(50) not null, -- �ۼ���
    board_date date not null,   -- �ۼ���¥
    board_content clob,     -- ����
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
    start with 1   -- ���۹�ȣ
    increment by 1; -- ������
    
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






























