SELECT A.*
FROM
(SELECT ROWNUM as rnum, B.*
FROM (SELECT * FROM board1 ORDER BY seq desc) B
WHERE ROWNUM <= 10)A
WHERE A.rnum >= 4;

select count(*) from board1;

update report
		set 
			status_code_num = 602,
			status_code_name = '신고 확인'
        WHERE report_num = 25;
        rollback;