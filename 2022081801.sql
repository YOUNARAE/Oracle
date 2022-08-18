2022-0817-2)
4)LTRIM(c1 [,c2], RTRIM(c1 [,c2])-**
  - �־��� ���ڿ� c1�� ���ʺ��� (LTRIM) �Ǵ� �����ʺ��� (RTRIM) c2 ���ڿ��� ã��
    ã�� ���ڿ��� ������
    
  - �ݵ�� ù ���ں��� ��ġ�ؾ���
  - c2�� �����Ǹ� ������ ã�� ����
  - c1 ���ڿ� ������ ������ ������ �� ����
  
��뿹)
    SELECT LTRIM('APPLEAP PERSIMMON BANANA','PPLE'),
           LTRIM(' APPLEAP PERSIMMON BANANA'),
           LTRIM('APTPLEAP PERSIMMON BANANA','AP'), --APP �����ؼ� ������ ���� �����
           LTRIM('PAAP PERSIMMON BANANA','AP') --a,p�ΰ��� ���۱��ڿ� ���ԵǾ� �־���Ѵ�.a��p�� ���۵Ǵ� ���ڸ� �����
      FROM DUAL
  
    SELECT * 
      FROM MEMBER
    WHERE MEM_NAME=RTRIM('�̻��� ');

5) TRIM(c1) -***
   - �־��� ���ڿ� ��, �쿡 �����ϴ� ��ȿ�� ������ ����
   - �ܾ� ������ ������ �������� ����
   
   ��� ��)�������̺�(JOBS)���� ������(JOB_TITLE) 'Accounting Manager'�� ������ ��ȸ�Ͻÿ�.
   -- JOB TITLE CHAR(20)���� ���� ��
   
   SELECT JOB_ID AS �����ڵ�,
          JOB_TITLE AS ������,
          LENGTHB(JOB_TITLE) AS "�������� ����",
          MIN_SALARY AS �����޿�,
          MAX_SALARY AS �ְ�޿�
     FROM HR.JOBS
    WHERE JOB_TITLE = 'Accounting Manager'; --TRIM �����ص� �˾Ƽ� TRIM �� ����� ��
    
��� ��)JOBS ���̺��� �������� ������ Ÿ���� VARCHAR(40)���� ����
      --CHAR(��������)�� CARCHAR(��������)�� ��ȯ �� UPDATE�� �ʼ�

    UPDATE HR.JOBS
    SER JOB_TITLE = TRIM(JOB_TITLE);
    
    COMMIT;
    
6)SUBSTR(c1,m[,[n])
  -  �־��� ���ڿ� c1���� m��°���� n���� ���ڸ� ����
  - m�� ���� ��ġ�� ��Ÿ���� 1���� counting��
  - n�� ������ ������ ���� �����ϸ� m���� ���� ��� ���ڸ� ����
  - m�� �����̸� �����ʺ��� counting��
  
  ��뿹)
  SELECT SUBSTR('ABCDEFGHIJK',3,5),
         SUBSTR('ABCDEFGHIJK',3),
         SUBSTR('ABCDEFGHIJK',-3,5),   --�ڿ������� m��°
         SUBSTR('ABCDEFGHIJK',3,15)    --�����ִ� ���̺��� �� ��� �ڷ� ��� ����
    FROM DUAL;
    
��뿹) ȸ�����̺��� �ֹι�ȣ �ʵ�(MEM_REGNO1, MEM_REGNO2)�� �̿��Ͽ� ȸ������ ���̸� ���ϰ�, ȸ����ȣ,ȸ����,�ֹι�ȣ,���̸� ����Ͻÿ�.
              -- ���� : ����⵵-����⵵ 
       -- 2022-1990
       -- 2022-2001
       
       SELECT MEM_ID AS ȸ����ȣ,
              MEM_NAME AS ȸ����,
              MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹι�ȣ,
              CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','2') THEN 
                2022-(TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+1900) --ù��°���� 2���ڸ� �� ��, 90+1900, 01+2000
              ELSE
                2022-(TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+2000) --ù��°���� 2���ڸ� �� ��, 01+2000
              END AS ����
         FROM MEMBER;


��뿹)������ 2020�� 4�� 1���̶�� �����Ͽ� 'c001'ȸ���� ��ǰ�� ������ �� �ʿ��� ��ٱ��Ϲ�ȣ�� �����Ͻÿ�. MAX(), TO_CHAR()�Լ����
      SELECT '20200401'||TRIM(TO_CHAR(MAX(TO_NUMBER(SUBSTR(CART_NO,9)))+1,'00000'))
        FROM CART
       WHERE SUBSTR(CART_NO,1,8)='20200401';

      SELECT MAX(CART_NO)+1
        FROM CART
       WHERE SUBSTR(CART_NO,1,8)='20200401';


��뿹)�̹��� ������ ȸ������ ��ȸ�Ͻÿ�.
      Alias�� ȸ����ȣ,ȸ����,�������,����
      ��, ������ �ֹε�Ϲ�ȣ�� �̿��� ��
      
      SELECT MEM_ID AS ȸ����ȣ,
             MEM_NAME AS ȸ����,
             MEM_REGNO1 AS �������,
             SUBSTR(MEM_REGNO1,3) AS ����
        FROM MEMBER
       WHERE SUBSTR(MEM_REGNO1,3,2)='09';
       
       
       
7) REPLACE(c1, c2, [,c3]) - **
   - �־��� ���ڿ� c1���� c2���ڿ��� ã�� c3���ڿ��� ġȯ
   - c3�� �����Ǹ� c2�� ������
   - �ܾ� ������ �������� ����(RTM,LTM���δ� ���� �ִ� ����ۿ� ���� ����),
   --ex)��ȭ��ȣ�� ������� �� �� 010 3441 �̷� �� �ƴϸ� �۴�⸦ �־��ų� ���� ��.
   --ex)���ڸ� ������� �ߴµ�.
   
��뿹)
       SELECT REPLACE('APPLE  PERSIMMON  BANNA','A','����'),
              REPLACE('APPLE  PERSIMMON  BANNA','A'),
              REPLACE('APPLE  PERSIMMON  BANNA',' ','-'),
              REPLACE(' APPLE  PERSIMMON  BANNA ',' ')
         FROM DUAL;     

     
     
      
      

        
