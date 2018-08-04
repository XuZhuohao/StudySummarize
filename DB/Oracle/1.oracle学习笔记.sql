SELECT to_char(to_date(201701,'yyyymm'),'yyyy"年"mm"日"') FROM dual;

decode:
	--若sale值=1000时翻译为D，=2000时翻译为C，=3000时翻译为B，=4000时翻译为A，如是其他值则翻译为Other；
	decode (sale,1000,'D',2000,'C',3000,'B',4000,'A','Other');
	--只与一个值比较 sale为null放回sale，否则返回sale，其实这里就是设置sale为缺省值而已
	decode（sale, NULL, '---', sale）;


substr:
	--substr(字符串,截取开始位置,截取长度) //返回截取的字
	substr('Hello World',0,1); --返回结果为 'H'  *从字符串第一个字符开始截取长度为1的字符串吾问无为谓无无无无无无无无无无无无无
	substr('Hello World',1,1); --返回结果为 'H'  *0和1都是表示截取的开始位置为第一个字符
	substr('Hello World',2);	--放回结果为 'ello World'

	
lpad:
	--lpad函数将左边的字符串填充一些特定的字符其语法格式如下：lpad(string,n,[pad_string])
	lpad('tech', 7); 							--将返回' tech' 
   lpad('tech', 2); 							--将返回'te' 
   lpad('tech', 8, '0'); 					--将返回'0000tech' 
   lpad('tech on the net', 15, 'z'); 	--将返回 'tech on the net' 
   lpad('tech on the net', 16, 'z');	--将返回 'ztech on the net'
	
SQL%ROWCOUNT:
	--表示修改记录条数
	
自动转换：
	字段为var查询条件可以用number（有的行有的不行，这个要看该列数据是否存在非数字的数据）
	select * from KC22 where AAZ217 = 128648833 and AAE072=005196699;--AAE072为VARCHAR2(20)，查到所有数值等于5196699（即宝库0005196699，不管前面多少个0）
	select * from KC22 where AAZ217 = 128648833 and AAE072='005196699';--只能查到为005196699的数据
	select * from SNZY_IC89_DOWNLOAD where aac002=440682198312121326;--aac002VARCHAR2(18),不能用number类型查找，报错

存储过程：
	TYPE table_ka45 IS TABLE OF ka45%ROWTYPE INDEX BY BINARY_INTEGER;--临时表
	
--时间加法
	select sysdate+1 from dual
	一天
	select sysdate+1/24 from dual
	一小时
	select sysdate+1/1440 from dual
	一分钟