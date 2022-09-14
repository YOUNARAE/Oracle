     
             
             (실행)
             SELECT PROD_ID AS 상품코드,
                    PROD_NAME AS 상품명,
                    FN_SUM_BUYQTY('202002',PROD_ID) AS 매입수량,
                    FN_SUM_BUY('202002',PROD_ID) AS 매입금액합계
               FROM PROD;
               
               
      사용예)다음 매출자료가 발생한 후의 작업을 트리거로 작성하시오
            구매회원 : 오철희('k001', 5000 포인트)
            구매 상품코드 : 'P202000010' (2020	P202000010	38	0	0	38	2020/01/01)
            구매 수량 : 2
            
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
              IF INSERTING THEN --인서트가 실행되서 트리거가 참이면 참인 함수
                V_QTY:=(:NEW.CART_QTY);
                V_PID:=(:NEW.CART_PROD);
                V_DATE:=TO_DATE(SUBSTR(:NEW.CART_NO,1,8));
                V_MID:=(:NEW.CART_MEMBER);
            ELSIF UPDATING THEN --업데이트이벤트가 발생되었을 때 참
                V_QTY:=(:NEW.CART_QTY) - (:OLD.CART_QTY);
                V_PID:=(:NEW.CART_PROD);
                V_DATE:=TO_DATE(SUBSTR(:NEW.CART_NO,1,8));
                V_MID:=(:NEW.CART_MEMBER);
            ELSIF DELETING THEN --딜리트이벤트가 발생되었을 때 참
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
    
    (3개 반품 : UPDATE)
    UPDATE CART
       SET CART_QTY=2
     WHERE CART_NO='2020061200002'
       AND CART_PROD='P202000010';
   
     2020	P202000010	38	0	2	36	2020/06/12     
     
    (구매취소 : DELETE)     
     DELETE FROM CART
      WHERE CART_NO='2020061200002'
        AND CART_PROD='P202000010';
               
      
            
      