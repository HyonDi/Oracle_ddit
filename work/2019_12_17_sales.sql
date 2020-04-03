create table sales as 
select to_date('2019-01-03', 'yyyy-MM-dd') dt, 500 sales from dual union all
select to_date('2019-01-15', 'yyyy-MM-dd') dt, 700 sales from dual union all
select to_date('2019-02-17', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-02-28', 'yyyy-MM-dd') dt, 1000 sales from dual union all
select to_date('2019-04-05', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-04-20', 'yyyy-MM-dd') dt, 900 sales from dual union all
select to_date('2019-05-11', 'yyyy-MM-dd') dt, 150 sales from dual union all
select to_date('2019-05-30', 'yyyy-MM-dd') dt, 100 sales from dual union all
select to_date('2019-06-22', 'yyyy-MM-dd') dt, 1400 sales from dual union all
select to_date('2019-06-27', 'yyyy-MM-dd') dt, 1300 sales from dual;

SELECT DECODE(TO_CHAR(dt,'MM'),01,TO_CHAR(dt,'MM')),
        DECODE(TO_CHAR(dt,'MM'),02,TO_CHAR(dt,'MM')),
        DECODE(TO_CHAR(dt,'MM'),03,TO_CHAR(dt,'MM')),
        DECODE(TO_CHAR(dt,'MM'),04,TO_CHAR(dt,'MM')),
        DECODE(TO_CHAR(dt,'MM'),05,TO_CHAR(dt,'MM')),
        DECODE(TO_CHAR(dt,'MM'),06,TO_CHAR(dt,'MM')) 
FROM
    (SELECT TO_CHAR(dt,'MM') a, SUM(sales)
    FROM sales
    GROUP BY TO_CHAR(dt,'MM')) b ;

SELECT *
FROM sales;

SELECT TO_CHAR(dt,'MM'),SUM(sales)
FROM sales
GROUP BY TO_CHAR(dt,'MM');


--
SELECT  MAX(DECODE(TO_CHAR(dt,'MM'),01,TO_CHAR(dt,'MM'))) JAN,
         MAX(DECODE(TO_CHAR(dt,'MM'),02,TO_CHAR(dt,'MM'))) FEB,
         MAX(DECODE(TO_CHAR(dt,'MM'),03,TO_CHAR(dt,'MM'))) MAR,
         MAX(DECODE(TO_CHAR(dt,'MM'),04,TO_CHAR(dt,'MM'))) APR,
         MAX(DECODE(TO_CHAR(dt,'MM'),05,TO_CHAR(dt,'MM'))) MAY,
         MAX(DECODE(TO_CHAR(dt,'MM'),06,TO_CHAR(dt,'MM'))) JUN 
FROM (SELECT TO_CHAR(dt,'MM') mm,SUM(sales)
        FROM sales
        GROUP BY TO_CHAR(dt,'MM'));

--  선생님답안
--과정1
SELECT TO_CHAR(dt, 'mm') mm, SUM(sales) sales_sum
FROM sales
GROUP BY TO_CHAR(dt, 'mm');
--과정2
/*최대값보다 최소값구하는 알고리즘이 더 빠르다고함. 로우값이 하나밖에 없는 경우.*/
SELECT NVL(MIN(DECODE(mm, '01', sales_sum)),0) JAN,
        NVL(MIN(DECODE(mm, '02', sales_sum)),0) FEB,
        NVL(MIN(DECODE(mm, '03', sales_sum)),0) MAR,
        NVL(MIN(DECODE(mm, '04', sales_sum)),0) APR,
        NVL(MIN(DECODE(mm, '05', sales_sum)),0) MAY,
        NVL(MIN(DECODE(mm, '06', sales_sum)),0) JUN
FROM
(SELECT TO_CHAR(dt, 'mm') mm, SUM(sales) sales_sum
FROM sales
GROUP BY TO_CHAR(dt, 'mm'));

-- 만들고싶은 행, 컬럼을 뒤바뀐채로 미리 만들어 놓고
--그 이후 decode 사용해서 바꾼다.















create table h_sum as
select '0' s_id, null ps_id, null value from dual union all
select '01' s_id, '0' ps_id, null value from dual union all
select '012' s_id, '01' ps_id, null value from dual union all
select '0123' s_id, '012' ps_id, 10 value from dual union all
select '0124' s_id, '012' ps_id, 10 value from dual union all
select '015' s_id, '01' ps_id, null value from dual union all
select '0156' s_id, '015' ps_id, 20 value from dual union all

select '017' s_id, '01' ps_id, 50 value from dual union all
select '018' s_id, '01' ps_id, null value from dual union all
select '0189' s_id, '018' ps_id, 10 value from dual union all
select '11' s_id, '0' ps_id, 27 value from dual;




create table no_emp(
    org_cd varchar2(100),
    parent_org_cd varchar2(100),
    no_emp number
);
insert into no_emp values('XX회사', null, 1);
insert into no_emp values('정보시스템부', 'XX회사', 2);
insert into no_emp values('개발1팀', '정보시스템부', 5);
insert into no_emp values('개발2팀', '정보시스템부', 10);
insert into no_emp values('정보기획부', 'XX회사', 3);
insert into no_emp values('기획팀', '정보기획부', 7);
insert into no_emp values('기획파트', '기획팀', 4);
insert into no_emp values('디자인부', 'XX회사', 1);
insert into no_emp values('디자인팀', '디자인부', 7);

commit;




?create table board_test (
 seq number,
 parent_seq number,
 title varchar2(100) );
 
insert into board_test values (1, null, '첫번째 글입니다');
insert into board_test values (2, null, '두번째 글입니다');
insert into board_test values (3, 2, '세번째 글은 두번째 글의 답글입니다');
insert into board_test values (4, null, '네번째 글입니다');
insert into board_test values (5, 4, '다섯번째 글은 네번째 글의 답글입니다');
insert into board_test values (6, 5, '여섯번째 글은 다섯번째 글의 답글입니다');
insert into board_test values (7, 6, '일곱번째 글은 여섯번째 글의 답글입니다');
insert into board_test values (8, 5, '여덜번째 글은 다섯번째 글의 답글입니다');
insert into board_test values (9, 1, '아홉번째 글은 첫번째 글의 답글입니다');
insert into board_test values (10, 4, '열번째 글은 네번째 글의 답글입니다');
insert into board_test values (11, 10, '열한번째 글은 열번째 글의 답글입니다');
commit;
