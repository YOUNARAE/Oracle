2022-0826-03) 순위 함수
- 특정 컬럼의 값을 기준으로 순위(등수)를 부여할 때 사용
- RANK(), DENSE_RANK(), ROW_NUMBER() 등이 제공됨
1)  RANK()
- 일반적인 순위함수
- 같은 값이면 같은 순위를 부여하고 다음 순위는 ‘현 순위 + 동일 순위 개수’로 부여
Ex) 1, 1, 3, 4, 5, 6, 7, 7, 7, 10…
(사용형식)
RANK() OVER(ORDER BY 컬럼명1 [DESC|ASC][,컬럼명2 [DESC|ASC],…])
- SELECT  문의 SELECT 절에 사용

사용예)
    회원테이블에서 회원번호, 회원명, 마일리지, 순위를 조회하시오.
    순위는 마일리지가 많은 회원부터 부여하고 같은 마일리지이면 같은 순위를 부여하시오.
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           MEM_MILEAGE AS 마일리지,
           EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR) AS 나이,
--         RANK() OVER(ORDER BY MEM_MILEAGE DESC) AS 순위
           RANK() OVER(ORDER BY MEM_MILEAGE, 
           (EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR)) DESC) AS 순위       
      FROM MEMBER;
    
    


2) DENSE_RANK()
  . 순위를 구하는 기능은 RANK()와 동일
  . 동일 순위가 복수개 발생하더라도 다음 순위는 현재순위 바로 다음 순위로 부여
    ex) 1,1,2,3,4,5,6,7,7,7,8,9,...

   (사용형식)
   DENSE_RANK() OVER(ORDER BY 컬럼명1 [DESC|ASC][,컬럼명2 [DESC|ASC],...])
   - SELECT 문의 SELECT절에 사용
   
       회원테이블에서 회원번호, 회원명, 마일리지, 순위를 조회하시오.
    순위는 마일리지가 많은 회원부터 부여하고 같은 마일리지이면 같은 순위를 부여하시오.
    SELECT MEM_ID  AS 회원번호,
           MEM_NAME AS 회원명,
           MEM_MILEAGE AS 마일리지,
           EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR) AS 나이,
           DENSE_RANK() OVER(ORDER BY MEM_MILEAGE DESC) AS 순위 
      --DENSE_RANK는 똑같이 순위를 부여하는데, 1순위는 똑같은데 차순위를 다르게 부여한다.
      -- 동점자 만큼 건너뛰지 않고 바로 나오는 게 DENSE_RANK이고 RANK는 동점자 수만큼 숫자가 건너뛰어진다
      -- RANK() OVER(ORDER BY MEM_MILEAGE DESC, MEM_ID) AS. 순위,
      -- RANK() OVER(ORDER BY MEM_MILEAGFE DESC, 
      --(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR) DESC) AS 순위
    FROM MEMBER;
    
    3) ROW_MEMBER()
    . 순위를 부여하는 함수
    . 동점자도 행위 순번에 따라 순위를 보여
    ex) 90,90,85,84,80,78,78,78,75
    순위  1  2  3  4  5  6  7  8  9
   
  (사용형식)
   ROW_NUMBER() OVER(ORDER BY 컬럼명1 [DESC|ASC][,컬럼명2 [DESC|ASC],...])
    - SELECT 문의 SELECT절에 사용
    
   SELECT MEM_ID  AS 회원번호,
          MEM_NAME AS 회원명,
          MEM_MILEAGE AS 마일리지,
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR) AS 나이,
          ROW_NUMBER() OVER(ORDER BY MEM_MILEAGE DESC) AS 순위 
      -- 순위대로 마지막번호까지 쭈욱 붙여나가는 것이 ROW_NUMBER이다. 
      -- RANK() OVER(ORDER BY MEM_MILEAGE DESC, MEM_ID) AS. 순위,
      -- RANK() OVER(ORDER BY MEM_MILEAGFE DESC, 
      --(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR) DESC) AS 순위
    FROM MEMBER;
    
    
    4)그룹별 순위
     . 자료를 그룹으로 분류하고 각 그룹내에서 특정 컬럼의 값을 기준으로 순위를 보여
     . PARTITION BY 예약어로 그룹을 구성함

    (사용형식)
     RANK() OVER(PARTITION BY 컬럼명p1[,컬럼명p2,...] ORDER BY 컬럼명b1 [DESC|ASC] [,
                 컬럼명b2 [DESC|ASC],...]) 
     - SELECT문의 SELECT절에 사용 
     
  사용예)사원테이블에서 부서별로 급여에 따른 순위를 부여하시오
        Alias는 사원번호, 사원명, 부서번호, 급여, 순위이며 순위는 급여가 많은 사람순으로 
        부여하시오. 같은 급여는 동일 순위 부여할 것 
        
        SELECT EMPLOYEE_ID AS 사원번호,
               EMP_NAME AS 사원명, 
               DEPARTMENT_ID AS 부서번호,
               SALARY AS 급여, 
               RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS 순위 --(PARTITION BY는 GROUP BY와 같다)
          FROM HR.EMPLOYEES;
        
    
    
    
   
   
   
   
   