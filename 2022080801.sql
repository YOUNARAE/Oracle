2022-0808-01)

3. ��¥�ڷ���
 - ��¥ �ð� ������ ����(��,��,��,��,��,��)
 - ��¥ �ڷ�� ������ ������ ������
 - date, timestamp Ÿ�� ����
 
 1)DATE Ÿ��
  . �⺻ ��¥ �� �ð����� ����
  (�������)
  �÷��� DATE
  . ������ ������ ���� ��ŭ �ٰ��� ��¥(�̷�)
  . ������ ������ ������ŭ ������ ��¥(����)
  . ��¥ �ڷ� ������ ������ ����(DAYS) ��ȯ
  . ��¥�ڷ�� ��/��/�� �κа� ��/��/�� �κ����� �����Ͽ� ����
  ** �ý����� �����ϴ� ��¥������ SYSDATE�Լ��� ���Ͽ� ������ �� ����
  
��� ��) CREATE TABLE TEMP06(
            COL1 DATE,
            COL2 DATE,
            COL3 DATE);
            
        INSERT INTO TEMP06 VALUES(SYSDATE, SYSDATE-10, SYSDATE+10);
        SELECT * FROM TEMP06;
        SELECT TO_CHAR(COL1, 'YYYY-MM-DD'),
               TO_CHAR(COL2, 'YYYY-MM-DD HH24:MI:SS'),
               TO_CHAR(COL1, 'YYYY-MM-DD HH12:MI:SS')
          FROM TEMP06;     
  
    * ���ó�¥�� 1�� 1�� 1�Ͽ��� ��¥�� ���ٴ� ��
    SELECT CASE MOD(TRUNC(SYSDATE)-TRUNC(TO_DATE('00010101'))-1,7)
                WHEN 1 THEN '������'
                WHEN 2 THEN 'ȭ����'
                WHEN 3 THEN '������'
                WHEN 4 THEN '�����'
                WHEN 5 THEN '�ݿ���'
                WHEN 6 THEN '�����'
                ELSE '�Ͽ���'
            END AS ����
      FROM DUAL;
      * �ʿ������ �ش簪�� ����ϱ� ���ؼ�(�԰��� ���߱� ����) ����ϴµ� ���̺��� ���� ��,  
        ������ ���̺��� DUAL,FROM���� �ݵ�� ���̺��� �ʿ��ϴ�.
      SELECT 126734178643786*1541 FROM DUAL;
      
      SELECT SYSDATE-TO_DATE('20200807') FROM DUAL;


2) TIMESTAMP Ÿ��
    .�ð��� ����( TIME ZONE)�� ������ �ð�����(10����� 1��)
    
 (�������)
    �÷��� TIMESTAMP - �ð��� �������� ������ �ð����� ����
    �÷��� TIMESTAMP WITH LOCAL TIME ZONE - �����ͺ��̽��� � ���� ������ �ð��븦 ��������
                                           ������ �����ϴ� Ŭ���̾�Ʈ���� ������ ���Ƚð� �Է�
                                           �ð��� Ŭ���̾�Ʈ ������ �ð����� �ڵ� ��ȯ��µǱ� ������
                                           �ð��� ������ ������� ����
    �÷��� TIMESTAMP WITH TIME ZONE - ������ �ð��� ���� ����
    
    . �ʸ� �ִ� 9�ڸ����� ǥ���� �� ������ �⺻�� 6�ڸ���
    
��뿹)
    CREATE TABLE TEMP07
     (COL1 DATE,
      COL2 TIMESTAMP,
      COL3 TIMESTAMP WITH LOCAL TIME ZONE,
      COL4 TIMESTAMP WITH TIME ZONE);

    INSERT INTO TEMP07 VALUES(SYSDATE,SYSDATE,SYSDATE,SYSDATE);
    SELECT * FROM TEMP07;
    
    











      
      
  
  
  
  
  