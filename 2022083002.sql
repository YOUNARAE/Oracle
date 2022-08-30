2022-0830-02)�ܺ�����(OUTER JOIN) --������ ������� ����� ����

  - ���������� ���������� �����ϴ� ����� ��ȯ������, �ܺ������� 
    �ڷᰡ ������ ���̺� NULL���� �߰��Ͽ� ������ ����
  - �������� ����� �ڷᰡ ������ ���̺��� �÷� �ڿ� �ܺ����� ������ '(+)'�� �߰������
  - �ܺ����� ������ �������� �� ��� �ܺ����� ���ǿ� ��� '(+)'�����ڸ� ���
    �ؾ� ��
  - �ѹ��� �� ���̺��� �ܺ������� �� �� ����
    ��, A,B,C ���̺��� �ܺ������� ��� A�� �������� B�� �ܺ������ϰ� ���ÿ� 
    C�� �������� C�� �ܺ������� �� ����(A=B(+) AND C=B(+)�� ������ ����)
    
  - �Ϲ� �ܺ����ο��� �Ϲ������� �ο��Ǹ� ��Ȯ�� ����� ��ȯ���� ����=>
    ���������� ����� �ܺ����� �Ǵ� ANSI�ܺ� �������� �ذ��ؾ���
    
  - IN������ �Ǵ� OR�����ڴ� �ܺ����ο�����('(+)')�� ���� ����� �� ����.--�������̺��ʿ� �ٿ����Ѵ�.
  --�Ϲ������� �ܺ������� ����ϸ� �����ȴ�
  (�Ϲݿܺ����� ����)
  SELECT �÷�list
    FROM ���̺��1 [��Ī1], ���̺��2 [��Ī2],...
   WHERE ��Ī1.�÷���(+)=��Ī2.�÷���2 => ���̺��1�� �ڷᰡ ������ ���̺��� ���
   
   
  (ANSI �ܺ����� �������)
  SELECT �÷�list
    FROM ���̺��1 [��Ī1]
  RIGHT|LEFT|FULL OUTER JOIN ���̺��2 [��Ī2] ON(��������1 [AND �Ϲ�����1])
            :
  [WHERE �Ϲ�����]
  
  -'RIGHT|LEFT|FULL' : FROM���� ����� ���̺�(���̺�1)�� �ڷᰡ 
   OUTER JOIN ���̺��2 ���� ������ 'LEFT', ������ 'RIGHT'
   ���� ��� ������ 'FULL'���
 
 ** 1)SELECT ����ϴ� �÷� �� ���� ���̺� ��� �����ϴ� �÷��� ���� �� ���̺�Ű��� ����ؾ��Ѵ�
    2)�ܺ������� SELECT���� COUNT�Լ��� ����ϴ� ���
    '*'�� NULL ���� ���� �൵ �ϳ��� ������ �ν��Ͽ� ����Ȯ�� ���� ��ȯ��. ���� '*'��� �ش����̺��� �⺻Ű�� ���
    
��뿹) ��� �з��� ���� ��ǰ�� ���� ����Ͻÿ�.

--   SELECT DISTINCT PROD_LGU
--   FROM PROD
    (�Ϲݿܺ�����)
      SELECT B.LPROD_GU AS �з��ڵ�,
             B.LPROD_NM AS �з���,
             COUNT(A.PROD_ID) AS "��ǰ�� ��" --*�� ���� NULL���� ���� �൵ 1�� ī��Ʈ�ȴ�
        FROM PROD A, LPROD B
       WHERE A.PROD_LGU(+)=B.LPROD_GU
    GROUP BY B.LPROD_GU, B.LPROD_NM
    ORDER BY 1;
    
    
    (ANSI�ܺ�����)  
      SELECT B.LPROD_GU AS �з��ڵ�,
             B.LPROD_NM AS �з���,
             COUNT(A.PROD_ID) AS "��ǰ�� ��" --*�� ���� NULL���� ���� �൵ 1�� ī��Ʈ�ȴ�
        FROM PROD A
       RIGHT OUTER JOIN LPROD B ON(A.PROD_LGU=B.LPROD_GU)--���������� ������ ���� ���̺��� �����Ͱ� ������ right�� ����
    GROUP BY B.LPROD_GU, B.LPROD_NM
    ORDER BY 1;


��뿹) 2020�� 6�� ��� �ŷ�ó�� �������踦 ��ȸ�Ͻÿ�
       Alias�� �ŷ�ó�ڵ�, �ŷ�ó��, ���Աݾ��հ�
       
       SELECT A.BUYER_ID AS �ŷ�ó�ڵ�, 
              A.BUYER_NAME AS �ŷ�ó��, 
              SUM(B.BUY_QTY*C.PROD_COST) AS ���Աݾ��հ�
         FROM BUYER A, BUYPROD B, PROD C 
        WHERE B.BUY_PROD(+)=C.PROD_ID
          AND A.BUYER_ID=C.PROD_BUYER(+) 
          AND BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')
     GROUP BY A.BUYER_ID, A.BUYER_NAME;
     
     
     (ANSI �ܺ�����)
     SELECT A.BUYER_ID AS �ŷ�ó�ڵ�, 
              A.BUYER_NAME AS �ŷ�ó��, 
              NVL(SUM(B.BUY_QTY*C.PROD_COST),0) AS ���Աݾ��հ�
         FROM BUYER A
         LEFT OUTER JOIN PROD C ON(A.BUYER_ID=C.PROD_BUYER) --�������� ������ ���̺� �ڷᰡ �� �پ��ϸ� LEFT�� ����
         LEFT OUTER JOIN BUYPROD B ON(B.BUY_PROD=C.PROD_ID AND --PROD�� �ִ� ��ǰ�ڵ庸�� BUYPROD���� �� �پ��� ��ǰ �ڵ带 ������ �־ LEFT��
              BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630'))
     GROUP BY A.BUYER_ID, A.BUYER_NAME
     ORDER BY 1;
        
     (SUBQUERY)
       SELECT A.BUYER_ID AS �ŷ�ó�ڵ�, 
              A.BUYER_NAME AS �ŷ�ó��, 
              NVL(TBL.BSUM,0) AS ���Աݾ��հ�
         FROM BUYER A,
              (--2020�� 6�� �ŷ�ó�� ���Աݾ��հ�
                SELECT C.PROD_BUYER AS CID,
                       SUM(B.BUY_QTY*C.PROD_COST) AS BSUM
                  FROM BUYPROD B, PROD C 
                 WHERE B.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')
                   AND B.BUY_PROD = C.PROD_ID
              GROUP BY C.PROD_BUYER) TBL       
         WHERE A.BUYER_ID=TBL.CID(+)
      ORDER BY 1;
     
        
        
        
        







    SELECT DISTINCT BUY_PROD
    FROM BUYPROD
    WHERE BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630');
         
         

��뿹) 2020�� ��ݱ�(1-6��) ��� ��ǰ�� ���Լ������踦 ��ȸ�Ͻÿ�


��뿹) 2020�� ��ݱ�(1-6��) ��� ��ǰ��/
    
    
    
    
    
    
    
    
  