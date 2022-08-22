2022-0822-01)형변환 함수
 - 오라클의 데이터 형변환 함수는 TO_CHAR, TO_DATE, TO_NUMBER, CAST 함수가 제공됨
 - 형의 변환은 해당 함수가 사용된 곳에 일시적 변환
 
 1)CAST(expr AS type) - *
   . expr로 제공되는 데이터(수식, 함수 등)를 'type' 형태로 변환하여 반환 함
   
사용예) 
  SELECT BUYER_ID AS 거래처코드, 
         BUYER_NAME AS 거래처명1,
         CAST(BUYER_NAME AS CHAR(30)) AS 거래처명2,
         BUYER_CHARGER AS 담당자
    FROM BUYER;
    
    
        --CAST(BUY_DATE AS NUMBER)CAST연산을 썼다고 해서 모든 것(날짜를->숫자로)을 다 바꿀 수 있는 것은 아니다. 
  SELECT  CAST(TO_CHAR(BUY_DATE,'YYYYMMDD') AS NUMBER) --BUY_DATE를 /를 생략시켜서 붙여서 문자열로 변환한 걸 AS 숫자로 변환하세요
    FROM  BUYPROD
   WHERE  BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131');
 
 
 2)TO_CHAR(d [,fmt]) - ***** --[fmt]는 삭제가능
   . 변환함수 중 가장널리 사용
   . 숫자,날짜,문자 타입을 문자타입으로 변환
   . 문자타입을 CHAR, CLOB를 VARCHAR2로 변환할 때만 사용 가능
   . 'fmt'는 형식문자열로 크게 날짜형과 숫자형으로 구분 됨
   
------------------------------------------------------------------------------------------------------------------
 FORMAT 문자        의미                   사용예
------------------------------------------------------------------------------------------------------------------
 CC                세기                   SELECT TO_CHAR(SYSDATE, 'CC')||'세기' FROM DUAL;
 AD, BC            기원전, 기원후           SELECT TO_CHAR(SYSDATE, 'CC BC')||EXTRACT(YEAR FROM SYSDATE) FROM DUAL;
 YYYY,YYY,YY,Y     년도                   SELECT TO_CHAR(SYSDATE, 'YYYY') FROM DUAL;
 YEAR              년도를 알파벳으로        SELECT TO_CHAR(SYSDATE, 'YYYY YEAR') FROM DUAL;
 Q                 분기                   SELECT TO_CHAR(SYSDATE, 'Q') FROM DUAL;
 MM,RM             월                    SELECT TO_CHAR(SYSDATE, 'YYYY-MM') FROM DUAL;
 MONTH,MON         월                    SELECT TO_CHAR(SYSDATE, 'YYYY-MONTH') FROM DUAL;
                                         SELECT TO_CHAR(SYSDATE, 'YYYY-MON') FROM DUAL;
 WW,W              주                    SELECT TO_CHAR(SYSDATE, 'YYYY-MM WW') FROM DUAL;
                                         SELECT TO_CHAR(SYSDATE, 'YYYY-MM W') FROM DUAL;
 DDD,DD,D          일                    SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DDD') FROM DUAL;--2022년에서 234일째 된 날이다.
                                         SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL;--이번달의 22일째 되는 날이다.
                                         SELECT TO_CHAR(SYSDATE, 'YYYY-MM-D') FROM DUAL;--일요일1,월요일2
 DAY, DY           요일                   SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL;
                                         SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DY') FROM DUAL;
 AM,PM,A.M.,P.M.   오전/오후              SELECT TO_CHAR(SYSDATE, 'AM YYYY-MM-DD DY') FROM DUAL;--현재시간이 오후이면 AM을 써도 오후로 나온다
 HH,HH12,HH24      시각                  SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH ') FROM DUAL;
                                         SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24 ') FROM DUAL;
 MI                분                    SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI') FROM DUAL;
 SS,SSSSS          초                    SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS SSSSS') FROM DUAL; --ssss는 오늘 새벽부터 경과된 시간을 초를 환산하고 싶을 때
------------------------------------------------------------------------------------------------------------------
 
 
 
 
 **숫자형 형식문자
