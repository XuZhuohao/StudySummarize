# dubbo 线程等待

## 1.问题描述
同事写了一个项目，提供一个依赖，业务项目添加依赖自动通过 dubbo 去调用核心模块，注册项目信息，并定时发送心跳信息保持在线。今天应用突然就从核心模块下线了。但是并没提示什么异常。定时发送消息处线程while(true)不停地调用，代码用 try...catch...包裹住，不可能出现线程结束的。线程中有 debug 日志，但是项目日志级别为 info 。所以看不出问题所在。

## 2.问题解决过程
### 2.1 通过 arthas 调整任务级别
> [arthas@86747] logger

```
 name                              ROOT                                                                                                                                                                  
 class                             ch.qos.logback.classic.Logger                                                                                                                                         
 classLoader                       sun.misc.Launcher$AppClassLoader@5c647e05                                                                                                                             
 classLoaderHash                   5c647e05                                                                                                                                                              
 level                             INFO                                                                                                                                                                  
 effectiveLevel                    INFO                                                                                                                                                                  
 additivity                        true                                                                                                                                                                  
 codeSource                        file:/data/springboot/short-message-service/lib/logback-classic-1.2.3.jar                                                                                             
 appenders                         name            CONSOLE                                                                                                                                               
                                   class           ch.qos.logback.core.ConsoleAppender                                                                                                                   
                                   classLoader     sun.misc.Launcher$AppClassLoader@5c647e05                                                                                                             
                                   classLoaderHash 5c647e05                                                                                                                                              
                                   target          System.out 
```
> [arthas@86747] logger --name=ROOT level=debug

通过 arthas 调整日志级别后仍然没有日志输出

### 2.2 通过 arthas 调用看是否正常
- 监控请求来记录应该引用
> tt -t org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter invokeHandlerMethod

```
[arthas@86747]$ tt -t org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter invokeHandlerMethod
Press Q or Ctrl+C to abort.
Affect(class-cnt:1 , method-cnt:1) cost in 74 ms.
 INDEX       TIMESTAMP                       COST(ms)       IS-RET       IS-EXP      OBJECT                  CLASS                                         METHOD                                        
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 1000        2019-11-20 16:45:33             93.959743      true         false       0x1f3aa970              RequestMappingHandlerAdapter                  invokeHandlerMethod                           

```

- 通过保存的引用下标获取对象，并通过 ognl 调用对应的方法
*其实就是调用  org.springframework.context.support.ApplicationObjectSupport#getApplicationContext 获取一个 ApplicationContext()，然后从 ApplicationContext() 中获取一个名称为 bizStarter 的 Bean 并调用其 initialize() 方法*  
> [arthas@86747] tt -i 1000 -w 'target.getApplicationContext().getBean("bizStarter").initialize()'

- 结论
对应的日志打印了一轮，然后就再也没反应了。推断出可能是线程阻塞了。

### 2.3 分析堆栈信息
> [appadm@ZJJt_tomcat_240_50 ~] jstack -l 86747 >> jstack.log  

