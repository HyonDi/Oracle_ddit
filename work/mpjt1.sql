commit;
select *
FROM adopt_app
WHERE user_id = 'guswl123';

select *
FROM ADOPT_REVIEWBOARD
WHERE user_id = 'guswl123';

select rownum num, c.user_id,c.adopt_review_num,c.adopt_review_title,c.adopt_review_date, d.com_name,d.kind
		from (select a.user_id, a.adopt_review_num, a.adopt_review_title,a.adopt_review_date, b.adopt_num
		from adopt_reviewboard a, adopt_app b
		where a.user_id = b.user_id) c,adopt_animal_board d
		where c.adopt_num = d.adopt_num
		and c.user_id='guswl123';
        
SELECT rownum num, ADOPT_ANIMAL_BOARD.com_name, ADOPT_ANIMAL_BOARD.VARIERY,adopt_reviewboard.adopt_review_title,adopt_reviewboard.adopt_review_date
FROM adopt_reviewboard, adopt_app, ADOPT_ANIMAL_BOARD
WHERE adopt_reviewboard.adopt_app_num = adopt_app.adopt_app_num
AND adopt_app.adopt_num = ADOPT_ANIMAL_BOARD.adopt_num
AND adopt_reviewboard.user_id='guswl123';