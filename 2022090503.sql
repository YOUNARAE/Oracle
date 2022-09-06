2022-0905-03) 인덱스(INDEX) 객체
  --장점
  - 자료검색을 효율적으로 수행하기 위한 객체
  - DBMS의 성능개선에 도움
  - B-TREE 개념이 적용되어 동일 시간안에 모든 자료 검색을 담보함
  - 데이터 검색, 삽입, 변경시 필요자료 선택의 효율성 증대
  - 정렬과 그룹화의 성능 개선에 도움
  --단점
  - 인덱스 구성에 자원이 많이 소요됨
  - 지속적인 데이터 변경이 발생되면 인덱스파일 갱신에 많은 시간 소요
  - 인덱스의 종류
    . Unique (키값이 중복되면 절대로 안된다. NULL값도 키값에 포함되고 1번만 가능하다) / Non Unique Index(키값이 중복될 수가 있다) 
    . Single (한컬럼으로 만들어지는 경우)/ Composite Index(여러개의 컬럼이 조합되어서 만들어지는 인덱스)
    . Normal / Bitmap(비트를 맵핑해서 만드는 인덱스,노말인덱스를 이진수로 변환해서 만든 인덱스) / Function-Based Normal Index(함수기반 노말 인덱스)
    
-- 검색 이진 트리의 전제 조건 : 좌자 < 부 < 우자
/*
        부모
      /     |
    좌자    우좌
*/

  (사용형식)
   CREATE [UNIQUE|BITMAP] INDEX 인덱스명
     ON 테이블명(컬럼명[,컬럼명,...])[ASC|DESC]
     
   사용예)회원테이블에서 이름컬럼으로 인덱스를 구성하시오
    CREATE INDEX IDX_NAME
        ON MEMBER(MEM_NAME);
      
    SELECT *
      FROM MEMBER
     WHERE MEM_NAME = '배인정';
     
     DROP INDEX IDX_NAME;
     
     CREATE INDEX IDX_REGNO
        ON MEMBER(SUBSTR(MEM_REGNO2,2,4));
        
    SELECT *
      FROM MEMBER
     WHERE SUBSTR(MEM_REGNO2,2,4)='4558'   
     
     
     
     
     1.인덱스 재구성
       - 인덱스 파일을 다른 테이블 스페이스로 이동 한 후 
       - 업데이트나 삭제등의 작업이 많이 수행된 직후 인덱스를 재구성 해야 하는 경우

    (사용형식)
     ALTER INDEX 인덱스명 REBUILD;
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     