2022-0819-01)
3. 날짜함수
  1) SYSDATE - ****
   - 시스템이 제공하는 날씨 및 시간 정보 제공
   - 덧셈과 뺄셈, ROUND, TRUNC 함수의 연산 대상이 됨 --년월일만 취하고 싶으면 TRUNC 시분초(소숫점으로인식)는 버려진다,
   - 기본 출력 타입은 '년/월/일'이고 '시분초'를 출력하기 위해서는 TO_CHAR 함수 사용--*날짜에는 LIKE,SUBSTR같은 함수를 쓰면 안된다
   
  2) ADD_MONTHS(d, n) - **
   - 주어진 날짜 d에 n 만큼의 월을 더한 날짜 반환--(반환타입:날짜)
   - 기간이 정해진 날짜가 필요한 경우 많이 사용
   
사용예)오늘 어느 단체의 2개월 유료회원으로 등록한 경우 다음 등록일자를 
      조회하시오. 
      
      SELECT ADD_MONTHS(SYSDATE,2)-1 FROM DUAL;
      
3) NEXT_MONTHS(d, c) - *
  - 주어진 날짜 d 이후 c요일에 해당하는 날짜 반환
  - c는 '월','월요일','화',...'일요일' 사용

사용예) 
   SELECT NEXT_DAY(SYSDATE,'금'),
          NEXT_DAY(SYSDATE,'토요일')--오늘 이후의 처음 만나는 토요일
     --   NEXT_DAY(SYSDATE,'FRIDAY')
     FROM DUAL;
     
     
4) LAST_DAY(d) - ***
  - 주어진 날짜 데이터의 월의 마지막일을 반환
  - 주로 2월의 마지막일을 반환 받는 곳에 사용됨 --윤년인지 평년인지 구분지어야하기 위해서 반드시 필요함. 달마다 마지막일이 다르기 때문에.
  

사용예)매입테이블에서 2020년 2월 제품별 매입집계를 구하시오.
      Alias 제품코드, 제품명, 매입량합계, 매입금액합계 --집계함수가 필요함.
      
  SELECT A.BUY_PROD AS 제품코드,  
         B.PROD_NAME AS 제품명, 
         COUNT(*) AS 매입횟수,
         SUM(A.BUY_QTY) AS 매입량합계, 
         SUM(A.BUY_QTY*B.PROD_COST) AS 매입금액합계
    FROM BUYPROD A, PROD B 
   WHERE A.BUY_PROD=B.PROD_ID 
     AND A.BUY_DATE BETWEEN TO_DATE('20200201') AND LAST_DAY(TO_DATE('20200201'))
GROUP BY A.BUY_PROD, B.PROD_NAME
  ORDER BY 1;
  
  
  
5) EXTRACT(fmt FROM d) - **** --추출하다 data를
  - 주어진 날짜 데이터 d에서 'fmt'로 설정한 요소 값을 반환
  - 'fmt'는 YEAR,MONTH,DAY,HOUR,MINUTE,SECOND 중 하나
  --ex)이번달이 생일인사람 -> 월만 필요하다, 나이를 알아낼 때 ->년만 필요하다
  - 반환데이터 타입은 숫자형 
  
  
**사원테이블의 자료 중 입사일을 10년이 경과된 일자로 변경하시오
  UPDATE HR.EMPLOYEES
     SET HIRE_DATE=ADD_MONTHS(HIRE_DATE,120);
     
     
  COMMIT;
  
  
  
  
사용예)사원테이블에서 50번부서 직원 중 근속년수가 17년 이상인 직원을 조회하시오
      Alias는 사원번호,사원명,직책,입사일,근속년수이며 근속년수가 많은 사원부터 출력
      
      SELECT EMPLOYEE_ID AS 사원번호,
             EMP_NAME AS 사원명,
             JOB_ID AS 직책,
             HIRE_DATE AS 입사일, --년월일로 구성된 날짜 타입
             EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM HIRE_DATE) AS 근속년수 --주어진 자료에서 연도를 반환받아야한다. 지금년도(YEAR FROM SYSDATE)
        FROM HR.EMPLOYEES
       WHERE DEPARTMENT_ID = 50
         AND EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM HIRE_DATE)>=7
    ORDER BY 4;
    
    
        
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
     
     
     
  
      
      
   