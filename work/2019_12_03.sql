--db, �����õȰ�. ��������. ���̽�, ������̿����� ��´������ �������´ٰ��Ͻ�.
--<<inner join>>
--�÷� ������ �����ϴ� �����͸� ������ join
--join = inner join
--<<cross join>>(cartesian product)
--������ ���������� ���� ���. ����������. �� ���̺��� ����� ���� �����ŭ�� ���.
--emp(14), dept(4) = 56��.
--���̺� �����ϴ� ��캸�� ������ ������ ���� ���.
--����Ŭ���� ���������� ����.

--cross join
SELECT cid, cnm, pid, pnm
FROM customer CROSS JOIN product;

--���̽����ڿ�?
--īī�� api����..
--�����ͽ���� 

--���ù�������
--�������Ŀ����� ���������� ����������. ������ ǥ���ض�.
--���ù��������� ���� ������ ����.
--���� / �õ� / �ñ��� / ���ù�������
-- 1   ����Ư���� ���ʱ�  7.5 (�Ҽ���ù��°�ڸ�������)

SELECT *
FROM FASTFOOD;

SELECT gb
FROM FASTFOOD
GROUP BY gb;

SELECT sido,sigungu
FROM fastfood
GROUP BY sido, sigungu;

--��ü
SELECT sido,sigungu,gb, COUNT(gb)
FROM fastfood
GROUP BY sido, sigungu, gb;

--�Ե����� ����
SELECT sido,sigungu,gb, COUNT(gb)
FROM fastfood
GROUP BY sido, sigungu, gb
HAVING gb IN ('�Ƶ�����', '����ŷ', 'KFC');

--�Ե����Ƹ�
SELECT sido,sigungu,gb, COUNT(gb)
FROM fastfood
GROUP BY sido, sigungu, gb
HAVING gb IN ('�Ե�����');

--�ñ����� �Ե��������� ���� �� = s
SELECT sido, sigungu, SUM (s1) s2
FROM
(SELECT sido,sigungu,gb, COUNT(gb) s1
FROM fastfood
GROUP BY sido, sigungu, gb
HAVING gb IN ('�Ƶ�����', '����ŷ', 'KFC')) a
GROUP BY sido, sigungu;

--s ������ �Ե����Ƹ� �غ���
SELECT sido, sigungu, SUM (s1),
         CASE
         WHEN gb IN ('�Ƶ�����', '����ŷ', 'KFC') THEN SUM(COUNT(gb))
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
WHEN gb IN ('�Ƶ�����', '����ŷ', 'KFC') THEN COUNT(gb) 
END a,
CASE
WHEN gb IN ('�Ե�����') THEN COUNT(gb) 
END b
FROM fastfood
GROUP BY sido, sigungu, gb) g
GROUP BY sido, sigungu;

-- ������ ������, ����, ����, �߱�, �����
--5�� �� ������ ������ۼ��غ�����
SELECT sido, sigungu, gb, COUNT(gb)
FROM fastfood
GROUP BY sido, sigungu, gb
HAVING sido = '����������';

/*������  4 / 8 = 0.5
����  6 / 8  = 0.75
����  17 / 12 = 1.416
�߱� 7/6 =1.16
����� 3/7 =0.428
*/

SELECT sido,sigungu,gb, COUNT(gb)
FROM fastfood
GROUP BY sigungu, sido, gb 
HAVING sido = '����������'
AND gb NOT IN '�Ե�����';


-----������ ���
--�ش�õ�, �ñ����� ��������� �Ǽ��� �ʿ�.
--���α��ؼ� �����Ѵٱ�???
SELECT sido, sigungu, COUNT(*) cnt --����ŷ, KFC, �Ƶ����� �Ǽ�
FROM fastfood
WHERE gb IN ('�Ƶ�����', '����ŷ', 'KFC')
GROUP BY sido, sigungu
ORDER BY sido, sigungu;

SELECT sido, sigungu, COUNT(*) cnt --�Ե����� �Ǽ�
FROM fastfood
WHERE gb IN ('�Ե�����')
GROUP BY sido, sigungu
ORDER BY sido, sigungu;
-----------------------------

SELECT a.sido, a.sigungu, a.cnt, b.cnt, ROUND(a.cnt/b.cnt, 1) as ���ù�������
FROM
(SELECT sido, sigungu, COUNT(*) cnt --����ŷ, KFC, �Ƶ����� �Ǽ�
FROM fastfood
WHERE gb IN ('�Ƶ�����', '����ŷ', 'KFC')
GROUP BY sido, sigungu) a,

(SELECT sido, sigungu, COUNT(*) cnt --�Ե����� �Ǽ�
FROM fastfood
WHERE gb IN ('�Ե�����')
GROUP BY sido, sigungu
ORDER BY sido, sigungu) b
WHERE a.sido = b.sido
AND a.sigungu = b.sigungu
ORDER BY ���ù������� DESC;

