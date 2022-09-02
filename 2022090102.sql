2022-0901-02)집합연산자
 - SELECT문의 결과를 대상으로 집합연산 수행
 - UNION ALL, UNION, INTERSECT, MINUS 연산자 제공
 - 집합연산자로 연결되는 SELECT문의 각 SELECT절의 컬럼의 갯수와 데이터 타입이 일치해야함
 - ORDER BY절은 맨 마지막 SELECT문에만 사용 가능
 - BLOB, CLOB, BFILE 타입의 컬럼은 집합연산자를 사용할 수 없음
 - UNION, INTERSECT, MINUS연산자는 LONG타입형 컬럼에 사용할 수 없음
 - GROUPING SETS(col1,col2,...) => UNION ALL 개념이 포함된 형태
   ex) GROUPING SETS(col1,col2,col3)
   =>((GROUP BY Col1) UNION ALL (GROUP BY col2) UNION ALL (GROUP BY col3)) 

--ex) 1신문을 보는 집 UNION
--    2신문을 보는 집 UNION
--    1,2신문을 다 보는 집 UNION ALL
--UNION, UNION ALL(합집합) /중복을 허락해주는 것이 UNION ALL
--INTERSECT(교집합)
--MINUS(차집합) 

1)UNION ALL
  - 중복을 허용한 합집합의 결과를 반환

 사용예)회원테이블에서 직업이 주부인 회원과 마일리지가 3000이상인 모든 회원들의
       회원번호,회원명,직업,마일리지를 조회하시오.
       
       SELECT MEM_ID AS 회원번호,
              MEM_NAME AS 회원명,
              MEM_JOB AS 직업,
              MEM_MILEAGE AS 마일리지
         FROM MEMBER
        WHERE MEM_JOB='주부'
        
UNION ALL
        
       SELECT MEM_ID,  --2번째 셀렉트문은 별칭을 안 써줘도 된다, 갯수와 내용이 똑같은 값이나 타입을 가지고 있어야된다.
              MEM_NAME,
              MEM_JOB,
              TO_NUMBER(MEM_REGNO1) --반드시 연결되어진 컬럼타입은 같은 타입이어야한다
         FROM MEMBER
        WHERE MEM_MILEAGE >= 3000;  --3000점이 넘는 사람들은 마일리지에 MEM_REGNO1를 표현함
       
사용예)2020년 4,5,6,7월 구매를 가장 많은 회원들의 회원번호,회원명,구매금액합계를 
      조회하시오
      
WITH T1 AS --미리 결과에 이름을 붙여주는 것, VIEW와 비슷한 개념이다. 
     (SELECT '4월' AS MON,C.MEM_ID AS CID, C.MEM_NAME AS CNAME, D.TOT1 AS CTOT1
        FROM  (SELECT CART_MEMBER AS AMID,
                      SUM(A.CART_QTY*B.PROD_PRICE) AS TOT1
                 FROM CART A, PROD B
                WHERE A.CART_NO LIKE '202004%'
                  AND A.CART_PROD=B.PROD_ID --(!)
             GROUP BY A.CART_MEMBER
             ORDER BY 2 DESC) D, MEMBER C
             WHERE C.MEM_ID=D.AMID
             AND ROWNUM = 1 -- 안쪽 쿼리에 AND(!)에 넣으면 그냥 CART 제일 위에서 가장 윗 사람을 꺼내오기때문에 값이 틀리다.
             --ORDER BY가 먼저 적용된 후에 ROWNUM을 적용시켜야한다. 1등만 빼야하니까 마지막에 ROWNUM을 써야한다
    UNION ALL   
    SELECT '5월', C.MEM_ID, C.MEM_NAME, D.TOT1
        FROM  (SELECT CART_MEMBER AS AMID,
                      SUM(A.CART_QTY*B.PROD_PRICE) AS TOT1
                 FROM CART A, PROD B
                WHERE A.CART_NO LIKE '202005%'
                  AND A.CART_PROD=B.PROD_ID
             GROUP BY A.CART_MEMBER
             ORDER BY 2 DESC) D, MEMBER C
             WHERE C.MEM_ID=D.AMID
             AND ROWNUM = 1
     UNION ALL
     SELECT '6월', C.MEM_ID, C.MEM_NAME, D.TOT1
        FROM  (SELECT CART_MEMBER AS AMID,
                      SUM(A.CART_QTY*B.PROD_PRICE) AS TOT1
                 FROM CART A, PROD B
                WHERE A.CART_NO LIKE '202006%'
                  AND A.CART_PROD=B.PROD_ID
             GROUP BY A.CART_MEMBER
             ORDER BY 2 DESC) D, MEMBER C
             WHERE C.MEM_ID=D.AMID
             AND ROWNUM = 1
     UNION ALL
     SELECT '7월', C.MEM_ID, C.MEM_NAME, D.TOT1
        FROM  (SELECT CART_MEMBER AS AMID,
                      SUM(A.CART_QTY*B.PROD_PRICE) AS TOT1
                 FROM CART A, PROD B
                WHERE A.CART_NO LIKE '202007%'
                  AND A.CART_PROD=B.PROD_ID
             GROUP BY A.CART_MEMBER
             ORDER BY 2 DESC) D, MEMBER C
             WHERE C.MEM_ID=D.AMID
             AND ROWNUM = 1)
             --여기까지 각 월에 해당하는 가장 높은 순위의 1명이 나와서 합해지기 때문에 4개의 행이 나온다.
             --나온 행에 밑에 셀렉트절에서 컬럼명 별칭을 붙여준 것임
