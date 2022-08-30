2022-0829-01) ���̺� ����
 - ������ �����ͺ��̽����� ����(Relationship)�� �̿��Ͽ� �������� ���̺�� ����
   �ʿ��� �ڷḦ �����ϴ� ���� 
   
 - ���ο� �����ϴ� ���̺��� �ݵ�� ����(�ܷ�Ű ����)�� �ξ����(���谡 ���� ���̺�
   ���� ������ Cartessian(Cross) join �̶�� ��)

 - ������ ����
   . �������ΰ� �ܺ�����(Inner join���������� �����ϴ� ���, outer join���������� �������� �ʴ� ������ ���Խ�Ű�� ���)
   --�������κ��� �ܺ������� ������� Ŀ�� �� �־ ��ü ������ ������ ������ �� �ִ�.
   . �Ϲ����ΰ� ANSI(KS�԰�����ȸ���� �̱��� ���α׷���� �԰��� ����� ��ü,ex�ƽ�Ű�ڵ�) Join
   --ANSI������ Ư¡ : ��� DBMS�� �ᵵ ������ ������ ������ �ִ�.
   . Equi-Join, Non-Equi Join, Self Join, Cartessian Product
   --�� �������ǿ� =�� ���Ǹ� Equi, !=�� ���Ǹ� Non-Equi
   --�� self Join�� �����ΰ� ������ �Ǵ� ���̺�
    
    
  1.�Ϲ� ����
  - �� DB�������� �ڻ��� DBMS�� ����ȭ�� ���������� ����
  - ��� DB�� �ٲ�� ����� ������ ���� �����ؾ� ��
  (�������)
   SELECT �÷�list
     FROM ���̺��1 [��Ī1], ���̺�2 [��Ī2] [,...] --�������� �ȴ�.
    WHERE [��Ī1.|���̺��1.]�÷��� ������ [��Ī2.|���̺��2.]�÷��� --���ι����� �������� ������ �� ����. ���������� ����ؾ��ؼ�.
     [AND ��������]
     [AND �Ϲ�����]
                      :
                      
    . n���� ���̺��� ���Ǹ� ���������� ��� n-1�� �̻� �Ǿ�� ��
    . �Ϲ����ǰ� ���������� ��� ������ �ٲ� ��� ����
   
2. ANSI �������� 
   SELECT �÷�list
     FROM ���̺��1[��Ī1]
     INNER|CROSS|NATURAL JOIN ���̺��2 [��Ī2] ON(�������� [AND �Ϲ�����])--������ ���� ������ ���̺�1�� ���̺�2���� ����ȴ�
     INNER|CROSS|NATURAL JOIN ���̺��2 [��Ī2] ON(�������� [AND �Ϲ�����])
                               :

    [WHERE �Ϲ�����] --��� ���̺� ����Ǿ���� ������ WHERE���� ���� ���̴�.
              :
    . ���̺��1�� ���̺��2�� �ݵ�� ���� JOIN �����ؾ���
    . ���̺��3�� ���̺��1�� ���̺��2�� ���� ����� ���� ����
    . 'CROSS JOIN'�� �Ϲ������� Cartessian Product�� ����
    . 'NATURAL JOIN'�� ���ο��꿡 ���� ���̺� ���� �÷����� �����ϸ� �ڵ����� ���� �߻�
      
    
3. Cartessian Product Join(Cross Join)
   . ���������� ������� �ʾҰų� �߸� ����� ��� �߻�
   . n�� m���� ���̺�� a�� b���� ���̺��� Cross Join�� ��� �־��� ���(���������� ������ ���)
     ����� n*a �� m+b  ���� ��ȯ��
   . �ݵ�� �ʿ��� ��찡 �ƴϸ� ����� �����ؾ� ��

