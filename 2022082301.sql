학습목표

1.집계함수 : 그룹별로 묶어서 의미있는 결과를 도출.

2.sum() : 합계
  avg() 평균
  max() 최대값
  min() 최소값
  count() 개수
   
--상품테이블의 상품분류별 매입가격 평균 값

--BY : ~ 별
--GROUP : 묶음
-- ASCENDING : 오름차순(생략가능) / DESCENDING : 내림차순

  SELECT PROD_LGU,
         ROUND(AVG(PROD_COST),2) PROD_COST
    FROM PROD
    GROUP BY PROD_LGU
    ORDER BY PROD_LGU ; 
       
       
--상품분류별 구매가격 평균    
    SELECT PROD_LGU 상품분류
           , ROUND(AVG(PROD_SALE),2) 구매가격평균
      FROM  PROD
  GROUP BY PROD_LGU
  ORDER BY PROD_LGU;
  
  
---------------------------------------------
  
   SELECT PROD_LGU,
          PROD_BUYER,
          ROUND(AVG(PROD_COST),2) PROD_COST,
          SUM(PROD_COST),
          MAX(PROD_COST),
          MIN(PROD_COST),
          COUNT(PROD_COST)
     FROM PROD
 GROUP BY PROD_LGU, PROD_BUYER --소그룹으로 묶었다는 의미(P101/P10101)
 ORDER BY 1,2;
    
--P.282 상품테이블(PROD)의 총 판매가격(PROD_SALE) 평균 값을 구하시오 ? (Alias는 상품총판매가평균) 
ALLAS 허용 BYTES는 30바이트까지 쓸 수 있다.
    
 SELECT ROUND(AVG(PROD_SALE),2) AS 상품총판매가평균
   FROM PROD;
    
 
--P.282 상품테이블의 상품분류(PROD_LGU)별 판매가격(PROD_SALE) 평균 값을 구하시오 ? (Alias는 상품분류(PROD_LGU), 상품분류별판매가격평균) 

    SELECT PROD_LGU AS 상품분류,
           TO_CHAR(ROUND(AVG(PROD_SALE),2),'L9,999,999.00') AS 상품분류별판매가평균
      FROM PROD
  GROUP BY PROD_LGU;
  
  
----P.283
--거래처테이블(BUYER)의 
--담당자(BUYER_CHARGER)를 컬럼으로 하여 
--COUNT집계 하시오 ? 
--( Alias는 자료수(DISTINCT), 
--  자료수, 자료수(*) )  --null값은 카운트에 안 세어진다.
--기본키(대표성,짧아야함,자주사용) <-후보키
--후보키 조건 : 1)Not Null, 2)No Duplicate
--*로 세는 것은 행으로 센다.

--행의 수 : 카디널리티
--열의 수 : 차수(DEGREE)
SELECT COUNT(*), --74
       COUNT(PROD_COLOR)--41
  FROM PROD;

SELECT COUNT(DISTINCT BUYER_CHARGER) AS "자료수 (DISTINCT)",
       COUNT(BUYER_CHARGER) AS 자료수,
       COUNT(*) AS "자료수(*)"
  FROM BUYER;
  
특수기호는 단 #_$ 스페이스바 안되고 괄호도 안된다
테이블명,컬럼명,Alias명
  
--p.283 회원테이블(MEMBER)의 취미(MEM_LIKE)별 COUNT집계 하시오?
  SELECT MEM_LIKE AS 취미, 
         COUNT(MEM_ID) AS 자료수, 
         COUNT(*) AS "자료수(*)"
    FROM MEMBER
GROUP BY MEM_LIKE;


--P.284
--장바구니테이블의 회원별 최대구매수량을 검색하시오?
--ALIAS : 회원ID, 최대수량, 최소수량

SELECT CART_MEMBER AS 회원,
       MAX(CART_QTY) AS 최대수량,
       MIN(CART_QTY) AS 최소수량
  FROM CART
GROUP BY CART_MEMBER
ORDER BY CART_MEMBER;


--오늘이 2020년도7월11일이라 가정하고 
--장바구니테이블(CART)에 발생될 추가주문번호(CART_NO)를 검색 하시오 ? 
--( Alias는 최고치주문번호MAX(CART_NO), 
--추가주문번호MAX(CART_NO)+1 )
--LIKE와 함께 쓰인 %,_를 와일드카드
-- % : 여러 글자 / _ : 한 글자

SELECT MAX(CART_NO)AS 최고치주문번호,
       MAX(CART_NO)+1 AS 추가주문번호
FROM CART
WHERE SUBSTR(CART_NO,1,8) = '20200711'
  AND CART_NO LIKE '20200711%';

<외우는 법>
검색해주   세여
Select..from...where

업데이트..쎄...대여
update...set..where

등푸른생선.....주세요
delete..from..where

GROUP BY HAVING
ORDER BY은 꼭 마지막에 쓴다


--285
--상품테이블에서 상품분류, 거래처별로
--최고판매가, 최소판매가, 자료수를 검색하시오?

SELECT MAX AS 최고판매가,
       MIN AS 최소판매가, 
       COUNT() AS 자료수
FROM PROD
GROUP BY 상품분류, 거래처