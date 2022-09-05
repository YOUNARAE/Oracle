2022-0902-02)오라클 객체

1.VIEW 객체
 - TABLE과 유사한 객체
 - 기존의 테이블이나 VIEW를 대상으로 새로운 SELECT 문의 결과가 VIEW가 됨
 - SELECT문의 종속 객체가 아니라 독립 객체임
 - 사용이유
   . 필요한 정보가 분산되어 매번 조인을 필요로 하는 경우
   . 특정자료의 접근을 제한하고자 하는 경우(보안상)
   --ex)특정 사이트에 로그인한 회원들의 데이터를 보관하는 데이터를 따로 만들었다고 가정했을 때
   --   뷰를 사용하면 매번 업데이트를 해주지 않아도 쿼리 한번만 수행으로도 원본데이터가 자동으로 업데이트되는 테이블이 만들어지는 것과 같다

 (사용형식)
 CREATE [OR REPLACE] VIEW 뷰이름 [(컬럼list)] 
 --OR REPLACE가 있으면 이미 생성되었던 테이블에도 먼저 있던 뷰에 새롭게 생성된 뷰를 덮어씌울 수 있다.
 --덮어씌울 수 있기때문에 결국 OR가 써있으면 1개의 동일한 테이블로 본다.
 AS
   SELECT 문
   [WITH READ ONLY]
   [WITH CHECK OPTION];
   
   'OR REPLACE' : 이미 존재하는 뷰인 경우 뷰를 대치하고 존재하지 않는 뷰는 새로 생성
   
    '(컬럼list)' : 뷰에서 사용할 컬럼명.
                  (생략하면
                   1) 뷰를 생성하는 SELECT 문의 SELECT절에 컬럼별칭이 사용되었으면 
                      뷰의 컬럼명이 됨
                   2) 뷰를 생성하는 SELECT문의 SELECT절에 컬럼별칭이 사용되지 않았으면
                      SELECT절의 컬럼명이 뷰의 컬럼명이 됨
                      
    'WITH READ ONLY' : 읽기전용뷰(뷰에만 적용)
    --뷰를 수정하면 원본데이터가 손상될 수 있기 때문에 읽기전용이 제공된다
    'WITH CHECK OPTION' : 생성된 뷰를 대상으로 뷰를 생성하는 SELECT 문의 조건절을 
                          위배하도록 하는 DML 명령을 사용할 수 없음(뷰에만 적용)
    --뷰에서 원본테이블에 WHERE을 위배하는 INSERT,DELETE 등의 DML명령을 아예 사용할 수 없게 하는 옵션이다
    --데이터를 손상시킬 수 있기 때문에

****'WITH READ ONLY'와 'WITH CHECK OPTION'는 같이 사용할 수 없음

 사용예)회원테이블에서 마일리지가 3000이상인 회원의 회원번호,회원명,직업,마일리지로 뷰를 생성하시오
       
     CREATE OR REPLACE VIEW V_MEM01 --뷰 옆에 사용한 컬럼명을 생략하면 밑에 셀렉트문에 있는 별칭이 컬럼명이 된다.
     AS 
       SELECT MEM_ID,
              MEM_NAME,
              MEM_JOB,
              MEM_MILEAGE
         FROM MEMBER
        WHERE MEM_MILEAGE >= 3000;

    SELECT * FROM V_MEM01;
 
    **V_MEM01에서 오철희회원(k001)의 마일리지를 2000으로 변경
    
    UPDATE V_MEM01
       SET MEM_MILEAGE = 2000
     WHERE MEM_ID = 'k001';
     
    **MEMBER테이블에서 오철희회원(k001)의 마일리지를 5000으로 변경
    UPDATE MEMBER
       SET MEM_MILEAGE = 5000
     WHERE MEM_ID = 'k001';


    **MEMBER테이블에서 모든 회원들의 마일리지를 1000씩 추가 지급하시오.
    UPDATE MEMBER
       SET MEM_MILEAGE = MEM_MILEAGE+1000;
    
--원본테이블을 바꾸면 뷰는 자동으로 바뀐다

    (읽기전용 뷰)
     CREATE OR REPLACE VIEW V_MEM01(MID,MNAME,MJOB,MILE) 
     AS 
       SELECT MEM_ID,
              MEM_NAME,
              MEM_JOB,
              MEM_MILEAGE
         FROM MEMBER
        WHERE MEM_MILEAGE >= 3000
        WITH READ ONLY;
        
    SELECT * FROM V_MEM01;
    
    **MEMBER테이블에서 모든 회원의 마일리지를 1000씩 감소시키시오
    UPDATE MEMBER
       SET MEM_MILEAGE=MEM_MILEAGE-1000;

 COMMIT;

    **뷰 V_MEM01의 자료에서 오철희 회원의 마일리지('k001')를 3700으로 변경
    
    UPDATE V_MEM01
       SET MILE = 3700
     WHERE MID = 'k001';  --Read Only 라서 불가능하다.

    (조건부여 뷰)
    CREATE OR REPLACE VIEW V_MEM01(MID,MNAME,MJOB,MILE) 
         AS 
           SELECT MEM_ID,
                  MEM_NAME,
                  MEM_JOB,
                  MEM_MILEAGE
             FROM MEMBER
            WHERE MEM_MILEAGE >= 3000
            WITH CHECK OPTION;
            
     **뷰 V_MEM01에서 신용환 회원('c001')의 마일리지를 5500으로 변경하시오.
     
     UPDATE V_MEM01
        SET MILE =  5500
      WHERE MID = 'c001';
      
     **뷰 V_MEM01에서 신용환 회원('c001')의 마일리지를 1500으로 변경하시오.
     UPDATE V_MEM01
        SET MILE =  1500
      WHERE MID = 'c001'; --WHERE절의 조건을 위배하기때문에 불가능하다.
      
     UPDATE MEMBER
        SET MEM_MILEAGE = 1500
      WHERE MEM_ID = 'c001';
     
     
        
    SELECT * FROM V_MEM01;     
      
        
ROLLBACK;


                      
                   
                   