2022-0902-01)
  4) MINUS
    - �������� ����� ��ȯ
    - A MINUS B : A�� ������� B�� ����� ������ �� ��ȯ
      B MINUS A : B�� ������� A�� ����� ������ �� ��ȯ
    
 
��뿹) 2020�� �������̺�(CART)���� 5���� 6�� ���� �� 5������ �Ǹŵ� 
       ��ǰ�� ��ȸ�Ͻÿ�.
       Alias ��ǰ��
      
      
      -- 5�� �Ǹŵ� �� 
       SELECT DISTINCT A.CART_PROD AS CID, 
              B.PROD_NAME AS CNAME
         FROM CART A, PROD B
        WHERE A.CART_PROD=B.PROD_ID
          AND SUBSTR(A.CART_NO,1,6)='202005'
          
     MINUS 
          
      -- 6�� �Ǹŵ� ��
      SELECT DISTINCT A.CART_PROD AS CID, 
              B.PROD_NAME AS CNAME
         FROM CART A, PROD B
        WHERE A.CART_PROD=B.PROD_ID
          AND SUBSTR(A.CART_NO,1,6)='202006'
          
          
          
(WITH�� ���)
WITH T1 AS ( --������ �л�� ���� �ѹ��� ��� ����� �� �־ ȿ�����̴�
   
   SELECT DISTINCT CART_PROD AS CID
         FROM CART
        WHERE SUBSTR(CART_NO,1,6)='202005'
        
   MINUS 
          
   SELECT DISTINCT CART_PROD
         FROM CART
        WHERE SUBSTR(CART_NO,1,6)='202006'
   )
   --WITH�� ���� ���
   SELECT A.CID AS ��ǰ�ڵ�, 
          B.PROD_NAME AS ��ǰ��
     FROM T1 A, PROD B
    WHERE A.CID=PROD_ID;
  
    
    