--īƼ�� ���δ�Ʈ (12�� * 74�� = 888��)
 SELECT * 
   FROM LPROD, PROD;
  -- a1, a2, a3, b1, b2, b3 ..... �̷� ����� ī����
  
  SELECT *
    FROM CART, MEMBER;
    
--�������� : �⺻Ű�� �ܷ�Ű�� �����Ѵ�  
--EQui JOIN = ���� = � = �Ϲ� = �������� ��� ���� ��

 SELECT * 
   FROM LPROD, PROD
  WHERE LPROD_GU = PROD_LGU;
   
  
-- PROD : � ��ǰ�� �ִµ�,
-- BUYER : �� ��ǰ�� ��ǰ�� ��ü��?
-- CART : �� ��ǰ�� ���� ��ٱ��Ͽ� ��Ҵ°�?
-- MEMBER : ������ �����ΰ�?
----�� ���ļ� ����⿣ ����ȭ�� �ɸ��� ��ü�� �޶� �ȵȴ�.
--EQUI JOIN = ���� ���� = �Ϲ����� = ��������

 SELECT B.BUYER_ID,
        B.BUYER_NAME,
        P.PROD_ID,
        P.PROD_NAME,
        C.CART_PROD,
        C.CART_MEMBER,
        C.CART_QTY,
        M.MEM_ID,
        M.MEM_NAME 
   FROM BUYER B, PROD P, CART C, MEMBER M --(���������� ������ ���̺� ���� - 1)
  WHERE B.BUYER_ID = P.PROD_BUYER
    AND P.PROD_ID = C.CART_PROD
    AND C.CART_MEMBER = M.MEM_ID;
    
    
    
 SELECT B.BUYER_ID,
        B.BUYER_NAME,
        P.PROD_ID,
        P.PROD_NAME,
        C.CART_PROD,
        C.CART_MEMBER,
        C.CART_QTY,
        M.MEM_ID,
        M.MEM_NAME 
   FROM BUYER B INNER JOIN PROD P ON(B.BUYER_ID = P.PROD_BUYER) 
                INNER JOIN CART C ON(P.PROD_ID = C.CART_PROD)
                INNER JOIN MEMBER M ON (C.CART_MEMBER = M.MEM_ID)
   WHERE PROD_NAME LIKE '%����%';

  