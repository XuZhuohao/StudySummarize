SELECT to_char(to_date(201701,'yyyymm'),'yyyy"��"mm"��"') FROM dual;

decode:
	--��saleֵ=1000ʱ����ΪD��=2000ʱ����ΪC��=3000ʱ����ΪB��=4000ʱ����ΪA����������ֵ����ΪOther��
	decode (sale,1000,'D',2000,'C',3000,'B',4000,'A','Other');
	--ֻ��һ��ֵ�Ƚ� saleΪnull�Ż�sale�����򷵻�sale����ʵ�����������saleΪȱʡֵ����
	decode��sale, NULL, '---', sale��;


substr:
	--substr(�ַ���,��ȡ��ʼλ��,��ȡ����) //���ؽ�ȡ����
	substr('Hello World',0,1); --���ؽ��Ϊ 'H'  *���ַ�����һ���ַ���ʼ��ȡ����Ϊ1���ַ���������Ϊν��������������������������
	substr('Hello World',1,1); --���ؽ��Ϊ 'H'  *0��1���Ǳ�ʾ��ȡ�Ŀ�ʼλ��Ϊ��һ���ַ�
	substr('Hello World',2);	--�Żؽ��Ϊ 'ello World'

	
lpad:
	--lpad��������ߵ��ַ������һЩ�ض����ַ����﷨��ʽ���£�lpad(string,n,[pad_string])
	lpad('tech', 7); 							--������' tech' 
   lpad('tech', 2); 							--������'te' 
   lpad('tech', 8, '0'); 					--������'0000tech' 
   lpad('tech on the net', 15, 'z'); 	--������ 'tech on the net' 
   lpad('tech on the net', 16, 'z');	--������ 'ztech on the net'
	
SQL%ROWCOUNT:
	--��ʾ�޸ļ�¼����
	
�Զ�ת����
	�ֶ�Ϊvar��ѯ����������number���е����еĲ��У����Ҫ�����������Ƿ���ڷ����ֵ����ݣ�
	select * from KC22 where AAZ217 = 128648833 and AAE072=005196699;--AAE072ΪVARCHAR2(20)���鵽������ֵ����5196699��������0005196699������ǰ����ٸ�0��
	select * from KC22 where AAZ217 = 128648833 and AAE072='005196699';--ֻ�ܲ鵽Ϊ005196699������
	select * from SNZY_IC89_DOWNLOAD where aac002=440682198312121326;--aac002VARCHAR2(18),������number���Ͳ��ң�����

�洢���̣�
	TYPE table_ka45 IS TABLE OF ka45%ROWTYPE INDEX BY BINARY_INTEGER;--��ʱ��
	
--ʱ��ӷ�
	select sysdate+1 from dual
	һ��
	select sysdate+1/24 from dual
	һСʱ
	select sysdate+1/1440 from dual
	һ����