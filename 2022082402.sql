2022-0824-02) ROLLUP�� CUBE
  - �پ��� �������� ��� ���� ���
  - �ݵ�� GROUP BY ���� ���Ǿ�� ��
   
  1) ROLLUP
    . LEVEL�� ���� ����� ��ȯ
    
  (�������)
  GROUP BY [�÷�,]ROLLUP(�÷���1 [,�÷���2,...,�÷���n])[,�÷�]
   - �÷���1���� �÷���n�� �����÷����� ���� ��� �� �����ʺ��� �÷��� �ϳ���
     ������ �������� ���踦 ��ȯ, n+1���� �ȴ�.
   - ���� �������� ��ü����(��� �÷����� ������ ������) ��ȯ
   - ROLLUP �� �Ǵ� �ڿ� �÷��� �� �� ���� => �κ� ROLLUP�̶���

��뿹) 2020�� 4-7�� ����,ȸ����,��ǰ�� ���ż����հ踦 ��ȸ�Ͻÿ�.
      (ROLLUP�� �����)
       SELECT SUBSTR(CART_NO,5,2) AS ��,
              CART_MEMBER AS ȸ����ȣ,
              CART_PROD AS ��ǰ�ڵ�,
              SUM(CART_QTY) AS ���ż����հ�
         FROM CART
        WHERE SUBSTR(CART_NO,1,6) BETWEEN '202004' AND '202007'
     GROUP BY SUBSTR(CART_NO,5,2), CART_MEMBER, CART_PROD
     ORDER BY 1;
              
              
       (ROLLUP���)
       SELECT SUBSTR(CART_NO,5,2) AS ��,
              CART_MEMBER AS ȸ����ȣ,
              CART_PROD AS ��ǰ�ڵ�,
              SUM(CART_QTY) AS ���ż����հ�
         FROM CART
        WHERE SUBSTR(CART_NO,1,6) BETWEEN '202004' AND '202007'
     GROUP BY ROLLUP(SUBSTR(CART_NO,5,2), CART_MEMBER, CART_PROD)
     ORDER BY 1;
              

   (CUBE ���)
    SELECT SUBSTR(CART_NO,5,2) AS ��,
              CART_MEMBER AS ȸ����ȣ,
              CART_PROD AS ��ǰ�ڵ�,
              SUM(CART_QTY) AS ���ż����հ�
         FROM CART
        WHERE SUBSTR(CART_NO,1,6) BETWEEN '202004' AND '202007'
     GROUP BY CUBE(SUBSTR(CART_NO,5,2), CART_MEMBER, CART_PROD)
     ORDER BY 1;

 (�κ�ť��)
      SELECT SUBSTR(CART_NO,5,2) AS ��,
              CART_MEMBER AS ȸ����ȣ,
              CART_PROD AS ��ǰ�ڵ�,
              SUM(CART_QTY) AS ���ż����հ�
         FROM CART
        WHERE SUBSTR(CART_NO,1,6) BETWEEN '202004' AND '202007'
     GROUP BY SUBSTR(CART_NO,5,2), CUBE(CART_MEMBER, CART_PROD) --�ڿ� ������ ���ذ��� �Ǿ��ش�
     ORDER BY 1;





��뿹) ��ǰ���̺���  ��ǰ�� �з���, �ŷ�ó�� ��ǰ�� ��(COUNT)�� ��ȸ�Ͻÿ�
       
       (GROUP BY���� ����ϴ� ���)
       SELECT PROD_LGU AS "��ǰ�� �з�",
              PROD_BUYER AS "�ŷ�ó �ڵ�",
              COUNT(*) AS "��ǰ�� ��"
         FROM PROD
     GROUP BY PROD_LGU, PROD_BUYER
     --�׷�������� ���ʺ��� ������� ��з�-�ߺз�-�Һз� 
     ORDER BY 1;
     
     (ROLLUP�� ����ϴ� ���)
      SELECT PROD_LGU AS "��ǰ�� �з�",
              PROD_BUYER AS "�ŷ�ó �ڵ�",
              COUNT(*) AS "��ǰ�� ��"
         FROM PROD
     GROUP BY ROLLUP(PROD_LGU, PROD_BUYER)
     ORDER BY 1;
       
       
       
    (�κ� ROLLUP)
       SELECT PROD_LGU AS "��ǰ�� �з�",
              PROD_BUYER AS "�ŷ�ó �ڵ�",
              COUNT(*) AS "��ǰ�� ��"
         FROM PROD
     GROUP BY PROD_LGU, ROLLUP(PROD_BUYER)
     ORDER BY 1;
       
       
       
2) CUBE
  . GROUP BY �� �ȿ� ���Ǿ� CUBE ���ο� ����� �÷��� ���� ������ ��� ���踦 ��ȯ
  . CUBE  ���ο� ����� �÷��� ������ n���� �� 2�� n�� ������ŭ�� ���������� ��ȯ
  
  
--�Ѿ��� ����Ǿ��� �������� ���踦 ��ȯ�ϴ� �ݸ鿡 ť��� ������ ������ �ʴ´�.
--ť��� ��ȣ ���� �÷��� ������ŭ ��� ����� ����ŭ ���踦 ��ȯ�Ѵ�.
--ex)��ȣ ���� ������ 3�� -> �Ѿ� 4����
--                        ť�� 8����

  .



       
       
       
       