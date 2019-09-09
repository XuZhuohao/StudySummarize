# jenkins+Playbooks
**后端部署**
## 1.说明
我们公司使用的并不是单纯的 jenkins，而是 jenkins + ansible-Playbooks 来部署项目的，这里主要讲快速构建一个 jenkins 项目（当然目前测环境中部分使用 Rancher 部署更加方便，部署发布升级更加无感知和自动化，想尝试新的东西请参照其他文章）
## 2.一个新任务
**2.1 和 2.2选一个即可**
### 2.1 复制一个任务
（一般采用直接复制旧的项目，然后修改对应配置即可）
**如果需要快速搭建一个新任务，只需要找对应类型的项目复制然后修改就行了，目前我们公司有 war, tar.gz, spring-boot.jar 几种**
[create new job.png](create new job.png)

[create new job02.png](create new job02.png)

**参数相关参见 2.2 填写相关参数**

### 2.2 创建一个新任务
- 创建一个新任务
[create new job03.png](create new job03.png)

- 填写相关参数
[create new job04.png](create new job04.png)

## 3 参数化构建过程
### 3.1 Post Steps
命令填写
```shell
cd /data/ansible/jenkins-ansible-supervisor-deploy
ansible-playbook -i hosts push.yml --verbose --extra-vars "target_host=$target_host  deploy_path=$deploy_path deploy_war_path=$WORKSPACE/$war_path node=$node app_name=$app_name app=$app_config_name" 
```

> cd /data/ansible/jenkins-ansible-supervisor-deploy

定位带 jenkins-ansible-supervisor-deploy 目录（为下一条命令 ansible-playbook 定位一个目录，不用这一句可以把下条中指定的 hosts，push.yml 指定绝对路径） 

#### 3.1.1 ansible-playbook
- -i 
INVENTORY, 指定 hosts 文件的地址

- hosts 
指定 hosts文件，详细见下文

- push.yml
主要执行的脚本，详细见下文

- --verbose
输入执行日志

- --extra-vars "target_host=$target_host  deploy_path=$deploy_path deploy_war_path=$WORKSPACE/$war_path node=$node app_name=$app_name app=$app_config_name" 
传递参数，比如 target_host=$target_host , 指定脚本参数， target_host 为 **参数化构建过程** 配置的 target_host 配置

#### 3.1.2 target_host
一般你第一次部署，问老员工都会让你去找 IDC 组，为你所属的机器申请一个 target_host ，那么 target_host 是一个说明东西呢？这我们就要讲讲 hosts 文件
- hosts 文件
Ansible 可同时操作属于一个组的多台主机,组和主机之间的关系通过 inventory 文件配置. 默认的文件路径为 /etc/ansible/hosts，我们使用的是 /data/ansible/jenkins-ansible-supervisor-deploy/hosts ,一般申请个 target_host 就是再 hosts 文件中添加以下配置
```
[target_host_name]
xxx.xxx.xxx.xx1 ansible_ssh_user=username   ansible_ssh_pass=password
xxx.xxx.xxx.xx2 ansible_ssh_user=username   ansible_ssh_pass=password
```
- target_host_name
ansible 中组的概念，即通过一个组名，代表组内的所有机子，这个 target_host_name 也是 $target_host 的值

- xxx.xxx.xxx.xx1 ansible_ssh_user=username   ansible_ssh_pass=password
这一行就是一台主机，
xxx.xxx.xxx.xx1 填 ip(域名) ,
ansible_ssh_user 登录对应主机的用户名
ansible_ssh_pass 用户对应的密码

#### 3.1.3 push.yml
这个是指定 playbooks 的执行脚本,这个脚本模版相对固定，
```
# This playbook deploys a simple standalone Tomcat 7 server. 

- hosts: "{{ target_host }}"
  user: appadm
  
  roles:
    - deploy-war02

```
- hosts
指定托管的主机组，以一个组名管理一批主机

- user
指定当前机子执行脚本的用户(当前机子不是目标机子)

- roles
Roles 基于一个已知的文件结构，去自动的加载某些 vars_files，tasks 以及 handlers
这里指定了 deploy-war02，可以查看 /data/ansible/jenkins-ansible-supervisor-deploy/roles/deploy-war02/task/main/main.yml 这就是 最终执行的脚本


### 3.2 脚本详解 om-platform.yml	
```
#- name: 停止服务
 # command: sh {{deploy_path}}/{{app_name}}/stop.sh

#- name: 删除旧目录
  #file: path={{deploy_path}}{{app_name}}* state=absent
  
- name: 复制压缩包至指定目录
  copy:  src={{deploy_war_path}}/{{tar_name}} dest={{deploy_path}}

- name: 删除lib目录，防止jar包版本变动造成classNotFound的错误
  file: path={{deploy_path}}/{{app_name}}/lib state=absent
- name: 解压缩文件至指定目录
  shell: tar -zxvf {{deploy_path}}/{{tar_name}} -C {{deploy_path}}/

- name: 初始化服务目录
  command: /bin/sh {{deploy_path}}/init.sh {{app_name}}

- name: 进入目录
  shell: cd {{deploy_path}}/{{app_name}} && sh stop.sh && sh start.sh

#- name: 启动服务
#  shell: sh start.sh
#- name: cd deploy_path
#  shell: cd {{deploy_path}}/

#- name: start  service
#  shell: sh {{deploy_path}}/startService.sh {{deploy_path}}/{{ app_name }}

```