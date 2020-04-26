---
layout: post
title:  "Java 的finalize()方法的总结"
date:   2012-06-04 23:42:04 +0800
categories: Java
published: true
---
Java提供的finalize()方法是定义JObject类中的方法。作用是帮助我们进行资源释放，类似于C++中的析构函数。但是需要注意的是该方法根本上和C++中的析构函数是不同的。

我们都知道Java是运行在JVM上的，JVM的垃圾回收机制承担了系统资源释放的任务，因此在编写Java程序的时候是不用考虑显式的调用方法进行资源释放的。这是因为Java是完全面向对象的语言，所有对象都驻留在堆内存，因此局部对象就不存在。而与Java不同，C++支持局部对象（基于栈）和全局对象（基于堆）。因此在C++语言中引入了析构函数用来处理资源的释放。析构函数的执行时机是确定的，在对象的作用域结束或者显式调用的时候会被执行。一般在C++编程中，子类的析构函数都会重写父类的析构函数用于本类的资源的释放。<br>

而Java的finalize()则不同，**finalize()虽然也会被用来进行资源的释放，但是finalize()方法的执行时机确是不确定的。**原因是因为finalize()是在垃圾回收时被调用的，而何时进行垃圾回收是由JVM根据当前的资源状况来决定，因此这个时间是无法保证的。

通常JVM会对当前的内存状况进行评估，只有当资源块耗尽或者有进程因为资源不足退出已经排队等待的时候，JVM会进行垃圾的回收。这个时候finalize()会被执行。因此如果我们想在确定的时间点用finalize()来释放有关的资源是十分不可靠的。

有意思的一点，Java的垃圾回收机制虽然简化了编程，程序员无需考虑资源的释放导致的内容泄漏问题，但是却无法知道申请的对象何时被系统撤销，即使该对象的作用域是可以预知的（不在被不再被运行状态引用或间接地通过其他对象引用时）。


当然，Java也提供了System.gc()方法，System.gc()会强制要求系统进行垃圾回收，从而可以增加finalize()的调用几率，缺点是强制进行垃圾回收会影响系统的性能。

下面对finalize()来做一个总结：<br>
+ finalize()方法可以被用来进行系统资源的释放
+ 系统在进行垃圾回收，准备释放对象所占用的内存空间之前会调用对象的finalize()方法
+ 因为系统进行垃圾回收的时机不确定，所以finalize()的执行时间是不确定的
+ finalize()只会在对象内存回收前被调用一次

<br>
<!-- Gitalk 评论 start  -->
<!-- Link Gitalk 的支持文件  -->
<link rel="stylesheet" href="https://unpkg.com/gitalk/dist/gitalk.css">
<script src="https://unpkg.com/gitalk/dist/gitalk.min.js"></script>
<div id="gitalk-container"></div>
<script type="text/javascript">
   var gitalk = new Gitalk({

   // gitalk的主要参数
   clientID: '5e24fc307693a6df3bc5',
   clientSecret: '28c9c17e1174c705c42e9bdc92f87cadcc4ec8b8',
   repo: 'daviddong.github.io',
   owner: 'gangdong',
   admin: ['gangdong'],
   id: 'java/2012/06/04/Java-finalize.html',
   title: 'comments'
    });
   gitalk.render('gitalk-container');
</script>
<!-- Gitalk end -->

<br><br><br>

<font size="2" color="#aaa">作者：David Dong<br></font>
<font size="2" color="#aaa">来源：https://gangdong.github.io/daviddong.github.io/java/2012/06/04/Java-finalize.html</font>
<font size="2" color="#aaa">转载请注明出处。</font>
<span id="busuanzi_container_page_pv" ></span><font size="2" color="#aaa">
本文总阅读量</font><font size="2" color="#aaa"><span id="busuanzi_value_page_pv"></font></span><font size="2" color="#aaa">次</font>