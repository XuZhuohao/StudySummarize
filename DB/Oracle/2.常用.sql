--ָ��
url:http://sb-app-02:7010/gdld/login.jsp

--�ֶκ��壬��־����
select * from AA10 where AAA100=upper('�ֶ���');
--select AAA102, AAA100, AAA103, AAA101 from AA10 where AAA100=upper('');
--���ݺ������ֶ�
select * from AA10 where AAA101 like '%�Ա�%';


-- HINT
/*+parallel(a,10)+*/			���ж�
 ָ������
/*+rule()+*/
/*+Append*/  INSERT ר�У�����־
/*+use_hash(b,a) index(a,IND_SKC20_AAZ272)*/  hash Join������
update ���У�
	alter session enable parallel dml; 
	update /*+ parallel(x,10)*/ all01 x set timee=xxx
create index ind_t_object_id on test(object_id) parallel 4 ;
alter index ind_t_object_id noparallel;

--ӵ�и��ֶεı�
SELECT TABLE_NAME,COLUMN_NAME FROM USER_TAB_COLUMNS WHERE COLUMN_NAME=upper('');


--���ݱ�ע�ؼ��ֲ�ѯ�����֣�param ���ؼ���   
--����ռ䣬��ռ�Ϊ�ռ����пɲ�ѯ��ռ�     YBDY_DATA01ҽ������
Select distinct a.Table_Name, Tablespace_Name,comments 
	From Dba_Tables a,all_tab_comments b 
	--ע���п��ܱ�ע��Ϊ���룬����û�����ҳ���-----------------------
	Where Tablespace_Name like upper('%&��ռ�%') and a.Table_Name= b.Table_Name and comments like '%&�ؼ���%'; 
	
select * from user_col_comments WHERE comments like '%��������%';
  
--�����֤��ȡ��Աid
select aac001,* from ac01 where aac002 like '%&���֤��%';
select * from ac01 where aac001 like '%&��Աid��%';

--
--��������
CREATE INDEX PK_HIS_BA10_FPRN	ON HIS_BA10(FPRN)
CREATE UNIQUE INDEX ������ ON ����(�ֶ���)

--��ѯ��ı���ֶ������������͡����ݳ��ȡ����ݾ��ȣ�
select column_name, data_type, data_length, data_precision
  from user_tab_columns
 where table_name = '�����������Ҫ��д';

 
--��ѯ����ʱ��
SELECT CREATED FROM USER_OBJECTS WHERE OBJECT_NAME=upper('&tableName');

--job��ѯ
SELECT * FROM USER_JOBS WHERE WHAT LIKE '%%'

--�鿴�����Ȩ���
select* from user_tab_privs where table_name like  upper('����');
--�����Ȩ
grant DELETE on HIS_BA10 to DGSBKF_GGYW;
grant INSERT on HIS_BA10 to DGSBKF_GGYW;
grant select on HIS_BA10 to DGSBKF_GGYW;
grant UPDATE on HIS_BA10 to DGSBKF_GGYW;
--ϵͳȨ��
GRANT debug any procedure, debug connect session TO USERXXX;

--Ȩ�޻���
revoke DELETE on KF01 from DGKFCS_SQMZ;

--����ͬ���

--ͬ��ʲ�ѯ
select * from user_synonyms
select * from dba_synonyms 

--��־javaд��
private JdbcTemplate jdbcTemplate = (JdbcTemplate)Util.getBean("jdbcTemplate", JdbcTemplate.class);--����jdb����
Connection conn = null;--�������Ӷ��󣨴�����try catch �У�
PreparedStatement ps = null;--����PreparedStatement����
conn = this.jdbcTemplate.getDataSource().getConnection();--��ȡ����
conn.setAutoCommit(false);--�����Զ��ύΪfalse
int i = 1;--����λ��
ps = conn.prepareStatement("delete from FW_LONGTRANS_LOG where TRANSID = ? and KEY = ?");--sql���
ps.setString(i++, jobLog.getTRANSID());--����1
ps.setString(i++, jobLog.getTRANSID());--����2
ps.execute();--ִ��
conn.commit();--�ύ
ps.close(); --����
conn.close();--����

--�ֶβ���
select * from dba_col_comments WHERE column_name like '%AAC027%' AND owner='DG_YBDY';

--job
select * from dba_jobs order by job;
select * from dba_jobs_running;
-----------------------------��˾��
--������ ���ݵ��� 
SELECT * FROM TABLE(dl_jbxx(aac002)); 

--�����˻�����Ϊa
update fw_operator set password='a',pwencrypt='2',pwmodified='1' where loginid='tdmz_01';   -- 
update fw_operator set password=md5hash(operid||'a'),pwencrypt='1',pwmodified='1' where loginid='xzh_zt_admin'; --dg
--��¼��ʾ
select * from aa01 where AAA001='LOGIN_TIP' 

--��������
insert into kzg2 select * from temp_kzg2;

--����Ȩ��
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
  
--����Ȩ�ޣ���������
--SELECT * FROM fw_operateunit WHERE operunitid LIKE '101__';--��ϵ�� 10110
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
--�˵���ѯ
SELECT (SELECT rightname FROM fw_right WHERE rightid=SUBSTR(a.rightid,1,2)) "һ���˵�",
       (SELECT rightname FROM fw_right WHERE rightid=SUBSTR(a.rightid,1,4)) "�����˵�",
       (SELECT rightname FROM fw_right WHERE rightid=SUBSTR(a.rightid,1,6)) "�����˵�"
 FROM fw_right a WHERE rightid='0703';

