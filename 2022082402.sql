2022-0824-02) ROLLUP과 CUBE
  - 다양한 집계결과를 얻기 위해 사용
  - 반드시 GROUP BY 절에 사용되어야 함
   
  1) ROLLUP
    . LEVEL별 집계 결과를 반환
    
  (사용형식)
  GROUP BY [컬럼,]ROLLUP(컬럼명1 [,컬럼명2,...,컬럼명n])[,컬럼]
   - 컬럼명1부터 컬럼명n을 기준컬럼으로 집계 출력 후 오른쪽부터 컬럼을 하나씩
     제거한 기준으로 집계를 반환, n+1개가 된다.
   - 제일 마지막은 전체집계(모든 컬럼명을 제거한 집계결과) 반환
   - ROLLUP 앞 또는 뒤에 컬럼이 올 수 있음 => 부분 ROLLUP이라함

사용예) 2020년 4-7월 월별,회원별,상품별 구매수량합계를 조회하시오.
      (ROLLUP을 사용전)
       SELECT SUBSTR(CART_NO,5,2) AS 월,
              CART_MEMBER AS 회원번호,
              CART_PROD AS 상품코드,
              SUM(CART_QTY) AS 구매수량합계
         FROM CART
        WHERE SUBSTR(CART_NO,1,6) BETWEEN '202004' AND '202007'
     GROUP BY SUBSTR(CART_NO,5,2), CART_MEMBER, CART_PROD
     ORDER BY 1;
              
              
       (ROLLUP사용)
       SELECT SUBSTR(CART_NO,5,2) AS 월,
              CART_MEMBER AS 회원번호,
              CART_PROD AS 상품코드,
              SUM(CART_QTY) AS 구매수량합계
         FROM CART
        WHERE SUBSTR(CART_NO,1,6) BETWEEN '202004' AND '202007'
     GROUP BY ROLLUP(SUBSTR(CART_NO,5,2), CART_MEMBER, CART_PROD)
     ORDER BY 1;
              

   (CUBE 사용)
    SELECT SUBSTR(CART_NO,5,2) AS 월,
              CART_MEMBER AS 회원번호,
              CART_PROD AS 상품코드,
              SUM(CART_QTY) AS 구매수량합계
         FROM CART
        WHERE SUBSTR(CART_NO,1,6) BETWEEN '202004' AND '202007'
     GROUP BY CUBE(SUBSTR(CART_NO,5,2), CART_MEMBER, CART_PROD)
     ORDER BY 1;

 (부분큐브)
      SELECT SUBSTR(CART_NO,5,2) AS 월,
              CART_MEMBER AS 회원번호,
              CART_PROD AS 상품코드,
              SUM(CART_QTY) AS 구매수량합계
         FROM CART
        WHERE SUBSTR(CART_NO,1,6) BETWEEN '202004' AND '202007'
     GROUP BY SUBSTR(CART_NO,5,2), CUBE(CART_MEMBER, CART_PROD) --뒤에 값들이 기준값이 되어준다
     ORDER BY 1;





사용예) 상품테이블에서  상품의 분류별, 거래처별 상품의 수(COUNT)를 조회하시오
       
       (GROUP BY절만 사용하는 경우)
       SELECT PROD_LGU AS "상품의 분류",
              PROD_BUYER AS "거래처 코드",
              COUNT(*) AS "상품의 수"
         FROM PROD
     GROUP BY PROD_LGU, PROD_BUYER
     --그룹바이절은 왼쪽부터 순서대로 대분류-중분류-소분류 
     ORDER BY 1;
     
     (ROLLUP을 사용하는 경우)
      SELECT PROD_LGU AS "상품의 분류",
              PROD_BUYER AS "거래처 코드",
              COUNT(*) AS "상품의 수"
         FROM PROD
     GROUP BY ROLLUP(PROD_LGU, PROD_BUYER)
     ORDER BY 1;
       
       
       
    (부분 ROLLUP)
       SELECT PROD_LGU AS "상품의 분류",
              PROD_BUYER AS "거래처 코드",
              COUNT(*) AS "상품의 수"
         FROM PROD
     GROUP BY PROD_LGU, ROLLUP(PROD_BUYER)
     ORDER BY 1;
       
       
       
2) CUBE
  . GROUP BY 절 안에 사용되어 CUBE 내부에 기술된 컬럼의 조합 가능한 모든 집계를 반환
  . CUBE  내부에 기술된 컬럼의 갯수가 n개일 때 2의 n승 가지만큼의 집계종류를 반환
  
  
--롤업은 기술되어진 레벨별로 집계를 반환하는 반면에 큐브는 레벨이 사용되지 않는다.
--큐브는 괄호 안의 컬럼의 갯수만큼 모든 경우의 수만큼 집계를 반환한다.
--ex)괄호 안의 갯수가 3개 -> 롤업 4가지
--                        큐브 8가지

  .



       
       
       
       