# SpringData-Jpa-Base

## 3 注解
**说明:** 对于实体类中属性的 Setter 和 Getter 均使用 lombok 注解实现

### 3.1 @Entity
- 指定实体类
- 必须指定@Id
#### 3.1.1 name
指定实体名称（表名）：
- 没有指定name属性且没有使用@Table，命名为类名生成
- 指定name属性且没有使用@Table，命名为name属性value值
- 指定了name属性且使用了@Table指定name，命名以@Table的name的value

### 3.2 @Table
**类型:** ElementType.TYPE

**代码示例**
```
package com.yui.study.springdatajpa.note.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Setter
@Getter
@Entity
@Table(name = "student",
        uniqueConstraints = {@UniqueConstraint(name = "unique_stu_idCardNo", columnNames = "idCardNo")},
        indexes = {@Index(name = "index_stu_loginId", columnList = "studNo", unique = true),
                @Index(name = "index_stu_age_height_weight", columnList = "age,height,weight")},
        catalog = "spring_data_jpa", schema = "removal")
public class StudentEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private String idCardNo;

    private int studNo;

    private int age;

    private double height;

    private double weight;
}


```
**生成数据库语句**
```
CREATE TABLE spring_data_jpa.student (
	id BIGINT NOT NULL auto_increment,
	age INTEGER NOT NULL,
	height DOUBLE PRECISION NOT NULL,
	id_card_no VARCHAR ( 255 ),
	NAME VARCHAR ( 255 ),
	stud_no INTEGER NOT NULL,
	weight DOUBLE PRECISION NOT NULL,
	PRIMARY KEY ( id ) 
) ENGINE = INNODB;
CREATE INDEX index_stu_age_height_weight ON spring_data_jpa.student ( age, height, weight );
ALTER TABLE spring_data_jpa.student ADD CONSTRAINT unique_stu_idCardNo UNIQUE ( id_card_no );
ALTER TABLE spring_data_jpa.student ADD CONSTRAINT index_stu_loginId UNIQUE ( stud_no );
```

#### 3.2.1 name
name 属性指定表名

#### 3.2.2 indexes
**声明表的索引**
```
 indexes = {@Index(name="index_stu_loginId", columnList = "studNo", unique = true),
        @Index(name="index_stu_age_height_weight", columnList = "age,height,weight", unique = false)})
```
声明索引，赋值索引数组，用  **@Index** 来声明创建索引
##### 3.2.2.1 @index
**name:** 指定索引名称  
**columnList：** 指定索引对应的属性名称(映射为字段)，可创建联合索引，如 index_stu_age_height_weight 所示  
**unique：**  指定索引是否为唯一索引，默认为false，如果为true，功能与属性 uniqueConstraints 一直，见 3.2.2 

#### 3.2.3 uniqueConstraints
**声明表的唯一索引**
```
uniqueConstraints = {@UniqueConstraint(name = "unique_stu_idCardNo", columnNames = "idCardNo")}
```
声明唯一索引，赋值唯一索引数组，用  **@UniqueConstraint** 来声明创建唯一索引

##### 3.2.3.1 @UniqueConstraint
**name:** 指定唯一索引名称  
**columnList：** 指定唯一索引对应的属性名称(映射为字段)，可创建联合唯一索引

#### 3.2.4 catalog
*这个概念不是了解，以下就以 mysql ，对应 jpa 来说明。*  
**catalog 配置数据库的库名。**
```
catalog = "spring_data_jpa",
```
**修改数据库配置**
```
spring:
  datasource:
    url: jdbc:mysql://127.0.0.1?useSSL=false&useUnicode=true&characterEncoding=utf8&autoReconnect=true
    username: root
    password: a
    driver-class-name: com.mysql.jdbc.Driver
```
***其实在配置文件 url 指定连接的库后，也可以通过 catalog 操作别的库，只有账号权限足够***

**执行测试用例，代码正常执行**
**删除 catalog ,重新执行代码, 出现异常**
```
Caused by: java.sql.SQLException: No database selected
```

