

**EMPLOYEES ���̺� ���ο� �÷�(EMP_NAME), ������Ÿ���� VARCHAR2(80)�� �÷��� �߰�
    ALTER TABLE ���̺�� ADD(�÷��� ������Ÿ��)[(ũ��)][DEFAULT ��])
    ALTER TABLE EMPLOYEES ADD(EMP_NAME VARCHAR2(80));
    
    
**UPDATE ��==> ����� �ڷḦ ������ �� ���
    UPDATE ���̺�� 
       SET �÷���=��[,]
           �÷���=��[,]
           :
           �÷���=��
    [ WHERE ���� ]
    -- WHERE���� �� ���� ��� �÷����� �� �Ȱ������ϱ� �����ؾ��Ѵ�. ������ �ڷ�� ������ �� �ڷῡ ������ �������ش�.
    

    UPDATE HR.EMPLOYEES 
        SET EMP_NAME=FIRST_NAME||' '||LAST_NAME;
        
    SELECT EMPLOYEE_ID,
           EMP_NAME
      FROM EMPLOYEES;
      
    COMMIT;  
      
      
      
      
      