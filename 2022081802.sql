2022-0818-02)
2. 숫자함수
  - 제공되는 숫자함수로는 수학적 함수(ABS, SIGN, SQRT 등), GREATEST, ROUND, MOD,
   FLOOP; WIDTH_BUCKET 등이 있음
   
1)수학적 함수
  (1)ABS(n), SIGN(n), POWER(e, n), PQRT(N) - *
  - ABS : n의 절대값 반환
  - SIGN : n이 양수이면 i, 수이면 -1, 0이면 0을 반환
  - POWER : e의 n승 값(e의 n번 곱한 값)
  - SQRT  :n의 평방근
  

사용예) 
    SELECT ABS(10), ABS(-100), ABS(0), --ABS는 부호가 의미없다
           SIGN(-20000), SIGN(-0.0099), SIGN(0.00005), SIGN(500000), SIGN(500000), SIGN(0), 
           POWER(2,10),
           SQRT(3.3)
      FROM DUAL;
      
      


2)GREATEST(n1,n2[,...n]), LEAST(n1,n2[,...n])
  - 주어진 값 n1 ~ n 사이의 값 중 제일 큰 값(GREATEST), 제일작은 값(LEAST) 반환
  --최소값과 최대값을 구별해준다
  
  사용예)
    SELECT GREATEST('KOREA', 1000, '홍길동'),
           LEAST('ABC','ABD',200)
      FROM DUAL;
    
    
    SELECT ASCII('홍') FROM DUAL;  --첫 글자만 아스키코드로 바꾼다.ABC- 656668
    
    MAX와 GREATEST의 차이점
    MAX는 하나의 컬럼에 들어있는 것 중에 가장 큰 값을 찾는 것(열에서 가장 큰 거)
    행으로 나열된 것 중에 가장 큰 값을 찾는 것이 GREATEST.
    
    
사용예)회원테이블에서 마일리지가 1000미만인 회원을 찾아 1000으로 변경 출력하시오
      Alias는 회원번호,회원명,원본마일리지,변경된마일리지
      
      SELECT MEM_ID AS 회원번호,
             MEM_NAME AS 회원명,
             MEM_MILEAGE AS 원본마일리지,
             GREATEST(MEM_MILEAGE, 1000) AS 변경된마일리지
        FROM MEMBER;
        
        
3)ROUND(n [,l]), TRUNC(n [,l]) - ****
  - 주어진 자료 n에서 소숫점 이하 l+1자리에서 반올림하여 (ROUND) 또는 자리버림(TRUNC) 하여
  1자리까지 표현함
  - 1이 생략되면 0으로 간주됨
  - 1이 음수이면 소숫점 이상의 L자리에서 반올림 또는 자리 버림 수행
  
사용예)
  SELECT ROUND(12345.678945,3),
         ROUND(12345.678945),
         ROUND(12345.678945,-3)--마이너스가 되면 소숫점 이하는 그냥 다 잘려나감
    FROM DUAL;
    
  SELECT TRUNC(12345.678945,3),--4번째 자리에서 무조건 삭제
         TRUNC(12345.678945),--소숫점 이하에서 다 버려
         TRUNC(12345.678945,-3)--소숫점 앞에 3번쨰 자리부터 그냥 다 버려
    FROM DUAL;
    

사용예)HR계정의 사원테이블에서 사원들의 근속연수를 구하여 근속연수에 따른 근속 수당을 계산하시오
      근속수당=기본급(SALARY)*(근속년수/100)
      급여합계=기본급+근속수당
      세금=급여합계의 13%
      지급액=급여합계-세금이며 소수 2째자리에서 반올림하시오,
      Alias는 사원번호, 사원명, 입사일, 근속년수, 급여, 근속수당, 세금, 지급액
      
      
      --입사일, 근속년수, 급여, 근속수당, 세금, 지급액
      --근속년수--근속수당-급여합계-세금-지급액
      
     -- SELECT EMPLOYEE_ID AS 사원번호,
     --        FIRST_NAME||LAST_NAME AS 사원명,
     --        HIRE_DATE AS 입사일,
      --       TRUNC((SYSDATE-HIRE_DATE)/365) AS 근속년수,
      --       SALARY AS 급여,
      --       SALARY*(TRUNC((SYSDATE-HIRE_DATE)/365))/100 AS 근속수당,
       --      SALARY+(SALARY*(TRUNC((SYSDATE-HIRE_DATE)/365))/100) AS 세금

       -- FROM HR.EMPLOYEES;
       
      SELECT EMPLOYEE_ID AS 사원번호,
             EMP_NAME AS 사원명,
             HIRE_DATE AS 입사일,
             TRUNC((SYSDATE-HIRE_DATE)/365) AS 근속년수, --시간을 날짜로 변환하기때문에 소숫잠이하까지 나오기때문에 TRUNC로 잘라버린다
             SALARY AS 급여,
             ROUND(SALARY*(TRUNC((SYSDATE-HIRE_DATE)/365)/100),1) AS 근속수당,
             ROUND(SALARY+SALARY*(TRUNC((SYSDATE-HIRE_DATE)/365)/100),1) AS 급여합계,
             ROUND(((SALARY+SALARY*(TRUNC((SYSDATE-HIRE_DATE)/365)/100)*0.13)))*0.13 AS 세금,             
             ROUND(SALARY+SALARY*(TRUNC((SYSDATE-HIRE_DATE)/365)/100)-(SALARY+SALARY*(TRUNC((SYSDATE-HIRE_DATE)/365)/100)*0.13),1) AS 지급액 
             
        FROM HR.EMPLOYEES;
        
        
