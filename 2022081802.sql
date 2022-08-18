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
    
      
      
      
      
      
      
      

      