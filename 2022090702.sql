2022-0907-02) Stored Procedure(Procedure)
 - 특정 로직을 처리하고 그 결과 값을 반환하지 않는 서브 프로그램
 - 미리 컴파일되어 저장(실행의 효율성이 좋고, 네트워크를 통해 전달되는 자료의 양이 작다)
 (사용형식)
  CREATE [OR REPLACE] PROCEDURE 프로시져명[(
    변수명 [IN|OUT|INOUT] 데이터타입[:=디폴트값],
                   :
    변수명 [IN|OUT|INOUT] 데이터타입[:=디폴트값])]
  IS|AS
    선언영역
  BEGIN
    실행영역
  END;
   . '변수명' : 매개변수명
   . 'IN|OUT|INOUT' : 매개변수의 역활 정의(IN : 입력용, OUT : 출력용, INOUT : 입출력 공용)
   . '데이터타입' : 크기를 기술하면 오류
   . '디폴트값' : 사용자가 매개변수를 기술하고 값을 배정하지 않았을때 자동으로 할당될 값
   
 (실행문)
  EXECUTE|EXEC 프로시저명[(매개변수list)];
  또는 프로시저나 다른 블록에서 실행할 경우
  프로시저명[(매개변수list)];
  
사용예)부서번호를 입력받아 해당부서의 부서장의 이름,직책,부서명,급여를 출력하는 
      프로시져를 작성하시오
  CREATE OR REPLACE PROCEDURE PROC_EMP01(
    P_DID IN HR.DEPARTMENTS.DEPARTMENT_ID%TYPE) 
  IS
    V_NAME VARCHAR2(100);
    V_JOBID HR.JOBS.JOB_ID%TYPE;
    V_DNAME VARCHAR2(100);
    V_SAL NUMBER:=0;
  BEGIN
    SELECT B.EMP_NAME,B.JOB_ID,A.DEPARTMENT_NAME,B.SALARY
      INTO V_NAME,V_JOBID,V_DNAME,V_SAL
      FROM HR.DEPARTMENTS A, HR.EMPLOYEES B
     WHERE A.DEPARTMENT_ID=P_DID
       AND A.MANAGER_ID=B.EMPLOYEE_ID;
    DBMS_OUTPUT.PUT_LINE('부서번호 : '||P_DID);
    DBMS_OUTPUT.PUT_LINE('부서장 : '||V_NAME);
    DBMS_OUTPUT.PUT_LINE('직무코드 : '||V_JOBID);
    DBMS_OUTPUT.PUT_LINE('부서명 : '||V_DNAME);
    DBMS_OUTPUT.PUT_LINE('급여 : '||V_SAL);
    DBMS_OUTPUT.PUT_LINE('---------------------------------');      
  END;


(실행)
EXECUTE PROC_EMP01(60);  