4) FLOOR(n), CEIL(n) - *
  - 보통 화폐에 관련된 데이터 처리에 사용
  - FLOOR : n과 같거나(n이 정수인 때) n보다 작은 정수 중 가장 큰 점수 --받을 때는
  - CEIL : n과 같거나(n이 정수인 때) n보다 큰 정수 중 가장 작은 정수 --줄때는
  
사용예)
    SELECT FLOOR(23.456), FLOOR(23), FLOOR(-23.456), -- -24가 -23보다 작아서 작은쪽으로 
           CEIL(23.456), CEIL(23), CEIL(-23.456)-- FLOOR랑 반대
      FROM DUAL;   
  

5) MOD(n,b), REMAINDER(n,b) - ***
  - 나머지를 반환
  - MOD : 일반적 나머지 반환
  - REMAINDER : 나머지의 크기가 b값의 절반보다 작으면 일반적 나머지를 반환하고, 
                 b값의 절반보다 크면 다음 몫을 되기위한 값에서 현재값(n)을 뺀값 반환
  - MOD와 REMAINDER는 내부 처리가 다름
    
   . MOD (n,b) : n - b * FLOOR(n/b)
   . REMAINDER(n,b) : n - b * ROUND(n/b)
   
 ex) MOD(23,7), REMAINDER(23,7) --나머지를 구할 때
     MOD(23,7) = 23 - 7 * FLOOR(23/7)
               = 23 - 7 * FLOOR(3.286)
               = 23 - 7 * 3
               = 2 
               
    REMAINDER(23,7) = 23 - 7 * ROUND(23/7)
                    = 23 - 7 * ROUND(3.286)
                    = 23 - 7 * 3;
                    = 2  --나머지가 7의 절반이 안되서
                    
    MOD(26,7), REMAINDER(26,7)
         MOD(26,7) = 26 - 7 * FLOOR(26/7)
                   = 26 - 7 * FLOOR(3.714)
                   = 26 - 7 * 3;
                   = 5
         
    REMAINDER(26,7) = 26 - 7 * ROUND(26/7)
                    = 26 - 7 * ROUND(3.714)--반올림
                    = 26 - 7 * 4;
                    = -2 
                    
                    


6) WIDTH_BUCKET(n, min, max, b)
  - 최소값 min에서 최대값 max 까지를 b개의 구간으로
    나누었을때 n이 어느 구간에 속하는지를 판단하여 구간의
    INDEX 값을 반환
  - n < min 인 경우 0을 반환하고 n >= 인 경우 b+1 값을 반환
  
  --WIDTH_BUCKET(9,10,39,3) 나눈 구간 하한 값 1구간 + 나눈 구간의 상한 값 2구간 = 5
  
  사용예)
    SELECT WIDTH_BUCKET(28,10,39,3),
           WIDTH_BUCKET(8,10,39,3),
           WIDTH_BUCKET(58,10,39,3),
           WIDTH_BUCKET(39,10,39,3),
           WIDTH_BUCKET(10,10,39,3)
    FROM DUAL;
    
  사용예) 회원테이블에서 회원들의 마일리지를 조회하여 1000-9000 사이를 3개의 구간으로 구분하고,
         회원번호, 회원명, 마일리지, 비고를 출력하되 비고에는
         마일리지가 많은 회원부터 '1등급 회원', '2등급 회원', '3등급 회원', '4등급 회원'을 출력하시오.
         
   SELECT MEM_ID AS 회원번호, 
          MEM_NAME AS 회원명, 
          MEM_MILEAGE AS 마일리지,
          4-WIDTH_BUCKET(MEM_MILEAGE,1000,9000,3)||'등급 회원' AS 비고
--        WIDTH_BUCKET(MEM_MILEAGE,9000,999,3)||'등급 회원' AS 비고 --각 구간마다 상한값은 포함이 안되기 때문에 1000이 아닌 999
     FROM MEMBER
    
     
  
                    
    

    
   
      
      
      
         
  
  
        
    
      
      
      
      
      
      
      

      