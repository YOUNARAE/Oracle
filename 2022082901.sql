2022-0829-01) 테이블 조인
 - 관계형 데이터베이스에서 관계(Relationship)를 이용하여 복수개의 테이블로 부터
   필요한 자료를 추출하는 연산 
   
 - 조인에 참여하는 테이블은 반드시 관계(외래키 관계)를 맺어야함(관계가 없는 테이블
   간의 조인을 Cartessian(Cross) join 이라고 함)

 - 조인의 종류
   . 내부조인과 외부조인(Inner join조인조건을 만족하는 경우, outer join조인조건을 만족하지 않는 경우까지 포함시키는 결과)
   --내부조인보다 외부조인이 결과값이 커질 수 있어서 전체 쿼리의 성능이 떨어질 수 있다.
   . 일반조인과 ANSI(KS규격위원회같은 미국의 프로그램언어 규격을 만드는 단체,ex아스키코드) Join
   --ANSI조인의 특징 : 어느 DBMS에 써도 실행이 가능한 장점이 있다.
   . Equi-Join, Non-Equi Join, Self Join, Cartessian Product
   --① 조인조건에 =이 사용되면 Equi, !=이 사용되면 Non-Equi
   --② self Join은 스스로가 조인이 되는 테이블
    
    
  1.일반 조인
  - 각 DB벤더에서 자사의 DBMS에 최적화된 문법구조를 가짐
  - 사용 DB가 바뀌면 변경된 문법을 새로 습득해야 함
  (사용형식)
   SELECT 컬럼list
     FROM 테이블명1 [별칭1], 테이블2 [별칭2] [,...] --여러개가 된다.
    WHERE [별칭1.|테이블명1.]컬럼명 연산자 [별칭2.|테이블명2.]컬럼명 --조인문에서 웨어절을 생략할 수 없다. 조인조건을 기술해야해서.
     [AND 조인조건]
     [AND 일반조건]
                      :
                      
    . n개의 테이블이 사용되면 조인조건은 적어도 n-1개 이상 되어야 함
    . 일반조건과 조인조건은 사용 순서가 바뀌어도 상관 없음
   
2. ANSI 내부조인 
   SELECT 컬럼list
     FROM 테이블명1[별칭1]
     INNER|CROSS|NATURAL JOIN 테이블명2 [별칭2] ON(조인조건 [AND 일반조건])--온절에 오는 조건은 테이블1과 테이블2에만 적용된다
     INNER|CROSS|NATURAL JOIN 테이블명2 [별칭2] ON(조인조건 [AND 일반조건])
                               :

    [WHERE 일반조건] --모든 테이블에 적용되어야할 조건은 WHERE절에 쓰는 것이다.
              :
    . 테이블명1과 테이블명2는 반드시 직업 JOIN 가능해야함
    . 테이블명3은 테이블명1과 테이블명2의 조인 결과와 조인 수행
    . 'CROSS JOIN'은 일반조인의 Cartessian Product와 동일
    . 'NATURAL JOIN'은 조인연산에 사용된 테이블에 동일 컬럼명이 존재하면 자동으로 조인 발생
      
    
3. Cartessian Product Join(Cross Join)
   . 조인조건이 기술되지 않았거나 잘못 기술된 경우 발생
   . n행 m열의 테이블과 a행 b열의 테이블이 Cross Join된 경우 최악의 경우(조인조건이 누락된 경우)
     결과는 n*a 행 m+b  열이 반환됨
   . 반드시 필요한 경우가 아니면 사용을 자제해야 함

