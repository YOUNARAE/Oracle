2022-0905-01) SEQUENCE  ��ü
  - ���������� ����(����)�ϴ� ���� ��ȯ�ϴ� ��ü
  - ���̺�� ���������� ��� : ���� ���̺��� ���� ��� ����
  - ����ϴ� ���
    . �⺻Ű�� �ʿ��ϳ� �÷� �� �⺻Ű�� ����ϱ⿡ ������ �÷��� ���� ���
    . ���������� �������� �ʿ��� ���(��, �Խ����� �۹�ȣ ��)
  
  (�������)
  CREATE SEQUENCE ��������
     [START WITH n] - ���۰� ���� �����Ǹ� �ּҰ�(MINVAL ��)
     [INCREMENT BY n] - ����(����) �� ����. �����Ǹ� 1
     [MAXVALUE n|NOMAXVALUE] - �ִ밪 ����. �⺻�� NOMAXVALUE(10^27)
     [MINVALUE n|NOMINVALUE] - �ּҰ� ����. �⺻�� NOMINVALUE�̰� ���� 1��
     [CYCLE|NOCYCLE] - �ִ�(�ּ�)������ ���� �� �ٽ� �������� �������� ����. �⺻�� NOCYCLE
     [CACHE n|NOCACHE] - ĳ���� �̸� �������� ����, �⺻�� CACHE 20
     [ORDER|NOORDER] - ��û�� �ɼǿ� �´� ������ ������ �����ϴ� ����. �⺻�� NOORDER
     
     
**�������� ���� ���� : �ǻ��÷�(Pseudo Column: NEXTVAL, CURRVAL) ���

---------------------------------------------------------------------------------

      �ǻ��÷�               �ǹ�
 ��������. NEXTVAL        '������'��ü�� ���� �� ��ȯ
 ��������. CURRVAL        '������'��ü��  ���� �� ��ȯ
 
***������ ���� �� �ݵ��    '������.NEXTVAL' 1�� �̻�, �� ó������ ����Ǿ�� ��

��뿹) �з����̺��� LPROD_ID���� �������� ���Ͽ� ���� �ڷḦ �Է��Ͻÿ�

------------------------
 �з��ڵ�       �з��D
 -----------------------
 P501          ��깰
 P502          ���깰          
 P503          �ӻ깰
 
 
 
  CREATE SEQUENCE SEQ_LPROD_ID
    START WITH 10;
 
 INSERT INTO LPROD(LPROD_ID,LPROD_GU,LPROD_NM)
     VALUES(SEQ_LPROD_ID.NEXTVAL, 'P501','��깰');
        
 INSERT INTO LPROD(LPROD_ID,LPROD_GU,LPROD_NM)
     VALUES(SEQ_LPROD_ID.NEXTVAL, 'P502','���깰');
     
   INSERT INTO LPROD(LPROD_ID,LPROD_GU,LPROD_NM)
     VALUES(SEQ_LPROD_ID.NEXTVAL, 'P503','�ӻ깰');    
 
  SELECT SEQ_LPROD_ID.NEXTVAL FROM DUAL;
 
  SELECT * FROM LPROD;
    
 

  