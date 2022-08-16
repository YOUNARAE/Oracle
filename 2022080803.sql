2022-0808-03)자료 검색명령 (SELECT)
 (사용형식)
 SELECT *|[DISTINCT] 컬럼명 [AS 별칭][,]
         컬럼명 [AS 별칭][,] 
               :
    FROM 테이블명
   [WHERE 조건]
   [ORDER BY 컬럼명|컬럼인덱스 [ASC|DESC][,컬럼명|컬럼인덱스 [ASC|DESC],...]];
   . '별칭' : 해당컬럼을 참조할때, 출력시 컬럼의 구별자로 사용
             특수문자(공백 등) 사용시 반드시 " "안에 기술
   . 컬럼인덱스 : SELECT 절에서 해당컬럼의 사용 순번(1번부터 COUNTING)
   . ASC : 오름차순, DESC : 내림차순 , 생략하면 ASC임
   . DISTINCT 중복배제하는 명령어
   . 오라클은 1번부터 순번 시작
   
** 테이블삭제
   DROP TABLE 테이블명
    
   DROP TABLE TEMP01;
   DROP TABLE TEMP02;
   DROP TABLE TEMP03;
   DROP TABLE TEMP04;
   DROP TABLE TEMP05;
   DROP TABLE TEMP06;
   DROP TABLE TEMP07;
   DROP TABLE TEMP08;
   DROP TABLE TEMP09;
   DROP TABLE TEMP10;
   DROP TABLE TBL_WORK;
   DROP TABLE TBL_MAT;
   DROP TABLE SITE;
   DROP TABLE EMP;
    
    
    
    
    
    
    
    
    
    
    
    
    
   
   
   
   
             