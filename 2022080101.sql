
오후
++오라클 설치
오라클은 설치는 쉽지만 삭제는 어렵다.
(오라클은 선생님이 주신 파일로 설치했음)
오라클은 자바 먼저 설치해야 설치가 가능하다.
SQL버튼을 새로 눌러서 새 이름과 비밀번호를 넣어서 생성한다.
시스템에 계정을 생성해준다 (ex.HR,YNR90)
이 계정에는 기본형 테이블들이 종속되어있는데, 시스템 유지에 필요한 최소한의 테이블들이다.

- - 
-오라클은 영대소문자 구분 안함
-첫글자 알파벳 올 수 있음
-단어와 단어사이에는 언더스코어 연결
-비번 소문자 java

2022-0801-01)사용자 생성 및 권한 설정
1)사용자 생성
  - CREATE USER 명령 사용
   (사용형식)
   CREATE USER 사용자명 IDENTIFIED BY 암호;
  
  CREATE USER YNR90 IDENTIFIED BY java;

2)권한부여
  - GRANT 명령 사용
  (사용형식)
  GRANT 권한명[,권한명,...] TO 사용자명;
   . 권한명 : CONNECT, RESOURCE, DBA 등이 주로 사용
   
  GRANT CONNECT, RESOURCE, DBA TO YNR90;
  
3)HR 계정 활성화
   - ALTER 명령 사용하여 활성화 및 암호 설정

  ALTER USER HR ACCOUNT UNLOCK;
  ALTER USER HR IDENTIFIED BY java;
  
  
  
오라클(관계형데이터베이스):JOIN
자식 테이블에 내용이 연계되면 부모테이블은 수정도 불가능하다
객체 생성할 때 CREATE
객체 구조를 변경할 때 ALTER, 컬럼을 추가할 때,테이블에 제약사항을 추가할 때, 데이터 사용을 수정할 때도 ALTER(만들어놓은 객체에 대해서 변경을 가할 때)
테이블을 지울 때 DROP


-데이터,메타데이터에 대한 설명