사용예) 
   SELECT COUNT(*) AS "PROD 테이블 행의 수" FROM PROD;
   SELECT COUNT(*) AS "CART 테이블 행의 수" FROM CART;
   SELECT COUNT(*) AS "BUYPROD 테이블 행의 수" FROM BUYPROD;
   
   SELECT COUNT(*) FROM PROD,CART,BUYPROD,HR.EMPLOYEES; --웨어절이 없으니까 카타시안 조인이다
   
  -- ANSI는 밑의 형태를 벗어나지 않는다
   SELECT * 
     FROM PROD
    CROSS JOIN BUYPROD
    CROSS JOIN CART;
    
  --조인 조건이 맞지 않을 때 카타시안 테이블이 실행된다 
  
  4. Equi Join(ANSI의 INNER JOIN)
    - 조인조건에 '='연산자 사용
  
    (일반조인 사용형식)
    SELECT 컬럼list
      FROM 테이블명1 [별칭1], 테이블명2 [별칭2] [,테이블명3 [별칭3],...]
     WHERE [별칭1.]컬럼명1=[별칭2.]컬럼명2 --조인조건
      [AND [별칭1.]컬렴명1=[별칭3.]컬럼명3]--조인조건
      
      [AND 일반조건]
    
    
    (ANSI 조인 사용형식)
    SELECT 컬럼list
      FROM 테이블명1 [별칭1]
      INNER JOIN 테이블명2 [별칭2] ON([별칭1.]컬럼명1=[별칭2.]컬럼명2 [AND 일반조건1])
      --위의 연산 결과(테이블1과 2와 먼저 연산)와 테이블3이 연산되는 조건이다.
      [INNER JOIN 테이블명3 [별칭3] ON([별칭1.]컬럼명1=[별칭3.]컬럼명3 [AND 일반조건2])
      
      [WHERE 일반조건] -- 위의 테이블의 공통적인 조건을 기술해주는 것
      
사용예) 매입테이블에서 2020년 7월 매입상품정보를 조회하시오
       Alias는 일자,상품번호,상품명,수량,금액 
       
       --①부모의 기본키를 가져다쓴 쪽이 자식테이블이다
       --②별칭은 두 테이블 사이에 공통적으로 사용된 컬럼이 있는 경우 사용한다.같은 테이블명이 없을 땐 안 써도됨.
       
       (일반조인문)
       SELECT A.BUY_DATE AS 일자,     --표기법 n.nnnn이 방식은 참조해야하는 셀렉트절과 프롬절만 가능하다.
              B.PROD_ID AS 상품번호,
              B.PROD_NAME AS 상품명,
              A.BUY_QTY AS 수량,
              A.BUY_QTY * B.PROD_COST AS 금액 
         FROM BUYPROD A, PROD B
        WHERE A.BUY_PROD=B.PROD_ID --조인조건
          AND A.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630') --일반조건
        ORDER BY 1;
       
       
       (ANSI조인문)
       SELECT A.BUY_DATE AS 일자,  
              B.PROD_ID AS 상품번호,
              B.PROD_NAME AS 상품명,
              A.BUY_QTY AS 수량,
              A.BUY_QTY * B.PROD_COST AS 금액 
         FROM BUYPROD A
         INNER JOIN PROD B ON(A.BUY_PROD=B.PROD_ID)
          WHERE A.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')
   --웨어절 대신에 밑에 처럼 넣을 수 있다 . 결과는 같다.
   --INNER JOIN PROD B ON(A.BUY_PROD=B.PROD_ID AND (A.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')))
     ORDER BY 1;
     
     
       
사용예) 상품테이블에서 'P10202' 거래처에서 납품하는 상품정보를 조회하시오.
       Alias는 상품코드,상품명,거래처명,매입단가
       
       
       (일반조인문)
        SELECT A.PROD_ID AS 상품코드,
               A.PROD_NAME AS 상품명,
               B.BUYER_NAME AS 거래처명,
               A.PROD_COST AS 매입단가
          FROM PROD A, BUYER B
         WHERE A.PROD_BUYER=B.BUYER_ID --조인조건
           AND B.BUYER_ID LIKE 'P10202';
         --WHERE SUBSTR(B.BUYER_ID,1,6) ='P10202%';
       
       (ANSI조인문으로 변경)
        SELECT A.PROD_ID AS 상품코드,
               A.PROD_NAME AS 상품명,
               B.BUYER_NAME AS 거래처명,
               A.PROD_COST AS 매입단가
          FROM PROD A
    INNER JOIN BUYER B ON(A.PROD_BUYER=B.BUYER_ID) 
         WHERE B.BUYER_ID LIKE 'P10202';  --WHERE절은 반드시 INNDER JOIN절 다음에 써야한다.
         
         
       
사용예) 상품테이블에서 다음 정보를 조회하시오
       Alias는 상품코드,상품명,분류명,판매단가
       
       (일반조인문)
       SELECT A.PROD_ID AS 상품코드,
              A.PROD_NAME AS 상품명,
              B.LPROD_NM AS 분류명,
              A.PROD_PRICE AS 판매단가
         FROM PROD A, LPROD B
        WHERE A.PROD_LGU=B.LPROD_GU;
        
        (ANSI조인문)
         SELECT A.PROD_ID AS 상품코드,
              A.PROD_NAME AS 상품명,
              B.LPROD_NM AS 분류명,
              A.PROD_PRICE AS 판매단가
         FROM PROD A
   INNER JOIN LPROD B ON(A.PROD_LGU=B.LPROD_GU);
        
    
       
사용예) 사원테이블에서 사원번호,사원명,부서명,부서의 책임자명,입사일을 출력하시오.
  
  (일반조인문)
  SELECT A.EMPLOYEE_ID AS 사원번호,
         A.EMP_NAME AS 사원명,
         B.DEPARTMENT_NAME AS 부서명,
         A.HIRE_DATE AS 입사일
    FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
   WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID --부서코드가 null값인 사람까지 출력하고 싶으면 outer join을 써야한다.
   
   
   (ANSI조인문) 
    SELECT A.EMPLOYEE_ID AS 사원번호,
           A.EMP_NAME AS 사원명,
           B.DEPARTMENT_NAME AS 부서명,
           A.HIRE_DATE AS 입사일
      FROM HR.EMPLOYEES A
INNER JOIN HR.DEPARTMENTS B ON(A.DEPARTMENT_ID=B.DEPARTMENT_ID);
   
    
    
