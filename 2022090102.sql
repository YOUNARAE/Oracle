2022-0901-02)���տ�����
 - SELECT���� ����� ������� ���տ��� ����
 - UNION ALL, UNION, INTERSECT, MINUS ������ ����
 - ���տ����ڷ� ����Ǵ� SELECT���� �� SELECT���� �÷��� ������ ������ Ÿ���� ��ġ�ؾ���
 - ORDER BY���� �� ������ SELECT������ ��� ����
 - BLOB, CLOB, BFILE Ÿ���� �÷��� ���տ����ڸ� ����� �� ����
 - UNION, INTERSECT, MINUS�����ڴ� LONGŸ���� �÷��� ����� �� ����
 - GROUPING SETS(col1,col2,...) => UNION ALL ������ ���Ե� ����
   ex) GROUPING SETS(col1,col2,col3)
   =>((GROUP BY Col1) UNION ALL (GROUP BY col2) UNION ALL (GROUP BY col3)) 

--ex) 1�Ź��� ���� �� UNION
--    2�Ź��� ���� �� UNION
--    1,2�Ź��� �� ���� �� UNION ALL
--UNION, UNION ALL(������) /�ߺ��� ������ִ� ���� UNION ALL
--INTERSECT(������)
--MINUS(������) 

1)UNION ALL
  - �ߺ��� ����� �������� ����� ��ȯ

 ��뿹)ȸ�����̺��� ������ �ֺ��� ȸ���� ���ϸ����� 3000�̻��� ��� ȸ������
       ȸ����ȣ,ȸ����,����,���ϸ����� ��ȸ�Ͻÿ�.
       
       SELECT MEM_ID AS ȸ����ȣ,
              MEM_NAME AS ȸ����,
              MEM_JOB AS ����,
              MEM_MILEAGE AS ���ϸ���
         FROM MEMBER
        WHERE MEM_JOB='�ֺ�'
        
UNION ALL
        
       SELECT MEM_ID,  --2��° ����Ʈ���� ��Ī�� �� ���൵ �ȴ�, ������ ������ �Ȱ��� ���̳� Ÿ���� ������ �־�ߵȴ�.
              MEM_NAME,
              MEM_JOB,
              TO_NUMBER(MEM_REGNO1) --�ݵ�� ����Ǿ��� �÷�Ÿ���� ���� Ÿ���̾���Ѵ�
         FROM MEMBER
        WHERE MEM_MILEAGE >= 3000;  --3000���� �Ѵ� ������� ���ϸ����� MEM_REGNO1�� ǥ����
       
��뿹)2020�� 4,5,6,7�� ���Ÿ� ���� ���� ȸ������ ȸ����ȣ,ȸ����,���űݾ��հ踦 
      ��ȸ�Ͻÿ�
      
WITH T1 AS --�̸� ����� �̸��� �ٿ��ִ� ��, VIEW�� ����� �����̴�. 
     (SELECT '4��' AS MON,C.MEM_ID AS CID, C.MEM_NAME AS CNAME, D.TOT1 AS CTOT1
        FROM  (SELECT CART_MEMBER AS AMID,
                      SUM(A.CART_QTY*B.PROD_PRICE) AS TOT1
                 FROM CART A, PROD B
                WHERE A.CART_NO LIKE '202004%'
                  AND A.CART_PROD=B.PROD_ID --(!)
             GROUP BY A.CART_MEMBER
             ORDER BY 2 DESC) D, MEMBER C
             WHERE C.MEM_ID=D.AMID
             AND ROWNUM = 1 -- ���� ������ AND(!)�� ������ �׳� CART ���� ������ ���� �� ����� �������⶧���� ���� Ʋ����.
             --ORDER BY�� ���� ����� �Ŀ� ROWNUM�� ������Ѿ��Ѵ�. 1� �����ϴϱ� �������� ROWNUM�� ����Ѵ�
    UNION ALL   
    SELECT '5��', C.MEM_ID, C.MEM_NAME, D.TOT1
        FROM  (SELECT CART_MEMBER AS AMID,
                      SUM(A.CART_QTY*B.PROD_PRICE) AS TOT1
                 FROM CART A, PROD B
                WHERE A.CART_NO LIKE '202005%'
                  AND A.CART_PROD=B.PROD_ID
             GROUP BY A.CART_MEMBER
             ORDER BY 2 DESC) D, MEMBER C
             WHERE C.MEM_ID=D.AMID
             AND ROWNUM = 1
     UNION ALL
     SELECT '6��', C.MEM_ID, C.MEM_NAME, D.TOT1
        FROM  (SELECT CART_MEMBER AS AMID,
                      SUM(A.CART_QTY*B.PROD_PRICE) AS TOT1
                 FROM CART A, PROD B
                WHERE A.CART_NO LIKE '202006%'
                  AND A.CART_PROD=B.PROD_ID
             GROUP BY A.CART_MEMBER
             ORDER BY 2 DESC) D, MEMBER C
             WHERE C.MEM_ID=D.AMID
             AND ROWNUM = 1
     UNION ALL
     SELECT '7��', C.MEM_ID, C.MEM_NAME, D.TOT1
        FROM  (SELECT CART_MEMBER AS AMID,
                      SUM(A.CART_QTY*B.PROD_PRICE) AS TOT1
                 FROM CART A, PROD B
                WHERE A.CART_NO LIKE '202007%'
                  AND A.CART_PROD=B.PROD_ID
             GROUP BY A.CART_MEMBER
             ORDER BY 2 DESC) D, MEMBER C
             WHERE C.MEM_ID=D.AMID
             AND ROWNUM = 1)
             --������� �� ���� �ش��ϴ� ���� ���� ������ 1���� ���ͼ� �������� ������ 4���� ���� ���´�.
             --���� �࿡ �ؿ� ����Ʈ������ �÷��� ��Ī�� �ٿ��� ����
SELECT MON AS ��,
       CID AS ȸ����ȣ,
       CNAME AS ȸ����,
       CTOT1 AS ���űݾ�
  FROM T1;

--UNION�� �� ������ Ư���� �ڷῡ�� Ư���� ���� ��� ���ƾ� ���� ����� ���´�

��뿹) 6���� 7���� �Ǹŵ� ��� ��ǰ�� �ߺ����� �ʰ� ����Ͻÿ�.
       Alias ��ǰ�ڵ�, ��ǰ��
      
      SELECT DISTINCT A.CART_PROD AS ��ǰ�ڵ�, 
             B.PROD_NAME AS ��ǰ��
        FROM CART A, PROD B
       WHERE A.CART_PROD=B.PROD_ID
         AND A.CART_NO LIKE '202006%'

      UNION
       
      SELECT DISTINCT A.CART_PROD, 
             B.PROD_NAME
        FROM CART A, PROD B
       WHERE A.CART_PROD=B.PROD_ID
         AND A.CART_NO LIKE '202007%'
       ORDER BY 1; 



2) INTERSECT 
  - ������(����κ�)�� ��� ��ȯ
  

��뿹) 2020�� ���Ի�ǰ �� 1���� 5���� ��� ���Ե� ��ǰ��
      ��ǰ�ڵ�,��ǰ��,����ó���� ��ȸ�Ͻÿ�
      
      SELECT DISTINCT A.BUY_PROD AS ��ǰ�ڵ�, --��ǰ�� �ߺ������Ǹ� �ŷ��� �ߺ������ȴ�
             C.PROD_NAME AS ��ǰ��,
             B.BUYER_NAME AS ����ó��
        FROM BUYPROD A, BUYER B, PROD C
       WHERE A.BUY_PROD=C.PROD_ID
         AND C.PROD_BUYER=B.BUYER_ID
         AND BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
         
    INTERSECT
      
      SELECT DISTINCT A.BUY_PROD, 
             C.PROD_NAME,
             B.BUYER_NAME
        FROM BUYPROD A, BUYER B, PROD C
       WHERE A.BUY_PROD=C.PROD_ID
         AND C.PROD_BUYER=B.BUYER_ID
         AND BUY_DATE BETWEEN TO_DATE('20200501') AND TO_DATE('20200531')
    ORDER BY 1;
    
    
��뿹)1�� ���Ի�ǰ �� 5�� �Ǹ� �������� 5�� �ȿ� �����ϴ� ��ǰ������ ��ȸ�Ͻÿ�
      
WITH T1 AS  
  (SELECT BUY_PROD 
     FROM BUYPROD
    WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')

INTERSECT  

     SELECT A.CART_PROD
       FROM (SELECT CART_PROD,
                    SUM(CART_QTY)
               FROM CART
              WHERE CART_NO LIKE '202005%'
              GROUP BY CART_PROD
              ORDER BY 2 DESC) A
       WHERE ROWNUM<=5)
             --������� �� ���� �ش��ϴ� ���� ���� ������ 1���� ���ͼ� �������� ������ 4���� ���� ���´�.
             --���� �࿡ �ؿ� ����Ʈ������ �÷��� ��Ī�� �ٿ��� ����
SELECT BUY_PROD AS ��ǰ�ڵ�, PROD_NAME AS ��ǰ��
  FROM T1,PROD
 WHERE T1.BUY_PROD=PROD_ID;
  
 
         
         
         







