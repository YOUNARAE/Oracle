2022-0906-01)PL/SQL
  - 표준 SQL이 가지고 있는 단점(변수, 반복문,분기문 등이 없음)을 보완
  - PROCEDUAL LANGUAGE SQL 
  - BLOCK구조로 구성되어 있음
  - 익명블록(Anonymous Block), Stored Procedure, user defined Function, Trigger,
    Package 등이 제공
  - 모듈화 및 캡슐화 기능 제공 -- 객체언어가 되려면 캡슐화,다형성,상속이 이루어져야한다.
  
  1. 익명블록
  - PL/SQL의 기본 구조 제공
  - 이름이 없어 재 실행(호출)이 불가능

 
  (구성)
    DECLARE
      선언부(변수,상수,커서 선언);
    BEGIN
      실행부 : 비지니스 로직을 구현하기 위한 SQL구문, 반복문, 분기문 등으로 구성
      [EXCEPTION
        예외처리 문
       ]
    END;
      - 실행영역에서 사용하는 SELECT문은
      SELECT 컬럼list
        INTO 변수명[,변수명,...]
        FROM 테이블명
      [WHERE 조건]
        .컬럼의 갯수와 데이터타입은 INTO절의 변수의 갯수 및 데이터 타입과 동일
  
   1) 변수
     . 개발언어의 변수와 같은 개념
     . SCLAR변수, REFERENCE 변수, COMPOSITE 변수, BINDING 변수 등이 제공

     (사용형식)
     ** SCLAR 변수
     변수명[CONSTANT] 데이터타입 [(크기)] [:=초기값]; --변수에 CONSTANT를 넣으면 상수가 되어진다
      .데이터타입 : SQL에서 제공하는 데이터 타입, PLS_INTEGER, BINARY_INTEGER, BOOLEAN 등이 제공됨
      --오라클에서는 불린값으로 TRUE,FAULSE,NULL이 있다
      
      .'CONSTANT' : 상수 선언
      
      
      **REFERENCE 변수
        변수명 테이블명.컬럼명%TYPE --열참조
        변수명 테이블명%ROWTYPE --행참조 ex)이 변수를 한 행과 같은 타입으로 만들어준다  a.cartmember
        
        
    사용예)키보드로 부서를 입력받아 해당부서에 가장 먼저 입사한 사원의 사원번호,
          사원명,직책코드,입사일을 출력하는 블록을 작성하시오.
          ACCEPT P_DID PROMPT * '부서번호 입력 : '
          DECLARE 
            V_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE;
            V_EID HR.EMPLOYEES.EMPLOYEE_ID%TYPE; --사원번호
            V_NAME VARCHAR2(100); --사원명
            V_JID HR.JOBS.JOB_ID%TYPE; --직책코드
            V_HDATE DATE; --입사일
          BEGIN
            V_DID:=TO_NUMBER('&P_DID');
            SELECT A.EMPLOYEE_ID, A.EMP_NAME, A.JOB_ID, A.HIRE_DATE
              INTO V_EID, V_NAME, V_JID, V_HDATE 
              FROM(SELECT EMPLOYEE_ID, EMP_NAME, JOB_ID, HIRE_DATE
                     FROM HR.EMPLOYEES
                     WHERE DEPARTMENT_ID=V_DID
                     ORDER BY 4)A
              WHERE ROWNUM=1;
             
             DBMS_OUTPUT.PUT_LINE('사원번호 : '||V_EID);
             DBMS_OUTPUT.PUT_LINE('사원명 : '||V_NAME);
             DBMS_OUTPUT.PUT_LINE('직책코드 : '||V_JID);
             DBMS_OUTPUT.PUT_LINE('입사일 : '||V_HDATE);
             DBMS_OUTPUT.PUT_LINE('------------------------------');           
          END;
          
  사용예) 회원테이블에서 직업이 '주부'인 회원들의 2020년 5월 구매현황을 조회하시오
         Alias는 회원번호,회원명,직업,구매금액합계
         
         SELECT A.MEM_ID AS 회원번호, 
                A.MEM_NAME AS 회원명, 
                A.MEM_JOB AS 직업, 
                D.BSUM AS 구매금액합계
           FROM (SELECT MEM_ID, MEM_NAME, MEM_JOB
                   FROM MEMBER
                  WHERE MEM_JOB='주부') A, --회원테이블에서 직업이 '주부'인 회원들
                (SELECT B.CART_MEMBER AS BMID, 
                        SUM(B.CART_QTY*C.PROD_PRICE) AS BSUM
                   FROM CART B, PROD C
                  WHERE B.CART_PROD=C.PROD_ID
                    AND B.CART_NO LIKE '202005%'
                  GROUP BY B.CART_MEMBER) D
          WHERE A.MEM_ID=D.BMID;
          
          (익명 블록)
          DECLARE
            --출력되어야하는 변수들이 무조건 나와야한다
            V_MID MEMBER.MEM_ID%TYPE; --MEMBER.MEM_ID타입으로 V_MID를 선언해주는 것이다.
            V_NAME VARCHAR2(100);
            V_JOB MEMBER.MEM_JOB%TYPE;
            V_SUM NUMBER:=0; -- NUMBER를 쓰면 27자리까지 알아서 잡아준다,초기화시켜주기
            CURSOR CUR_MEM IS --셀렉트문이 사용되어지는 커서는 인투절을 안 써준다
              SELECT MEM_ID, MEM_NAME, MEM_JOB
                FROM MEMBER
               WHERE MEM_JOB='주부';
          BEGIN
            OPEN CUR_MEM;
            LOOP
              FETCH CUR_MEM INTO V_MID, V_NAME, V_JOB; --FETCH는 한 줄씩 읽어서 각자의 변수에 한 개씩 저장하라는 명령
              EXIT WHEN CUR_MEM%NOTFOUND;
              SELECT SUM(A.CART_QTY*B.PROD_PRICE) INTO V_SUM --서브쿼리 아니라서 반드시 인투절을 써줘야한다.
                FROM CART A, PROD B
               WHERE A.CART_PROD=B.PROD_ID
                 AND A.CART_NO LIKE '202005%'
                 AND A.CART_MEMBER=V_MID;
                DBMS_OUTPUT.PUT_LINE('회원번호 : '||V_MID);  
                DBMS_OUTPUT.PUT_LINE('회원명 : '||V_NAME);
                DBMS_OUTPUT.PUT_LINE('직업 : '||V_JOB);
                DBMS_OUTPUT.PUT_LINE('구매금액 : '||V_SUM);
                DBMS_OUTPUT.PUT_LINE('-----------------------------');
            END LOOP;
            CLOSE CUR_MEM; --열어놓은 커서를 닫아준다. 커서는 방이라고 생각한다.
            --커서는 여러줄의 결과가 나왔을 때 그 결과에 들어있는 값들을 변수에 넣어주어야하는데, 한번에 여러개의 데이터를 하나의 변수가 감당할 수 없기때문에
            --한줄씩 한줄씩 꺼내서 읽기 위해서 커서를 만드는 것이다.
          END;
          
          
          
          
    사용예)년도를 입력 받아 윤년인지 평년인지 구별하는 블록을 작성하시오.
        
    ACCEPT P_YEAR PROMPT '년도입력 : '    
    DECLARE
        V_YEAR NUMBER:=TO_NUMBER('&P_YEAR');--아예 변수를 선언하면서 입력받은 년도를 숫자로 변환해서 V_YEAR에 값을 넣어주었다.
        V_RES VARCHAR2(200);
    BEGIN
        IF (MOD(V_YEAR,4)=0 AND MOD(V_YEAR,100)!=0) OR (MOD(V_YEAR,400)=0) THEN
           V_RES:=V_YEAR||'년은 윤년입니다';
        ELSE
           V_RES:=V_YEAR||'년은 평년입니다';
        END IF;
        
        DBMS_OUTPUT.PUT_LINE(V_RES);
    END;
    
    사용예)반지름을 입력받아 원의 넓이와 원주의 길이를 구하시오.
          원의 넓이 : 반지름 * 반지름 * 원주율(3.14155926)
          원둘레 : 지름 * 3.1415926
          
          ACCEPT P_RADIUS PROMPT '반지름 : '  
          DECLARE
             V_RADIUS NUMBER:=TO_NUMBER('&P_RADIUS');
             V_AREA VARCHAR2(200);
             V_ROUND VARCHAR2(200);
             V_PIE CONSTANT NUMBER:=3.1415926;
          BEGIN
               V_AREA:=V_RADIUS*V_RADIUS*V_PIE;
               V_ROUND:=(V_RADIUS+V_RADIUS)*V_PIE;        
               
               DBMS_OUTPUT.PUT_LINE('원의 넓이 : '||V_AREA);
               DBMS_OUTPUT.PUT_LINE('원의 둘레 : '||V_ROUND);
          END;
           
 
  