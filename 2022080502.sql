2022-08-05-02)�����ڷ���
- ������ �Ǽ� ����
- NUMBERŸ�� ����
(�������)
  NUMBER[(���е�|* [,������])]
   - ���� ǥ�� ���� : 10e-130 ~ 9.999...9e125
   - ���е� : ��ü�ڸ� ��(1-38)
   - ������ : �Ҽ��� ������ �ڸ���
   - '*' 38�ڸ� �̳����� ����ڰ� �Է��� �����͸� ������ �� �ִ� ������ �������� �ý����� ����
   - ������ �Ҽ��� ���� '������'+1��° �ڸ����� �ݿø��Ͽ� '������'�ڸ����� ����(�������� ����� ���)
     '������'�� �����̸� �����κ� '������' �ڸ����� �ݿø��Ͽ� ����

 ���� ��)
--------------------------------------------------------------
    ����          �Է°�           ��������
--------------------------------------------------------------
  NUMBER        12345.6789      12345.6789
  NUMBER(*,2)   12345.6789      12345.68
  NUMBER(6,2)   12345.6789      ����
  NUMBER(7,2)   12345.6789      12345.68
  NUMBER(8,0)   12345.6789      12346
  NUMBER(6)     12345.6789      12346 //0�� �� �ɷ� �����ؼ� 0+1 �ڸ����� �ݿø��� �Ͼ��
  NUMBER(6,-2)  12345.6789      12300
  
  
  CREATE TABLE TEMP05(
        COL1 NUMBER,
        COL2 NUMBER(*,2),
        COL3 NUMBER(6,2),
        COL4 NUMBER(7,2),
        COL5 NUMBER(8,0),
        COL6 NUMBER(6),
        COL7 NUMBER(6,-2));
        
    INSERT INTO TEMP05 VALUES(12345.6789,12345.6789,2345.6789,
                              12345.6789,12345.6789,12345.6789,12345.6789);

    SELECT * FROM TEMP05;  
    
    ** ���е�<�������� ���
    - ���е� : �Ҽ��� ���Ͽ��� 0�� �ƴ� ��ȿ������ ����
    - ������ : �Ҽ��� ������ �ڸ���
    - [������ - ���е� ]:�Ҽ��� ���Ͽ��� �����ؾ��� 0�� ����
    
    
    -------------------------------------------------------
        �Է°�       ����           ����� ��
    -------------------------------------------------------
    1234.5678       NUMBER(2,4)   ����(�����κ��� ���ͼ�)
    0.12            NUMBER(3,5)   ����
    0.003456        NUMBER(2,4)   0.0035(4��°���� �ݿø�,2�� 0�� ������)
    0.0345678       NUMBER(2,3)   0.035(3��°���� �ݿø�)
    
    �������� ��ü ����
    ���е��� ��ȿ���ڰ���
  
 