2022-0822-01)����ȯ �Լ�
 - ����Ŭ�� ������ ����ȯ �Լ��� TO_CHAR, TO_DATE, TO_NUMBER, CAST �Լ��� ������
 - ���� ��ȯ�� �ش� �Լ��� ���� ���� �Ͻ��� ��ȯ
 
 1)CAST(expr AS type) - *
   . expr�� �����Ǵ� ������(����, �Լ� ��)�� 'type' ���·� ��ȯ�Ͽ� ��ȯ ��
   
��뿹) 
  SELECT BUYER_ID AS �ŷ�ó�ڵ�, 
         BUYER_NAME AS �ŷ�ó��1,
         CAST(BUYER_NAME AS CHAR(30)) AS �ŷ�ó��2,
         BUYER_CHARGER AS �����
    FROM BUYER;
    
    
        --CAST(BUY_DATE AS NUMBER)CAST������ ��ٰ� �ؼ� ��� ��(��¥��->���ڷ�)�� �� �ٲ� �� �ִ� ���� �ƴϴ�. 
  SELECT  CAST(TO_CHAR(BUY_DATE,'YYYYMMDD') AS NUMBER) --BUY_DATE�� /�� �������Ѽ� �ٿ��� ���ڿ��� ��ȯ�� �� AS ���ڷ� ��ȯ�ϼ���
    FROM  BUYPROD
   WHERE  BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131');
 
 
 2)TO_CHAR(d [,fmt]) - ***** --[fmt]�� ��������
   . ��ȯ�Լ� �� ����θ� ���
   . ����,��¥,���� Ÿ���� ����Ÿ������ ��ȯ
   . ����Ÿ���� CHAR, CLOB�� VARCHAR2�� ��ȯ�� ���� ��� ����
   . 'fmt'�� ���Ĺ��ڿ��� ũ�� ��¥���� ���������� ���� ��
   
------------------------------------------------------------------------------------------------------------------
 FORMAT ����        �ǹ�                   ��뿹
------------------------------------------------------------------------------------------------------------------
 CC                ����                   SELECT TO_CHAR(SYSDATE, 'CC')||'����' FROM DUAL;
 AD, BC            �����, �����           SELECT TO_CHAR(SYSDATE, 'CC BC')||EXTRACT(YEAR FROM SYSDATE) FROM DUAL;
 YYYY,YYY,YY,Y     �⵵                   SELECT TO_CHAR(SYSDATE, 'YYYY') FROM DUAL;
 YEAR              �⵵�� ���ĺ�����        SELECT TO_CHAR(SYSDATE, 'YYYY YEAR') FROM DUAL;
 Q                 �б�                   SELECT TO_CHAR(SYSDATE, 'Q') FROM DUAL;
 MM,RM             ��                    SELECT TO_CHAR(SYSDATE, 'YYYY-MM') FROM DUAL;
 MONTH,MON         ��                    SELECT TO_CHAR(SYSDATE, 'YYYY-MONTH') FROM DUAL;
                                         SELECT TO_CHAR(SYSDATE, 'YYYY-MON') FROM DUAL;
 WW,W              ��                    SELECT TO_CHAR(SYSDATE, 'YYYY-MM WW') FROM DUAL;
                                         SELECT TO_CHAR(SYSDATE, 'YYYY-MM W') FROM DUAL;
 DDD,DD,D          ��                    SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DDD') FROM DUAL;--2022�⿡�� 234��° �� ���̴�.
                                         SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL;--�̹����� 22��° �Ǵ� ���̴�.
                                         SELECT TO_CHAR(SYSDATE, 'YYYY-MM-D') FROM DUAL;--�Ͽ���1,������2
 DAY, DY           ����                   SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL;
                                         SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DY') FROM DUAL;
 AM,PM,A.M.,P.M.   ����/����              SELECT TO_CHAR(SYSDATE, 'AM YYYY-MM-DD DY') FROM DUAL;--����ð��� �����̸� AM�� �ᵵ ���ķ� ���´�
 HH,HH12,HH24      �ð�                  SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH ') FROM DUAL;
                                         SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24 ') FROM DUAL;
 MI                ��                    SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI') FROM DUAL;
 SS,SSSSS          ��                    SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS SSSSS') FROM DUAL; --ssss�� ���� �������� ����� �ð��� �ʸ� ȯ���ϰ� ���� ��
------------------------------------------------------------------------------------------------------------------
 
 
 
 
 **������ ���Ĺ���
------------------------------------------------------------------------------------------------------------------------------------------
 FORMAT ����        �ǹ�                   ��뿹
