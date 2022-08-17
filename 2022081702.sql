2022-0817-2)
4)LTRIM(c1 [,c2], RTRIM(c1 [,c2])-**
  - 주어진 문자열 c1의 왼쪽부터 (LTRIM) 또는 오른쪽부터 (RTRIM) c2 문자열을 찾아
    찾은 문자열을 삭제함
    
  - 반드시 첫 글자부터 일치해야함
  - c2가 생략되면 공백을 찾아 삭제
  - c1 문자열 내부의 공백은 제거할 수 없음
  
사용예)
    SELECT LTRIM('APPLEAP PERSIMMON BANANA','PPLE'),
           LTRIM(' APPLEAP PERSIMMON BANANA'),
           LTRIM('APTPLEAP PERSIMMON BANANA','AP'), --APP 연속해서 있으면 같이 지운다
           LTRIM('PAAP PERSIMMON BANANA','AP') --a,p두개가 시작글자에 포함되어 있어야한다.a나p로 시작되는 글자를 지운다
      FROM DUAL
  
    SELECT * 
      FROM MEMBER
    WHERE MEM_NAME=RTRIM('이쁜이 ');



5) TRIM(c1) -***
   - 주어진 문자열 좌, 우에 존재하는 무효의 공백을 제거
   - 단어 내부의 공백은 제거하지 못함