**总结：对于数据库连接来说，并不需要通过 url 指定连接的库名，可以通过指定连接的实例的地址和端口(没指定端口时默认使用 3306 )，再通过实体Entity 的 @Table 中的 catalog 来指定表对应的库即可，可以在同个实例下操作多个库(需要账号有库的权限)**


### 3.2.5 schema
***没有经过测试的想法都不可信= =，本小结内容纯属论证(而且是非演绎论证，哈哈哈)。。因为我不想搭建 oracle = =***


### 3.2.6 catalog & schema
```
对于 oracle 来说
我们可以会这么做：
在数据库 db01 下
创建用户A， A下创建表ta1, ta2
创建用户B， B下参加表tb1, tb2
创建用户C， A授与C，操作 ta1， ta2的权限； B授与C，操作tb1， tb2 的权利。

应用程序通过用户C连接数据库实例 db01， 通过 A.ta1， A.ta2, B.tb1, B.tb2 (通常我们会通过建立同义词来使用表名操作表，但是同义词的表名实质上还是等于 用户名.表名)访问表。

=====
对于 mysql 来说
我们可以这样做：
在数据库实例(指数据库连接)下，
创建库 dbA， dbA 下创建表tdba1, tdba2,
创建库 dbB， dbB 下创建表tdbb1, tdbb2,
创建用户A， 拥有管理 dbA 库 和 dbB 库的权限。

应用程序通过数据库连接，用户A的账号和密码，连接到数据库实例中来，
应用程序通过 dbA.tdba1, dbA.tdba2, dbB.tdba1, dbB.tdba2, 来访问表。

========
以上是 Mysql 和 Oracle 的一个差别

对于 catalog & schema 不是特别理解，请问了下 DBA ，大概可以这么理解，一个数据库里面有多个 catalog，一个 catalog 里面有多个 schema，mysql和oracle 没有 catalog这个概念，= =(dba 还给我看了一下其他库比如 Sybase 的实例，嗯，我就记得，没错有个 catalog 目录- -)

也就说，对于Mysal 和 Oracle 来说，访问表是通过 schema.table 来指定，而两者不同的是 mysql 的 schema 是库名， 而 oracle 的 schema 是 用户名。那么 拥有 catalog 和 schema 的数据库产品来说， 指定一个表就是通过 catalog.schema.tableName 

=====
以上是在数据库层面来分析的

```
#### 3.2.6.1 **JPA 源码解读01**
##### createContainerEntityManagerFactory
从 org.springframework.orm.jpa.vendor.SpringHibernateJpaPersistenceProvider#createContainerEntityManagerFactory  开始看起，在这个方法是创建Entity的容器管理工厂
```
@Override
	@SuppressWarnings("rawtypes")
	public EntityManagerFactory createContainerEntityManagerFactory(PersistenceUnitInfo info, Map properties) {
		final List<String> mergedClassesAndPackages = new ArrayList<>(info.getManagedClassNames());
		if (info instanceof SmartPersistenceUnitInfo) {
			mergedClassesAndPackages.addAll(((SmartPersistenceUnitInfo) info).getManagedPackages());
		}
		return new EntityManagerFactoryBuilderImpl(
				new PersistenceUnitInfoDescriptor(info) {
					@Override
					public List<String> getManagedClassNames() {
						return mergedClassesAndPackages;
					}
				}, properties).build();
	}
```
*入参 properties* ，是在 yml 中或者默认的各项配置，如下：
```
{
	"hibernate.transaction.jta.platform": {
		"currentStatus": 5
	},
	"hibernate.hbm2ddl.auto": "create",
	"hibernate.id.new_generator_mappings": "true",
	"hibernate.physical_naming_strategy": "org.springframework.boot.orm.jpa.hibernate.SpringPhysicalNamingStrategy",
	"hibernate.connection.handling_mode": "DELAYED_ACQUISITION_AND_HOLD",
	"hibernate.dialect": "org.hibernate.dialect.MySQL5InnoDBDialect",
	"hibernate.implicit_naming_strategy": "org.springframework.boot.orm.jpa.hibernate.SpringImplicitNamingStrategy",
	"hibernate.show_sql": "true"
}
```
*入参 info* ,指定实体类位置，我这里是 juint test 所以对应到 /target/test-classes中
```
PersistenceUnitInfo: name 'default', root URL [file:/D:/Projects/StudySource/spring-data-jpa/target/test-classes/]
```
##### MetadataBuildingProcess#complete
从build 一路进到， org.hibernate.boot.model.process.spi.MetadataBuildingProcess#complete
这个代码有点长就不全写了= =
```
public static MetadataImplementor complete(final ManagedResources managedResources, final MetadataBuildingOptions options) {
		final BasicTypeRegistry basicTypeRegistry = handleTypes( options );
		final InFlightMetadataCollectorImpl metadataCollector = new InFlightMetadataCollectorImpl(
				options,
				new TypeResolver( basicTypeRegistry, new TypeFactory() )
		);
		...
		
}
```
*参数 managedResources*
```
{
	"annotatedClassNames": ["com.yui.study.springdatajpa.note.entity.StudentEntity"],
	"annotatedClassReferences": [],
	"annotatedPackageNames": [],
	"attributeConverterDefinitions": [],
	"xmlMappingBindings": []
}
```
*参数 options*
```
{
	"attributeConverters": [],
	"auxiliaryDatabaseObjectList": [],
	"basicTypeRegistrations": [],
	"hcannClassLoaderDelegate": {},
	"idGenerationTypeInterpreter": {},
	"implicitNamingStrategy": {},
	"jpaGeneratorGlobalScopeComplianceEnabled": false,
	"mappingDefaults": {
		"autoImportEnabled": true,
		"implicitCascadeStyleName": "none",
		"implicitDiscriminatorColumnName": "class",
		"implicitIdColumnName": "id",
		"implicitPropertyAccessorName": "property",
		"implicitTenantIdColumnName": "tenant_id"
	},
	"multiTenancyStrategy": "NONE",
	"physicalNamingStrategy": {},
	"reflectionManager": {
		"classLoaderDelegate": {
			"$ref": "$.hcannClassLoaderDelegate"
		},
		"defaults": {
			"javax.persistence.EntityListeners": []
		},
		"metadataProvider": {
			"defaults": {
				"$ref": "$.reflectionManager.defaults"
			},
			"xMLContext": {
				"allDocuments": [],
				"defaultEntityListeners": []
			}
		}
	},
	"scanEnvironment": {
		"explicitlyListedClassNames": ["com.yui.study.springdatajpa.note.entity.StudentEntity"],
		"explicitlyListedMappingFiles": [],
		"nonRootUrls": [],
		"rootUrl": "file:/D:/Projects/StudySource/spring-data-jpa/target/test-classes/"
	},
	"scanOptions": {},
	"serviceRegistry": {
		"active": true,
		"parentServiceRegistry": {
			"active": true
		}
	},
	"sharedCacheMode": "UNSPECIFIED",
	"sourceProcessOrdering": ["HBM", "CLASS"],
	"specjProprietarySyntaxEnabled": false,
	"sqlFunctions": {}
}
```

