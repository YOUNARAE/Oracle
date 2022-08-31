2022-0809-01)������
1. ����(��)������
   - �ڷ��� ��Ұ��踦 ���ϴ� �����ڷ� ����� ��(true)�� ����(false)�� ��ȯ
   - >, <, >=, <=, =, != (<>)
   - ǥ����(CASE WHEN ~ THEN, DECODE)�̳� WHERE �������� ���

��뿹)ȸ�����̺�(MEMBER)���� ��� ȸ������ ȸ����ȣ, ȸ����, ������ ��ȸ�Ͻÿ�
        ���ϸ����� ��ȸ�Ͻÿ�
    SELECT MEM_ID AS ȸ����ȣ,
           MEM_NAME AS ȸ����,
           MEM_JOB AS ����,
           MEM_MILEAGE AS ���ϸ���
      FROM MEMBER
      --ORDER BY MEM_MILEAGE DESC;
      ORDER BY 4 DESC;
      
--,(�޸�)�� ������ ������ ���� ����ؼ� FROM���� �� ã�Ҵ��ϴ� �����޼����� ���.

��뿹) ������̺�(HR.EMPLOYEES) �μ���ȣ�� 50���� ������� ��ȸ�Ͻÿ�.
       Alias�� �����ȣ,�����,�μ���ȣ,�޿��̴�.--��Ī�� ����Ʈ������ ���;��Ѵ�--
       
       SELECT EMPLOYEE_ID AS �����ȣ,
              EMP_NAME AS �����,
              DEPARTMENT_ID AS �μ���ȣ,
              SALARY AS �޿�
         FROM HR.EMPLOYEES 
        WHERE DEPARTMENT_ID=50;
    
    
��뿹)ȸ�����̺�(MEMBER)���� ������ �ֺ��� ȸ������ ��ȸ�Ͻÿ�.
      Alias�� ȸ����ȣ,ȸ����,����,���ϸ����̴�.
      
      SELECT MEM_ID AS ȸ����ȣ,
             MEM_NAME AS ȸ����,
             MEM_JOB AS ����,
             MEM_MILEAGE AS ���ϸ���
        FROM MEMBER
       WHERE MEM_JOB = '�ֺ�'; 
        

2. ���������
  - '+','-','*','/' => 4Ģ ������
  - ( ) : ������ �켱���� ����
  -- ����Ŭ������ ����������, �����������ڰ� ���� ���� �Լ��� ����.
  -- �� �࿡ �����ڸ� �������� ��� �켱������ �������� ��
  -- Infix(���ڰ����)->a-b / prefix->-ab �����ڰ� ������ ������ �� / postfix->ab+

��� ��) ������̺�(HR.EMPLOYEES)���� ���ʽ��� ����ϰ� ���޾��� �����Ͽ� ����Ͻÿ�.
        ���ʽ� = ���� * ���������� 30%
        ���޾� = ���� + ���ʽ�
        
        Alias�� �����ȣ,�����,����,��������,���ʽ�,���޾�
        ��� ���� �����κи� ���
        
    SELECT EMPLOYEE_ID AS �����ȣ,
           EMP_NAME AS �����,--FIRST_NAME|| ' '||LAST_NAME AS �����
           SALARY AS ����,
           COMMISSION_PCT AS ��������,
           NVL(ROUND(COMMISSION_PCT*SALARY*0.3),0) AS ���ʽ�,
           SALARY + NVL(ROUND(COMMISSION_PCT*SALARY*0.3),0) AS ���޾�
      FROM HR.EMPLOYEES
    
      
3. ��������
  - �� �� �̻��� ������� ����(AND, OR)�ϰų� ����(NOT)��� ��ȯ
  - NOT, AND, OR

  --------------------------
     �Է�           ���
    A    B       OR    AND
  --------------------------
    0    0       0      0
    0    1       1      0
    1    0       1      0
    1    1       1      1

��뿹)��ǰ���̺�(PROD)���� �ǸŰ����� 30���� �̻��̰� ������� 5�� �̻��� ��ǰ�� 
      ��ǰ��ȣ, ��ǰ��, ���԰�, �ǸŰ�, ������� ��ȸ�Ͻÿ�.
       
    SELECT PROD_ID AS ��ǰ��ȣ, 
           PROD_NAME AS ��ǰ��, 
           PROD_COST AS ���԰�, 
           PROD_PRICE AS �ǸŰ�,
           PROD_PROPERSTOCK AS �������
      FROM PROD
     WHERE PROD_PRICE >= 300000 
       AND PROD_PROPERSTOCK >= 5
     ORDER BY 4;
 
 
