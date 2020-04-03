SELECT sysdate
FROM dual;

commit;

select rownum, report.*
		from report
		where user_id = 'guswl123';
        
select *
from user_admin
WHERE user_id='guswl1234';

select comments_num,user_id,com_id,comments_date,comments_cont,report_num,writer
	 		from comments
	 		where report_num = 25
	 		ORDER BY comments_num desc;