final BasicTypeRegistry basicTypeRegistry = handleTypes( options );
生成数据库基本数据类型  


##### SingleTableEntityPersister
一路走到
org.hibernate.persister.entity.SingleTableEntityPersister#SingleTableEntityPersister
里面有一行就是生成表名的
```
qualifiedTableNames[0] = determineTableName( table, jdbcEnvironment );
```
##### determineTableName
**向里面看**
```
protected String determineTableName(Table table, JdbcEnvironment jdbcEnvironment) {
		if ( table.getSubselect() != null ) {
			return "( " + table.getSubselect() + " )";
		}

		return jdbcEnvironment.getQualifiedObjectNameFormatter().format(
				table.getQualifiedTableName(),
				jdbcEnvironment.getDialect()
		);
	}
```
其中 table.getQualifiedTableName() -> spring_data_jpa.removal.student
        jdbcEnvironment.getDialect() -> org.hibernate.dialect.MySQL5InnoDBDialect
继续往里走=_=

##### QualifiedObjectNameFormatterStandardImpl#format
org.hibernate.engine.jdbc.env.internal.QualifiedObjectNameFormatterStandardImpl#format(org.hibernate.boot.model.relational.QualifiedTableName, org.hibernate.dialect.Dialect)
```
@Override
	public String format(QualifiedTableName qualifiedTableName, Dialect dialect) {
		return format.format(
				qualifiedTableName.getCatalogName(),
				qualifiedTableName.getSchemaName(),
				qualifiedTableName.getTableName(),
				dialect
		);
	}
```
org.hibernate.engine.jdbc.env.internal.QualifiedObjectNameFormatterStandardImpl.CatalogNameFormat#format
```
@Override
		public String format(Identifier catalog, Identifier schema, Identifier name, Dialect dialect) {
			StringBuilder buff = new StringBuilder();

			if ( catalog != null ) {
				buff.append( render( catalog, dialect ) ).append( catalogSeparator );
			}

			buff.append( render( name, dialect ) );

			return buff.toString();
		}
```
这里可以看到。。。只有判断 catalog ,也只拼接 catalog，对于 schema 没有进行处理
#### 3.2.6.2 **JPA 源码解读02**
回到**MetadataBuildingProcess#complete** 的生成生成数据库基本数据类型的语句 final BasicTypeRegistry basicTypeRegistry = handleTypes( options ); 往里面走，一路走到 org.hibernate.engine.jdbc.env.internal.QualifiedObjectNameFormatterStandardImpl#QualifiedObjectNameFormatterStandardImpl(org.hibernate.engine.jdbc.env.spi.NameQualifierSupport, java.lang.String, boolean)

