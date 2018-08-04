--指标
url:http://sb-app-02:7010/gdld/login.jsp

--字段含义，标志含义
select * from AA10 where AAA100=upper('字段名');
--select AAA102, AAA100, AAA103, AAA101 from AA10 where AAA100=upper('');
--根据含义搜字段
select * from AA10 where AAA101 like '%性别%';


-- HINT
/*+parallel(a,10)+*/			并行度
 指定索引
/*+rule()+*/
/*+Append*/  INSERT 专有，无日志
/*+use_hash(b,a) index(a,IND_SKC20_AAZ272)*/  hash Join和索引
update 并行：
	alter session enable parallel dml; 
	update /*+ parallel(x,10)*/ all01 x set timee=xxx
create index ind_t_object_id on test(object_id) parallel 4 ;
alter index ind_t_object_id noparallel;

--拥有该字段的表
SELECT TABLE_NAME,COLUMN_NAME FROM USER_TAB_COLUMNS WHERE COLUMN_NAME=upper('');


--根据备注关键字查询表名字，param ：关键字   
--带表空间，表空间为空即所有可查询表空间     YBDY_DATA01医保待遇
Select distinct a.Table_Name, Tablespace_Name,comments 
	From Dba_Tables a,all_tab_comments b 
	--注意有可能表注释为乱码，导致没被查找出来-----------------------
	Where Tablespace_Name like upper('%&表空间%') and a.Table_Name= b.Table_Name and comments like '%&关键字%'; 
	
select * from user_col_comments WHERE comments like '%申请日期%';
  
--由身份证或取人员id
select aac001,* from ac01 where aac002 like '%&身份证号%';
select * from ac01 where aac001 like '%&人员id号%';

--
--创建索引
CREATE INDEX PK_HIS_BA10_FPRN	ON HIS_BA10(FPRN)
CREATE UNIQUE INDEX 索引名 ON 表名(字段名)

--查询你的表的字段名、数据类型、数据长度、数据精度：
select column_name, data_type, data_length, data_precision
  from user_tab_columns
 where table_name = '这里填表名，要大写';

 
--查询建表时间
SELECT CREATED FROM USER_OBJECTS WHERE OBJECT_NAME=upper('&tableName');

--job查询
SELECT * FROM USER_JOBS WHERE WHAT LIKE '%%'

--查看表的授权情况
select* from user_tab_privs where table_name like  upper('表名');
--表的授权
grant DELETE on HIS_BA10 to DGSBKF_GGYW;
grant INSERT on HIS_BA10 to DGSBKF_GGYW;
grant select on HIS_BA10 to DGSBKF_GGYW;
grant UPDATE on HIS_BA10 to DGSBKF_GGYW;
--系统权限
GRANT debug any procedure, debug connect session TO USERXXX;

--权限回收
revoke DELETE on KF01 from DGKFCS_SQMZ;

--建立同义词

--同义词查询
select * from user_synonyms
select * from dba_synonyms 

--日志java写法
private JdbcTemplate jdbcTemplate = (JdbcTemplate)Util.getBean("jdbcTemplate", JdbcTemplate.class);--创建jdb对象
Connection conn = null;--声明连接对象（处理处在try catch 中）
PreparedStatement ps = null;--声明PreparedStatement对象
conn = this.jdbcTemplate.getDataSource().getConnection();--获取连接
conn.setAutoCommit(false);--设置自动提交为false
int i = 1;--参数位置
ps = conn.prepareStatement("delete from FW_LONGTRANS_LOG where TRANSID = ? and KEY = ?");--sql语句
ps.setString(i++, jobLog.getTRANSID());--参数1
ps.setString(i++, jobLog.getTRANSID());--参数2
ps.execute();--执行
conn.commit();--提交
ps.close(); --销毁
conn.close();--销毁

--字段查找
select * from dba_col_comments WHERE column_name like '%AAC027%' AND owner='DG_YBDY';

--job
select * from dba_jobs order by job;
select * from dba_jobs_running;
-----------------------------公司：
--基本表 数据导出 
SELECT * FROM TABLE(dl_jbxx(aac002)); 

--设置账户密码为a
update fw_operator set password='a',pwencrypt='2',pwmodified='1' where loginid='tdmz_01';   -- 
update fw_operator set password=md5hash(operid||'a'),pwencrypt='1',pwmodified='1' where loginid='xzh_zt_admin'; --dg
--登录提示
select * from aa01 where AAA001='LOGIN_TIP' 

--批量插入
insert into kzg2 select * from temp_kzg2;

--新增权限
INSERT INTO fw_operator2right(id, operid, rightid, authtype, aae100,validfrom)
SELECT seq_fw_operator2right.nextval,(SELECT operid FROM fw_operator WHERE Loginid='&' ) ,
       rightid,1,1,TO_NUMBER(TO_CHAR(sysdate,'yyyymmddhh24miss')) 
  FROM fw_right WHERE rightid like '&%';
--
INSERT INTO fw_operator2right(id, operid, rightid, authtype, aae100,validfrom)
SELECT seq_fw_operator2right.nextval,(SELECT operid FROM fw_operator WHERE Loginid='&' ) ,
       rightid,1,1,TO_NUMBER(TO_CHAR(sysdate,'yyyymmddhh24miss')) 
  FROM fw_right a
  WHERE rightid like '&%'
  AND NOT exists(
      SELECT 1 FROM  fw_operator2right 
		 WHERE rightid=a.rightid 
		   AND operid=(SELECT operid FROM fw_operator WHERE Loginid='&')
  );
  
