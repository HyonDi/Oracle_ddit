select rownum num,comments.*
FROM comments
WHERE user_id='guswl123';

select rownum num,comments.*   from comments   where user_id='guswl123' ;

-- 댓글VO에 담긴 글번호를 가져와서
select *
FROM ADOPT_REVIEWBOARD
WHERE adopt_review_num = 161;