**buidFormat**
```
private Format buildFormat(
			NameQualifierSupport nameQualifierSupport,
			String catalogSeparator,
			boolean catalogAtEnd) {
		switch ( nameQualifierSupport ) {
			case NONE: {
				return NoQualifierSupportFormat.INSTANCE;
			}
			case CATALOG: {
				return catalogAtEnd
						? new NameCatalogFormat( catalogSeparator )
						: new CatalogNameFormat( catalogSeparator );
			}
			case SCHEMA: {
				return SchemaNameFormat.INSTANCE;
			}
			default: {
				return catalogAtEnd
						? new SchemaNameCatalogFormat( catalogSeparator )
						: new CatalogSchemaNameFormat( catalogSeparator );
			}
		}
	}
```

这里其实就是根据 nameQualifierSupport 去选择不同的格式对象
nameQualifierSupport 来自 org.hibernate.engine.jdbc.env.internal.JdbcEnvironmentImpl#determineNameQualifierSupport 里面会调用通过 SPI 实现的数据库驱动程序实现的方法生成
com.mysql.jdbc.DatabaseMetaData#supportsCatalogsInTableDefinitions
com.mysql.jdbc.DatabaseMetaData#supportsSchemasInTableDefinitions
所以吐血吐完= =

#### 3.2.6.3 总结

- 对应的规则以 org.hibernate.engine.jdbc.env.internal.JdbcEnvironmentImpl#determineNameQualifierSupport 得到的 NameQualifierSupport 有关

- NameQualifierSupport 根据对应数据库驱动的
com.mysql.jdbc.DatabaseMetaData#supportsCatalogsInTableDefinitions
com.mysql.jdbc.DatabaseMetaData#supportsSchemasInTableDefinitions
获得

- org.hibernate.engine.jdbc.env.internal.QualifiedObjectNameFormatterStandardImpl#buildFormat根据 NameQualifierSupport 使用不同的 org.hibernate.engine.jdbc.env.internal.QualifiedObjectNameFormatter

- 不同的 QualifiedObjectNameFormatter 实现类 format 去生成 table name 的 sql 语句(与 catalog 和 schema 有关的语句)

- org.hibernate.persister.entity.SingleTableEntityPersister#SingleTableEntityPersister 生成建表语句

**对于mysql的驱动(和版本有关，这里使用5.0的) 使用 org.hibernate.engine.jdbc.env.internal.QualifiedObjectNameFormatterStandardImpl.CatalogNameFormat#format 进行格式化，只与 catalog 有关， 所以 @Table 中的 schema 取啥值都没有影响=_=，至少从数据库建表语句上看是没有影响的。。。**