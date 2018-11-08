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
![Persistence](https://www.github.com/XuZhuohao/studyNote-git-markdown-File-img/raw/master/ByDate/18/1539852944889.png)
**右键Generate Persistence Mapping -->By Database Schema**
![Import Database Schema](https://www.github.com/XuZhuohao/studyNote-git-markdown-File-img/raw/master/ByDate/18/1539853088528.png)

**点击Import Database Schema 中的Choose Data Source 新建一个数据源**
**在Data Sources and Drivers中新建一个数据源，这里我用的是mysql**
![Data Sources and Drivers](https://www.github.com/XuZhuohao/studyNote-git-markdown-File-img/raw/master/ByDate/18/1539853254137.png)
**缺少驱动是点击下载**
![Drive Download](https://www.github.com/XuZhuohao/studyNote-git-markdown-File-img/raw/master/ByDate/18/1539853517384.png)

**外部导入驱动如下**
![Drive Link01](https://www.github.com/XuZhuohao/studyNote-git-markdown-File-img/raw/master/ByDate/18/1539853613534.png)
![Drive Link02](https://www.github.com/XuZhuohao/studyNote-git-markdown-File-img/raw/master/ByDate/18/1539853595867.png)

**这里我选择的是我maven仓库里的jar包**
![my drive](https://www.github.com/XuZhuohao/studyNote-git-markdown-File-img/raw/master/ByDate/18/1539853746931.png)
#### 1.4.3 生成实体类
**生成实体类配置**  
![at the end](https://www.github.com/XuZhuohao/studyNote-git-markdown-File-img/raw/master/ByDate/18/1539853954411.png)

**大功告成**  
![success](https://www.github.com/XuZhuohao/studyNote-git-markdown-File-img/raw/master/ByDate/18/1539854584128.png)

## 2.Quick Start
(这里用由Entity到表举例)
### 2.1 引入依赖和配置（见前面）

### 2.2 构建Entity对象
```
package com.yui.study.springdatajpa.entity;

import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;

/**
 * 注解学习实体类
 *
 * @author XuZhuohao
 * @date 2018/10/19
 */
@Setter
@Getter
@Entity
public class AnnotationEntity {
    @Id
    private Long id;

    @Basic(fetch = FetchType.LAZY, optional = false)
    private String name;
}
```
**@Setter @Getter:**
这两个是 lombok 的注解，为属性提供get，set方法，直接写get set也一样
### 2.3 构建Repository接口
**根据不同的需求可以继承不同的Repository，或者扩展自己的Repository**  
泛型传入实体类型，主键类型
```
package com.yui.study.springdatajpa.repository;

import com.yui.study.springdatajpa.entity.AnnotationEntity;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Repository
 *
 * @author XuZhuohao
 * @date 2018/10/19
 */
public interface AnnotationRepository extends JpaRepository<AnnotationEntity, Long> {
}
```
### 2.4 测试代码
```
	@Autowired
    private AnnotationRepository annotationRepository;

    @Test
    public void testQuickStart(){
        AnnotationEntity annotationEntity = new AnnotationEntity();
        annotationEntity.setId(1L);
        annotationEntity.setName("test01");
        annotationRepository.save(annotationEntity);
    }
```
