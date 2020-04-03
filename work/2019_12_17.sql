--with 절 .
--with 블록이름 AS(
--      서브쿼리
--  )
-- SELECT *
-- FROM 블록이름

--deptno, avg(sal) avg_(sal)
--해당부서의 급여평균이 전체직원의 급여평균보다 높은 부서에 한해 조회/.
SELECT deptno, avg(sal) avg_sal
FROM emp
GROUP BY deptno
HAVING avg(sal) > (SELECT avg(sal) FROM emp);

--위 쿼리를 with절 사용해 작성.
WITH dept_sal_avg AS (
    SELECT deptno, avg(sal) avg_sal
    FROM emp
    GROUP BY deptno),
    emp_sal_avg AS(
        SELECT avg(sal)avg_sal FROM emp    
    )
SELECT *
FROM dept_sal_avg
WHERE dept_sal_avg.avg_sal > (SELECT avg_sal FROM emp_sal_avg);

--with 사용? : 
-- 테스트시. 진짜 테이블 만들기 귀찮을때. 회사정보를 보여줄수없을때.

--<<  계층쿼리  >>
--달력만들기
--CONNECT BY LEVERL <=N
--테이블의 row 건수를 N만큼 반복한다.
--CONNECT BY LEVEL 절을 사용한 쿼리에서는
--select  절에서 level 이라는 특수 컬럼을 사용할 수 있다.
--계층을 표현하는 특수컬럼으로 1부터 증가하며 ROWNUM과 유사하니
--추후 배우게될 START WITH, CONNECT BY 절에서 다른점을 배우게 된다.

--해당 년월의 날짜가 몇일까지 존재하는가?? 를 알아내야 한다.


--201911
--아래가 12월이 이상한 달력. 제대로 나오게 해보자.
SELECT /*dt, d,*/
    MAX(DECODE(d,1,dt)) sun, MAX(DECODE(d,2,dt))m,MAX(DECODE(d,3,dt))t,MAX(DECODE(d,4,dt))w,MAX(DECODE(d,5,dt))th,MAX(DECODE(d,6,dt))f,MAX(DECODE(d,7,dt))sat
FROM
(SELECT TO_DATE(:YYYYMM, 'yyyymm') + (level-1) dt,
        TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level-1),'D') d,
        TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level),'iw') iw
from DUAL  
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'yyyymm')), 'DD'))
GROUP BY iw
ORDER BY iw;


-- 1주차인데 dd가 23이상이면 60주차로 바꾸기? iw = 1 && dd>23 ->iw+59 X
SELECT CASE 
        WHEN TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level),'iw') = '1' AND TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level-1),'DD') > 23 
        THEN iw = iw+59 
        DEFAULT iw 
        END,
    MAX(DECODE(d,1,dt)) sun, MAX(DECODE(d,2,dt))m,MAX(DECODE(d,3,dt))t,MAX(DECODE(d,4,dt))w,MAX(DECODE(d,5,dt))th,MAX(DECODE(d,6,dt))f,MAX(DECODE(d,7,dt))sat
FROM
(SELECT TO_DATE(:YYYYMM, 'yyyymm') + (level-1) dt,
        TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level-1),'D') d,
        TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level),'iw') iw
from DUAL  
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'yyyymm')), 'DD'))
GROUP BY iw
ORDER BY iw;

--12월 && 1주차를 로우넘 6번에 놓기. X
SELECT a.*, DECODE(ROWNUM,1,6, ROWNUM) aa
FROM
(SELECT /*dt, d,*/
    MAX(DECODE(d,1,dt)) sun, MAX(DECODE(d,2,dt))m,MAX(DECODE(d,3,dt))t,MAX(DECODE(d,4,dt))w,MAX(DECODE(d,5,dt))th,MAX(DECODE(d,6,dt))f,MAX(DECODE(d,7,dt))sat
FROM
(SELECT TO_DATE(:YYYYMM, 'yyyymm') + (level-1) dt,
        TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level-1),'D') d,
        TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level),'iw') iw
from DUAL  
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'yyyymm')), 'DD'))
GROUP BY iw
ORDER BY iw)a
ORDER BY aa;


--해당일자가 속한 일요일을 구해서 그거로 그룹바이한다.
SELECT /*dt, d,*/  
    MAX(DECODE(d,1,dt)) sun, MAX(DECODE(d,2,dt))m,MAX(DECODE(d,3,dt))t,MAX(DECODE(d,4,dt))w,MAX(DECODE(d,5,dt))th,MAX(DECODE(d,6,dt))f,MAX(DECODE(d,7,dt))sat
FROM
(SELECT TO_DATE(:YYYYMM, 'yyyymm') + (level-1) dt,
        TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level-1),'D') d,
        TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level),'iw') iw
