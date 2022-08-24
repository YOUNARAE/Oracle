2022-0824-01) �����Լ�
�����ռ��� �ߺ��ؼ� ����� �� ����. �Ϲ��Լ��� �����Լ��� �� �� �ְ�
���� �ȿ� �Ϲ��Լ��� ������ ���� ����� ���� �ִ�.


��뿹) ��ٱ������̺��� 2020�� 5�� ��ǰ�� �Ǹ����踦 ��ȸ�Ͻÿ�.
       Alias�� ��ǰ�ڵ�, �ǸŰǼ�, �Ǹż���, �ݾ�
       --�������� ������ ���� �� �μ����� ������ �ű⼭ �� ���� ���� �� �μ����� ������� �ȴ�.
      
       SELECT A.CART_PROD AS ��ǰ�ڵ�, 
              COUNT(*) AS �ǸŰǼ�, 
              SUM(A.CART_QTY) AS �Ǹż���, 
              SUM(A.CART_QTY*PROD_PRICE) AS �ݾ�
         FROM CART A, PROD B
        WHERE A.CART_NO LIKE '202005%' 
          AND A.CART_PROD=B.PROD_ID
     GROUP BY A.CART_PROD
     ORDER BY 1;
       
��뿹) ��ٱ������̺��� 2020�� 5�� ȸ���� �Ǹ����踦 ��ȸ�Ͻÿ�.
       Alias�� ȸ����ȣ, ���ż���, ���űݾ�
       
     SELECT A.CART_MEMBER AS ȸ����ȣ, 
            SUM(A.CART_QTY) AS ���ż���, 
            SUM(CART_QTY*PROD_PRICE) AS ���űݾ�
       FROM CART A, PROD B
      WHERE A.CART_NO LIKE '202005%'
        AND A.CART_PROD = B.PROD_ID
   GROUP BY A.CART_MEMBER
   ORDER BY 1;


��뿹) ��ٱ������̺��� 2020�� ����, ȸ���� �Ǹ����踦 ��ȸ�Ͻÿ�.
       Alias�� ��, ȸ����ȣ, ���ż���, ���űݾ�
       
     SELECT A.CART_MEMBER AS ȸ����ȣ, 
            SUM(A.CART_QTY) AS ���ż���, 
            SUM(CART_QTY*PROD_PRICE) AS ���űݾ�,
            SUBSTR(CART_NO,5,2) AS �� --���� ������
       FROM CART A, PROD B
      WHERE A.CART_NO LIKE '2020%' --SUBSTR(A.CART_NO,1,4)='2020'
        AND A.CART_PROD = B.PROD_ID --���� ����
   GROUP BY SUBSTR(CART_NO,5,2), A.CART_MEMBER
   ORDER BY 1;--SELECT���� �����Լ��� �ƴ� ���� ������ GROUPT BY���� �ٿ��ֱ����ش�.

       
��뿹) ��ٱ������̺��� 2020�� 5�� ��ǰ�� �Ǹ����踦 ��ȸ�ϵ� 
      �Ǹűݾ��� 100���� �̻��� �ڷḸ ��ȸ�Ͻÿ�.
       Alias�� ��ǰ�ڵ�, �Ǹż���, �ݾ�
       
     SELECT CART_PROD AS ��ǰ�ڵ�, 
            SUM(A.CART_QTY) AS �Ǹż���, 
            SUM(A.CART_QTY*PROD_PRICE) AS �Ǹűݾ�
       FROM CART A, PROD B     
      WHERE A.CART_NO LIKE '202005%'
      AND A.CART_PROD=B.PROD_ID
   GROUP BY A.CART_PROD
     HAVING SUM(A.CART_QTY*B.PROD_PRICE)>=1000000 --�׷��Լ� ��ü�� ������ �־��� ��
   ORDER BY 1;
       
       
��뿹) 2020�� ��ݱ�(1-6��) ���� ���� ���� ���Ե� ��ǰ 1���� ��ȸ�Ͻÿ�
      Alias�� ��ǰ�ڵ�BUY_PROD, ���Լ���BUY_QTY, ���Աݾ�BUY_COST
      
     (1) 2020�� ��ݱ�(1-6��) ��ǰ���Ծ�(BUYPROD�� �ִ� �ɷ� �Ἥ ���̺� 1���� �־ ��)
  
     SELECT BUY_PROD AS ��ǰ�ڵ�,
            SUM(BUY_QTY) AS ���Լ����հ�,
            SUM(BUY_COST*BUY_QTY) ���Ծ�
       FROM BUYPROD
      WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630')
   GROUP BY BUY_PROD
   ORDER BY 3 DESC;
-- Pseudo (����Ŭ���� �������ִ� �ѹ��� �÷� �÷��� : ROWNUM)


����] ������̺��� �μ��� ��ձ޿��� ��ȸ�Ͻÿ�.

    SELECT DEPARTMENT_ID AS �μ�,
           ROUND(AVG(SALARY)) AS ��ձ޿�
      FROM HR.EMPLOYEES
  GROUP BY DEPARTMENT_ID
  ORDER BY 1;
     

����] ������̺��� �μ��� ���� ���� �Ի��� ����� �����ȣ,
�����,�μ���ȣ,�Ի����� ����Ͻÿ�.

  SELECT B.EMPLOYEE_ID AS �����ȣ,
         B.EMP_NAME AS �����,
         A.DEPARTMENT_ID AS �μ���ȣ,
         A.HDATE AS �Ի���
    FROM (SELECT DEPARTMENT_ID,
    
    HR.EMPLOYEES
  ORDER BY 4 ASC;



 SELECT --EMPLOYEE_ID AS �����ȣ,
       -- EMP_NAME AS �����,
         DEPARTMENT_ID AS �μ���ȣ,
         MIN(HIRE_DATE) AS �Ի���
    FROM HR.EMPLOYEES
GROUP BY EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID;


����] ������� ��ձ޿����� �� ���� �޴� ����� �����ȣ, �����, 
�μ���ȣ, �޿��� ���
  SELECT A.EMPLOYEE_ID AS �����ȣ, 
         A.EMP_NAME AS �����, 
         A.DEPARTMENT_ID AS �μ���ȣ, 
         A.SALARY AS �޿�
    FROM HR.EMPLOYEES A 
    WHERE A.SALARY > (SELECT AVG(SALARY)
                        FROM HR.EMPLOYEES) --�񱳴�� �񱳰����� ����Ѵ�
    ORDER BY 4 DESC;


    
����] ȸ�����̺��� ����ȸ���� ���ϸ��� �հ�� ��� ���ϸ����� ��ȸ�Ͻÿ�
     Alias�� ����,���ϸ����հ�,��ո��ϸ���
     
     1) ����ȸ������ ����ȸ������ ���� �˾ƾ��Ѵ�(�׷��� ����)
     
     SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN 
                      '����ȸ��' 
                 ELSE  
                      '����ȸ��'
            END AS ����,
            COUNT(*) AS ȸ����,
            SUM(MEM_MILEAGE) AS ���ϸ����հ�,
            ROUND(AVG(MEM_MILEAGE)) AS ��ո��ϸ���
       FROM MEMBER
   GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN 
                      '����ȸ��' 
                ELSE  
                      '����ȸ��'
                END;
     
     
     
      
      
      