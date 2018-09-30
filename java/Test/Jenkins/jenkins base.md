# Jenkins

## 基础知识

### 1.安装

**download**

> [root@localhost download]# wget http://mirrors.shu.edu.cn/jenkins/war/2.141/jenkins.war  

**start**

> [root@localhost jenkins]# java -jar jenkins.war 

打开网页查看：  http://ip:8080

输入密码： 383458d2d4f646818954a324f52d392f  (查看对应文件)

**install plugins**

> 根据要求选择 推荐安装 或 自定义安装

**Create admin account **



### 2.Jenkins 插件

**安装插件**

> 系统管理 --> 插件管理 --> 可选插件  --> 选中要安装插件(多选) --> 直接安装

**推荐插件**

> Rebuilder
>
> Safe Restart



### 3.Jenkins 基础配置

**配置全局安全属性**

> 系统管理 --> 全局安全配置 -->  授权策略 --> 安全矩阵 添加新创建的用户

**添加用户**

>系统管理 --> 管理用户 --> 新建用户 --> 参照授权方法，授予出admin外所有全向



### 4.应用部署服务器

**安装并配置git**

安装

> [root@localhost jenkins]# yum -y install git

配置

> [root@localhost jenkins]# git config --global user.name "yui"
> [root@localhost jenkins]# git config --global user.email "786725551@qq.com"

生成秘钥

> [root@localhost .ssh]# ssh-keygen -t rsa -C "786725551@qq.com"
>
> [root@localhost .ssh]# cd ~/.ssh/
>
> [root@localhost .ssh]# ls
> id_rsa  id_rsa.pub

github配置

> login --> setting --> SSH AND GPG kyes

