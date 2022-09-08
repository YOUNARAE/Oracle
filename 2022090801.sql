2022-0908-01)�Լ�(User Defined Function : Function)
  - ���� �� Ư¡�� ���ν����� ����
  - ���ν����� �������� ��ȯ ���� ����(select ���� select��, where��, update �� 
    insert ���� �������� ��� ����)
    
  (�������)
  CREATE [OR REPLACE] FUNCTION �Լ���[(
    ������ [IN|OUT|INOUT] ������Ÿ��[:=����Ʈ��],
                   :
    ������ [IN|OUT|INOUT] ������Ÿ��[:=����Ʈ��])]
    RETURN Ÿ�Ը�
  IS|AS
    ���𿵿�
  BEGIN
    ���࿵��
    RETURN expr;
  END;
   . ���࿵���� �ݵ�� �ϳ� �̻��� RETURN���� �����ؾ� �� 

��뿹) ������ 2020�� 5�� 17���̶�� �����ϰ� ���� ��¥�� �Է� �޾� ��ٱ��Ϲ�ȣ��
       �����ϴ� �Լ��� �����Ͻÿ�.
       
       --�Լ��� �ݵ�� ���� ��ȯ�޾ƾ��� ���� ����Ѵ�
       --�����ϼ���-������Ʈ�ϼ��� ���� ���ǿ��� ��ȯ���� ���� ��� ���ν����� ���� �ȴ�

       �Է� :  2020�� 5�� 17��
       ��� :  ��ٱ��Ϲ�ȣ
       
       CREATE OR REPLACE FUNCTION FN_CREATE_CARTNO(P_DATE IN DATE)
         RETURN CHAR 
       IS
         V_CARTNO CART.CART_NO%TYPE;
         V_FLAG NUMBER := 0;
         V_DAY CHAR(9):= TO_CHAR(P_DATE,'YYYYMMDD')||TRIM('%');
       BEGIN
         SELECT COUNT(*) INTO V_FLAG
           FROM CART
          WHERE CART_NO LIKE V_DAY;
        
          IF V_FLAG=0 THEN
             V_CARTNO:=TO_CHAR(P_DATE,'YYYYMMDD')||TRIM('00001');
          ELSE
            SELECT MAX(CART_NO)+1 INTO V_CARTNO
              FROM CART
             WHERE CART_NO LIKE V_DAY;
         END IF;
         
         RETURN V_CARTNO;
       END;
       
       
  (����) ���� �ڷḦ CART���̺� �����Ͻÿ�.
        ����ȸ�� : 'j001'
        ���Ż�ǰ : 'P201000012'
        ���ż��� : 5
        �������� : ����
        
        INSERT INTO CART (CART_MEMBER, CART_NO, CART_PROD, CART_QTY)
             VALUES('j001', FN_CREATE_CARTNO(SYSDATE),'P201000012',5);
 
 
        
  ��뿹)�⵵�� ���� ��ǰ��ȣ�� �Է� �޾� �ش� �Ⱓ�� �߻��� ��ǰ�� �������踦 ��ȸ�Ͻÿ�
        Alias�� ��ǰ��ȣ,��ǰ��,���Լ���,���Աݾ� --���ؼ� ����� ������ �Ѳ����� 2���� ��ȯ���ִ� �Լ��� ���
        
        CREATE OR REPLACE FUNCTION FN_SUM_BUYQTY(
          P_PERIOD IN CHAR, P_PID IN VARCHAR2)
          RETURN NUMBER
        IS 
          V_SUM NUMBER:=0;--��������
          V_SDATE DATE:=TO_DATE(P_PERIOD||'01');
          V_EDATE DATE:=LAST_DAY(V_SDATE);
        BEGIN
          SELECT NVL(SUM(BUY_QTY),0) INTO V_SUM
            FROM BUYPROD
           WHERE BUY_DATE BETWEEN V_SDATE AND V_EDATE
             AND BUY_PROD=P_PID;
          RETURN V_SUM;
        END;
        
        (����)
        SELECT PROD_ID AS ��ǰ�ڵ�,
               PROD_NAME AS ��ǰ��,
               FN_SUM_BUYQTY('202002', PROD_ID) AS ���Լ���
          FROM PROD;

----------------------------------------------------------------

     (���Աݾ�)
      CREATE OR REPLACE FUNCTION FN_SUM_PRICE(
          P_PERIOD IN CHAR, P_PID IN VARCHAR2)
          RETURN NUMBER
        IS 
          V_SUM NUMBER:=0;--���űݾ�����
          V_SDATE DATE:=TO_DATE(P_PERIOD||'01');
          V_EDATE DATE:=LAST_DAY(V_SDATE);
        BEGIN
          SELECT NVL(SUM(BUY_COST*BUY_QTY),0) INTO V_SUM
            FROM BUYPROD
           WHERE BUY_DATE BETWEEN V_SDATE AND V_EDATE
             AND BUY_PROD=P_PID;
          RETURN V_SUM;
        END;
    
      (����)
        SELECT PROD_ID AS ��ǰ�ڵ�,
               PROD_NAME AS ��ǰ��,
               FN_BUYQTY_PRICE('202002', PROD_ID) AS ���Լ�������
          FROM PROD;
    
        
        
        (����+_���Աݾ�)
        CREATE OR REPLACE FUNCTION FN_BUYQTY_PRICE(
          P_PERIOD IN CHAR, P_PID IN VARCHAR2)
          RETURN VARCHAR2
        IS 
          V_CHAR VARCHAR2(100);--���űݾ�����
          V_SDATE DATE:=TO_DATE(P_PERIOD||'01');
          V_EDATE DATE:=LAST_DAY(V_SDATE);
        BEGIN
          SELECT NVL(SUM(BUY_COST*BUY_QTY),0)||','||NVL(SUM(BUY_QTY),0) INTO V_CHAR
            FROM BUYPROD
           WHERE BUY_DATE BETWEEN V_SDATE AND V_EDATE
             AND BUY_PROD=P_PID;
          RETURN V_CHAR;
        END;
        
        
        
        
        
    
       
       
       
       















