2022-0818-02)
2. �����Լ�
  - �����Ǵ� �����Լ��δ� ������ �Լ�(ABS, SIGN, SQRT ��), GREATEST, ROUND, MOD,
   FLOOP; WIDTH_BUCKET ���� ����
   
1)������ �Լ�
  (1)ABS(n), SIGN(n), POWER(e, n), PQRT(N) - *
  - ABS : n�� ���밪 ��ȯ
  - SIGN : n�� ����̸� i, ���̸� -1, 0�̸� 0�� ��ȯ
  - POWER : e�� n�� ��(e�� n�� ���� ��)
  - SQRT  :n�� ����
  

��뿹) 
    SELECT ABS(10), ABS(-100), ABS(0), --ABS�� ��ȣ�� �ǹ̾���
           SIGN(-20000), SIGN(-0.0099), SIGN(0.00005), SIGN(500000), SIGN(500000), SIGN(0), 
           POWER(2,10),
           SQRT(3.3)
      FROM DUAL;
      
      


2)GREATEST(n1,n2[,...n]), LEAST(n1,n2[,...n])
  - �־��� �� n1 ~ n ������ �� �� ���� ū ��(GREATEST), �������� ��(LEAST) ��ȯ
  --�ּҰ��� �ִ밪�� �������ش�
  
  ��뿹)
    SELECT GREATEST('KOREA', 1000, 'ȫ�浿'),
           LEAST('ABC','ABD',200)
      FROM DUAL;
    
    
    SELECT ASCII('ȫ') FROM DUAL;  --ù ���ڸ� �ƽ�Ű�ڵ�� �ٲ۴�.ABC- 656668
    
    MAX�� GREATEST�� ������
    MAX�� �ϳ��� �÷��� ����ִ� �� �߿� ���� ū ���� ã�� ��(������ ���� ū ��)
    ������ ������ �� �߿� ���� ū ���� ã�� ���� GREATEST.
    
    
��뿹)ȸ�����̺��� ���ϸ����� 1000�̸��� ȸ���� ã�� 1000���� ���� ����Ͻÿ�
      Alias�� ȸ����ȣ,ȸ����,�������ϸ���,����ȸ��ϸ���
      
      SELECT MEM_ID AS ȸ����ȣ,
             MEM_NAME AS ȸ����,
             MEM_MILEAGE AS �������ϸ���,
             GREATEST(MEM_MILEAGE, 1000) AS ����ȸ��ϸ���
        FROM MEMBER;
        
        
3)ROUND(n [,l]), TRUNC(n [,l]) - ****
  - �־��� �ڷ� n���� �Ҽ��� ���� l+1�ڸ����� �ݿø��Ͽ� (ROUND) �Ǵ� �ڸ�����(TRUNC) �Ͽ�
  1�ڸ����� ǥ����
  - 1�� �����Ǹ� 0���� ���ֵ�
  - 1�� �����̸� �Ҽ��� �̻��� L�ڸ����� �ݿø� �Ǵ� �ڸ� ���� ����
  
��뿹)
  SELECT ROUND(12345.678945,3),
         ROUND(12345.678945),
         ROUND(12345.678945,-3)--���̳ʽ��� �Ǹ� �Ҽ��� ���ϴ� �׳� �� �߷�����
    FROM DUAL;
    
  SELECT TRUNC(12345.678945,3),--4��° �ڸ����� ������ ����
         TRUNC(12345.678945),--�Ҽ��� ���Ͽ��� �� ����
         TRUNC(12345.678945,-3)--�Ҽ��� �տ� 3���� �ڸ����� �׳� �� ����
    FROM DUAL;
    

��뿹)HR������ ������̺��� ������� �ټӿ����� ���Ͽ� �ټӿ����� ���� �ټ� ������ ����Ͻÿ�
      �ټӼ���=�⺻��(SALARY)*(�ټӳ��/100)
      �޿��հ�=�⺻��+�ټӼ���
      ����=�޿��հ��� 13%
      ���޾�=�޿��հ�-�����̸� �Ҽ� 2°�ڸ����� �ݿø��Ͻÿ�,
      Alias�� �����ȣ, �����, �Ի���, �ټӳ��, �޿�, �ټӼ���, ����, ���޾�
      
      
      --�Ի���, �ټӳ��, �޿�, �ټӼ���, ����, ���޾�
      --�ټӳ��--�ټӼ���-�޿��հ�-����-���޾�
      
     -- SELECT EMPLOYEE_ID AS �����ȣ,
     --        FIRST_NAME||LAST_NAME AS �����,
     --        HIRE_DATE AS �Ի���,
      --       TRUNC((SYSDATE-HIRE_DATE)/365) AS �ټӳ��,
      --       SALARY AS �޿�,
      --       SALARY*(TRUNC((SYSDATE-HIRE_DATE)/365))/100 AS �ټӼ���,
       --      SALARY+(SALARY*(TRUNC((SYSDATE-HIRE_DATE)/365))/100) AS ����

       -- FROM HR.EMPLOYEES;
       
      SELECT EMPLOYEE_ID AS �����ȣ,
             EMP_NAME AS �����,
             HIRE_DATE AS �Ի���,
             TRUNC((SYSDATE-HIRE_DATE)/365) AS �ټӳ��, --�ð��� ��¥�� ��ȯ�ϱ⶧���� �Ҽ������ϱ��� �����⶧���� TRUNC�� �߶������
             SALARY AS �޿�,
             ROUND(SALARY*(TRUNC((SYSDATE-HIRE_DATE)/365)/100),1) AS �ټӼ���,
             ROUND(SALARY+SALARY*(TRUNC((SYSDATE-HIRE_DATE)/365)/100),1) AS �޿��հ�,
             ROUND(((SALARY+SALARY*(TRUNC((SYSDATE-HIRE_DATE)/365)/100)*0.13)))*0.13 AS ����,             
             ROUND(SALARY+SALARY*(TRUNC((SYSDATE-HIRE_DATE)/365)/100)-(SALARY+SALARY*(TRUNC((SYSDATE-HIRE_DATE)/365)/100)*0.13),1) AS ���޾� 
             
        FROM HR.EMPLOYEES;
        
        