SELECT (SELECT rightname FROM fw_right WHERE rightid=SUBSTR(a.rightid,1,2))||'->'||
       (SELECT rightname FROM fw_right WHERE rightid=SUBSTR(a.rightid,1,4))||'->'||
       (SELECT rightname FROM fw_right WHERE rightid=SUBSTR(a.rightid,1,6)) "�˵�"
 FROM fw_right a WHERE rightid='0703';
 
 
alter table t_CS_170821_038_ksyybh add  aaz107old  VARCHAR(20);

--------------------------���ñ�---------------------------
--������֤������
kea9

--סԺ
KC21

--�������ݵ���
SELECT * FROM TABLE(dl_jbxx(aac002));

---��������
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

--���ݿ�ִ������ѯ
SELECT sql_text,last_active_time FROM v$sql WHERE sql_text LIKE '%dual%' ORDER BY last_active_time;

--

--job
/*
��һ������ѯ�����Ǹ�job�����У��Ҹ���Ӧ��SID�ֶ�
1��select * from dba_jobs_running--�ҵ�job��Ӧ��sid

�ڶ�����ͨ����������ѯ����SID��Ӧ��SPID��
     ����SCHEMANAME='#username#'��JOB���е��û�����
     SID=342��ǰ���ѯ������SID��
2��select * from gv$process s,Gv$session gn where s.ADDR=gn.PADDR and gn.STATUS='ACTIVE' and gn.SCHEMANAME='#username#'
AND SID=342

--�ҵ���sid��Ӧ��spid
����������������ģʽ�£��������£�����1622202�ǲ�ѯ������SPID
3��kill -9 1622202--kill�ý���
*/
select * from dba_jobs order by job;
select * from dba_jobs_running;

--ʱ��
SELECT  TO_CHAR(TO_DATE(20170607112031,'yyyymmddhh24miss'),'yyyy-mm-dd hh24:mi:ss') aae036 FROM dual;
SELECT to_char(to_date('2017-06-07 11:20:31','yyyy-mm-dd hh24:mi:ss'),'yyyymmddhh24miSS') FROM dual;

-----KILL
SELECT 'alter system kill session ' || '''' || sid || ',' || serial# || '''immediate;', a.*  
  FROM dba_ddl_locks a, v$session ss  
 WHERE a.name =upper('pkg_report_bxgx_zb')  
   AND a.session_id = ss.sid;

--���spid
SELECT spid, osuser, s.program
  FROM v$session s, v$process p
 where s.paddr = p.addr
   and s.sid =2122;
--����spid��Ӧ����
ps -ef |grep spid
=============================
-----------------------------����cmd����
--�ر�8080
C:\Users\xuzhuohao>netstat -aon|findstr "8080"
  TCP    0.0.0.0:8080           0.0.0.0:0              LISTENING       12820
  TCP    127.0.0.20:8080        127.0.0.1:52892        TIME_WAIT       0
  TCP    192.168.140.121:50675  121.42.48.1:8080       CLOSE_WAIT      3536
  TCP    [::]:8080              [::]:0                 LISTENING       12820

C:\Users\xuzhuohao>tasklist|findstr "12820"
javaw.exe                    12820 Console                    1    353,636 K

--������ʾ�ļ�
tree /f > 1.txt


---�޸��ֶ�

--��һ������Ϊtb���ֶζ���Ϊname����������nchar(20)��

--1�������ֶ�����Ϊ�գ��򲻹ܸ�Ϊʲô�ֶ����ͣ�����ֱ��ִ�У�
alter table tb modify (name nvarchar2(20));

--2�������ֶ������ݣ����Ϊnvarchar2(20)����ֱ��ִ�У�
alter table tb modify (name nvarchar2(20));

--3�������ֶ������ݣ����Ϊvarchar2(40)ִ��ʱ�ᵯ������ORA-01439:Ҫ������������,��Ҫ�޸ĵ��б���Ϊ�ա�����ʱҪ�����淽�������������⣺
--����ԭλ��һ�㲻�ø÷���

/*�޸�ԭ�ֶ���nameΪname_tmp*/
 alter table tb rename column name to name_tmp;

 /*����һ����ԭ�ֶ���ͬ�����ֶ�name*/
 alter table tb add name varchar2(40);

 /*��ԭ�ֶ�name_tmp���ݸ��µ����ӵ��ֶ�name*/
 update tb set name=trim(name_tmp);

 /*�����꣬ɾ��ԭ�ֶ�name_tmp*/
 alter table tb drop column name_tmp;

--�ܽ᣺
--1�����ֶ�û�����ݻ���Ҫ�޸ĵ������ͺ�ԭ���ͼ���ʱ������ֱ��modify�޸ġ�
--2�����ֶ������ݲ���Ҫ�޸ĵ������ͺ�ԭ���Ͳ�����ʱ��Ҫ����½��ֶ���ת�ơ�  


-----�ַ����ۺ�
wm_concat

-----���ݴ���
bf_hzb
@dblink_dgcx