사용예)년도와 월을 입력 받아 해당 기간에 가장 많은 구매액을 기록한 회원정보를 조회하시오.
      Alias는 회원번호,회원명,구매금액,주소이다.   
      
  (프로시져)
    입력 : 년도와 월
    처리 : CART테이블에서 최대구매액을 기록한 회원번호, 구매액 합계 계산
    출력 : 회원번호, 구매액 합계
        
  CREATE OR REPLACE PROCEDURE PROC_CART01(
     P_PERIOD IN VARCHAR2,  --년월 입력
     P_MID OUT MEMBER.MEM_ID%TYPE, --회원번호출력 / 출력에 OUT은 무조건 써줘야한다.
     P_SUM OUT NUMBER)  --구매금액합계 출력 
 IS
     
 BEGIN
    SELECT TA.CID, TA.CSUM INTO P_MID, P_SUM
      FROM (SELECT A.CART_MEMBER AS CID,
                   SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM
              FROM CART A, PROD B
             WHERE A.CART_PROD=B.PROD_ID
               AND SUBSTR(A.CART_NO,1,6)=P_PERIOD
             GROUP BY A.CART_MEMBER
             ORDER BY 2 DESC) TA
     WHERE ROWNUM=1;
 END;
     
  
  (실행)
    입력 : 회원번호, 구매액 합계 
    처리 : MEMBER테이블에서 회원번호,회원명,주소
    출력 : 회원번호,회원명,주소,구매액 합계
    
    
    DECLARE
      V_MID MEMBER.MEM_ID%TYPE;
      V_SUM NUMBER:=0;
      V_ADDR VARCHAR2(100);
      V_NAME MEMBER.MEM_NAME%TYPE;
    BEGIN
      PROC_CART01('202005',V_MID,V_SUM);
      SELECT MEM_NAME,MEM_ADD1||'-'||MEM_ADD2 INTO V_NAME, V_ADDR
        FROM MEMBER
       WHERE MEM_ID=V_MID;
      DBMS_OUTPUT.PUT_LINE('회원번호 : '||V_MID);
      DBMS_OUTPUT.PUT_LINE('회원명 : '||V_NAME);
      DBMS_OUTPUT.PUT_LINE('주소 : '||V_ADDR);
      DBMS_OUTPUT.PUT_LINE('구매금액 : '||V_SUM);
      DBMS_OUTPUT.PUT_LINE('-----------------');
    END;
    
    
    
 사용예)직업이 '자영업'인 회원번호를 입력 받아 2020년 상반기 (1-6월) 구매현황을 출력하는 프로시져를 작성하시오
       Alias는 회원번호, 회원명, 구매금액합계
    (과제)
    
    (프로시져)
    입력 : 회원번호
    처리 : 자영업인 회원, 2020년 상반기(1-6월) 구매현황
    출력 : 회원번호, 회원명, 구매금액합계
        
    CREATE OR REPLACE PROCEDURE PROC_CART02(
         P_PERIOD IN NUMBER, --회원번호출력 / 출력에 OUT은 무조건 써줘야한다.
         P_MNAME OUT MEMBER.MEM_ID%TYPE,
         P_SUM OUT NUMBER)  --구매금액합계 출력 
     IS
     BEGIN
        SELECT TA.CID, TA.CSUM INTO P_MID, P_SUM
          FROM (SELECT A.CART_MEMBER AS CID,
                       SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM
                  FROM CART A, PROD B
                 WHERE A.CART_PROD=B.PROD_ID
                   AND 
                 GROUP BY A.CART_MEMBER
                 ORDER BY 2 DESC) TA
         WHERE 
     END;
         
      
      (실행)
        입력 : 회원번호, 구매액 합계 
        처리 : MEMBER테이블에서 회원번호,회원명,주소
        출력 : 회원번호,회원명,주소,구매액 합계
        
        
        DECLARE
          V_MID MEMBER.MEM_ID%TYPE;
          V_SUM NUMBER:=0;
          V_ADDR VARCHAR2(100);
          V_NAME MEMBER.MEM_NAME%TYPE;
        BEGIN
          PROC_CART01('202005',V_MID,V_SUM);
          SELECT MEM_NAME,MEM_ADD1||'-'||MEM_ADD2 INTO V_NAME, V_ADDR
            FROM MEMBER
           WHERE MEM_ID=V_MID;
          DBMS_OUTPUT.PUT_LINE('회원번호 : '||V_MID);
          DBMS_OUTPUT.PUT_LINE('회원명 : '||V_NAME);
          DBMS_OUTPUT.PUT_LINE('주소 : '||V_ADDR);
          DBMS_OUTPUT.PUT_LINE('구매금액 : '||V_SUM);
          DBMS_OUTPUT.PUT_LINE('-----------------');
        END;
        
        
        
    
     
      
      
      
      
      
사용예)다음 자료를 판매한 경우 매출처리를 프로시져로 작성하시오
            판매자료
            -------------------------------------------------
             구매회원번호    날짜          상품코드          수량
            -------------------------------------------------
              n001         2020-07-28   P102000005       3 
              
              
            CREATE OR REPLACE PROCEDURE PROD_CART_INPUT(
              P_MID MEMBER.MEM_ID%TYPE,
              P_DATE IN DATE, 
              P_PID PROD.PROD_ID%TYPE,
              P_QTY NUMBER)
            IS
              V_CART_NO CART.CART_NO%TYPE;
              V_FLAG NUMBER:=0;
              V_DAY CHAR(9):=TO_CHAR(P_DATE,'YYYYMMDD')||'%';
            BEGIN
              -- CART에 저장
              SELECT COUNT(*) INTO V_CART_NO
                FROM CART
               WHERE CART_NO LIKE V_DAY;
        
              IF V_FLAG=0 THEN
                 V_CART_NO:=TO_CHAR(P_DATE,'YYYYMMDD')||TRIM('00001');
              ELSE   -- 0이 아닐 때 실행되어야하는 부분 // 주문이 들어왔을 경우에는 총 주문수에 +1이 되는 거라서 +1을 더해준다
              SELECT MAX(CART_NO)+1 INTO V_CART_NO
                FROM CART
               WHERE CART_NO LIKE V_DAY;
              END IF;
            
              INSERT INTO CART VALUES(P_MID,V_CART_NO,P_PID,P_QTY);
              COMMIT;
               
               
              -- 재고조정
              UPDATE REMAIN A
                 SET A.REMAIN_O=A.REMAIN_O+P_QTY, 
                     A.REMAIN_J_99=A.REMAIN_J_99-P_QTY, 
                     A.REMAIN_DATE=P_DATE
               WHERE A.PROD_ID=P_PID
                 AND A.REMAIN_YEAR='2020'; --기본키가 PROD_ID와REMAIN_YEAR인데 둘 중 하나만 적으면 안된다.
                 
              -- 마일리지 부여
              COMMIT;
              
              UPDATE MEMBER A
                 SET A.MEM_MILEAGE=(SELECT A.MEM_MILEAGE + B.PROD_MILEAGE*P_QTY
                                      FROM PROD B
                                     WHERE B.PROD_ID=P_PID)
               WHERE A.MEM_ID=P_MID;
                 
               COMMIT;
               

            END;
    
      
      
            EXECUTE PROD_CART_INPUT('n001',TO_DATE('20200728'),'P102000005',3);
 
 
 
 
 
 
 
 
 
 
 
 

  
   