4) FLOOR(n), CEIL(n) - *
  - ���� ȭ�� ���õ� ������ ó���� ���
  - FLOOR : n�� ���ų�(n�� ������ ��) n���� ���� ���� �� ���� ū ���� --���� ����
  - CEIL : n�� ���ų�(n�� ������ ��) n���� ū ���� �� ���� ���� ���� --�ٶ���
  
��뿹)
    SELECT FLOOR(23.456), FLOOR(23), FLOOR(-23.456), -- -24�� -23���� �۾Ƽ� ���������� 
           CEIL(23.456), CEIL(23), CEIL(-23.456)-- FLOOR�� �ݴ�
      FROM DUAL;   
  

5) MOD(n,b), REMAINDER(n,b) - ***
  - �������� ��ȯ
  - MOD : �Ϲ��� ������ ��ȯ
  - REMAINDER : �������� ũ�Ⱑ b���� ���ݺ��� ������ �Ϲ��� �������� ��ȯ�ϰ�, 
                 b���� ���ݺ��� ũ�� ���� ���� �Ǳ����� ������ ���簪(n)�� ���� ��ȯ
  - MOD�� REMAINDER�� ���� ó���� �ٸ�
    
   . MOD (n,b) : n - b * FLOOR(n/b)
   . REMAINDER(n,b) : n - b * ROUND(n/b)
   
 ex) MOD(23,7), REMAINDER(23,7) --�������� ���� ��
     MOD(23,7) = 23 - 7 * FLOOR(23/7)
               = 23 - 7 * FLOOR(3.286)
               = 23 - 7 * 3
               = 2 
               
    REMAINDER(23,7) = 23 - 7 * ROUND(23/7)
                    = 23 - 7 * ROUND(3.286)
                    = 23 - 7 * 3;
                    = 2  --�������� 7�� ������ �ȵǼ�
                    
    MOD(26,7), REMAINDER(26,7)
         MOD(26,7) = 26 - 7 * FLOOR(26/7)
                   = 26 - 7 * FLOOR(3.714)
                   = 26 - 7 * 3;
                   = 5
         
    REMAINDER(26,7) = 26 - 7 * ROUND(26/7)
                    = 26 - 7 * ROUND(3.714)--�ݿø�
                    = 26 - 7 * 4;
                    = -2 
                    
                    


6) WIDTH_BUCKET(n, min, max, b)
  - �ּҰ� min���� �ִ밪 max ������ b���� ��������
    ���������� n�� ��� ������ ���ϴ����� �Ǵ��Ͽ� ������
    INDEX ���� ��ȯ
  - n < min �� ��� 0�� ��ȯ�ϰ� n >= �� ��� b+1 ���� ��ȯ
  
  --WIDTH_BUCKET(9,10,39,3) ���� ���� ���� �� 1���� + ���� ������ ���� �� 2���� = 5
  
  ��뿹)
    SELECT WIDTH_BUCKET(28,10,39,3),
           WIDTH_BUCKET(8,10,39,3),
           WIDTH_BUCKET(58,10,39,3),
           WIDTH_BUCKET(39,10,39,3),
           WIDTH_BUCKET(10,10,39,3)
    FROM DUAL;
    
  ��뿹) ȸ�����̺��� ȸ������ ���ϸ����� ��ȸ�Ͽ� 1000-9000 ���̸� 3���� �������� �����ϰ�,
         ȸ����ȣ, ȸ����, ���ϸ���, ��� ����ϵ� �����
         ���ϸ����� ���� ȸ������ '1��� ȸ��', '2��� ȸ��', '3��� ȸ��', '4��� ȸ��'�� ����Ͻÿ�.
         
   SELECT MEM_ID AS ȸ����ȣ, 
          MEM_NAME AS ȸ����, 
          MEM_MILEAGE AS ���ϸ���,
          4-WIDTH_BUCKET(MEM_MILEAGE,1000,9000,3)||'��� ȸ��' AS ���
--        WIDTH_BUCKET(MEM_MILEAGE,9000,999,3)||'��� ȸ��' AS ��� --�� �������� ���Ѱ��� ������ �ȵǱ� ������ 1000�� �ƴ� 999
     FROM MEMBER
    
     
  
                    
    

    
   
      
      
      
         
  
  
        
    
      
      
      
      
      
      
      

      