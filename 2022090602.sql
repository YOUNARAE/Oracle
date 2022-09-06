2022-0906-02)커서(CURSOR)
 - 커서는 SQL의 DML명령으로 영향받은 행들의 집합
 - SELECT문의 결과 집합
 - 묵시적커서와 명시적커서로 구분
 
 1)묵시적 커서
   . 이름이 없는 커서
   . 항상 커서가 CLOSE 되어 있음
   . 개발자가 커서 내부에 접근할 수 없음
   . 커서속성 -- 커서 이름이 없어서 SQL이라고 쓰고 명시적 커서에는 SQL이라 쓰지 않고 이름이 들어간다
   -----------------------------------------------------------
     속성           의미
   -----------------------------------------------------------
     SQL%ISOPEN    커서가 OPEN 되었으면 참(true)반환 항상 false임
     SQL%FOUND     커서 내부에 FETCH할 자료가 존재하면 참(true) -- 와일문에서 쓰인다
     SQL%NOTFOUND  커서 내부에 FETCH할 자료가 없으면 참(true)   -- 루프문에서 반복을 결정해주는 조건으로 쓰인다
     SQL%ROWCOUNT  커서 내부의 행의 수 반환
   -----------------------------------------------------------
   
 2)명시적 커서
   . 이름이 부여된 커서
   . 묵시적 커서속성에서 'SQL' 대신 커서명을 사용
   . 커서의 사용절차
     커서선언(선언영역) => 커서 OPEN => FETCH(반복명령 내부) => CLOSE--BEGIN영역에서 해준다
     단, FOR문에서 사용되는 커서는 OPEN, FETCH, CLOSE명령이 불필요
    
    (1) 커서선언
       CURSOR 커서명[(변수명 데이터타입[,...])] IS--데이터타입 바인드 변수는 변수명과 타입만 지정하고 절대 크기를 지정해서는 안된다 ex)VARCHAR2(200)=(x)
         SELECT 문
         
사용예) 사원테이블에서 부서번호를 입력받아 그 부서에 속한 사원정보를 출력하는 커서
       작성
       
       DECLARE
         CURSER EMP_CUR (P_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE) IS
           SELECT EMPLOYEE_ID, EMP_NAME, HIRE_DATE, SALARY
             FROM HR.EMPLOYEES
            WHRER DEPARTMENT_ID=P_DID;