��뿹) 
   SELECT COUNT(*) AS "PROD ���̺� ���� ��" FROM PROD;
   SELECT COUNT(*) AS "CART ���̺� ���� ��" FROM CART;
   SELECT COUNT(*) AS "BUYPROD ���̺� ���� ��" FROM BUYPROD;
   
   SELECT COUNT(*) FROM PROD,CART,BUYPROD,HR.EMPLOYEES; --�������� �����ϱ� īŸ�þ� �����̴�
   
  -- ANSI�� ���� ���¸� ����� �ʴ´�
   SELECT * 
     FROM PROD
    CROSS JOIN BUYPROD
    CROSS JOIN CART;
    
  --���� ������ ���� ���� �� īŸ�þ� ���̺��� ����ȴ� 
  
  4. Equi Join(ANSI�� INNER JOIN)
    - �������ǿ� '='������ ���
  
    (�Ϲ����� �������)
    SELECT �÷�list
      FROM ���̺��1 [��Ī1], ���̺��2 [��Ī2] [,���̺��3 [��Ī3],...]
     WHERE [��Ī1.]�÷���1=[��Ī2.]�÷���2 --��������
      [AND [��Ī1.]�÷Ÿ�1=[��Ī3.]�÷���3]--��������
      
      [AND �Ϲ�����]
    
    
    (ANSI ���� �������)
    SELECT �÷�list
      FROM ���̺��1 [��Ī1]
      INNER JOIN ���̺��2 [��Ī2] ON([��Ī1.]�÷���1=[��Ī2.]�÷���2 [AND �Ϲ�����1])
      --���� ���� ���(���̺�1�� 2�� ���� ����)�� ���̺�3�� ����Ǵ� �����̴�.
      [INNER JOIN ���̺��3 [��Ī3] ON([��Ī1.]�÷���1=[��Ī3.]�÷���3 [AND �Ϲ�����2])
      
      [WHERE �Ϲ�����] -- ���� ���̺��� �������� ������ ������ִ� ��
      
��뿹) �������̺��� 2020�� 7�� ���Ի�ǰ������ ��ȸ�Ͻÿ�
       Alias�� ����,��ǰ��ȣ,��ǰ��,����,�ݾ� 
       
       --��θ��� �⺻Ű�� �����پ� ���� �ڽ����̺��̴�
       --�躰Ī�� �� ���̺� ���̿� ���������� ���� �÷��� �ִ� ��� ����Ѵ�.���� ���̺���� ���� �� �� �ᵵ��.
       
       (�Ϲ����ι�)
       SELECT A.BUY_DATE AS ����,     --ǥ��� n.nnnn�� ����� �����ؾ��ϴ� ����Ʈ���� �������� �����ϴ�.
              B.PROD_ID AS ��ǰ��ȣ,
              B.PROD_NAME AS ��ǰ��,
              A.BUY_QTY AS ����,
              A.BUY_QTY * B.PROD_COST AS �ݾ� 
         FROM BUYPROD A, PROD B
        WHERE A.BUY_PROD=B.PROD_ID --��������
          AND A.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630') --�Ϲ�����
        ORDER BY 1;
       
       
       (ANSI���ι�)
       SELECT A.BUY_DATE AS ����,  
              B.PROD_ID AS ��ǰ��ȣ,
              B.PROD_NAME AS ��ǰ��,
              A.BUY_QTY AS ����,
              A.BUY_QTY * B.PROD_COST AS �ݾ� 
         FROM BUYPROD A
         INNER JOIN PROD B ON(A.BUY_PROD=B.PROD_ID)
          WHERE A.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')
   --������ ��ſ� �ؿ� ó�� ���� �� �ִ� . ����� ����.
   --INNER JOIN PROD B ON(A.BUY_PROD=B.PROD_ID AND (A.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')))
     ORDER BY 1;
     
     
       
��뿹) ��ǰ���̺��� 'P10202' �ŷ�ó���� ��ǰ�ϴ� ��ǰ������ ��ȸ�Ͻÿ�.
       Alias�� ��ǰ�ڵ�,��ǰ��,�ŷ�ó��,���Դܰ�
       
       
       (�Ϲ����ι�)
        SELECT A.PROD_ID AS ��ǰ�ڵ�,
               A.PROD_NAME AS ��ǰ��,
               B.BUYER_NAME AS �ŷ�ó��,
               A.PROD_COST AS ���Դܰ�
          FROM PROD A, BUYER B
         WHERE A.PROD_BUYER=B.BUYER_ID --��������
           AND B.BUYER_ID LIKE 'P10202';
         --WHERE SUBSTR(B.BUYER_ID,1,6) ='P10202%';
       
       (ANSI���ι����� ����)
        SELECT A.PROD_ID AS ��ǰ�ڵ�,
               A.PROD_NAME AS ��ǰ��,
               B.BUYER_NAME AS �ŷ�ó��,
               A.PROD_COST AS ���Դܰ�
          FROM PROD A
    INNER JOIN BUYER B ON(A.PROD_BUYER=B.BUYER_ID) 
         WHERE B.BUYER_ID LIKE 'P10202';  --WHERE���� �ݵ�� INNDER JOIN�� ������ ����Ѵ�.
         
         
       
��뿹) ��ǰ���̺��� ���� ������ ��ȸ�Ͻÿ�
       Alias�� ��ǰ�ڵ�,��ǰ��,�з���,�ǸŴܰ�
       
       (�Ϲ����ι�)
       SELECT A.PROD_ID AS ��ǰ�ڵ�,
              A.PROD_NAME AS ��ǰ��,
              B.LPROD_NM AS �з���,
              A.PROD_PRICE AS �ǸŴܰ�
         FROM PROD A, LPROD B
        WHERE A.PROD_LGU=B.LPROD_GU;
        
        (ANSI���ι�)
         SELECT A.PROD_ID AS ��ǰ�ڵ�,
              A.PROD_NAME AS ��ǰ��,
              B.LPROD_NM AS �з���,
              A.PROD_PRICE AS �ǸŴܰ�
         FROM PROD A
   INNER JOIN LPROD B ON(A.PROD_LGU=B.LPROD_GU);
        
    
       
