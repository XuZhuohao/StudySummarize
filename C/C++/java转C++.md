



## 1. 运行流程



### 1.1 java

```flow
flowchat
	src=>operation: 源码.java
	byte=>operation: 字节码.class
	run=>operation: jvm运行
	t1=>subroutine: 词法分析
	t2=>subroutine: 语法分析
	t3=>subroutine: 语义分析
	java=>operation: java|past
	javac=>operation: javac|past
	src->javac->t1->t2->t3->byte->java->run
```



### 1.2 Cpp

```flow

```





## 2. Hello World

**java:**

```java

public class FirstApplication{
    
    public static void main(String[] args) {
        System.out.println("Hello World");
    }
    
}
```

**Cpp:**

```c++
#include <iostream>

int main() {
	std::cout << "Hello World" << std::endl;
	return 0;
}
```





## 3. 变量

| 变量名         | java    | java | C++     | C++    |
| -------------- | ------- | ---- | ------- | ------ |
| 变量名         | 声明    | 长度 | 声明    | 长度   |
| 布尔类型       | boolean | 8   | bool      | 未定义  |
| 字节 | byte | 8 | -- | -- |
| 字符           | char | 16 | char      | 8              |
| 宽字符         | -- | -- | wchar_t   | 16          |
| Unicode 字符   | -- | -- | char16_t  | 16    |
| Unicode 字符   | -- | -- | char32_t  | 32     |
| 短整型         | short | 16 | short     | 16          |
| 整型           | int | 32 | int       | 16            |
| 长整型         | long | 64 | long      | 32           |
| 长整型         | -- | -- | long long | 64          |
| 单精度浮点数   | float | 32 | float | 6 位有效数字 |
| 双精度浮点数   | double | 64 | double | 10 位有效数字 |
| 扩展精度浮点数 | -- | -- | long doubl | 10 位有效数字 |

- C++:
  - 算数类型分为整型（integral type,  包括字符和布尔类型在内）和浮点型
  - 算数类型的大小（占位）在不同机器上有所不同，上方列出**最小值**
  - *C++ 语言规定一个 int 至少和一个 short 一样大， 一个 long 至少和一个 int 一样大， 一个 long long 至少和一个 long 一样大。其中，数据类型 long long 是在 C++Ⅱ 中新定义的*



