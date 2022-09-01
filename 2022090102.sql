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