��뿹)�������̺�(BUYPROD)���� �������� 2020�� 1���̰� ���Լ����� 10�� �̻��� 
      ���������� ��ȸ�Ͻÿ�
      Alias�� ������, ���Ի�ǰ, ���Լ���, ���Աݾ�
      
      SELECT BUY_DATE AS ������, 
             BUY_PROD AS ���Ի�ǰ, 
             BUY_QTY AS ���Լ���, 
             BUY_QTY * BUY_COST AS ���Աݾ�
        FROM BUYPROD
       WHERE BUY_DATE >= TO_DATE('20200101') AND BUY_DATE<=TO_DATE('20200131')
         AND BUY_QTY >= 10
    ORDER BY 1;
        
        
��뿹)ȸ�����̺��� ���ɴ밡 20���̰ų� ���� ȸ���̰ų� ȸ���� ��ȸ�Ͻÿ�
      Alias�� ȸ����ȣ,ȸ����,�ֹι�ȣ,���ϸ���,
      
    SELECT MEM_ID AS ȸ����ȣ,
           MEM_NAME AS ȸ����,
           MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹι�ȣ,
           TRUNC(EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR),-1) AS ���ɴ�,
           MEM_MILEAGE AS ���ϸ���
      FROM MEMBER
     WHERE TRUNC(EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR),-1)=20
     -- 2022�� ���� �ð��� �����ϰ� - ������Ͽ��� �⵵�� �����Ѵ�
     -- ���� ���ؼ� 1�� �ڸ��� 0���� ������ִ� ��.
     OR (SUBSTR(MEM_REGNO2,1,1)='2' AND SUBSTR(MEM_REGNO2,1,1)='4');
     -- OR SUBSTR(MEM_REGNO2,1,1) IN('2','4'))
     
     
     (������)
     ȸ�����̺��� ���ɴ밡 30�� ����ȸ���̰� ���ϸ����� 1000�� �̻��� ȸ���� ��ȸ�Ͻÿ�
      Alias�� ȸ����ȣ,ȸ����,�ֹι�ȣ,���ϸ���,
    SELECT MEM_ID AS ȸ����ȣ,
           MEM_NAME AS ȸ����,
           MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹι�ȣ,
           TRUNC(EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR),-1) AS ���ɴ�,
           MEM_MILEAGE AS ���ϸ���
      FROM MEMBER
     WHERE TRUNC(EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR),-1)=30
       AND SUBSTR(MEM_REGNO2,1,1)='1' OR SUBSTR(MEM_REGNO2,1,1)='3'
       AND MEM_MILEAGE >=1000;
     
     
       
        
��뿹)ȸ�����̺��� ���ɴ밡 20���̰ų� ���� ȸ���̸鼭 ���ϸ����� 2000�̻��� ȸ���� ��ȸ�Ͻÿ�
      Alias�� ȸ����ȣ,ȸ����,�ֹι�ȣ,���ϸ���,
      
    SELECT MEM_ID AS ȸ����ȣ,
           MEM_NAME AS ȸ����,
           MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹι�ȣ,
           TRUNC(EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR),-1) AS ���ɴ�,
           MEM_MILEAGE AS ���ϸ���
      FROM MEMBER
     WHERE (TRUNC(EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR),-1)=20
     OR (SUBSTR(MEM_REGNO2,1,1)='2' OR SUBSTR(MEM_REGNO2,1,1)='4'))
     AND MEM_MILEAGE >= 2000;

     
��뿹) Ű����� �⵵�� �Է¹޾� ����� ����� �Ǵ��Ͻÿ�.
        *���� : 4�ǹ���̸鼭 100�� ����� �ƴϰų� �Ǵ� 400�� ����� �Ǵ� �⵵
    
    ACCEPT P_YEAR   PROMPT '�⵵�Է� : '
    DECLARE
        V_YEAR NUMBER:=TO_NUMBER('&P_YEAR');
        V_RES VARCHAR2(100);
    BEGIN
        IF (MOD(V_YEAR,4)=0 AND MOD(V_YEAR,100)!=0) OR (MOD(V_YEAR,400)=0) THEN
           V_RES:=TO_CHAR(V_YEAR)||'�⵵�� �����Դϴ�.';
        ELSE
           V_RES:=TO_CHAR(V_YEAR)||'�⵵�� ����Դϴ�.';
        END IF;
        DBMS_OUTPUT.PUT_LINE(V_RES);
        --system.out.println�ϰ� ���� ��� 
    END;
