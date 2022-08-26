2022-0826-03) ���� �Լ�
- Ư�� �÷��� ���� �������� ����(���)�� �ο��� �� ���
- RANK(), DENSE_RANK(), ROW_NUMBER() ���� ������
1)  RANK()
- �Ϲ����� �����Լ�
- ���� ���̸� ���� ������ �ο��ϰ� ���� ������ ���� ���� + ���� ���� �������� �ο�
Ex) 1, 1, 3, 4, 5, 6, 7, 7, 7, 10��
(�������)
RANK() OVER(ORDER BY �÷���1 [DESC|ASC][,�÷���2 [DESC|ASC],��])
- SELECT  ���� SELECT ���� ���

��뿹)
    ȸ�����̺��� ȸ����ȣ, ȸ����, ���ϸ���, ������ ��ȸ�Ͻÿ�.
    ������ ���ϸ����� ���� ȸ������ �ο��ϰ� ���� ���ϸ����̸� ���� ������ �ο��Ͻÿ�.
    SELECT MEM_ID AS ȸ����ȣ,
           MEM_NAME AS ȸ����,
           MEM_MILEAGE AS ���ϸ���,
           EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR) AS ����,
--         RANK() OVER(ORDER BY MEM_MILEAGE DESC) AS ����
           RANK() OVER(ORDER BY MEM_MILEAGE, 
           (EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR)) DESC) AS ����       
      FROM MEMBER;
    
    


2) DENSE_RANK()
  . ������ ���ϴ� ����� RANK()�� ����
  . ���� ������ ������ �߻��ϴ��� ���� ������ ������� �ٷ� ���� ������ �ο�
    ex) 1,1,2,3,4,5,6,7,7,7,8,9,...

   (�������)
   DENSE_RANK() OVER(ORDER BY �÷���1 [DESC|ASC][,�÷���2 [DESC|ASC],...])
   - SELECT ���� SELECT���� ���
   
       ȸ�����̺��� ȸ����ȣ, ȸ����, ���ϸ���, ������ ��ȸ�Ͻÿ�.
    ������ ���ϸ����� ���� ȸ������ �ο��ϰ� ���� ���ϸ����̸� ���� ������ �ο��Ͻÿ�.
    SELECT MEM_ID  AS ȸ����ȣ,
           MEM_NAME AS ȸ����,
           MEM_MILEAGE AS ���ϸ���,
           EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR) AS ����,
           DENSE_RANK() OVER(ORDER BY MEM_MILEAGE DESC) AS ���� 
      --DENSE_RANK�� �Ȱ��� ������ �ο��ϴµ�, 1������ �Ȱ����� �������� �ٸ��� �ο��Ѵ�.
      -- ������ ��ŭ �ǳʶ��� �ʰ� �ٷ� ������ �� DENSE_RANK�̰� RANK�� ������ ����ŭ ���ڰ� �ǳʶپ�����
      -- RANK() OVER(ORDER BY MEM_MILEAGE DESC, MEM_ID) AS. ����,
      -- RANK() OVER(ORDER BY MEM_MILEAGFE DESC, 
      --(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR) DESC) AS ����
    FROM MEMBER;
    
    3) ROW_MEMBER()
    . ������ �ο��ϴ� �Լ�
    . �����ڵ� ���� ������ ���� ������ ����
    ex) 90,90,85,84,80,78,78,78,75
    ����  1  2  3  4  5  6  7  8  9
   
  (�������)
   ROW_NUMBER() OVER(ORDER BY �÷���1 [DESC|ASC][,�÷���2 [DESC|ASC],...])
    - SELECT ���� SELECT���� ���
    
   SELECT MEM_ID  AS ȸ����ȣ,
          MEM_NAME AS ȸ����,
          MEM_MILEAGE AS ���ϸ���,
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR) AS ����,
          ROW_NUMBER() OVER(ORDER BY MEM_MILEAGE DESC) AS ���� 
      -- ������� ��������ȣ���� �޿� �ٿ������� ���� ROW_NUMBER�̴�. 
      -- RANK() OVER(ORDER BY MEM_MILEAGE DESC, MEM_ID) AS. ����,
      -- RANK() OVER(ORDER BY MEM_MILEAGFE DESC, 
      --(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR) DESC) AS ����
    FROM MEMBER;
    
    
    4)�׷캰 ����
     . �ڷḦ �׷����� �з��ϰ� �� �׷쳻���� Ư�� �÷��� ���� �������� ������ ����
     . PARTITION BY ������ �׷��� ������

    (�������)
     RANK() OVER(PARTITION BY �÷���p1[,�÷���p2,...] ORDER BY �÷���b1 [DESC|ASC] [,
                 �÷���b2 [DESC|ASC],...]) 
     - SELECT���� SELECT���� ��� 
     
  ��뿹)������̺��� �μ����� �޿��� ���� ������ �ο��Ͻÿ�
        Alias�� �����ȣ, �����, �μ���ȣ, �޿�, �����̸� ������ �޿��� ���� ��������� 
        �ο��Ͻÿ�. ���� �޿��� ���� ���� �ο��� �� 
        
        SELECT EMPLOYEE_ID AS �����ȣ,
               EMP_NAME AS �����, 
               DEPARTMENT_ID AS �μ���ȣ,
               SALARY AS �޿�, 
               RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS ���� --(PARTITION BY�� GROUP BY�� ����)
          FROM HR.EMPLOYEES;
        
    
    
    
   
   
   
   
   