2022-0906-01)PL/SQL
  - ǥ�� SQL�� ������ �ִ� ����(����, �ݺ���,�б⹮ ���� ����)�� ����
  - PROCEDUAL LANGUAGE SQL 
  - BLOCK������ �����Ǿ� ����
  - �͸�����(Anonymous Block), Stored Procedure, user defined Function, Trigger,
    Package ���� ����
  - ���ȭ �� ĸ��ȭ ��� ���� -- ��ü�� �Ƿ��� ĸ��ȭ,������,����� �̷�������Ѵ�.
  
  1. �͸�����
  - PL/SQL�� �⺻ ���� ����
  - �̸��� ���� �� ����(ȣ��)�� �Ұ���

 
  (����)
    DECLARE
      �����(����,���,Ŀ�� ����);
    BEGIN
      ����� : �����Ͻ� ������ �����ϱ� ���� SQL����, �ݺ���, �б⹮ ������ ����
      [EXCEPTION
        ����ó�� ��
       ]
    END;
      - ���࿵������ ����ϴ� SELECT����
      SELECT �÷�list
        INTO ������[,������,...]
        FROM ���̺���
      [WHERE ����]
        .�÷��� ������ ������Ÿ���� INTO���� ������ ���� �� ������ Ÿ�԰� ����
  
   1) ����
     . ���߾���� ������ ���� ����
     . SCLAR����, REFERENCE ����, COMPOSITE ����, BINDING ���� ���� ����

     (�������)
     ** SCLAR ����
     ������[CONSTANT] ������Ÿ�� [(ũ��)] [:=�ʱⰪ]; --������ CONSTANT�� ������ ����� �Ǿ�����
      .������Ÿ�� : SQL���� �����ϴ� ������ Ÿ��, PLS_INTEGER, BINARY_INTEGER, BOOLEAN ���� ������
      --����Ŭ������ �Ҹ������� TRUE,FAULSE,NULL�� �ִ�
      
      .'CONSTANT' : ��� ����
      
      
      **REFERENCE ����
        ������ ���̺���.�÷���%TYPE --������
        ������ ���̺���%ROWTYPE --������ ex)�� ������ �� ��� ���� Ÿ������ ������ش�  a.cartmember
        
        
    ��뿹)Ű����� �μ��� �Է¹޾� �ش�μ��� ���� ���� �Ի��� ����� �����ȣ,
          �����,��å�ڵ�,�Ի����� ����ϴ� ������ �ۼ��Ͻÿ�.
          ACCEPT P_DID PROMPT * '�μ���ȣ �Է� : '
          DECLARE 
            V_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE;
            V_EID HR.EMPLOYEES.EMPLOYEE_ID%TYPE; --�����ȣ
            V_NAME VARCHAR2(100); --�����
            V_JID HR.JOBS.JOB_ID%TYPE; --��å�ڵ�
            V_HDATE DATE; --�Ի���
          BEGIN
            V_DID:=TO_NUMBER('&P_DID');
            SELECT A.EMPLOYEE_ID, A.EMP_NAME, A.JOB_ID, A.HIRE_DATE
              INTO V_EID, V_NAME, V_JID, V_HDATE 
              FROM(SELECT EMPLOYEE_ID, EMP_NAME, JOB_ID, HIRE_DATE
                     FROM HR.EMPLOYEES
                     WHERE DEPARTMENT_ID=V_DID
                     ORDER BY 4)A
              WHERE ROWNUM=1;
             
             DBMS_OUTPUT.PUT_LINE('�����ȣ : '||V_EID);
             DBMS_OUTPUT.PUT_LINE('����� : '||V_NAME);
             DBMS_OUTPUT.PUT_LINE('��å�ڵ� : '||V_JID);
             DBMS_OUTPUT.PUT_LINE('�Ի��� : '||V_HDATE);
             DBMS_OUTPUT.PUT_LINE('------------------------------');           
          END;
          
  ��뿹) ȸ�����̺����� ������ '�ֺ�'�� ȸ������ 2020�� 5�� ������Ȳ�� ��ȸ�Ͻÿ�
         Alias�� ȸ����ȣ,ȸ����,����,���űݾ��հ�
         
         SELECT A.MEM_ID AS ȸ����ȣ, 
                A.MEM_NAME AS ȸ����, 
                A.MEM_JOB AS ����, 
                D.BSUM AS ���űݾ��հ�
           FROM (SELECT MEM_ID, MEM_NAME, MEM_JOB
                   FROM MEMBER
                  WHERE MEM_JOB='�ֺ�') A, --ȸ�����̺����� ������ '�ֺ�'�� ȸ����
                (SELECT B.CART_MEMBER AS BMID, 
                        SUM(B.CART_QTY*C.PROD_PRICE) AS BSUM
                   FROM CART B, PROD C
                  WHERE B.CART_PROD=C.PROD_ID
                    AND B.CART_NO LIKE '202005%'
                  GROUP BY B.CART_MEMBER) D
          WHERE A.MEM_ID=D.BMID;
          
          (�͸� ����)
          DECLARE
            --��µǾ���ϴ� �������� ������ ���;��Ѵ�
            V_MID MEMBER.MEM_ID%TYPE; --MEMBER.MEM_IDŸ������ V_MID�� �������ִ� ���̴�.
            V_NAME VARCHAR2(100);
            V_JOB MEMBER.MEM_JOB%TYPE;
            V_SUM NUMBER:=0; -- NUMBER�� ���� 27�ڸ����� �˾Ƽ� ����ش�,�ʱ�ȭ�����ֱ�
            CURSOR CUR_MEM IS --����Ʈ���� ���Ǿ����� Ŀ���� �������� �� ���ش�
              SELECT MEM_ID, MEM_NAME, MEM_JOB
                FROM MEMBER
               WHERE MEM_JOB='�ֺ�';
          BEGIN
            OPEN CUR_MEM;
            LOOP
              FETCH CUR_MEM INTO V_MID, V_NAME, V_JOB; --FETCH�� �� �پ� �о ������ ������ �� ���� �����϶�� ����
              EXIT WHEN CUR_MEM%NOTFOUND;
              SELECT SUM(A.CART_QTY*B.PROD_PRICE) INTO V_SUM --�������� �ƴ϶� �ݵ�� �������� ������Ѵ�.
                FROM CART A, PROD B
               WHERE A.CART_PROD=B.PROD_ID
                 AND A.CART_NO LIKE '202005%'
                 AND A.CART_MEMBER=V_MID;
                DBMS_OUTPUT.PUT_LINE('ȸ����ȣ : '||V_MID);  
                DBMS_OUTPUT.PUT_LINE('ȸ���� : '||V_NAME);
                DBMS_OUTPUT.PUT_LINE('���� : '||V_JOB);
                DBMS_OUTPUT.PUT_LINE('���űݾ� : '||V_SUM);
                DBMS_OUTPUT.PUT_LINE('-----------------------------');
            END LOOP;
            CLOSE CUR_MEM; --������� Ŀ���� �ݾ��ش�. Ŀ���� ���̶�� �����Ѵ�.
            --Ŀ���� �������� ����� ������ �� �� ����� ����ִ� ������ ������ �־��־���ϴµ�, �ѹ��� �������� �����͸� �ϳ��� ������ ������ �� ���⶧����
            --���پ� ���پ� ������ �б� ���ؼ� Ŀ���� ����� ���̴�.
          END;
          
          
          
          
    ��뿹)�⵵�� �Է� �޾� �������� ������� �����ϴ� ������ �ۼ��Ͻÿ�.
        
    ACCEPT P_YEAR PROMPT '�⵵�Է� : '    
    DECLARE
        V_YEAR NUMBER:=TO_NUMBER('&P_YEAR');--�ƿ� ������ �����ϸ鼭 �Է¹��� �⵵�� ���ڷ� ��ȯ�ؼ� V_YEAR�� ���� �־��־���.
        V_RES VARCHAR2(200);
    BEGIN
        IF (MOD(V_YEAR,4)=0 AND MOD(V_YEAR,100)!=0) OR (MOD(V_YEAR,400)=0) THEN
           V_RES:=V_YEAR||'���� �����Դϴ�';
        ELSE
           V_RES:=V_YEAR||'���� ����Դϴ�';
        END IF;
        
        DBMS_OUTPUT.PUT_LINE(V_RES);
    END;
    
    ��뿹)�������� �Է¹޾� ���� ���̿� ������ ���̸� ���Ͻÿ�.
          ���� ���� : ������ * ������ * ������(3.14155926)
          ���ѷ� : ���� * 3.1415926
          
          ACCEPT P_RADIUS PROMPT '������ : '  
          DECLARE
             V_RADIUS NUMBER:=TO_NUMBER('&P_RADIUS');
             V_AREA VARCHAR2(200);
             V_ROUND VARCHAR2(200);
             V_PIE CONSTANT NUMBER:=3.1415926;
          BEGIN
               V_AREA:=V_RADIUS*V_RADIUS*V_PIE;
               V_ROUND:=(V_RADIUS+V_RADIUS)*V_PIE;        
               
               DBMS_OUTPUT.PUT_LINE('���� ���� : '||V_AREA);
               DBMS_OUTPUT.PUT_LINE('���� �ѷ� : '||V_ROUND);
          END;
           
 
  