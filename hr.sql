

**EMPLOYEES 테이블에 새로운 컬럼(EMP_NAME), 데이터타입은 VARCHAR2(80)인 컬럼을 추가
    ALTER TABLE 테이블명 ADD(컬럼명 데이터타입)[(크기)][DEFAULT 값])
    ALTER TABLE EMPLOYEES ADD(EMP_NAME VARCHAR2(80));
    
    
**UPDATE 문==> 저장된 자료를 수정할 때 사용
    UPDATE 테이블명 
       SET 컬럼명=값[,]
           컬럼명=값[,]
           :
           컬럼명=값
    [ WHERE 조건 ]
    -- WHERE절을 안 쓰면 모든 컬럼명이 다 똑같아지니까 주의해야한다. 변경할 자료와 변경할 행 자료에 열값만 변경해준다.
    

    UPDATE HR.EMPLOYEES 
        SET EMP_NAME=FIRST_NAME||' '||LAST_NAME;
        
    SELECT EMPLOYEE_ID,
           EMP_NAME
      FROM EMPLOYEES;
      
    COMMIT;  
      
      
      
      
      