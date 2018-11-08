# SpringData-Jpa-Base

## 3 注解
### 3.1 @Entity
- 指定实体类
- 必须指定@Id
#### 3.1.1 name
指定实体名称（表名）：
- 没有指定name属性且没有使用@Table，命名为类名生成
- 指定name属性且没有使用@Table，命名为name属性value值
- 指定了name属性且使用了@Table指定name，命名以@Table的name的value
### 3.1 @Id
定义主键

### 3.2 @GeneratedValue
**定义主键生成方式**  

### 3.3 @Basic
```
@Target({METHOD, FIELD})
@Retention(RUNTIME)
public @interface Basic {

    FetchType fetch() default EAGER;

    boolean optional() default true;
}
```
#### 2.1.1 fetch
数据加载策略  
FetchType.LAZY： 懒加载
FetchType.EAGER： 即时加载

#### 2.1.2 optional
