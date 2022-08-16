2022-0810-01)
4. ��Ÿ������
   - ����Ŭ���� �����ϴ� ��Ÿ �����ڴ� IN, ANY, SOME, ALL, EXISTS, BETWEEN, LIKE �����ڰ� ����
   1) IN ������
      . IN �����ڿ��� '='(Equal to)����� ����
      . IN ���� '( )'�ȿ� ����� �� �� ��� �ϳ��� ��ġ�ϸ� ��ü ����� ��(true)�� ��ȯ
      . IN�����ڴ� '-ANY', '-SOME'���� ġȯ ����
      . IN�����ڴ� OR�����ڷ� ġȯ ����
      . ��� �����͸� �� ���� �� �ִ�.(����,��¥,���� �� �����ϴ�/LIKE�����ڴ� ���ڸ� �����ϴ�)
      
      (�������)
      expr    IN(��1,��2,...��n); --expr�� �÷��� �� ���� �ְ� ������ �� ���� �ִ�.
      => expr = ��1
      OR expr = ��2
      OR      :
      OR expr = ��n
       . IN �����ڴ� �ҿ������� ���̳� �ұ�Ģ�� ���� ���� �� �ַ� ���
       =>�������� ���� ���� BETWEEN ���
       
��뿹)������̺��� �μ���ȣ�� 20, 50, 60, 100���� ���� ������� ��ȸ�Ͻÿ�.
     Alias�� �����ȣ,�����,�μ���ȣ,�Ի���
     (OR ������ ��� ����)
     SELECT EMPLOYEE_ID AS �����ȣ,
            EMP_NAME AS �����,
            DEPARTMENT_ID AS �μ���ȣ,
            HIRE_DATE AS �Ի���
       FROM HR.EMPLOYEES
      WHERE DEPARTMENT_ID=20
         OR DEPARTMENT_ID=50
         OR DEPARTMENT_ID=60
         OR DEPARTMENT_ID=100
      ORDER BY 3;
      
     (IN ������ ��� ����)
     SELECT EMPLOYEE_ID AS �����ȣ,
            EMP_NAME AS �����,
            DEPARTMENT_ID AS �μ���ȣ,
            HIRE_DATE AS �Ի���
       FROM HR.EMPLOYEES
      WHERE DEPARTMENT_ID IN(20,50,60,100)
      ORDER BY 3;
      
    (ANY ������ ��� ����)
     SELECT EMPLOYEE_ID AS �����ȣ,
            EMP_NAME AS �����,
            DEPARTMENT_ID AS �μ���ȣ,
            HIRE_DATE AS �Ի���
       FROM HR.EMPLOYEES
      --WHERE DEPARTMENT_ID =ANY(20,50,60,100)
      WHERE DEPARTMENT_ID =SOME(20,50,60,100)
      ORDER BY 3;
               
               
2) ANY(SOME) ������
   . IN�����ڿ� ����� ��� ����
   . ANY�� SOME�� ���� ���
   (�������)
   expr ���迬���� ANY|SOME(��1,...��n)
    - expr�� ���� ( )���� �� �� ��� �ϳ��� ���õ� ���迬���ڸ� �����ϸ� ��ü�� ��(true)
     �� ��ȯ ��
    
��뿹)������̺��� �μ���ȣ 60�� �μ��� ���� ������� �޿� �� ���� ���� �޿����� 
      �� ���� �޿��� �޴� ������� ��ȸ�Ͻÿ�.
      
      
      Alias�� �����ȣ,�����,�޿�,�μ���ȣ�̸� �޿��� ���� ������� ����Ͻÿ�. 
      
      SELECT EMPLOYEE_ID AS �����ȣ,
             EMP_NAME AS �����,
             SALARY AS �޿�,
             DEPARTMENT_ID AS �μ���ȣ
        FROM HR.EMPLOYEES
        --(�˷����� ���� ���� �˻��� �� ����ϴ� ����� ���������� ����Ѵ�)
        -- ���迬���ڴ� �����ʰ� ������ ���� ������ �Ȱ��ƾ� ����� �� �ִ�.
        -- �ؿ� ���̽�ó�� �������� �������� ������ ��� ��Ÿ�����ڸ� ����ؾ��Ѵ�.(�����࿬����)
        --**�����࿬����:�������� �� ���� �ϳ��� ��ġ�Ѵٴ� ��
       WHERE SALARY > ANY (SELECT SALARY
                             FROM HR.EMPLOYEES
                            WHERE DEPARTMENT_ID=60)
      --ANY�ڸ��� SOME�� ���൵ �ȴ�.
      --WHERE SALARY > ANY(9000,6000,4800,4800,4200) ���� ���� �޿����� ũ�� �ٸ� ���ǵ��� �翬�� �����Ѵ�.
      --WHERE SALARY > ANY(9000,6000,4800,4800,4200)
       AND  DEPARTMENT_ID!=60
       ORDER BY 3;
      
��뿹)2020�� 4�� �Ǹŵ� ��ǰ �� ���Ե��� ���� ��ǰ�� ��ȸ�Ͻÿ�.
    Alias�� ��ǰ�ڵ��̴�.
    SELECT DISTINCT CART_PROD AS ��ǰ�ڵ� 
      FROM CART
     WHERE CART_NO LIKE '202004%'
       AND NOT CART_PROD =ANY(SELECT DISTINCT BUY_PROD
                                FROM BUYPROD
                               WHERE BUY_DATE >= '20200401' AND BUY_DATE <= '20200430')
                                
    
    
 3) ALL ������
 (�������)
  expr ALL(��1,...��n) --expr ���� ������ ���� ��� ���� ������ �ϼ��� ���� ���̰� �������� �����̴�.
   - expr�� ���� �־��� '��1'~'��n'�� ��� ���� ���迬���� ������ ����� ���̸�
   WHERE ���� ����� TRUE�� ��ȯ
   - ANY(SOME)�� ���� ���� ���� �������� �ϰ�, ALL�� ���� ū ���� �������� ��
   
��뿹)������̺��� �μ���ȣ 60�� �μ��� ���� (�������ٵ�=ALL)������� �޿� �� ���� ���� �޿����� 
      �� ���� �޿��� �޴� ������� ��ȸ�Ͻÿ�.
      
      SELECT EMPLOYEE_ID AS �����ȣ,
             EMP_NAME AS �����,
             SALARY AS �޿�,
             DEPARTMENT_ID AS �μ���ȣ
        FROM HR.EMPLOYEES
       WHERE SALARY > ALL(9000,6000,4800,4200)
       -- 60�� �μ����� 9000�̻� �޴� ����� ��� ������ ������ �� ���ѵ� �ȴ�.
       ORDER BY 3;
        
      
   
   
    
      