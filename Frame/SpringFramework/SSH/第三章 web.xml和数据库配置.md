---
date: 2017-12-09 13:04
status: public
title: '第三章 web.xml和数据库配置'
---

1.web.xml配置
IDEA自动生成配置如下
```
<!DOCTYPE web-app PUBLIC
 "-//Sun Microsystems, Inc.//DTD Web Application 2.3//EN"
 "http://java.sun.com/dtd/web-app_2_3.dtd" >

<web-app>
  <display-name>Archetype Created Web Application</display-name>
</web-app>
```
修改配置为：
```
<?xml version="1.0" encoding="UTF-8"?>
<web-app version="2.5" xmlns="http://java.sun.com/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://java.sun.com/xml/ns/javaee
    http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd">
  <error-page>
    <error-code>404</error-code>
    <location>/errorPage.jsp</location>
  </error-page>
  <!--配置监听器-->
  <listener>
    <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
  </listener>
  <context-param>
    <param-name>contextConfigLocation</param-name>
    <param-value>classpath:applicationContext.xml</param-value>
  </context-param>
  <!--配置servlet-->
  <servlet>
    <servlet-name>dispatcher</servlet-name>
    <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
    <init-param>
      <param-name>contextConfigLocation</param-name>
      <!--其中<param-value>**.xml</param-value> 这里可以使用多种写法-->
      <!--1、不写,使用默认值:/WEB-INF/<servlet-name>-servlet.xml-->
      <!--2、<param-value>/WEB-INF/classes/dispatcher-servlet.xml</param-value>-->
      <!--3、<param-value>classpath*:dispatcher-servlet.xml</param-value>-->
      <!--4、多个值用逗号分隔-->
      <param-value>classpath:dispatcher-servlet.xml</param-value>
    </init-param>
    <load-on-startup>1</load-on-startup>
  </servlet>
  <servlet-mapping>
    <servlet-name>dispatcher</servlet-name>
    <url-pattern>/</url-pattern>
  </servlet-mapping>

  <!-- 编码过滤器-->
  <filter>
    <filter-name>encodingFilter</filter-name>
    <filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
    <init-param>
      <param-name>encoding</param-name>
      <param-value>UTF-8</param-value>
    </init-param>
  </filter>
  <filter-mapping>
    <filter-name>encodingFilter</filter-name>
    <url-pattern>/*</url-pattern>
  </filter-mapping>
</web-app>
```
web.xml的加载过程是：context-param -> listener -> fileter -> servlet。
接着在resources目录下添加applicationContext.xml和dispatcher-servlet.xml

**applicationContext.xml：**
```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:aop="http://www.springframework.org/schema/aop" xmlns:tx="http://www.springframework.org/schema/tx"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop.xsd http://www.springframework.org/schema/tx http://www.springframework.org/schema/tx/spring-tx.xsd">
</beans>
```
**dispatcher-servlet.xml:**
```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:mvc="http://www.springframework.org/schema/mvc"
       xmlns:context="http://www.springframework.org/schema/context"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/mvc http://www.springframework.org/schema/mvc/spring-mvc.xsd http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd">
</beans>
```
**配置容器路径**

