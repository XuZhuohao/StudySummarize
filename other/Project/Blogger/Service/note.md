## 服务器购买（以腾讯云为例）
### 购买服务器
1.条件：有钱

2.打开地址  [腾讯云](https://cloud.tencent.com/?fromSource=gwzcw.234976.234976.234976)

3.登录账号

4.买买买

![](https://raw.githubusercontent.com/XuZhuohao/picture/master/Project/Blogger/Service/Buy.jpg)


### 简单配置
1.查看站内信

![](https://raw.githubusercontent.com/XuZhuohao/picture/master/Project/Blogger/Service/Mail.jpg)

2.根据提供的账号和密码连接服务器（以Xshell为例）

![](https://raw.githubusercontent.com/XuZhuohao/picture/master/Project/Blogger/Service/Xshell01.jpg)  
![](https://raw.githubusercontent.com/XuZhuohao/picture/master/Project/Blogger/Service/Xshell02.jpg)  
![](https://raw.githubusercontent.com/XuZhuohao/picture/master/Project/Blogger/Service/Xshell03.jpg)  

3.修改密码
命令：*passwd*

## mysql
### 安装
命令：
```
# wget http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
# rpm -ivh mysql-community-release-el7-5.noarch.rpm
# yum install mysql-community-server
```

### 外网访问
**创建用户**
```
CREATE USER study@"%" IDENTIFIED BY "a";
```
**JDBC连接出错**

1.错误信息
>
The last packet sent successfully to the server was 0 milliseconds ago. The driver has not received any packets from the server.

2.修改配置
```
mysql> flush privileges;Ctrl-C -- exit!
Aborted
[root@VM_0_15_centos /]# find / -name my.cnf
/etc/my.cnf
[root@VM_0_15_centos /]# vi /etc/my.cnf
--添加配置
wait_timeout=31536000
interactive_timeout=31536000
```
3.重启mysql
```
service mysqld restart
```
4.其他原因
```
url错误
```

## jdk  
### 1.更换yum源为阿里云
1、备份
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup

2、下载新的CentOS-Base.repo 到/etc/yum.repos.d/
CentOS 5
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-5.repo

或者
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-5.repo

CentOS 6
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo

或者
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo

CentOS 7
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

或者
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

3、之后运行yum makecache生成缓存

### 按照jdk
yum -y install  java-1.8.0-openjdk*

## tomcat


systemctl start tomcat
systemctl stop tomcat
