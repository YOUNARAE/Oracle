2022-0818-02)
2. �����Լ�
  - �����Ǵ� �����Լ��δ� ������ �Լ�(ABS, SIGN, SQRT ��), GREATEST, ROUND, MOD,
   FLOOP; WIDTH_BUCKET ���� ����
   
1)������ �Լ�
  (1)ABS(n), SIGN(n), POWER(e, n), PQRT(N) - *
  - ABS : n�� ���밪 ��ȯ
  - SIGN : n�� ����̸� i, ���̸� -1, 0�̸� 0�� ��ȯ
  - POWER : e�� n�� ��(e�� n�� ���� ��)
  - SQRT  :n�� ����
  

��뿹) 
    SELECT ABS(10), ABS(-100), ABS(0), --ABS�� ��ȣ�� �ǹ̾���
           SIGN(-20000), SIGN(-0.0099), SIGN(0.00005), SIGN(500000), SIGN(500000), SIGN(0), 
           POWER(2,10),
           SQRT(3.3)
      FROM DUAL;
      
      


2)GREATEST(n1,n2[,...n]), LEAST(n1,n2[,...n])
  - �־��� �� n1 ~ n ������ �� �� ���� ū ��(GREATEST), �������� ��(LEAST) ��ȯ
  --�ּҰ��� �ִ밪�� �������ش�
  
  ��뿹)
    SELECT GREATEST('KOREA', 1000, 'ȫ�浿'),
           LEAST('ABC','ABD',200)
      FROM DUAL;
    
    
    SELECT ASCII('ȫ') FROM DUAL;  --ù ���ڸ� �ƽ�Ű�ڵ�� �ٲ۴�.ABC- 656668
    
    MAX�� GREATEST�� ������
    MAX�� �ϳ��� �÷��� ����ִ� �� �߿� ���� ū ���� ã�� ��(������ ���� ū ��)
    ������ ������ �� �߿� ���� ū ���� ã�� ���� GREATEST.
    
    
��뿹)ȸ�����̺��� ���ϸ����� 1000�̸��� ȸ���� ã�� 1000���� ���� ����Ͻÿ�
      Alias�� ȸ����ȣ,ȸ����,�������ϸ���,����ȸ��ϸ���
      
      SELECT MEM_ID AS ȸ����ȣ,
             MEM_NAME AS ȸ����,
             MEM_MILEAGE AS �������ϸ���,
             GREATEST(MEM_MILEAGE, 1000) AS ����ȸ��ϸ���
        FROM MEMBER;
    
      
      
      
      
      
      
      

      