------------------------------------------------------------------------------------------------------------------------------------------
 9,0               �����ڷ����             SELECT TO_CHAR(12345.56, '9,999,999.9'), --�ڸ��� �Ҽ��� ���ڸ��� ������ �� �ι�°�ڸ����� �ݿø��� �߻�
                                                 TO_CHAR(12345.56, '0,000,000.0') FROM DUAL; --���̻� ���ڰ� �ƴϰ� ���ڿ��̶� ������ �Ұ����ϴ�
 ,(COMMA),         3�ڸ����� �ڸ���(,)
 .(DOT)            �Ҽ���
 $,L               ȭ���ȣ                SELECT TO_CHAR(PROD_PRICE, 'L9,999,999')
                                            FROM PROD;
                                          SELECT TO_CHAR(SALARY,'$999,999') AS �޿�1,--����ó�� ������ ������ �ߴٰ� �ؼ� ���ڰ� �ƴ϶� ���ڿ��̶� 100�� ���ϴ� ���� ������ �Ұ����ϴ�
                                                 TO_CHAR(SALARY) AS �޿�2
                                            FROM HR.EMPLOYEES;
                                            
 PR                �����ڷḦ '<>'�ȿ� ���   SELECT TO_CHAR(-2500,'99,999PR') FROM DUAL; --PR�� �� �������� ���� ������ ���� ����
                                           
 MI          �����ڷ� ��½� �����ʿ� '-'���   SELECT TO_CHAR(-2500,'99,999MI') FROM DUAL;
                    
                   
 " "            ����ڰ� ���� �����ϴ� ���ڿ�   SELECT TO_CHAR(SYSDATE,'YYYY"��" MM"��" DD"��"')
                                             FROM DUAL;
                                             
--�÷��� ��Ī�� ������ �� �� " "���� �־��ش�
--�ٸ� ������� ��Ű���� ����� �� " "���� ��� ������ش�
               
------------------------------------------------------------------------------------------------------------------------------------------ 

3) TO_DATE(c [,fmt]) - *** 
   . �־��� ���ڿ� �ڷ� c�� ��¥Ÿ���� �ڷ�� ����ȯ ��Ŵ.
   . c�� ���Ե� ���ڿ� �� ��¥�ڷ�� ��ȯ�� �� ���� ���ڿ��� ���Ե� ���
     'fmt'�� ����Ͽ� �⺻ �������� ��ȯ�� �� ����
   . 'fmt'�� TO_CHAR�Լ��� '��¥�� ���Ĺ���'�� ����
   
   --���ڿ� �ڷḸ ��¥�� �ٲ� �� �ִ�, ���ڴ� ��¥�ڷ�� ���� �ٲ��� �ʽ��ϴ�.
   
��뿹)
   SELECT TO_DATE('20200504'),--���� ���� ���δ�
          TO_DATE('20200504','YYYY-MM-DD'),--��������� ����ȯ�� ������ ����. -�� /�߿� /�� ������
          TO_DATE('2020�� 08�� 22��','YYYY"��" MM"��" DD"��"')--����� �⺻ ��¥Ÿ������ ��µȴ�
     FROM DUAL;
          
          

3) TO_NUMBER(c [,fmt]) - *** 
  . �־��� ���ڿ� �ڷ� c�� ����Ÿ���� �ڷ�� ����ȯ ��Ŵ.
  . c�� ���Ե� ���ڿ� �� �����ڷ�� ��ȯ�� �� ���� ���ڿ��� ���Ե� ���
  . 'fmt'�� ����Ͽ� �⺻ ���� �������� ��ȯ�� �� ����
  . 'fmt'�� TO_CHAR�Լ��� '������ ���Ĺ���'�� ����  
  -- *��¥�� ���ڷ� �� �ٲ��
  
��뿹) 
    SELECT TO_NUMBER('2345') / 7, --���ڷ� ���ͼ� ������ �����ϴ�
        -- TO_NUMBER('2,345','9,999')--fmt�� ���� �ʹٸ� �޸��� �Ἥ ������ ��������Ѵ�.
           TO_NUMBER('2345.56'),
           TO_NUMBER('2,345','0,000'),
           TO_NUMBER('$2345','$9999'),
           TO_NUMBER('002,345','000,000'),
           TO_NUMBER('<2,345>','9,999PR')
      FROM DUAL;
      
    --�������� �������� ã���� fmt������ ã�Ƽ� �ִ´�
      
      
      
      
      
      
      
      
      
      
      
  
  
  
          
   
  


 
 
 
 
 