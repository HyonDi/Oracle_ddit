--db, 돈관련된곳. 보수적임. 파이썬, 노드제이에스가 노력대비결과가 빨리나온다고하심.
--<<inner join>>
--컬럼 연결이 성공하는 데이터만 나오는 join
--join = inner join
--<<cross join>>(cartesian product)
--별도의 조인조건이 없는 경우. 묻지마조인. 두 테이블의 행수를 곱한 결과만큼의 결과.
--emp(14), dept(4) = 56건.
--테이블간 적용하는 경우보다 데이터 복제를 위해 사용.
--오라클에서 웨어절없는 조인.

--cross join
SELECT cid, cnm, pid, pnm
FROM customer CROSS JOIN product;

--제이슨문자열?
--카카오 api에서..
--데이터스토어 

--도시발전지수
--지수공식에따라 높은곳부터 낮은곳까지. 점수도 표현해라.
--도시발전지수가 높은 순으로 나열.
--순위 / 시도 / 시군구 / 도시발전지수
-- 1   서울특별시 서초구  7.5 (소수점첫번째자리수까지)

SELECT *
FROM FASTFOOD;

SELECT gb
FROM FASTFOOD
GROUP BY gb;

SELECT sido,sigungu
FROM fastfood
GROUP BY sido, sigungu;

--전체
SELECT sido,sigungu,gb, COUNT(gb)
FROM fastfood
GROUP BY sido, sigungu, gb;

--롯데리아 빼고
SELECT sido,sigungu,gb, COUNT(gb)
FROM fastfood
GROUP BY sido, sigungu, gb
HAVING gb IN ('맥도날드', '버거킹', 'KFC');

--롯데리아만
SELECT sido,sigungu,gb, COUNT(gb)
FROM fastfood
GROUP BY sido, sigungu, gb
HAVING gb IN ('롯데리아');

--시군구별 롯데리아제외 점포 합 = s
SELECT sido, sigungu, SUM (s1) s2
FROM
(SELECT sido,sigungu,gb, COUNT(gb) s1
FROM fastfood
GROUP BY sido, sigungu, gb
HAVING gb IN ('맥도날드', '버거킹', 'KFC')) a
GROUP BY sido, sigungu;

--s 나누기 롯데리아를 해보자
SELECT sido, sigungu, SUM (s1),
         CASE
         WHEN gb IN ('맥도날드', '버거킹', 'KFC') THEN SUM(COUNT(gb))
         END
FROM
(SELECT sido,sigungu,gb, COUNT(gb) s1
FROM fastfood
GROUP BY sido, sigungu, gb) a
GROUP BY sido, sigungu;


--
SELECT SUM(a.COUNT(gb)), SUM(b.COUNT(gb))
FROM
(SELECT sido,sigungu,gb, COUNT(gb),
CASE
WHEN gb IN ('맥도날드', '버거킹', 'KFC') THEN COUNT(gb) 
END a,
CASE
WHEN gb IN ('롯데리아') THEN COUNT(gb) 
END b
FROM fastfood
GROUP BY sido, sigungu, gb) g
GROUP BY sido, sigungu;

-- 대전시 유성구, 동구, 서구, 중구, 대덕구
--5개 의 점수를 수기로작성해보세요
SELECT sido, sigungu, gb, COUNT(gb)
FROM fastfood
GROUP BY sido, sigungu, gb
HAVING sido = '대전광역시';

/*유성구  4 / 8 = 0.5
동구  6 / 8  = 0.75
서구  17 / 12 = 1.416
중구 7/6 =1.16
대덕구 3/7 =0.428
*/

SELECT sido,sigungu,gb, COUNT(gb)
FROM fastfood
GROUP BY sigungu, sido, gb 
HAVING sido = '대전광역시'
AND gb NOT IN '롯데리아';


-----선생님 답안
--해당시도, 시군구별 프렌차이즈별 건수가 필요.
--따로구해서 조인한다구???
SELECT sido, sigungu, COUNT(*) cnt --버거킹, KFC, 맥도날드 건수
FROM fastfood
WHERE gb IN ('맥도날드', '버거킹', 'KFC')
GROUP BY sido, sigungu
ORDER BY sido, sigungu;

SELECT sido, sigungu, COUNT(*) cnt --롯데리아 건수
FROM fastfood
WHERE gb IN ('롯데리아')
GROUP BY sido, sigungu
ORDER BY sido, sigungu;
-----------------------------

SELECT a.sido, a.sigungu, a.cnt, b.cnt, ROUND(a.cnt/b.cnt, 1) as 도시발전지수
FROM
(SELECT sido, sigungu, COUNT(*) cnt --버거킹, KFC, 맥도날드 건수
FROM fastfood
WHERE gb IN ('맥도날드', '버거킹', 'KFC')
GROUP BY sido, sigungu) a,

(SELECT sido, sigungu, COUNT(*) cnt --롯데리아 건수
FROM fastfood
WHERE gb IN ('롯데리아')
GROUP BY sido, sigungu
ORDER BY sido, sigungu) b
WHERE a.sido = b.sido
AND a.sigungu = b.sigungu
ORDER BY 도시발전지수 DESC;

