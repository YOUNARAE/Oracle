2022-0901-02)���տ�����
 - SELECT���� ����� ������� ���տ��� ����
 - UNION ALL, UNION, INTERSECT, MINUS ������ ����
 - ���տ����ڷ� ����Ǵ� SELECT���� �� SELECT���� �÷��� ������ ������ Ÿ���� ��ġ�ؾ���
 - ORDER BY���� �� ������ SELECT������ ��� ����
 - BLOB, CLOB, BFILE Ÿ���� �÷��� ���տ����ڸ� ����� �� ����
 - UNION, INTERSECT, MINUS�����ڴ� LONGŸ���� �÷��� ����� �� ����
 - GROUPING SETS(col1,col2,...) => UNION ALL ������ ���Ե� ����
   ex) GROUPING SETS(col1,col2,col3)
   =>((GROUP BY Col1) UNION ALL (GROUP BY col2) UNION ALL (GROUP BY col3)) 
   
--ex) 1�Ź��� ���� �� UNION
--    2�Ź��� ���� �� UNION
--    1,2�Ź��� �� ���� �� UNION ALL
--UNION, UNION ALL(������) /�ߺ��� ������ִ� ���� UNION ALL
--INTERSECT(������)
--MINUS(������) 