2022-0805-01)������ Ÿ��
 -����Ŭ�� ���Ǵ� �ڷ� Ÿ���� ���ڿ�, ����, ��¥, ������ �ڷ�Ÿ���� ����
 1. ���� ������Ÿ��
  . ����Ŭ�� �����ڷ�� ' '�ȿ� ����� �ڷ�
  . ��ҹ��� ����
  . CHAR(��������), 
    VARCHAR(��� ������ �� �� ���� ��������,mysql������ �ٸ� ������ ��� ����,Variable), VARCHAR2(����Ŭ������ �� �� �ִ� ��������,Variable), 
    NVARCHAR2(N=national, �ٱ�� �����ϴ� ����Ŭ������ �� �� �ִ� ��������,UTF-8,UTF-16������� ��ȯ), 
    LONG(2Gbyte ���ڿ��� ������ ��), CLOB(4Gbyte���ڿ��� ������ ��), NCLOB ���� ������
  1) CHAR(n[BYTE|CHAR])
    - �������� ���ڿ� ����
    - �ִ� 2000BYTE���� ���尡��(������ ����,�ѱ��� 666���ڱ��� ���尡��)
    - 'n[BYTE|CHAR]' : '[BYTE|CHAR]'�� �����Ǹ� BYTE�� ���
      'CHAR'�� n���ڼ� ���� ����
    - �ѱ� �� ���ڴ� 3BYTE�� ����
    - �⺻Ű�� ���̰� ������ �ڷ�(�ֹι�ȣ,�����ȣ)�� ���缺�� Ȯ���ϱ� ���� ���. 
    (���ڴ� ���� ����, ���ڴ� ������ ����)
    

    ��� ��)
        CREATE TABLE TEMP01 (
            COL1 CHAR(10),
            COL2 CHAR(10 BYTE),
            COL3 CHAR(10 CHAR));
            
        INSERT INTO TEMP01 VALUES('����', '���ѹ�', '���ѹα�');
        
        SELECT * FROM TEMP01;
        
        SELECT LENGTHB(COL1) AS COL1,
               LENGTHB(COL3) AS COL2,
               LENGTHB(COL3) AS COL3
          FROM TEMP01;
        
        LENGHB ������ ����Ʈ�� ��Ÿ������� �Լ�
        
  2) VARCHAR2(n[BYTE|CHAR])
    - �������� ���ڿ� �ڷ� ����
    - �ִ� 4000BYTE���� ���� ����
    - VARCHAR, NVARCHAR2�� ��������� ����
    
    ��� ��)
    CREATE TABLE TEMP02(
        COL1 CHAR(20),
        COL2 VARCHAR2(2000 BYTE),
        COL3 VARCHAR2(4000 CHAR));

    INSERT INTO TEMP02  VALUES('ILPOSINO', 'BOYHOOD', 
                                '����ȭ ���� �Ǿ����ϴ�-������');
                                
    SELECT * FROM TEMP02;
        
    SELECT LENGTHB(COL1) AS COL1,
           LENGTHB(COL2) AS COL2,
           LENGTHB(COL3) AS COL3,
           LENGTH(COL1) AS COL1,
           LENGTH(COL2) AS COL2,
           LENGTH(COL3) AS COL3
      FROM TEMP02;
      
  3) LONG
    - �������� ���ڿ� �ڷ� ����
    - �ִ� 2GB���� ���� ����
    - �� ���̺� �� �÷��� LONGŸ�� ��� ����
    - ũ�⸦ �������� ����
    - ���� ��� �������� ����(����Ŭ 8i) => CLOB(4GB����)�� Upgrade
    - �ʿ��� ���̸� ���� �������� �ݳ�
    (�������)
         �÷��� LONG
         . LONG Ÿ������ ����� �ڷḦ �����ϱ� ���� �ּ� 31bit(2�� 30��*2)�� �ʿ�
         =>�Ϻ� ���(LENGTHB ���� �Լ�)�� ����
          . SELECT���� SELECT��, UPDATE�� SET��, INSERT���� VALUES������ ��� ����
          
    ��뿹)
    CREATE TABLE TEMP03 (
        COL1 VARCHAR2(2000),
        COL2 LONG);
  
    INSERT INTO TEMP03 VALUES('������ �߱� ���� 846','������ �߱� ���� 846');
    
    SELECT LENGTHB(COL2)
          -- SUBSTR(COL2,8,3)
      FROM TEMP03;
      
    SELECT * FROM TEMP03;
    
    
  4) CLOB(Character Large OBjects)
    - ��뷮�� �������� ���ڿ� ����
    - �ִ� 4GB���� ó�� ����
    - �� ���̺� �������� CLOB Ÿ�� ���� ����
    - �Ϻ� ����� DBMS_LOB API(Application Programming Interface)���� �����ϴ�
      �Լ� ���
  (�������)
    �÷���  CLOB
    
    ��뿹)
    CREATE TABLE TEMP04(
        COL1 VARCHAR2(255),
        COL2 CLOB,
        COL3 CLOB);

    INSERT INTO TEMP04 VALUES('APPLE BANANA PERSIMMON','APPLE BANANA PERSIMMON',
                              'APPLE BANANA PERSIMMON');
                              
    
    SELECT * FROM TEMP04;                          
    
    SELECT SUBSTR(COL1,7,6) AS COL1,
           SUBSTR(COL3,7,6) AS COL3,
           --LENGTHB(COL2) AS COL4,
           DBMS_LOB.GETLENGTH(COL2) AS COL4, --���ڼ� ��ȯ
           DBMS_LOB.SUBSTR(COL2,7,6) AS COL2
      FROM TEMP04;
        