--------------------------------
SELECT ROWNUM rn, sido, sigungu, 도시발전지수
FROM
(SELECT a.sido, a.sigungu, a.cnt, b.cnt, ROUND(a.cnt/b.cnt, 1) as 도시발전지수
FROM
(SELECT sido, sigungu, COUNT(*) cnt --버거킹, KFC, 맥도날드 건수
FROM fastfood
WHERE gb IN ('맥도날드', '버거킹', 'KFC')
GROUP BY sido, sigungu) a,

(SELECT sido, sigungu, COUNT(*) cnt --롯데리아 건수
FROM fastfood
WHERE gb IN ('롯데리아')
GROUP BY sido, sigungu
ORDER BY sido, sigungu) b
WHERE a.sido = b.sido
AND a.sigungu = b.sigungu
ORDER BY 도시발전지수 DESC);

--프롬절에 저 두개가 올수있구나......
--국세청..............20만명이 14조..... 1인당 7천만원.
--1인당 평균금액!
--하고 버거지수1위랑 국세청 1위랑  한 로우에 조인을 할 것임.
SELECT *
FROM TAX;
---------------------------------------------------------------------------------------------------------
SELECT aa. rn, aa.sido, aa.sigungu, aa.도시발전지수,
bb. rn, bb.sido, bb.sigungu, bb.t
FROM
    (SELECT ROWNUM rn, sido, sigungu, 도시발전지수
    FROM
        (SELECT a.sido, a.sigungu, a.cnt, b.cnt, ROUND(a.cnt/b.cnt, 1) as 도시발전지수
        FROM
            (SELECT sido, sigungu, COUNT(*) cnt --버거킹, KFC, 맥도날드 건수
            FROM fastfood
            WHERE gb IN ('맥도날드', '버거킹', 'KFC')
            GROUP BY sido, sigungu) a,
        
        (SELECT sido, sigungu, COUNT(*) cnt --롯데리아 건수
        FROM fastfood
        WHERE gb IN ('롯데리아')
        GROUP BY sido, sigungu
        ORDER BY sido, sigungu) b
        
        WHERE a.sido = b.sido
        AND a.sigungu = b.sigungu
        ORDER BY 도시발전지수 DESC)) aa RIGHT OUTER JOIN
    
        (SELECT ROWNUM rn, sido, sigungu, t
        FROM
            (SELECT sido, sigungu, ROUND(sal/people,1) t 
            FROM tax
            ORDER BY t DESC)) bb
ON (aa.rn = bb.rn)
ORDER BY bb.rn;



SELECT ROWNUM, a.*
FROM
(SELECT sido, sigungu, sal,ROUND(sal/people,1) t
FROM tax
ORDER BY t DESC) a;

-------------------------------------------------------------------------------------------------------
--위 쿼리를 수정해서 도시발전지수 시도, 시군구와 연말정산납임금액의 시도, 시군구가 같은 지역끼리 조인.
--정렬순서는 tax테이블의 id 컬럼순.

SELECT bb.id, aa.sido, aa.sigungu, aa.도시발전지수,
 bb.sido, bb.sigungu, bb.t
FROM
(SELECT ROWNUM rn, sido, sigungu, 도시발전지수
FROM
(SELECT a.sido, a.sigungu, a.cnt, b.cnt, ROUND(a.cnt/b.cnt, 1) as 도시발전지수
FROM
(SELECT sido, sigungu, COUNT(*) cnt --버거킹, KFC, 맥도날드 건수
FROM fastfood
WHERE gb IN ('맥도날드', '버거킹', 'KFC')
GROUP BY sido, sigungu) a,

(SELECT sido, sigungu, COUNT(*) cnt --롯데리아 건수
FROM fastfood
WHERE gb IN ('롯데리아')
GROUP BY sido, sigungu
) b

WHERE a.sido = b.sido
AND a.sigungu = b.sigungu)) aa RIGHT OUTER JOIN

(SELECT ROWNUM id, sido, sigungu, t
FROM
(SELECT sido, sigungu, ROUND(sal/people,1) t 
FROM tax
ORDER BY tax.id)) bb
ON (aa. sigungu = bb.sigungu AND aa.sido = bb.sido)
ORDER BY bb.id
;


-----------------------------------------------------------------------------------------------------------
SELECT aa. rn, aa.sido, aa.sigungu, aa.도시발전지수,
bb. rn, bb.sido, bb.sigungu, bb.t
FROM
(SELECT ROWNUM rn, sido, sigungu, 도시발전지수
FROM
(SELECT a.sido, a.sigungu, a.cnt, b.cnt, ROUND(a.cnt/b.cnt, 1) as 도시발전지수
FROM
(SELECT sido, sigungu, COUNT(*) cnt --버거킹, KFC, 맥도날드 건수
FROM fastfood
WHERE gb IN ('맥도날드', '버거킹', 'KFC')
GROUP BY sido, sigungu) a,

(SELECT sido, sigungu, COUNT(*) cnt --롯데리아 건수
FROM fastfood
WHERE gb IN ('롯데리아')
GROUP BY sido, sigungu
ORDER BY sido, sigungu) b
WHERE a.sido = b.sido
AND a.sigungu = b.sigungu
ORDER BY 도시발전지수 DESC)) aa RIGHT OUTER JOIN

(SELECT ROWNUM rn, sido, sigungu, t
FROM
(SELECT sido, sigungu, ROUND(sal/people,1) t 
FROM tax
ORDER BY t DESC)) bb;