��뿹) ������̺��� �����ȣ,�����,�μ���,�μ��� å���ڸ�,�Ի����� ����Ͻÿ�.
  
  (�Ϲ����ι�)
  SELECT A.EMPLOYEE_ID AS �����ȣ,
         A.EMP_NAME AS �����,
         B.DEPARTMENT_NAME AS �μ���,
         A.HIRE_DATE AS �Ի���
    FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
   WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID --�μ��ڵ尡 null���� ������� ����ϰ� ������ outer join�� ����Ѵ�.
   
   
   (ANSI���ι�) 
    SELECT A.EMPLOYEE_ID AS �����ȣ,
           A.EMP_NAME AS �����,
           B.DEPARTMENT_NAME AS �μ���,
           A.HIRE_DATE AS �Ի���
      FROM HR.EMPLOYEES A
INNER JOIN HR.DEPARTMENTS B ON(A.DEPARTMENT_ID=B.DEPARTMENT_ID);
   
    
    
��뿹) 2020�� 4�� ȸ����, ��ǰ�� �������踦 ��ȸ�Ͻÿ�
       Alias�� ȸ����ȣ,ȸ����,��ǰ��,���ż����հ�,���űݾ��հ�
      
      (�Ϲ����ι�)
      SELECT A.CART_MEMBER AS ȸ����ȣ,
             B.MEM_NAME AS ȸ����,
             C.PROD_NAME AS ��ǰ��,
             SUM(A.CART_QTY) AS ���ż����հ�,
             SUM(A.CART_QTY*C.PROD_PRICE) AS ���űݾ��հ�
        FROM CART A, MEMBER B, PROD C
       WHERE A.CART_MEMBER=B.MEM_ID -- ȸ���� �������� ���� ��������
         AND A.CART_PROD=C.PROD_ID --��ǰ��,��ǰ�ܰ��� ���ϱ� ���� ��������
         AND A.CART_NO LIKE '202004%'
    GROUP BY A.CART_MEMBER, B.MEM_NAME, C.PROD_NAME --GROUP BY������ SELECT���� �� ������ ������Ѵ�
    ORDER BY 1;
    
    
         (ANSI���ι�)
      SELECT A.CART_MEMBER AS ȸ����ȣ,
             B.MEM_NAME AS ȸ����,
             C.PROD_NAME AS ��ǰ��,
             SUM(A.CART_QTY) AS ���ż����հ�,
             SUM(A.CART_QTY*C.PROD_PRICE) AS ���űݾ��հ�
        FROM CART A 
  INNER JOIN MEMBER B ON(A.CART_MEMBER=B.MEM_ID)
