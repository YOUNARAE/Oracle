2022-0830-02)외부조인(OUTER JOIN) --가급적 사용하지 말라고 권장

  - 내부조인은 조인조건을 만족하는 결과만 반환하지만, 외부조인은 
    자료가 부족한 테이블에 NULL행을 추가하여 조인을 수행
  - 조인조건 기술시 자료가 부족한 테이블의 컬럼 뒤에 외부조인 연산자 '(+)'를 추가기술함
  - 외부조인 조건이 복수개일 때 모든 외부조인 조건에 모두 '(+)'연산자를 기술
    해야 함
  - 한번에 한 테이블에만 외부조인을 할 수 있음
    즉, A,B,C 테이블을 외부조인할 경우 A를 기준으로 B와 외부조인하고 동시에 
    C를 기준으로 C를 외부조인할 수 없다(A=B(+) AND C=B(+)는 허용되지 않음)
    
  - 일반 외부조인에서 일반조건이 부여되면 정확한 결과가 반환되지 않은=>
    서브쿼리를 사용한 외부조인 또는 ANSI외부 조인으로 해결해야함
    
  - IN연산자 또는 OR연산자는 외부조인연산자('(+)')는 같이 사용할 수 없다.--작은테이블쪽에 붙여야한다.
  --일반조건은 외부조인을 사용하면 해제된다
  (일반외부조인 형식)
  SELECT 컬럼list
    FROM 테이블명1 [별칭1], 테이블명2 [별칭2],...
   WHERE 별칭1.컬럼명(+)=별칭2.컬럼명2 => 테이블명1이 자료가 부족한 테이블인 경우
   
   
  (ANSI 외부조인 사용형식)
  SELECT 컬럼list
    FROM 테이블명1 [별칭1]
  RIGHT|LEFT|FULL OUTER JOIN 테이블명2 [별칭2] ON(조인조건1 [AND 일반조건1])
            :
  [WHERE 일반조건]
  
  -'RIGHT|LEFT|FULL' : FROM절에 기술된 테이블(테이블1)의 자료가 
   OUTER JOIN 테이블명2 보다 많은면 'LEFT', 적으면 'RIGHT'
   양쪽 모두 적으면 'FULL'사용
 
 ** 1)SELECT 사용하는 컬럼 중 양쪽 테이블에 모두 존재하는 컬럼은 많은 쪽 테이블거것을 사용해야한다
    2)외부조인의 SELECT절에 COUNT함수를 사용하는 경우
    '*'는 NULL 값을 갖는 행도 하나의 행으로 인식하여 부정확한 값을 반환함. 따라서 '*'대신 해당테이블의 기본키를 사용
    
사용예) 모든 분류에 속한 상품의 수를 출력하시오.

--   SELECT DISTINCT PROD_LGU
--   FROM PROD
    (일반외부조인)
      SELECT B.LPROD_GU AS 분류코드,
             B.LPROD_NM AS 분류명,
             COUNT(A.PROD_ID) AS "상품의 수" --*를 쓰면 NULL값을 갖는 행도 1로 카운트된다
        FROM PROD A, LPROD B
       WHERE A.PROD_LGU(+)=B.LPROD_GU
    GROUP BY B.LPROD_GU, B.LPROD_NM
    ORDER BY 1;
    
    
    (ANSI외부조인)  
      SELECT B.LPROD_GU AS 분류코드,
             B.LPROD_NM AS 분류명,
             COUNT(A.PROD_ID) AS "상품의 수" --*를 쓰면 NULL값을 갖는 행도 1로 카운트된다
        FROM PROD A
       RIGHT OUTER JOIN LPROD B ON(A.PROD_LGU=B.LPROD_GU)--프롬절보다 다음에 적을 테이블의 데이터가 적으면 right를 쓴다
    GROUP BY B.LPROD_GU, B.LPROD_NM
    ORDER BY 1;


사용예) 2020년 6월 모든 거래처별 매입집계를 조회하시오
       Alias는 거래처코드, 거래처명, 매입금액합계
       
       SELECT A.BUYER_ID AS 거래처코드, 
              A.BUYER_NAME AS 거래처명, 
              SUM(B.BUY_QTY*C.PROD_COST) AS 매입금액합계
         FROM BUYER A, BUYPROD B, PROD C 
        WHERE B.BUY_PROD(+)=C.PROD_ID
          AND A.BUYER_ID=C.PROD_BUYER(+) 
          AND BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')
     GROUP BY A.BUYER_ID, A.BUYER_NAME;
     
     
     (ANSI 외부조인)
     SELECT A.BUYER_ID AS 거래처코드, 
              A.BUYER_NAME AS 거래처명, 
              NVL(SUM(B.BUY_QTY*C.PROD_COST),0) AS 매입금액합계
         FROM BUYER A
         LEFT OUTER JOIN PROD C ON(A.BUYER_ID=C.PROD_BUYER) --프롬절에 쓰여진 테이블에 자료가 더 다양하면 LEFT를 쓴다
         LEFT OUTER JOIN BUYPROD B ON(B.BUY_PROD=C.PROD_ID AND --PROD에 있는 상품코드보다 BUYPROD보다 더 다양한 상품 코드를 가지고 있어서 LEFT다
              BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630'))
     GROUP BY A.BUYER_ID, A.BUYER_NAME
     ORDER BY 1;
        
     (SUBQUERY)
       SELECT A.BUYER_ID AS 거래처코드, 
              A.BUYER_NAME AS 거래처명, 
              NVL(TBL.BSUM,0) AS 매입금액합계
         FROM BUYER A,
              (--2020년 6월 거래처별 매입금액합계
                SELECT C.PROD_BUYER AS CID,
                       SUM(B.BUY_QTY*C.PROD_COST) AS BSUM
                  FROM BUYPROD B, PROD C 
                 WHERE B.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')
                   AND B.BUY_PROD = C.PROD_ID
              GROUP BY C.PROD_BUYER) TBL       
         WHERE A.BUYER_ID=TBL.CID(+)
      ORDER BY 1;
     
        
        
        
        







    SELECT DISTINCT BUY_PROD
    FROM BUYPROD
    WHERE BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630');
         
         

사용예) 2020년 상반기(1-6월) 모든 제품별 매입수량집계를 조회하시오


사용예) 2020년 상반기(1-6월) 모든 제품별/
    
    
    
    
    
    
    
    
  