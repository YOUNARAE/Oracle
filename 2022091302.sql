     
             
             (����)
             SELECT PROD_ID AS ��ǰ�ڵ�,
                    PROD_NAME AS ��ǰ��,
                    FN_SUM_BUYQTY('202002',PROD_ID) AS ���Լ���,
                    FN_SUM_BUY('202002',PROD_ID) AS ���Աݾ��հ�
               FROM PROD;
               
               
      ��뿹)���� �����ڷᰡ �߻��� ���� �۾��� Ʈ���ŷ� �ۼ��Ͻÿ�
            ����ȸ�� : ��ö��('k001', 5000 ����Ʈ)
            ���� ��ǰ�ڵ� : 'P202000010' (2020	P202000010	38	0	0	38	2020/01/01)
            ���� ���� : 2
            
            CREATE OR REPLACE TRIGGER tg_change_cart
              AFTER INSERT OR UPDATE OR DELETE ON CART
              FOR EACH ROW
            DECLARE
              V_QTY NUMBER:=0;
              V_PID PROD.PROD_ID%TYPE;
              V_DATE DATE;
              V_MID MEMBER.MEM_ID%TYPE;
              V_MILE NUMBER:=0;
            BEGIN
              IF INSERTING THEN --�μ�Ʈ�� ����Ǽ� Ʈ���Ű� ���̸� ���� �Լ�
                V_QTY:=(:NEW.CART_QTY);
                V_PID:=(:NEW.CART_PROD);
                V_DATE:=TO_DATE(SUBSTR(:NEW.CART_NO,1,8));
                V_MID:=(:NEW.CART_MEMBER);
            ELSIF UPDATING THEN --������Ʈ�̺�Ʈ�� �߻��Ǿ��� �� ��
                V_QTY:=(:NEW.CART_QTY) - (:OLD.CART_QTY);
                V_PID:=(:NEW.CART_PROD);
                V_DATE:=TO_DATE(SUBSTR(:NEW.CART_NO,1,8));
                V_MID:=(:NEW.CART_MEMBER);
            ELSIF DELETING THEN --����Ʈ�̺�Ʈ�� �߻��Ǿ��� �� ��
                V_QTY:=-(:OLD.CART_QTY);
                V_PID:=(:OLD.CART_PROD);
                V_DATE:=TO_DATE(SUBSTR(:OLD.CART_NO,1,8));
                V_MID:=(:OLD.CART_MEMBER);
         END IF;
        
        
        UPDATE REMAIN
           SET REMAIN_O=REMAIN_O + V_QTY,
               REMAIN_J_99=REMAIN_J_99 - V_QTY,
               REMAIN_DATE=V_DATE
         WHERE PROD_ID=V_PID;
         
         SELECT V_QTY*PROD_MILEAGE INTO V_MILE
           FROM PROD
          WHERE PROD_ID=V_PID; 
           
         UPDATE MEMBER
            SET MEM_MILEAGE=MEM_MILEAGE + V_MILE
          WHERE MEM_ID=V_MID;
    END;
    
    
    INSERT INTO CART VALUES ('k001',FN_CREATE_CARTNO(SYSDATE),'P202000010',5);
    2020	P202000010	38	0	5	33	2020/06/12
    
    (3�� ��ǰ : UPDATE)
    UPDATE CART
       SET CART_QTY=2
     WHERE CART_NO='2020061200002'
       AND CART_PROD='P202000010';
   
     2020	P202000010	38	0	2	36	2020/06/12     
     
    (������� : DELETE)     
     DELETE FROM CART
      WHERE CART_NO='2020061200002'
        AND CART_PROD='P202000010';
               
      
            
      