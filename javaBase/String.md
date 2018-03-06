---
date: 2017-12-24 21:44
status: public
title: String
---

##String.valueOf,toString,(String)
###对于为空的对象转为String类型：
1.toString()
>
String ss = null;
System.out.println(ss.toString());

AND

>Object i = 100;
System.out.println(i.toString());

**输出:**
```
Exception in thread "main" java.lang.NullPointerException
```
```
100
```
2.String.valueOf()
>
System.out.println(String.valueOf(ss));
            System.out.println(String.valueOf(ss) == null);
            System.out.println(String.valueOf(ss).isEmpty());
            System.out.println(String.valueOf(ss) instanceof String);
            
AND
>
Object i = 100;
System.out.println(String.valueOf(i));        

**输出：**
```
null
false
false
true
```
```
100
```
*所以null是字符串的"null"*

3.(String)
>
System.out.println((String)ss);
System.out.println(((String)ss) == null);
System.out.println(((String)ss) instanceof String);

AND
>Object i = 100;
System.out.println((String)i);

**输出**
```
null
true
false
```
```
Exception in thread "main" java.lang.ClassCastException: java.lang.Integer cannot be cast to java.lang.String
```
*null 对象为空*

***综上所述，使用方法转空对象，toString()发生异常，String.valueOf()返回字符串"null"，（String）返回空null,强制转型发生类型不同是会报异常ClassCastException***

###源码分析
1.toString()
>
public String toString() {
        return getClass().getName() + "@" + Integer.toHexString(hashCode());
    }
    
**以上为object的toString,然而当你一个引用指向null时调用的toString方法并不是你的什么的对象的toString方法，null既不是对象也不是一种类型，它仅是一种特殊的值，你可以将其赋予任何引用类型，你也可以将null转化成任何类型,null不是对象，而是一个空指针，不是对象为null，而是变量为null,**
>
String o;
o = "ssss";
String s = "aaa";
String a = null;
```
Code:
       0: ldc           #2                  // String ssss
       2: astore_1
       3: ldc           #3                  // String aaa
       5: astore_2
       6: aconst_null
       7: astore_3
       8: return
注释：
0： 把常量池中的项压入栈
2：将引用类型或returnAddress类型值存入局部变量1
3： 把常量池中的项压入栈
5:将引用类型或returnAddress类型值存入局部变量2
6:将null对象引用压入栈
7:将引用类型或returnAddress类型值存入局部变量3
8:从方法中返回，返回值为void   
```
2.String.valueOf()
>
 public static String valueOf(Object obj) {
        return (obj == null) ? "null" : obj.toString();
    }

**所以如果对象为null时，返回字符串"null"**

3.(String)
强制转型

###字符串创建
>
String t1 = "abc";
        String t2 = "abc";
        System.out.println("t1 == t2 " + (t1 == t2));
        String t3 = "abc";
        String t4 = new String("abc");
        System.out.println("t3 == t4 " + (t3 == t4));
        String t5 = "abc";
        String t6 = "a" + "bc";
        System.out.println("t5 == t6 " + (t5 == t6));
        String t7 = "abc";
        String t8 = new String("abc");
        System.out.println("t7 == t8.intern() " + (t7 == t8.intern()));
        System.out.println("t8 == t8.intern() " + (t8 == t8.intern()));
        String t9 = "abc";
        String t10 = "a";
        String t11 = "bc";
        String t12 = t10 + t11;
        System.out.println("t9 == t11 " + (t9 == t11));
        
```
t1 == t2 true
t3 == t4 false
t5 == t6 true
t7 == t8.intern() true
t8 == t8.intern() false
t9 == t11 false
```

4.other  
**a.编译器优化**  
```
String t1 = new String("A" + "B");
String t2 = new String("AB");
```  
上述代码中，t1 == t2返回true，编译器在编译过程中把"A"+"B"优化成"AB";
