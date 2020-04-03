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

--  �����Դ��
--����1
SELECT TO_CHAR(dt, 'mm') mm, SUM(sales) sales_sum
FROM sales
GROUP BY TO_CHAR(dt, 'mm');
--����2
/*�ִ밪���� �ּҰ����ϴ� �˰����� �� �����ٰ���. �ο찪�� �ϳ��ۿ� ���� ���.*/
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

-- �������� ��, �÷��� �ڹٲ�ä�� �̸� ����� ����
--�� ���� decode ����ؼ� �ٲ۴�.















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
insert into no_emp values('XXȸ��', null, 1);
insert into no_emp values('�����ý��ۺ�', 'XXȸ��', 2);
insert into no_emp values('����1��', '�����ý��ۺ�', 5);
insert into no_emp values('����2��', '�����ý��ۺ�', 10);
insert into no_emp values('������ȹ��', 'XXȸ��', 3);
insert into no_emp values('��ȹ��', '������ȹ��', 7);
insert into no_emp values('��ȹ��Ʈ', '��ȹ��', 4);
insert into no_emp values('�����κ�', 'XXȸ��', 1);
insert into no_emp values('��������', '�����κ�', 7);

commit;




?create table board_test (
 seq number,
 parent_seq number,
 title varchar2(100) );
 
insert into board_test values (1, null, 'ù��° ���Դϴ�');
insert into board_test values (2, null, '�ι�° ���Դϴ�');
insert into board_test values (3, 2, '����° ���� �ι�° ���� ����Դϴ�');
insert into board_test values (4, null, '�׹�° ���Դϴ�');
insert into board_test values (5, 4, '�ټ���° ���� �׹�° ���� ����Դϴ�');
insert into board_test values (6, 5, '������° ���� �ټ���° ���� ����Դϴ�');
insert into board_test values (7, 6, '�ϰ���° ���� ������° ���� ����Դϴ�');
insert into board_test values (8, 5, '������° ���� �ټ���° ���� ����Դϴ�');
insert into board_test values (9, 1, '��ȩ��° ���� ù��° ���� ����Դϴ�');
insert into board_test values (10, 4, '����° ���� �׹�° ���� ����Դϴ�');
insert into board_test values (11, 10, '���ѹ�° ���� ����° ���� ����Դϴ�');
commit;
