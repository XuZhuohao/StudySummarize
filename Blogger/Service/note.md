## 服务器购买（以腾讯云为例）
### 购买服务器
1.条件：有钱

2.打开地址  [腾讯云](https://cloud.tencent.com/?fromSource=gwzcw.234976.234976.234976)

3.登录账号

4.买买买

![](https://github.com/XuZhuohao/studyNote-git-markdown-File-img/blob/master/Builderver/Buy.jpg?raw=true)

### 简单配置
1.查看站内信

![](https://github.com/XuZhuohao/studyNote-git-markdown-File-img/blob/master/Builderver/Mail.jpg?raw=true)

2.根据提供的账号和密码连接服务器（以Xshell为例）

![](https://github.com/XuZhuohao/studyNote-git-markdown-File-img/blob/master/Builderver/Xshell01.jpg?raw=true)

![](https://github.com/XuZhuohao/studyNote-git-markdown-File-img/blob/master/Builderver/Xshell02.jpg?raw=true)

![](https://github.com/XuZhuohao/studyNote-git-markdown-File-img/blob/master/Builderver/Xshell03.jpg?raw=true)

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