SELECT MON AS 월,
       CID AS 회원번호,
       CNAME AS 회원명,
       CTOT1 AS 구매금액
  FROM T1;

--UNION을 쓸 때에는 특정한 자료에서 특정한 값은 모두 같아야 값이 제대로 나온다

사용예) 6월과 7월에 판매된 모든 상품을 중복하지 않고 출력하시오.
       Alias 상품코드, 상품명
      
      SELECT DISTINCT A.CART_PROD AS 상품코드, 
             B.PROD_NAME AS 상품명
        FROM CART A, PROD B
       WHERE A.CART_PROD=B.PROD_ID
         AND A.CART_NO LIKE '202006%'

      UNION
       
      SELECT DISTINCT A.CART_PROD, 
             B.PROD_NAME
        FROM CART A, PROD B
       WHERE A.CART_PROD=B.PROD_ID
         AND A.CART_NO LIKE '202007%'
       ORDER BY 1; 



2) INTERSECT 
  - 교집합(공통부분)의 결과 반환
  

사용예) 2020년 매입상품 중 1월과 5월에 모두 매입된 상품의
      상품코드,상품명,매입처명을 조회하시오
      
      SELECT DISTINCT A.BUY_PROD AS 상품코드, --상품명도 중복배제되면 거래명도 중복배제된다
             C.PROD_NAME AS 상품명,
             B.BUYER_NAME AS 매입처명
        FROM BUYPROD A, BUYER B, PROD C
       WHERE A.BUY_PROD=C.PROD_ID
         AND C.PROD_BUYER=B.BUYER_ID
         AND BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
         
    INTERSECT
      
      SELECT DISTINCT A.BUY_PROD, 
             C.PROD_NAME,
             B.BUYER_NAME
        FROM BUYPROD A, BUYER B, PROD C
       WHERE A.BUY_PROD=C.PROD_ID
         AND C.PROD_BUYER=B.BUYER_ID
         AND BUY_DATE BETWEEN TO_DATE('20200501') AND TO_DATE('20200531')
    ORDER BY 1;
    
    
사용예)1월 매입상품 중 5월 판매 수량기준 5위 안에 존재하는 상품정보를 조회하시오
      
WITH T1 AS  
  (SELECT BUY_PROD 
     FROM BUYPROD
    WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')

INTERSECT  

     SELECT A.CART_PROD
       FROM (SELECT CART_PROD,
                    SUM(CART_QTY)
               FROM CART
              WHERE CART_NO LIKE '202005%'
              GROUP BY CART_PROD
              ORDER BY 2 DESC) A
       WHERE ROWNUM<=5)
             --여기까지 각 월에 해당하는 가장 높은 순위의 1명이 나와서 합해지기 때문에 4개의 행이 나온다.
             --나온 행에 밑에 셀렉트절에서 컬럼명 별칭을 붙여준 것임
SELECT BUY_PROD AS 상품코드, PROD_NAME AS 상품명
  FROM T1,PROD
 WHERE T1.BUY_PROD=PROD_ID;
  
 
         
         
         







