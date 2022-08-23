�н���ǥ

1.�����Լ� : �׷캰�� ��� �ǹ��ִ� ����� ����.

2.sum() : �հ�
  avg() ���
  max() �ִ밪
  min() �ּҰ�
  count() ����
   
--��ǰ���̺��� ��ǰ�з��� ���԰��� ��� ��

--BY : ~ ��
--GROUP : ����
-- ASCENDING : ��������(��������) / DESCENDING : ��������

  SELECT PROD_LGU,
         ROUND(AVG(PROD_COST),2) PROD_COST
    FROM PROD
    GROUP BY PROD_LGU
    ORDER BY PROD_LGU ; 
       
       
--��ǰ�з��� ���Ű��� ���    
    SELECT PROD_LGU ��ǰ�з�
           , ROUND(AVG(PROD_SALE),2) ���Ű������
      FROM  PROD
  GROUP BY PROD_LGU
  ORDER BY PROD_LGU;
  
  
---------------------------------------------
  
   SELECT PROD_LGU,
          PROD_BUYER,
          ROUND(AVG(PROD_COST),2) PROD_COST,
          SUM(PROD_COST),
          MAX(PROD_COST),
          MIN(PROD_COST),
          COUNT(PROD_COST)
     FROM PROD
 GROUP BY PROD_LGU, PROD_BUYER --�ұ׷����� �����ٴ� �ǹ�(P101/P10101)
 ORDER BY 1,2;
    
--P.282 ��ǰ���̺�(PROD)�� �� �ǸŰ���(PROD_SALE) ��� ���� ���Ͻÿ� ? (Alias�� ��ǰ���ǸŰ����) 
ALLAS ��� BYTES�� 30����Ʈ���� �� �� �ִ�.
    
 SELECT ROUND(AVG(PROD_SALE),2) AS ��ǰ���ǸŰ����
   FROM PROD;
    
 
--P.282 ��ǰ���̺��� ��ǰ�з�(PROD_LGU)�� �ǸŰ���(PROD_SALE) ��� ���� ���Ͻÿ� ? (Alias�� ��ǰ�з�(PROD_LGU), ��ǰ�з����ǸŰ������) 

    SELECT PROD_LGU AS ��ǰ�з�,
           TO_CHAR(ROUND(AVG(PROD_SALE),2),'L9,999,999.00') AS ��ǰ�з����ǸŰ����
      FROM PROD
  GROUP BY PROD_LGU;
  
  
----P.283
--�ŷ�ó���̺�(BUYER)�� 
--�����(BUYER_CHARGER)�� �÷����� �Ͽ� 
--COUNT���� �Ͻÿ� ? 
--( Alias�� �ڷ��(DISTINCT), 
--  �ڷ��, �ڷ��(*) )  --null���� ī��Ʈ�� �� ��������.
--�⺻Ű(��ǥ��,ª�ƾ���,���ֻ��) <-�ĺ�Ű
--�ĺ�Ű ���� : 1)Not Null, 2)No Duplicate
--*�� ���� ���� ������ ����.

--���� �� : ī��θ�Ƽ
--���� �� : ����(DEGREE)
SELECT COUNT(*), --74
       COUNT(PROD_COLOR)--41
  FROM PROD;

SELECT COUNT(DISTINCT BUYER_CHARGER) AS "�ڷ�� (DISTINCT)",
       COUNT(BUYER_CHARGER) AS �ڷ��,
       COUNT(*) AS "�ڷ��(*)"
  FROM BUYER;
  
Ư����ȣ�� �� #_$ �����̽��� �ȵǰ� ��ȣ�� �ȵȴ�
���̺��,�÷���,Alias��
  
--p.283 ȸ�����̺�(MEMBER)�� ���(MEM_LIKE)�� COUNT���� �Ͻÿ�?
  SELECT MEM_LIKE AS ���, 
         COUNT(MEM_ID) AS �ڷ��, 
         COUNT(*) AS "�ڷ��(*)"
    FROM MEMBER
GROUP BY MEM_LIKE;


--P.284
--��ٱ������̺��� ȸ���� �ִ뱸�ż����� �˻��Ͻÿ�?
--ALIAS : ȸ��ID, �ִ����, �ּҼ���

SELECT CART_MEMBER AS ȸ��,
       MAX(CART_QTY) AS �ִ����,
       MIN(CART_QTY) AS �ּҼ���
  FROM CART
GROUP BY CART_MEMBER
ORDER BY CART_MEMBER;


--������ 2020�⵵7��11���̶� �����ϰ� 
--��ٱ������̺�(CART)�� �߻��� �߰��ֹ���ȣ(CART_NO)�� �˻� �Ͻÿ� ? 
--( Alias�� �ְ�ġ�ֹ���ȣMAX(CART_NO), 
--�߰��ֹ���ȣMAX(CART_NO)+1 )
--LIKE�� �Բ� ���� %,_�� ���ϵ�ī��
-- % : ���� ���� / _ : �� ����

SELECT MAX(CART_NO)AS �ְ�ġ�ֹ���ȣ,
       MAX(CART_NO)+1 AS �߰��ֹ���ȣ
FROM CART
WHERE SUBSTR(CART_NO,1,8) = '20200711'
  AND CART_NO LIKE '20200711%';

<�ܿ�� ��>
�˻�����   ����
Select..from...where

������Ʈ..��...�뿩
update...set..where

��Ǫ������.....�ּ���
delete..from..where

GROUP BY HAVING
ORDER BY�� �� �������� ����


--285
--��ǰ���̺��� ��ǰ�з�, �ŷ�ó����
--�ְ��ǸŰ�, �ּ��ǸŰ�, �ڷ���� �˻��Ͻÿ�?

SELECT MAX AS �ְ��ǸŰ�,
       MIN AS �ּ��ǸŰ�, 
       COUNT() AS �ڷ��
FROM PROD
GROUP BY ��ǰ�з�, �ŷ�ó