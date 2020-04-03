--잠시 system 계정으로 온다.
SELECT *
FROM V$SQL;
-->911개의 데이터가 있다.
-->여태 사용한 SQL 기록.
SELECT *
FROM V$SQL
WHERE SQL_TEXT LIKE '%emp%';
--> 여태 사용한 sql 중 emp 가 언제쓰였나? 의 기록.
--저장된 sql 의 실행계획들?을 저장한것의 쿼리

--2019_12_11 의 주석에 201911_205 가 들어간 sql 실행 후에
SELECT *
FROM V$SQL
WHERE SQL_TEXT LIKE '%201911_205%';
--를 검색하면 실행계획이 쿼리를 실행함에따라 계속 증가한다.
--동일한쿼리를 할때에는 재활용해서 행수가 늘지 않는다.