--------------------------------
SELECT ROWNUM rn, sido, sigungu, ���ù�������
FROM
(SELECT a.sido, a.sigungu, a.cnt, b.cnt, ROUND(a.cnt/b.cnt, 1) as ���ù�������
FROM
(SELECT sido, sigungu, COUNT(*) cnt --����ŷ, KFC, �Ƶ����� �Ǽ�
FROM fastfood
WHERE gb IN ('�Ƶ�����', '����ŷ', 'KFC')
GROUP BY sido, sigungu) a,

(SELECT sido, sigungu, COUNT(*) cnt --�Ե����� �Ǽ�
FROM fastfood
WHERE gb IN ('�Ե�����')
GROUP BY sido, sigungu
ORDER BY sido, sigungu) b
WHERE a.sido = b.sido
AND a.sigungu = b.sigungu
ORDER BY ���ù������� DESC);

--�������� �� �ΰ��� �ü��ֱ���......
--����û..............20������ 14��..... 1�δ� 7õ����.
--1�δ� ��ձݾ�!
--�ϰ� ��������1���� ����û 1����  �� �ο쿡 ������ �� ����.
SELECT *
FROM TAX;
---------------------------------------------------------------------------------------------------------
SELECT aa. rn, aa.sido, aa.sigungu, aa.���ù�������,
bb. rn, bb.sido, bb.sigungu, bb.t
FROM
    (SELECT ROWNUM rn, sido, sigungu, ���ù�������
    FROM
        (SELECT a.sido, a.sigungu, a.cnt, b.cnt, ROUND(a.cnt/b.cnt, 1) as ���ù�������
        FROM
            (SELECT sido, sigungu, COUNT(*) cnt --����ŷ, KFC, �Ƶ����� �Ǽ�
            FROM fastfood
            WHERE gb IN ('�Ƶ�����', '����ŷ', 'KFC')
            GROUP BY sido, sigungu) a,
        
        (SELECT sido, sigungu, COUNT(*) cnt --�Ե����� �Ǽ�
        FROM fastfood
        WHERE gb IN ('�Ե�����')
        GROUP BY sido, sigungu
        ORDER BY sido, sigungu) b
        
        WHERE a.sido = b.sido
        AND a.sigungu = b.sigungu
        ORDER BY ���ù������� DESC)) aa RIGHT OUTER JOIN
    
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
--�� ������ �����ؼ� ���ù������� �õ�, �ñ����� �������곳�ӱݾ��� �õ�, �ñ����� ���� �������� ����.
--���ļ����� tax���̺��� id �÷���.

SELECT bb.id, aa.sido, aa.sigungu, aa.���ù�������,
 bb.sido, bb.sigungu, bb.t
FROM
(SELECT ROWNUM rn, sido, sigungu, ���ù�������
FROM
(SELECT a.sido, a.sigungu, a.cnt, b.cnt, ROUND(a.cnt/b.cnt, 1) as ���ù�������
FROM
(SELECT sido, sigungu, COUNT(*) cnt --����ŷ, KFC, �Ƶ����� �Ǽ�
FROM fastfood
WHERE gb IN ('�Ƶ�����', '����ŷ', 'KFC')
GROUP BY sido, sigungu) a,

(SELECT sido, sigungu, COUNT(*) cnt --�Ե����� �Ǽ�
FROM fastfood
WHERE gb IN ('�Ե�����')
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
SELECT aa. rn, aa.sido, aa.sigungu, aa.���ù�������,
bb. rn, bb.sido, bb.sigungu, bb.t
FROM
(SELECT ROWNUM rn, sido, sigungu, ���ù�������
FROM
(SELECT a.sido, a.sigungu, a.cnt, b.cnt, ROUND(a.cnt/b.cnt, 1) as ���ù�������
FROM
(SELECT sido, sigungu, COUNT(*) cnt --����ŷ, KFC, �Ƶ����� �Ǽ�
FROM fastfood
WHERE gb IN ('�Ƶ�����', '����ŷ', 'KFC')
GROUP BY sido, sigungu) a,

(SELECT sido, sigungu, COUNT(*) cnt --�Ե����� �Ǽ�
FROM fastfood
WHERE gb IN ('�Ե�����')
GROUP BY sido, sigungu
ORDER BY sido, sigungu) b
WHERE a.sido = b.sido
AND a.sigungu = b.sigungu
ORDER BY ���ù������� DESC)) aa RIGHT OUTER JOIN

(SELECT ROWNUM rn, sido, sigungu, t
FROM
(SELECT sido, sigungu, ROUND(sal/people,1) t 
FROM tax
ORDER BY t DESC)) bb;