*86747 为对应 pid*
```
...
"Thread-2" #35 prio=5 os_prio=0 tid=0x00007fa0963b6000 nid=0xf974 waiting on condition [0x00007fa0198f0000]
   java.lang.Thread.State: TIMED_WAITING (parking)
	at sun.misc.Unsafe.park(Native Method)
	- parking to wait for  <0x00000000e27d9bd8> (a java.util.concurrent.locks.AbstractQueuedSynchronizer$ConditionObject)
	at java.util.concurrent.locks.LockSupport.parkNanos(LockSupport.java:215)
	at java.util.concurrent.locks.AbstractQueuedSynchronizer$ConditionObject.await(AbstractQueuedSynchronizer.java:2163)
	at com.alibaba.dubbo.remoting.exchange.support.DefaultFuture.get(DefaultFuture.java:148)
	at com.alibaba.dubbo.remoting.exchange.support.DefaultFuture.get(DefaultFuture.java:135)
	at com.alibaba.dubbo.rpc.protocol.dubbo.DubboInvoker.doInvoke(DubboInvoker.java:95)
	at com.alibaba.dubbo.rpc.protocol.AbstractInvoker.invoke(AbstractInvoker.java:155)
	at com.alibaba.dubbo.monitor.support.MonitorFilter.invoke(MonitorFilter.java:75)
	at com.alibaba.dubbo.rpc.protocol.ProtocolFilterWrapper$1.invoke(ProtocolFilterWrapper.java:72)
	at com.alibaba.dubbo.rpc.protocol.dubbo.filter.FutureFilter.invoke(FutureFilter.java:54)
	at com.alibaba.dubbo.rpc.protocol.ProtocolFilterWrapper$1.invoke(ProtocolFilterWrapper.java:72)
	at com.alibaba.dubbo.rpc.filter.ConsumerContextFilter.invoke(ConsumerContextFilter.java:49)
	at com.alibaba.dubbo.rpc.protocol.ProtocolFilterWrapper$1.invoke(ProtocolFilterWrapper.java:72)
	at com.alibaba.dubbo.rpc.listener.ListenerInvokerWrapper.invoke(ListenerInvokerWrapper.java:77)
	at com.alibaba.dubbo.rpc.protocol.InvokerWrapper.invoke(InvokerWrapper.java:56)
	at com.alibaba.dubbo.rpc.cluster.support.FailoverClusterInvoker.doInvoke(FailoverClusterInvoker.java:78)
	at com.alibaba.dubbo.rpc.cluster.support.AbstractClusterInvoker.invoke(AbstractClusterInvoker.java:244)
	at com.alibaba.dubbo.rpc.cluster.support.wrapper.MockClusterInvoker.invoke(MockClusterInvoker.java:75)
	at com.alibaba.dubbo.rpc.proxy.InvokerInvocationHandler.invoke(InvokerInvocationHandler.java:52)
	at com.alibaba.dubbo.common.bytecode.proxy0.bizInfoRegister(proxy0.java)
	at sun.reflect.GeneratedMethodAccessor100.invoke(Unknown Source)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at com.alibaba.dubbo.config.spring.beans.factory.annotation.ReferenceAnnotationBeanPostProcessor$ReferenceBeanInvocationHandler.invoke(ReferenceAnnotationBeanPostProcessor.java:165)
	at com.sun.proxy.$Proxy144.bizInfoRegister(Unknown Source)
	at com.bluemoon.pf.mgr.consumer.BizStarter.sendRegister(BizStarter.java)
	at com.bluemoon.pf.mgr.consumer.BizStarter.lambda$initialize$0(BizStarter.java:50)
	at com.bluemoon.pf.mgr.consumer.BizStarter$$Lambda$848/1141714276.run(Unknown Source)
	at java.lang.Thread.run(Thread.java:745)

   Locked ownable synchronizers:
	- None
...
```
- 查看阻塞点
com.alibaba.dubbo.remoting.exchange.support.DefaultFuture.get(DefaultFuture.java:148)
```
	@Override
    public Object get() throws RemotingException {
        return get(timeout);
    }

    @Override
    public Object get(int timeout) throws RemotingException {
        if (timeout <= 0) {
            timeout = Constants.DEFAULT_TIMEOUT;
        }
        if (!isDone()) {
            long start = System.currentTimeMillis();
            lock.lock();
            try {
                while (!isDone()) {
                    done.await(timeout, TimeUnit.MILLISECONDS);
                    if (isDone() || System.currentTimeMillis() - start > timeout) {
                        break;
                    }
                }
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            } finally {
                lock.unlock();
            }
            if (!isDone()) {
                throw new TimeoutException(sent > 0, channel, getTimeoutMessage(false));
            }
        }
        return returnFromResponse();
    }
```
- 通过 arthas 查看 timeout 入参
> [arthas@86747]$ watch com.alibaba.dubbo.remoting.exchange.support.DefaultFuture get params

```
Press Q or Ctrl+C to abort.
Affect(class-cnt:1 , method-cnt:2) cost in 94 ms.
ts=2019-11-21 09:03:57; [cost=4.298591ms] result=@Object[][
    @Integer[50000000],
]
```

**综上，推断出是 dubbo 调用时设置超时时间过程（5万秒），调用出现异常时，在等待超时，所以线程挂起等待 - TIMED_WAITING (parking)**

后续，在 apollo 配置中找到配置 dubbo.consumer.timeout = 50000000 我说怎么全局搜索，找不到 50000000 这个数字