![Spring](https://github.com/XuZhuohao/studyNote-git-markdown-File-img/blob/master/studySSH/3/addSpringConfig.png?raw=true)
![Spring02](https://github.com/XuZhuohao/studyNote-git-markdown-File-img/blob/master/studySSH/3/addSpringConfig02.png?raw=true)
2.数据库配置
**打开database视图：**
![openDatabaseTool](https://github.com/XuZhuohao/studyNote-git-markdown-File-img/blob/master/studySSH/3/openDatabaseTool.png?raw=true)
**添加MySql数据源**
![addMySqlDataSource](https://github.com/XuZhuohao/studyNote-git-markdown-File-img/blob/master/studySSH/3/addMySqlDataSource.png?raw=true)
**配置数据源**
![mySqlDataSourceConfig](https://github.com/XuZhuohao/studyNote-git-markdown-File-img/blob/master/studySSH/3/mySqlDataSourceConfig.png?raw=true)
**添加目录结构**
![directoryStructure](https://github.com/XuZhuohao/studyNote-git-markdown-File-img/blob/master/studySSH/3/directoryStructure.png?raw=true)
**配置jdbc.properties**
```
jdbc.driver=com.mysql.jdbc.Driver
jdbc.url=jdbc:mysql://localhost:3306/webDemo?useUnicode=true&characterEncoding=UTF-8
jdbc.username=root
jdbc.password=a

initialPoolSize=3
minPoolSize=3
maxPoolSize=15
acquireIncrement=3
maxStatements=8
maxStatementsPerConnection=10
maxIdleTime=1800

hibernate.show_sql=true
hibernate.use_sql_comments=true
hibernate.dialect=org.hibernate.dialect.MySQLDialect
hibernate.jdbc.fetch_size=50
hibernate.jdbc.batch_size=30
hibernate.use_outer_join=true
hibernate.cache.use_query_cache=true
hibernate.query.factory_class=org.hibernate.hql.internal.ast.ASTQueryTranslatorFactory
```
**配置appicationContext.xml**
```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:aop="http://www.springframework.org/schema/aop" xmlns:tx="http://www.springframework.org/schema/tx"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop.xsd http://www.springframework.org/schema/tx http://www.springframework.org/schema/tx/spring-tx.xsd">
    <!-- 自动扫描与装配bean -->
    <context:component-scan base-package="org.yuihtt"/>

    <!-- 导入外部的properties文件-->
    <context:property-placeholder location="classpath:jdbc.properties"/>
    <bean name="DataSource" class="com.mchange.v2.c3p0.ComboPooledDataSource" destroy-method="close">
        <!-- 数据连接信息 -->
        <property name="jdbcUrl" value="${jdbc.url}"/>
        <property name="driverClass" value="${jdbc.driver}"/>
        <property name="user" value="${jdbc.username}"/>
        <property name="password" value="${jdbc.password}"/>
        <!-- 其他配置 -->
        <!--初始化时获取三个连接，取值应在minPoolSize与maxPoolSize之间。Default: 3 -->
        <property name="initialPoolSize" value="${initialPoolSize}"/>
        <!--连接池中保留的最小连接数。Default: 3 -->
        <property name="minPoolSize" value="${minPoolSize}"/>
        <!--连接池中保留的最大连接数。Default: 15 -->
        <property name="maxPoolSize" value="${maxPoolSize}"/>
        <!--当连接池中的连接耗尽的时候c3p0一次同时获取的连接数。Default: 3 -->
        <property name="acquireIncrement" value="${acquireIncrement}"/>
        <!-- 控制数据源内加载的PreparedStatements数量。如果maxStatements与maxStatementsPerConnection均为0，则缓存被关闭。Default: 0 -->
        <property name="maxStatements" value="${maxStatements}"/>
        <!--maxStatementsPerConnection定义了连接池内单个连接所拥有的最大缓存statements数。Default: 0 -->
        <property name="maxStatementsPerConnection" value="${maxStatementsPerConnection}"/>
        <!--最大空闲时间,1800秒内未使用则连接被丢弃。若为0则永不丢弃。Default: 0 -->
        <property name="maxIdleTime" value="${maxIdleTime}"/>
    </bean>

    <!-- 配置SessionFactory -->
    <bean id="sessionFactory" class="org.springframework.orm.hibernate4.LocalSessionFactoryBean">
        <!-- 配置c3p0数据库连接池 -->
        <property name="dataSource" ref="DataSource"/>
        <property name="hibernateProperties">
            <props>
                <prop key="hibernate.show_sql">
                    ${hibernate.show_sql}
                </prop>
                <prop key="hibernate.use_sql_comments">
                    ${hibernate.use_sql_comments}
                </prop>
                <!--<prop key="hibernate.hbm2ddl.auto">create</prop>-->
                <prop key="hibernate.dialect">
                    ${hibernate.dialect}
                </prop>
                <prop key="hibernate.jdbc.fetch_size">
                    ${hibernate.jdbc.fetch_size}
                </prop>
                <prop key="hibernate.jdbc.batch_size">
                    ${hibernate.jdbc.batch_size}
                </prop>
                <prop key="hibernate.use_outer_join">
                    ${hibernate.use_outer_join}
                </prop>
                <prop key="cache.use_query_cache">${hibernate.cache.use_query_cache}</prop>
                <prop key="hibernate.query.factory_class">${hibernate.query.factory_class}</prop>
            </props>
        </property>
        <!-- 自动扫描注解方式配置的hibernate类文件 -->
        <property name="packagesToScan" value="org.yuihtt.model"/>
    </bean>

    <!--<tx:annotation-driven transaction-manager="txManager"/>-->
    <bean id="txManager" class="org.springframework.orm.hibernate4.HibernateTransactionManager">
        <property name="sessionFactory" ref="sessionFactory"/>
    </bean>

    <!-- 配置事务事务属性 --><!--<tx:annotation-driven transaction-manager="txManager"/>-->
    <tx:advice id="txAdvice" transaction-manager="txManager">
        <tx:attributes>
            <tx:method name="save*" read-only="false" propagation="REQUIRED"/>
            <tx:method name="find*" read-only="true" propagation="REQUIRED"/>
            <tx:method name="delete*" propagation="REQUIRED"/>
            <tx:method name="*"/>
        </tx:attributes>
    </tx:advice>

    <!--<context:annotation-config/>-->
    <aop:config>
        <aop:pointcut id="txServices" expression="execution(* org.yuihtt.dao.*.*(..))"/>
        <aop:advisor advice-ref="txAdvice" pointcut-ref="txServices"/>
    </aop:config>

</beans>
```
**配置hibernate**
![addHibernate01](https://github.com/XuZhuohao/studyNote-git-markdown-File-img/blob/master/studySSH/3/addHibernate01.png?raw=true)
![addHibernate02](https://github.com/XuZhuohao/studyNote-git-markdown-File-img/blob/master/studySSH/3/addHibernate02.png?raw=true)
![addHibernate03](https://github.com/XuZhuohao/studyNote-git-markdown-File-img/blob/master/studySSH/3/addHibernate03.png?raw=true)
![addHibernate04](https://github.com/XuZhuohao/studyNote-git-markdown-File-img/blob/master/studySSH/3/addHibernate04.png?raw=true)
3.添加dao层
**UserDAO**
```
package org.yuihtt.dao;

import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;
import org.yuihtt.model.User;

import javax.annotation.Resource;
import java.util.List;


/**
 * Created by Administrator on 2017/12/13 0013.
 */
@Transactional
@Repository
public class UserDAO extends HibernateDaoSupport{
    @Resource
    public void setHibernateTemplate(SessionFactory sessionFactory) {
        super.setSessionFactory(sessionFactory);
    }

    public void save(User value) {
        this.getHibernateTemplate().saveOrUpdate(value);
    }

    public void delete(User value) {
        this.getHibernateTemplate().delete(value);
    }

    public User findByID(String key) {
        return this.getHibernateTemplate().get(User.class, key);
    }
    public List<User> findAll() {
        return this.getHibernateTemplate().loadAll(User.class);
    }
}
```
**BlogDAO**
```
package org.yuihtt.dao;

import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;
import org.yuihtt.model.Blog;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/12/13 0013.
 */
@Transactional
@Repository
public class BlogDAO extends HibernateDaoSupport {
    @Resource
    public void setHibernateTemplate(SessionFactory sessionFactory) {
        super.setSessionFactory(sessionFactory);
    }

    public void save(Blog value) {
        this.getHibernateTemplate().saveOrUpdate(value);
    }

    public void delete(Blog value) {
        this.getHibernateTemplate().delete(value);
    }

    public Blog findByID(String key) {
        return this.getHibernateTemplate().get(Blog.class, key);
    }

    public List<Blog> findAll() {
        return this.getHibernateTemplate().loadAll(Blog.class);
    }
}
```

4.测试
**添加测试类：TestUser**
```
package org.yuihtt.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.yuihtt.dao.UserDAO;
import org.yuihtt.model.User;

import javax.annotation.Resource;

/**
 * Created by Administrator on 2017/12/13 0013.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class TestUser {
    private UserDAO userDAO;

    @Resource
    public void setUserDAO(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    @Test
    //测试save
    public void testSave() throws Exception {
        User user = new User();
        user.setUid(1);
        user.setUsername("123");
        user.setPassword("456");
        userDAO.save(user);
    }
}
```
**选中测试类**

![addTestResouce](https://github.com/XuZhuohao/studyNote-git-markdown-File-img/blob/master/studySSH/3/addTestResouce.png?raw=true)
**运行测试方法**
![testRun01](https://github.com/XuZhuohao/studyNote-git-markdown-File-img/blob/master/studySSH/3/testRun01.png?raw=true)
**数据库查看测试结果**
![testRun02](https://github.com/XuZhuohao/studyNote-git-markdown-File-img/blob/master/studySSH/3/testRun02.png?raw=true)