--       INNER JOIN PROD C ON(A.CART_PROD=C.PROD_ID AND A.CART_NO LIKE '202004%') --�Ϲ������� ���� ������ �Ʒ��� �������� �� �Ǵ��ؾ��Ѵ�.
  INNER JOIN PROD C ON(A.CART_PROD=C.PROD_ID)
       WHERE A.CART_NO LIKE '202004%' --�������ο����� �Ϲ������� ���� �������� ���� ������ �߻����� ������ �ܺ������� ������ ������ �߻��ȴ�
    GROUP BY A.CART_MEMBER, B.MEM_NAME, C.PROD_NAME
    ORDER BY 1;
        
        
��뿹) 2020�� 5�� �ŷ�ó�� �������踦 ��ȸ�Ͻÿ�
      Alias�� �ŷ�ó�ڵ�, �ŷ�ó��, ����ݾ��հ�

--(I.E ǥ����) 
--�ĺ��ڰ��� : �θ��� �⺻Ű�� �ڽ��� �⺻Ű�� �Ǵ� ���, �θ� ������ �ڽĵ� �ʿ����, �������� ǥ�õȴ�.
--��ĺ����� : �θ��� �⺻Ű�� �ڽ��� �Ϲ��÷��� �Ǿ�����, �������� ǥ��

--��Ŀ��ǥ�����


      (�Ϲ����ι�)    
       SELECT A.BUYER_ID AS �ŷ�ó�ڵ�, 
              A.BUYER_NAME AS �ŷ�ó��, 
              SUM(B.PROD_PRICE*C.CART_QTY) AS ����ݾ��հ�
         FROM BUYER A, PROD B, CART C
        WHERE C.CART_NO LIKE '202005%' --�Ϲ�����
          AND B.PROD_ID=C.CART_PROD --��������
          AND A.BUYER_ID=B.PROD_BUYER --��������
     GROUP BY A.BUYER_ID, A.BUYER_NAME
     ORDER BY 1;

       (ANSI���ι�)
        SELECT A.BUYER_ID AS �ŷ�ó�ڵ�, 
               A.BUYER_NAME AS �ŷ�ó��, 
               SUM(B.PROD_PRICE*C.CART_QTY) AS ����ݾ��հ�
          FROM BUYER A
    INNER JOIN PROD B ON(A.BUYER_ID=B.PROD_BUYER)
    INNER JOIN CART C ON(B.PROD_ID=C.CART_PROD AND C.CART_NO LIKE '202005%')
      GROUP BY  A.BUYER_ID, A.BUYER_NAME
      ORDER BY 1;
    
    
��뿹) HR�������� �̱��̿��� ������ ��ġ�� �μ��� �ٹ��ϴ� ���������� ��ȸ�Ͻÿ�
       Alias�� �μ���ȣ, �μ���, �ּ�, ������

      (�Ϲ����ι�) 
       SELECT A.DEPARTMENT_ID AS �μ���ȣ, 
              A.DEPARTMENT_NAME AS �μ���, 
              B.STREET_ADDRESS||', '||B.CITY||', '||STATE_PROVINCE AS �ּ�, 
              C.COUNTRY_NAME AS ������
         FROM HR.DEPARTMENTS A, HR.LOCATIONS B, HR.COUNTRIES C
        WHERE A.LOCATION_ID=B.LOCATION_ID
          AND B.COUNTRY_ID=C.COUNTRY_ID
          AND B.COUNTRY_ID != 'US'
     ORDER BY 1;
         
    (ANSI���ι�)      
     SELECT A.DEPARTMENT_ID AS �μ���ȣ, 
              A.DEPARTMENT_NAME AS �μ���, 
              B.COUNTRY_ID||' '||B.CITY||' '||B.STREET_ADDRESS AS �ּ�, 
              C.COUNTRY_NAME AS ������
         FROM HR.DEPARTMENTS A
   INNER JOIN HR.LOCATIONS B ON(A.LOCATION_ID=B.LOCATION_ID)
   INNER JOIN HR.COUNTRIES C ON(B.COUNTRY_ID=C.COUNTRY_ID)
          AND B.COUNTRY_ID != 'US';
       
    
    
   
   
   
   
   
   
   