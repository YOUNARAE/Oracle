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