------------------------------------------------------------------------------------------------------------------------------------------
 FORMAT 문자        의미                   사용예
------------------------------------------------------------------------------------------------------------------------------------------
 9,0               숫자자료출력             SELECT TO_CHAR(12345.56, '9,999,999.9'), --자릿수 소숫점 두자리가 들어왔을 땐 두번째자리에서 반올림이 발생
                                                 TO_CHAR(12345.56, '0,000,000.0') FROM DUAL; --더이상 숫자가 아니고 문자열이라서 연산이 불가능하다
 ,(COMMA),         3자리마다 자리점(,)
 .(DOT)            소숫점
 $,L               화폐기호                SELECT TO_CHAR(PROD_PRICE, 'L9,999,999')
                                            FROM PROD;
                                          SELECT TO_CHAR(SALARY,'$999,999') AS 급여1,--숫자처럼 오른쪽 정렬을 했다고 해서 숫자가 아니라 문자열이라서 100을 더하는 등의 연산은 불가능하다
                                                 TO_CHAR(SALARY) AS 급여2
                                            FROM HR.EMPLOYEES;
                                            
 PR                음수자료를 '<>'안에 출력   SELECT TO_CHAR(-2500,'99,999PR') FROM DUAL; --PR은 꼭 형식지정 글자 오른쪽 끝에 쓴다
                                           
 MI          음수자료 출력시 오른쪽에 '-'출력   SELECT TO_CHAR(-2500,'99,999MI') FROM DUAL;
                    
                   
 " "            사용자가 직접 정의하는 문자열   SELECT TO_CHAR(SYSDATE,'YYYY"년" MM"월" DD"일"')
                                             FROM DUAL;
                                             
--컬럼에 별칭에 공백이 들어갈 때 " "으로 넣어준다
--다른 사용자의 스키마를 기술할 때 " "으로 묶어서 기술해준다
               
------------------------------------------------------------------------------------------------------------------------------------------ 

3) TO_DATE(c [,fmt]) - *** 
   . 주어진 문자열 자료 c를 날짜타입의 자료로 형변환 시킴.
   . c에 포함된 문자열 중 날짜자료로 변환될 수 없는 문자열이 포함된 경우
     'fmt'를 사용하여 기본 형식으로 변환할 수 있음
   . 'fmt'는 TO_CHAR함수의 '날짜형 형식문자'와 동일
   
   --문자열 자료만 날짜로 바꿀 수 있다, 숫자는 날짜자료로 절대 바뀌지 않습니다.
   
사용예)
   SELECT TO_DATE('20200504'),--가장 많이 쓰인다
          TO_DATE('20200504','YYYY-MM-DD'),--여기까지는 형변환에 무리가 없다. -와 /중에 /가 먼저다
          TO_DATE('2020년 08월 22일','YYYY"년" MM"월" DD"일"')--출력은 기본 날짜타입으로 출력된다
     FROM DUAL;
          
          

3) TO_NUMBER(c [,fmt]) - *** 
  . 주어진 문자열 자료 c를 숫자타입의 자료로 형변환 시킴.
  . c에 포함된 문자열 중 숫자자료로 변환될 수 없는 문자열이 포함된 경우
  . 'fmt'를 사용하여 기본 숫자 형식으로 변환할 수 있음
  . 'fmt'는 TO_CHAR함수의 '숫자형 형식문자'와 동일  
  -- *날짜는 숫자로 못 바뀐다
  
사용예) 
    SELECT TO_NUMBER('2345') / 7, --숫자로 나와서 연산이 가능하다
        -- TO_NUMBER('2,345','9,999')--fmt를 쓰고 싶다면 콤마를 써서 형식을 맞춰줘야한다.
           TO_NUMBER('2345.56'),
           TO_NUMBER('2,345','0,000'),
           TO_NUMBER('$2345','$9999'),
           TO_NUMBER('002,345','000,000'),
           TO_NUMBER('<2,345>','9,999PR')
      FROM DUAL;
      
    --데이터의 원본값을 찾을때 fmt형식을 찾아서 넣는다
      
      
      
      
      
      
      
      
      
      
      
  
  
  
          
   
  


 
 
 
 
 