2022-0824-01) 집계함수
집계합수는 중복해서 사용할 수 없다. 일반함수는 집계함수랑 쓸 수 있고
집계 안에 일반함수가 들어오는 것은 사용할 수는 있다.


사용예) 장바구니테이블에서 2020년 5월 제품별 판매집계를 조회하시오.
       Alias는 제품코드, 판매건수, 판매수량, 금액
       --직원수를 세어보라고 했을 때 부서별로 보여서 거기서 줄 수를 세면 한 부서당의 사원수가 된다.
      
       SELECT A.CART_PROD AS 제품코드, 
              COUNT(*) AS 판매건수, 
              SUM(A.CART_QTY) AS 판매수량, 
              SUM(A.CART_QTY*PROD_PRICE) AS 금액
         FROM CART A, PROD B
        WHERE A.CART_NO LIKE '202005%' 
          AND A.CART_PROD=B.PROD_ID
     GROUP BY A.CART_PROD
     ORDER BY 1;
       
사용예) 장바구니테이블에서 2020년 5월 회원별 판매집계를 조회하시오.
       Alias는 회원번호, 구매수량, 구매금액
       
     SELECT A.CART_MEMBER AS 회원번호, 
            SUM(A.CART_QTY) AS 구매수량, 
            SUM(CART_QTY*PROD_PRICE) AS 구매금액
       FROM CART A, PROD B
      WHERE A.CART_NO LIKE '202005%'
        AND A.CART_PROD = B.PROD_ID
   GROUP BY A.CART_MEMBER
   ORDER BY 1;


사용예) 장바구니테이블에서 2020년 월별, 회원별 판매집계를 조회하시오.
       Alias는 월, 회원번호, 구매수량, 구매금액
       
     SELECT A.CART_MEMBER AS 회원번호, 
            SUM(A.CART_QTY) AS 구매수량, 
            SUM(CART_QTY*PROD_PRICE) AS 구매금액,
            SUBSTR(CART_NO,5,2) AS 월 --글자 빼내기
       FROM CART A, PROD B
      WHERE A.CART_NO LIKE '2020%' --SUBSTR(A.CART_NO,1,4)='2020'
        AND A.CART_PROD = B.PROD_ID --조인 조건
   GROUP BY SUBSTR(CART_NO,5,2), A.CART_MEMBER
   ORDER BY 1;--SELECT에서 집계함수가 아닌 것은 무조건 GROUPT BY절에 붙여넣기해준다.

       
사용예) 장바구니테이블에서 2020년 5월 제품별 판매집계를 조회하되 
      판매금액이 100만원 이상인 자료만 조회하시오.
       Alias는 제품코드, 판매수량, 금액
       
     SELECT CART_PROD AS 제품코드, 
            SUM(A.CART_QTY) AS 판매수량, 
            SUM(A.CART_QTY*PROD_PRICE) AS 판매금액
       FROM CART A, PROD B     
      WHERE A.CART_NO LIKE '202005%'
      AND A.CART_PROD=B.PROD_ID
   GROUP BY A.CART_PROD
     HAVING SUM(A.CART_QTY*B.PROD_PRICE)>=1000000 --그룹함수 자체에 조건이 주어질 때
   ORDER BY 1;
       
       
사용예) 2020년 상반기(1-6월) 기준 가장 많이 매입된 상품 1개를 조회하시오
      Alias는 상품코드BUY_PROD, 매입수량BUY_QTY, 매입금액BUY_COST
      
     (1) 2020년 상반기(1-6월) 제품매입액(BUYPROD에 있는 걸로 써서 테이블 1개만 있어도 됨)
  
     SELECT BUY_PROD AS 제품코드,
            SUM(BUY_QTY) AS 매입수량합계,
            SUM(BUY_COST*BUY_QTY) 매입액
       FROM BUYPROD
      WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630')
   GROUP BY BUY_PROD
   ORDER BY 3 DESC;
-- Pseudo (오라클에서 제공해주는 넘버링 컬럼 컬럼명 : ROWNUM)


문제] 사원테이블에서 부서별 평균급여를 조회하시오.

    SELECT DEPARTMENT_ID AS 부서,
           ROUND(AVG(SALARY)) AS 평균급여
      FROM HR.EMPLOYEES
  GROUP BY DEPARTMENT_ID
  ORDER BY 1;
     

문제] 사원테이블에서 부서별 가장 먼저 입사한 사원의 사원번호,
사원명,부서번호,입사일을 출력하시오.

  SELECT B.EMPLOYEE_ID AS 사원번호,
         B.EMP_NAME AS 사원명,
         A.DEPARTMENT_ID AS 부서번호,
         A.HDATE AS 입사일
    FROM (SELECT DEPARTMENT_ID,
    
    HR.EMPLOYEES
  ORDER BY 4 ASC;



 SELECT --EMPLOYEE_ID AS 사원번호,
       -- EMP_NAME AS 사원명,
         DEPARTMENT_ID AS 부서번호,
         MIN(HIRE_DATE) AS 입사일
    FROM HR.EMPLOYEES
GROUP BY EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID;


문제] 사원들의 평균급여보다 더 많이 받는 사원의 사원번호, 사원명, 
부서번호, 급여를 출력
  SELECT A.EMPLOYEE_ID AS 사원번호, 
         A.EMP_NAME AS 사원명, 
         A.DEPARTMENT_ID AS 부서번호, 
         A.SALARY AS 급여
    FROM HR.EMPLOYEES A 
    WHERE A.SALARY > (SELECT AVG(SALARY)
                        FROM HR.EMPLOYEES) --비교대상에 비교값으로 사용한다
    ORDER BY 4 DESC;


    
문제] 회원테이블에서 남녀회원별 마일리지 합계와 평균 마일리지를 조회하시오
     Alias는 구분,마일리지합계,평균마일리지
     
     1) 남자회원인지 여자회원인지 먼저 알아야한다(그룹의 조건)
     
     SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN 
                      '남성회원' 
                 ELSE  
                      '여성회원'
            END AS 구분,
            COUNT(*) AS 회원수,
            SUM(MEM_MILEAGE) AS 마일리지합계,
            ROUND(AVG(MEM_MILEAGE)) AS 평균마일리지
       FROM MEMBER
   GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN 
                      '남성회원' 
                ELSE  
                      '여성회원'
                END;
     
     
     
      
      
      