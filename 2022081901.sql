2022-0819-01)
3. ��¥�Լ�
  1) SYSDATE - ****
   - �ý����� �����ϴ� ���� �� �ð� ���� ����
   - ������ ����, ROUND, TRUNC �Լ��� ���� ����� �� --����ϸ� ���ϰ� ������ TRUNC �ú���(�Ҽ��������ν�)�� ��������,
   - �⺻ ��� Ÿ���� '��/��/��'�̰� '�ú���'�� ����ϱ� ���ؼ��� TO_CHAR �Լ� ���--*��¥���� LIKE,SUBSTR���� �Լ��� ���� �ȵȴ�
   
  2) ADD_MONTHS(d, n) - **
   - �־��� ��¥ d�� n ��ŭ�� ���� ���� ��¥ ��ȯ--(��ȯŸ��:��¥)
   - �Ⱓ�� ������ ��¥�� �ʿ��� ��� ���� ���
   
��뿹)���� ��� ��ü�� 2���� ����ȸ������ ����� ��� ���� ������ڸ� 
      ��ȸ�Ͻÿ�. 
      
      SELECT ADD_MONTHS(SYSDATE,2)-1 FROM DUAL;
      
3) NEXT_MONTHS(d, c) - *
  - �־��� ��¥ d ���� c���Ͽ� �ش��ϴ� ��¥ ��ȯ
  - c�� '��','������','ȭ',...'�Ͽ���' ���

��뿹) 
   SELECT NEXT_DAY(SYSDATE,'��'),
          NEXT_DAY(SYSDATE,'�����')--���� ������ ó�� ������ �����
     --   NEXT_DAY(SYSDATE,'FRIDAY')
     FROM DUAL;
     
     
4) LAST_DAY(d) - ***
  - �־��� ��¥ �������� ���� ���������� ��ȯ
  - �ַ� 2���� ���������� ��ȯ �޴� ���� ���� --�������� ������� ����������ϱ� ���ؼ� �ݵ�� �ʿ���. �޸��� ���������� �ٸ��� ������.
  

��뿹)�������̺��� 2020�� 2�� ��ǰ�� �������踦 ���Ͻÿ�.
      Alias ��ǰ�ڵ�, ��ǰ��, ���Է��հ�, ���Աݾ��հ� --�����Լ��� �ʿ���.
      
  SELECT A.BUY_PROD AS ��ǰ�ڵ�,  
         B.PROD_NAME AS ��ǰ��, 
         COUNT(*) AS ����Ƚ��,
         SUM(A.BUY_QTY) AS ���Է��հ�, 
         SUM(A.BUY_QTY*B.PROD_COST) AS ���Աݾ��հ�
    FROM BUYPROD A, PROD B 
   WHERE A.BUY_PROD=B.PROD_ID 
     AND A.BUY_DATE BETWEEN TO_DATE('20200201') AND LAST_DAY(TO_DATE('20200201'))
GROUP BY A.BUY_PROD, B.PROD_NAME
  ORDER BY 1;
  
  
  
5) EXTRACT(fmt FROM d) - **** --�����ϴ� data��
  - �־��� ��¥ ������ d���� 'fmt'�� ������ ��� ���� ��ȯ
  - 'fmt'�� YEAR,MONTH,DAY,HOUR,MINUTE,SECOND �� �ϳ�
  --ex)�̹����� �����λ�� -> ���� �ʿ��ϴ�, ���̸� �˾Ƴ� �� ->�⸸ �ʿ��ϴ�
  - ��ȯ������ Ÿ���� ������ 
  
  
**������̺��� �ڷ� �� �Ի����� 10���� ����� ���ڷ� �����Ͻÿ�
  UPDATE HR.EMPLOYEES
     SET HIRE_DATE=ADD_MONTHS(HIRE_DATE,120);
     
     
  COMMIT;
  
  
  
  
��뿹)������̺��� 50���μ� ���� �� �ټӳ���� 17�� �̻��� ������ ��ȸ�Ͻÿ�
      Alias�� �����ȣ,�����,��å,�Ի���,�ټӳ���̸� �ټӳ���� ���� ������� ���
      
      SELECT EMPLOYEE_ID AS �����ȣ,
             EMP_NAME AS �����,
             JOB_ID AS ��å,
             HIRE_DATE AS �Ի���, --����Ϸ� ������ ��¥ Ÿ��
             EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM HIRE_DATE) AS �ټӳ�� --�־��� �ڷῡ�� ������ ��ȯ�޾ƾ��Ѵ�. ���ݳ⵵(YEAR FROM SYSDATE)
        FROM HR.EMPLOYEES
       WHERE DEPARTMENT_ID = 50
         AND EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM HIRE_DATE)>=7
    ORDER BY 4;
    
    
        
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
     
     
     
  
      
      
   