사용예) 2020년 4월 회원별, 상품별 매입집계를 조회하시오
       Alias는 회원번호,회원명,상품명,구매수량합계,구매금액합계
      
      (일반조인문)
      SELECT A.CART_MEMBER AS 회원번호,
             B.MEM_NAME AS 회원명,
             C.PROD_NAME AS 상품명,
             SUM(A.CART_QTY) AS 구매수량합계,
             SUM(A.CART_QTY*C.PROD_PRICE) AS 구매금액합계
        FROM CART A, MEMBER B, PROD C
       WHERE A.CART_MEMBER=B.MEM_ID -- 회원명 가져오기 위한 조인조건
         AND A.CART_PROD=C.PROD_ID --상품명,상품단가를 구하기 위한 조인조건
         AND A.CART_NO LIKE '202004%'
    GROUP BY A.CART_MEMBER, B.MEM_NAME, C.PROD_NAME --GROUP BY절에는 SELECT절에 쓴 구분을 써줘야한다
    ORDER BY 1;
    
    
         (ANSI조인문)
      SELECT A.CART_MEMBER AS 회원번호,
             B.MEM_NAME AS 회원명,
             C.PROD_NAME AS 상품명,
             SUM(A.CART_QTY) AS 구매수량합계,
             SUM(A.CART_QTY*C.PROD_PRICE) AS 구매금액합계
        FROM CART A 
  INNER JOIN MEMBER B ON(A.CART_MEMBER=B.MEM_ID)
--       INNER JOIN PROD C ON(A.CART_PROD=C.PROD_ID AND A.CART_NO LIKE '202004%') --일반조건을 위에 붙일지 아래에 붙일지를 잘 판단해야한다.
  INNER JOIN PROD C ON(A.CART_PROD=C.PROD_ID)
       WHERE A.CART_NO LIKE '202004%' --내부조인에서는 일반조건을 쓰든 웨어절을 쓰든 문제가 발생되지 않지만 외부조인할 때에는 문제가 발생된다
    GROUP BY A.CART_MEMBER, B.MEM_NAME, C.PROD_NAME
    ORDER BY 1;
        
        
사용예) 2020년 5월 거래처별 매출집계를 조회하시오
      Alias는 거래처코드, 거래처명, 매출금액합계

--(I.E 표현법) 
--식별자관계 : 부모의 기본키가 자식의 기본키가 되는 경우, 부모가 없으면 자식도 필요없다, 직선으로 표시된다.
--비식별관계 : 부모의 기본키가 자식의 일반컬럼이 되어진다, 점선으로 표시

--바커식표현방법


      (일반조인문)    
       SELECT A.BUYER_ID AS 거래처코드, 
              A.BUYER_NAME AS 거래처명, 
              SUM(B.PROD_PRICE*C.CART_QTY) AS 매출금액합계
         FROM BUYER A, PROD B, CART C
        WHERE C.CART_NO LIKE '202005%' --일반조건
          AND B.PROD_ID=C.CART_PROD --조인조건
          AND A.BUYER_ID=B.PROD_BUYER --조인조건
     GROUP BY A.BUYER_ID, A.BUYER_NAME
     ORDER BY 1;

       (ANSI조인문)
        SELECT A.BUYER_ID AS 거래처코드, 
               A.BUYER_NAME AS 거래처명, 
               SUM(B.PROD_PRICE*C.CART_QTY) AS 매출금액합계
          FROM BUYER A
    INNER JOIN PROD B ON(A.BUYER_ID=B.PROD_BUYER)
    INNER JOIN CART C ON(B.PROD_ID=C.CART_PROD AND C.CART_NO LIKE '202005%')
      GROUP BY  A.BUYER_ID, A.BUYER_NAME
      ORDER BY 1;
    
    
사용예) HR계정에서 미국이외의 국가에 위치한 부서에 근무하는 직원정보를 조회하시오
       Alias는 부서번호, 부서명, 주소, 국가명

      (일반조인문) 
       SELECT A.DEPARTMENT_ID AS 부서번호, 
              A.DEPARTMENT_NAME AS 부서명, 
              B.STREET_ADDRESS||', '||B.CITY||', '||STATE_PROVINCE AS 주소, 
              C.COUNTRY_NAME AS 국가명
         FROM HR.DEPARTMENTS A, HR.LOCATIONS B, HR.COUNTRIES C
        WHERE A.LOCATION_ID=B.LOCATION_ID
          AND B.COUNTRY_ID=C.COUNTRY_ID
          AND B.COUNTRY_ID != 'US'
     ORDER BY 1;
         
    (ANSI조인문)      
     SELECT A.DEPARTMENT_ID AS 부서번호, 
              A.DEPARTMENT_NAME AS 부서명, 
              B.COUNTRY_ID||' '||B.CITY||' '||B.STREET_ADDRESS AS 주소, 
              C.COUNTRY_NAME AS 국가명
         FROM HR.DEPARTMENTS A
   INNER JOIN HR.LOCATIONS B ON(A.LOCATION_ID=B.LOCATION_ID)
   INNER JOIN HR.COUNTRIES C ON(B.COUNTRY_ID=C.COUNTRY_ID)
          AND B.COUNTRY_ID != 'US';
       
    
    
   
   
   
   
   
   
   