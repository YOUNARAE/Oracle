2022-0808-02)
4. ��Ÿ�ڷ���
  - �����ڷḦ �����ϱ� ���� ������ Ÿ��
  - RAW, LONG RAW, BLOB, BFILE ���� ������
  - �����ڷ�� ����Ŭ�� �ؼ��ϰų� ��ȯ���� �ʴ´�.
  1)RAW
   . ���� �����ڷ� ����
   . �ִ� 2000BYTE ���� ���尡��
   . �ε��� ó���� ����
   . 16������ 2���� ���·� ����
  (�������)
  �÷��� RAW(ũ��)  
  
  ��� ��)
   CREATE TABLE TEMP08(
     COL1 RAW(2000));
     
   INSERT INTO TEMP08 VALUES('2A7F');
   INSERT INTO TEMP08 VALUES(HEXTORAW('2A7F'));
   INSERT INTO TEMP08 VALUES('00101001111111');
  
  SELECT * FROM TEMP08;
  
  
  2)BFILE
  . �����ڷḦ ����
  . ����̵Ǵ� �����ڷḦ �����ͺ��̽� �ܺο� �����ϰ� �����ͺ��̽����� ��� ������ ����
  . �ִ� 4GB���� ���� ����
 (�������)
 �÷��� BFILE;
 BLOB�� ���̺� ���ο� ����,
 BFILE�� ���̺� �ۿ� ����
 
 ** �ڷ� �������
   (1) �ڷ� �غ�
        D:\A_TeachingMaterial\02_Oracle\SAMPLE.JPG
        (�����θ�)
        
   (2) ���̺� ����
        CREATE TABLE TEMP09(
            COL1 BFILE);
            
   (3) ���丮(����) ��ü ����-������� �� ���ϸ�
        ���丮 ��ü ����
        CREATE OR REPLACE DIRECTORY ��Ī AS ��θ�;
        (������ �����, ������ �������ִ� ���)
        
        CREATE OR REPLACE DIRECTORY TEST_DIR AS 'D:\A_TeachingMaterial\02_Oracle';
        
   (4) ����
   
        INSERT INTO TEMP09 VALUES(BFILENAME('TEST_DIR','SAMPLE.jpg'));
        
        SELECT * FROM TEMP09;
        (����Ŭ�� �׳� ����� ���·� �����ְ� �� �̻��� ������ ���� �ʴ´�. �׸������� TEMP09�� �ִ� �� �ƴϴ�.
        ���丮 ������ �׸������̶� �ϳ��� �Ǿ ����Ǿ��� �� �����ִ� �����̴�.
        ��������� �̿��ؼ� �ش絥���͸� �ٸ� ���� �����ϰ� ��� �������� ������ �����ڷḦ �ڵ鸵�ϰ��� �ϴ� ��� ����ϴ� ����)
        
        
        
 3)BLOB(Binary Large Objects)
    . ���� 2�� �ڷḦ ���̺� ���ο� ����
    . 4GB���� ���� ����
    
    (�������)
    �÷��� BLOB;
    
��뿹)
    CREATE TABLE TEMP10(
        COL1 BLOB);
   

������ ����
 DECLARE
   L_DIR VARCHAR2(20):='TEST_DIR';
   L_FILE VARCHAR2(30):='SAMPLE.jpg';
   L_BFILE  BFILE;
   L_BLOB  BLOB;
 BEGIN
   INSERT INTO TEMP10 VALUES(EMPTY_BLOB())
     RETURN COL1 INTO L_BLOB;
   
   L_BFILE:=BFILENAME(L_DIR,L_FILE);
   
   DBMS_LOB.FILEOPEN(L_BFILE,DBMS_LOB.FILE_READONLY);
   DBMS_LOB.LOADFROMFILE(L_BLOB,L_BFILE, DBMS_LOB.GETLENGTH(L_BFILE));
   DBMS_LOB.FILECLOSE(L_BFILE);
   
   COMMIT;
 END;
   
 SELECT * FROM TEMP10;
   
   
   
  
  
  
  
  
  
  
  
  
  
  
  
  