FROM DUAL  
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'yyyymm')), 'DD'))
GROUP BY dt-(d-1)
ORDER BY dt-(d-1);


--
SELECT /*dt, d,*/  
    MAX(DECODE(d,1,dt)) sun, MAX(DECODE(d,2,dt))m,MAX(DECODE(d,3,dt))t,MAX(DECODE(d,4,dt))w,MAX(DECODE(d,5,dt))th,MAX(DECODE(d,6,dt))f,MAX(DECODE(d,7,dt))sat
FROM
(SELECT TO_DATE(:YYYYMM, 'yyyymm') + (level-1) dt,
        TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level-1),'D') d,
        TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level),'iw') iw
FROM DUAL  
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'yyyymm')), 'DD'))
GROUP BY iw
ORDER BY sat;


-- NULL 없이 전월, 후월 날짜 나오게하기. 과제.........................ㅜㅜㅜㅜㅜㅜㅜㅜ
SELECT /*dt, d,*/  
    MAX(DECODE(d,1,dt)) sun, MAX(DECODE(d,2,dt))m,MAX(DECODE(d,3,dt))t,MAX(DECODE(d,4,dt))w,MAX(DECODE(d,5,dt))th,MAX(DECODE(d,6,dt))f,MAX(DECODE(d,7,dt))sat
FROM
    (SELECT TO_DATE(:YYYYMM, 'yyyymm') + (level-1) dt,
            TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level-1),'D') d,
            TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level),'iw') iw
    FROM DUAL  
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'yyyymm')), 'IW'))
GROUP BY dt-(d-1)
ORDER BY dt-(d-1);
--NVL로 빈 자리채우는방법

--level을 바꾸는 방법
--201910 : 35, 첫 주의 일요일 : 20190929 , 마지막 주의 토요일 : 20191102

SELECT /*dt, d,*/  
    MAX(DECODE(d,1,dt)) sun, MAX(DECODE(d,2,dt))m,MAX(DECODE(d,3,dt))t,MAX(DECODE(d,4,dt))w,MAX(DECODE(d,5,dt))th,MAX(DECODE(d,6,dt))f,MAX(DECODE(d,7,dt))sat
FROM
    (SELECT TO_DATE(:YYYYMM, 'yyyymm') + (level-1) dt,
            TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level-1),'D') d,
            TO_CHAR(TO_DATE(:YYYYMM, 'yyyymm') + (level),'iw') iw
    FROM DUAL  
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'yyyymm')), 'IW'))
GROUP BY dt-(d-1)
ORDER BY dt-(d-1);
---------------------------------------------------------------------------------------------------
SELECT LDT-FDT+1
FROM
(SELECT LAST_DAY(TO_DATE(:yyyymm,'yyyymm')) dt,

       LAST_DAY(TO_DATE(:yyyymm,'yyyymm')) + 7 - TO_CHAR(LAST_DAY(TO_DATE(:yyyymm,'yyyymm')),'D') ldt,
       
        TO_DATE(:yyyymm,'YYYYMM') - (TO_CHAR(TO_DATE(:yyyymm,'yyyymm'),'D')-1) fdt        
FROM dual);


--


SELECT /*dt, d,*/  
    MAX(DECODE(d,1,dt)) sun, MAX(DECODE(d,2,dt))m,
    MAX(DECODE(d,3,dt))t,MAX(DECODE(d,4,dt))w,
    MAX(DECODE(d,5,dt))th,MAX(DECODE(d,6,dt))f,
    MAX(DECODE(d,7,dt))sat
FROM
    (SELECT TO_DATE(:yyyymm,'YYYYMM') - (TO_CHAR(TO_DATE(:yyyymm,'yyyymm'),'D')-1) + (level-1) dt, --해당 월의 1일?일요일?날짜
            TO_CHAR(TO_DATE(:yyyymm,'YYYYMM') - (TO_CHAR(TO_DATE(:yyyymm,'yyyymm'),'D')-1) + (level-1),'D') d,
            TO_CHAR(TO_DATE(:yyyymm,'YYYYMM') - (TO_CHAR(TO_DATE(:yyyymm,'yyyymm'),'D')-1) + (level),'iw') iw                                 
    FROM DUAL  
    CONNECT BY LEVEL <= (SELECT ldt - fdt +1
                            FROM 
                            (SELECT LAST_DAY(TO_DATE(:yyyymm,'YYYYMM')) dt,
                                     LAST_DAY(TO_DATE(:yyyymm,'yyyymm')) + 7 - TO_CHAR(LAST_DAY(TO_DATE(:yyyymm,'yyyymm')),'D') ldt,
                                    TO_DATE(:yyyymm,'YYYYMM') - (TO_CHAR(TO_DATE(:yyyymm,'yyyymm'),'D')-1) fdt        
                             FROM dual)))                         
