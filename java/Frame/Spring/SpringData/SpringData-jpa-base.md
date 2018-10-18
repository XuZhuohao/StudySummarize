# SpringData-Jpa-Base
## 1 构建项目

### 1.1 依赖
[Spring Initializr](https://start.spring.io/)
```
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-data-jpa</artifactId>
</dependency>
```

### 1.2 配置
#### 1.2.1 示例

``` *.yml
spring:
  datasource:
    url: jdbc:mysql://127.0.0.1/spring_data_jpa?useSSL=false&useUnicode=true&characterEncoding=utf8&autoReconnect=true
    username: root
    password: a
    driver-class-name: com.mysql.jdbc.Driver
  jpa:
    hibernate:
      ddl-auto: update
    show-sql: true
```
#### 1.2.2 说明
**ddl-auto**

create 启动时删数据库中的表，然后创建，退出时不删除数据表
create-drop 启动时删数据库中的表，然后创建，退出时删除数据表 如果表不存在报错
update 如果启动时表格式不一致则更新表，原有数据保留
validate 项目启动表结构进行校验 如果不一致则报错

**show-sql**
是否在控制台显示执行操作的对应sql语句，默认为false

### 1.3 从实体类生成表结构
配置文件的 ddl-auto 参数配置

### 1.4 从表结构生成实体类
#### 1.4.1 添加项目jpa module
**按下Ctrl+ Shift + Alt + S**
![添加module](https://www.github.com/XuZhuohao/studyNote-git-markdown-File-img/raw/master/ByDate/18/1539852635570.png)
**再点ok**
#### 1.4.2 配置数据源
**多出选项卡 Persistence**
![enter description here](https://www.github.com/XuZhuohao/studyNote-git-markdown-File-img/raw/master/ByDate/18/1539852944889.png)
**右键Generate Persistence Mapping -->By Database Schema**
![enter description here](https://www.github.com/XuZhuohao/studyNote-git-markdown-File-img/raw/master/ByDate/18/1539853088528.png)

**点击Import Database Schema 中的Choose Data Source 新建一个数据源**
**在Data Sources and Drivers中新建一个数据源，这里我用的是mysql**
![enter description here](https://www.github.com/XuZhuohao/studyNote-git-markdown-File-img/raw/master/ByDate/18/1539853254137.png)
**缺少驱动是点击下载**
![enter description here](https://www.github.com/XuZhuohao/studyNote-git-markdown-File-img/raw/master/ByDate/18/1539853517384.png)

**外部导入驱动如下**
![enter description here](https://www.github.com/XuZhuohao/studyNote-git-markdown-File-img/raw/master/ByDate/18/1539853613534.png)
![enter description here](https://www.github.com/XuZhuohao/studyNote-git-markdown-File-img/raw/master/ByDate/18/1539853595867.png)

**这里我选择的是我maven仓库里的jar包**
![enter description here](https://www.github.com/XuZhuohao/studyNote-git-markdown-File-img/raw/master/ByDate/18/1539853746931.png)
#### 1.4.3 生成实体类
**生成实体类配置**
![enter description here](https://www.github.com/XuZhuohao/studyNote-git-markdown-File-img/raw/master/ByDate/18/1539853954411.png)
**大功告成**
![enter description here](https://markdown.xiaoshujiang.com/img/spinner.gif "[[[1539854009493]]]" )


## 2 代码实现

### 2.1 