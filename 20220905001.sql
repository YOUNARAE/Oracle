--카티젼 프로덕트 (12행 * 74행 = 888행)
 SELECT * 
   FROM LPROD, PROD;
  -- a1, a2, a3, b1, b2, b3 ..... 이런 방식이 카디젼
  
  SELECT *
    FROM CART, MEMBER;
    
--참조관계 : 기본키를 외래키가 참조한다  
--EQui JOIN = 동등 = 등가 = 일반 = 내부조인 모두 같은 말

 SELECT * 
   FROM LPROD, PROD
  WHERE LPROD_GU = PROD_LGU;
   
  
-- PROD : 어떤 상품이 있는데,
-- BUYER : 그 상품을 납품한 업체는?
-- CART : 그 상품을 누가 장바구니에 담았는가?
-- MEMBER : 누가가 누구인가?
----다 합쳐서 만들기엔 정규화에 걸리고 객체가 달라서 안된다.
--EQUI JOIN = 내부 조인 = 일반조인 = 동등조인

 SELECT B.BUYER_ID,
        B.BUYER_NAME,
        P.PROD_ID,
        P.PROD_NAME,
        C.CART_PROD,
        C.CART_MEMBER,
        C.CART_QTY,
        M.MEM_ID,
        M.MEM_NAME 
   FROM BUYER B, PROD P, CART C, MEMBER M --(조인조건의 갯수는 테이블 개수 - 1)
  WHERE B.BUYER_ID = P.PROD_BUYER
    AND P.PROD_ID = C.CART_PROD
    AND C.CART_MEMBER = M.MEM_ID;
    
    
    
 SELECT B.BUYER_ID,
        B.BUYER_NAME,
        P.PROD_ID,
        P.PROD_NAME,
        C.CART_PROD,
        C.CART_MEMBER,
        C.CART_QTY,
        M.MEM_ID,
        M.MEM_NAME 
   FROM BUYER B INNER JOIN PROD P ON(B.BUYER_ID = P.PROD_BUYER) 
                INNER JOIN CART C ON(P.PROD_ID = C.CART_PROD)
                INNER JOIN MEMBER M ON (C.CART_MEMBER = M.MEM_ID)
   WHERE PROD_NAME LIKE '%샤넬%';

  