GROUP BY dt-(d-1)
ORDER BY dt-(d-1);
--이제 이해를 해보자!
--다ㅣ른방법
SELECT /*dt, d,*/  
    MAX(DECODE(d,1,dt)) sun, MAX(DECODE(d,2,dt))m,
    MAX(DECODE(d,3,dt))t,MAX(DECODE(d,4,dt))w,
    MAX(DECODE(d,5,dt))th,MAX(DECODE(d,6,dt))f,
    MAX(DECODE(d,7,dt))sat
FROM
    (SELECT level, trunc((level-1)/7) m,
    TO_DATE(:yyyymm,'YYYYMM') - (TO_CHAR(TO_DATE(:yyyymm,'yyyymm'),'D')-1) + (level-1) dt, --해당 월의 1일?일요일?날짜
            TO_CHAR(TO_DATE(:yyyymm,'YYYYMM') - (TO_CHAR(TO_DATE(:yyyymm,'yyyymm'),'D')-1) + (level-1),'D') d,
            TO_CHAR(TO_DATE(:yyyymm,'YYYYMM') - (TO_CHAR(TO_DATE(:yyyymm,'yyyymm'),'D')-1) + (level),'iw') iw                                 
    FROM DUAL  
    CONNECT BY LEVEL <= (SELECT ldt - fdt +1
                            FROM 
                            (SELECT LAST_DAY(TO_DATE(:yyyymm,'YYYYMM')) dt,
                                     LAST_DAY(TO_DATE(:yyyymm,'yyyymm')) + 7 - TO_CHAR(LAST_DAY(TO_DATE(:yyyymm,'yyyymm')),'D') ldt,
                                    TO_DATE(:yyyymm,'YYYYMM') - (TO_CHAR(TO_DATE(:yyyymm,'yyyymm'),'D')-1) fdt        
                             FROM dual)))                         
GROUP BY m
ORDER BY m;












--알아둬야하는것. (2019_12_17_sales 도 보렴)
--1. CONNECT BY LEVEL 을 통해 없는 컬럼 만들기.
--2. DECODE 를 통해 행을 컬럼으로 바꾼것. 
--3. GROUP 함수를 적용해서 동일한 애들을 한 주차에 표시되도록 만들기.
--************************************************************************************************************



--계층쿼리
--FROM  다음에 CONNECT BY 가 온다.
--최상위에서 시작하는것(혹은 어쨋든 아래로향할때)을 하향식. 자기 밑의 모든 노드를 따라감. 대체로 하향식 많이 씀.
--중간 혹은 최하위에서 시작하는 것을 상향식. 부모만 따라감.

--시작점이 제대로 됐는지 먼저 확인한다.
SELECT *
FROM dept_h
WHERE deptcd='dept0';

--
SELECT dept_h.*, LEVEL --LEVEL 은 계층구조에따라 중복된 숫자가 나올 수 있다.
FROM dept_h
START WITH deptcd='dept0' --=시작점은 DEPTCD = 'DEPT0' --> XX회사(최상위조직)
CONNECT BY PRIOR deptcd = p_deptcd
    --이미 읽은 PRIOR deptcd(= 최상위조직 XX회사dml deptcd)
    --p_deptcd =  앞으로 읽을 데이터의 p_deptcd. (=XX회사 하위로 둘 부서.)
    --한 번만쓰면 프라이어가 그 다음읽고 다음읽으니까 쭉 전체 다 연결된다. 자식으로 둘게 없을때까지.
    --prior 가 계속 바뀌면서 죽죽 내려갈것임.
    
;

SELECT *
FROM Sales.Customer AS c
INNER LOOP JOIN Sales.CustomerAddress AS ca ON c.CustomerID = ca.CustomerID

SELECT *
FROM Sales.Customer AS c
INNER JOIN Sales.CustomerAddress AS ca ON c.CustomerID = ca.CustomerID 
OPTION (LOOP join);
------------------------------
SELECT *
FROM Sales.Customer AS c
     INNER MERGE JOIN Sales.CustomerAddress AS ca ON c.CustomerID = ca.CustomerID

SELECT *
FROM Sales.Customer AS c
  	INNER JOIN Sales.CustomerAddress AS ca ON c.CustomerID = ca.CustomerID
OPTION (MERGE join);
--
SELECT *
FROM Sales.Customer AS c
     INNER HASH JOIN Sales.CustomerAddress AS ca ON c.CustomerID = ca.CustomerID

SELECT *
FROM Sales.Customer AS c
     INNER JOIN Sales.CustomerAddress AS ca ON c.CustomerID = ca.CustomerID
OPTION (HASH join);