--新增权限（可批量）
--SELECT * FROM fw_operateunit WHERE operunitid LIKE '101__';--关系科 10110
INSERT INTO fw_operator2right(id, operid, rightid, authtype, aae100,validfrom)
SELECT seq_fw_operator2right.nextval,b.operid ,
       rightid,1,1,TO_NUMBER(TO_CHAR(sysdate,'yyyymmddhh24miss')) 
  FROM fw_right a, fw_operator b
 WHERE a.rightid LIKE '%'
   AND  NOT exists(
      SELECT 1 FROM  fw_operator2right 
     WHERE rightid=a.rightid 
       AND operid=b.operid
  )
   AND b.LOGINID='';--operunitid='' operid LOGINID
   

--zzp113005  22980318
--菜单查询
SELECT (SELECT rightname FROM fw_right WHERE rightid=SUBSTR(a.rightid,1,2)) "一级菜单",
       (SELECT rightname FROM fw_right WHERE rightid=SUBSTR(a.rightid,1,4)) "二级菜单",
       (SELECT rightname FROM fw_right WHERE rightid=SUBSTR(a.rightid,1,6)) "三级菜单"
 FROM fw_right a WHERE rightid='0703';

SELECT (SELECT rightname FROM fw_right WHERE rightid=SUBSTR(a.rightid,1,2))||'->'||
       (SELECT rightname FROM fw_right WHERE rightid=SUBSTR(a.rightid,1,4))||'->'||
       (SELECT rightname FROM fw_right WHERE rightid=SUBSTR(a.rightid,1,6)) "菜单"
 FROM fw_right a WHERE rightid='0703';
 
 
alter table t_CS_170821_038_ksyybh add  aaz107old  VARCHAR(20);

--------------------------常用表---------------------------
--密码验证白名单
kea9

--住院
KC21

--基本数据导出
SELECT * FROM TABLE(dl_jbxx(aac002));

---自治事务
  PROCEDURE p_log(
   pi_aaz217 IN VARCHAR2,
   pi_sj IN DATE,
   pi_bz IN VARCHAR2
  ) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN 
      INSERT INTO kzn2_log (ykc700bd,sj,bz) VALUES(pi_aaz217,pi_sj,pi_bz);
      COMMIT;
  END p_log;

--数据库执行语句查询
SELECT sql_text,last_active_time FROM v$sql WHERE sql_text LIKE '%dual%' ORDER BY last_active_time;

--

--job
/*
第一步、查询出来那个job在运行，找个对应的SID字段
1、select * from dba_jobs_running--找到job对应的sid

第二部、通过以下语句查询出来SID对应的SPID，
     其中SCHEMANAME='#username#'是JOB运行的用户名称
     SID=342是前面查询出来的SID号
2、select * from gv$process s,Gv$session gn where s.ADDR=gn.PADDR and gn.STATUS='ACTIVE' and gn.SCHEMANAME='#username#'
AND SID=342

--找到该sid对应的spid
第三部、在命令行模式下，允许如下，其中1622202是查询出来的SPID
3、kill -9 1622202--kill该进程
*/
select * from dba_jobs order by job;
select * from dba_jobs_running;

--时间
SELECT  TO_CHAR(TO_DATE(20170607112031,'yyyymmddhh24miss'),'yyyy-mm-dd hh24:mi:ss') aae036 FROM dual;
SELECT to_char(to_date('2017-06-07 11:20:31','yyyy-mm-dd hh24:mi:ss'),'yyyymmddhh24miSS') FROM dual;

-----KILL
SELECT 'alter system kill session ' || '''' || sid || ',' || serial# || '''immediate;', a.*  
  FROM dba_ddl_locks a, v$session ss  
 WHERE a.name =upper('pkg_report_bxgx_zb')  
   AND a.session_id = ss.sid;

--查出spid
SELECT spid, osuser, s.program
  FROM v$session s, v$process p
 where s.paddr = p.addr
   and s.sid =2122;
--查找spid对应进程
ps -ef |grep spid
=============================
-----------------------------常用cmd命令
--关闭8080
C:\Users\xuzhuohao>netstat -aon|findstr "8080"
  TCP    0.0.0.0:8080           0.0.0.0:0              LISTENING       12820
  TCP    127.0.0.20:8080        127.0.0.1:52892        TIME_WAIT       0
  TCP    192.168.140.121:50675  121.42.48.1:8080       CLOSE_WAIT      3536
  TCP    [::]:8080              [::]:0                 LISTENING       12820

C:\Users\xuzhuohao>tasklist|findstr "12820"
javaw.exe                    12820 Console                    1    353,636 K

--树形显示文件
tree /f > 1.txt


---修改字段

--有一个表名为tb，字段段名为name，数据类型nchar(20)。

--1、假设字段数据为空，则不管改为什么字段类型，可以直接执行：
alter table tb modify (name nvarchar2(20));

--2、假设字段有数据，则改为nvarchar2(20)可以直接执行：
alter table tb modify (name nvarchar2(20));

--3、假设字段有数据，则改为varchar2(40)执行时会弹出：“ORA-01439:要更改数据类型,则要修改的列必须为空”，这时要用下面方法来解决这个问题：
--保存原位置一般不用该方法

/*修改原字段名name为name_tmp*/
 alter table tb rename column name to name_tmp;

 /*增加一个和原字段名同名的字段name*/
 alter table tb add name varchar2(40);

 /*将原字段name_tmp数据更新到增加的字段name*/
 update tb set name=trim(name_tmp);

 /*更新完，删除原字段name_tmp*/
 alter table tb drop column name_tmp;

--总结：
--1、当字段没有数据或者要修改的新类型和原类型兼容时，可以直接modify修改。
--2、当字段有数据并用要修改的新类型和原类型不兼容时，要间接新建字段来转移。  


-----字符串聚合
wm_concat

-----数据处理
bf_hzb
@dblink_dgcx