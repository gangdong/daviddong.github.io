---
layout: post
title:  "如何在github上构建个人blog"
date:   2019-03-23 21:03:36 +0800
categories: Github
published: false
---
因为工作的原因，对github的使用比较多,github也提供了个人主页的功能，因此就想把个人的博客迁到Github上来。Github上托管的方式属于静态访问，但是能够完全满足我的需求。只要按照github格式要求，新建一个仓库，把网站代码上传到里面，那么就可以在任何时候任何地方都能够访问了。那么如何搭建这个代码托管仓库呢？
可以参考 Github 官网上的教程 [官方链接](https://pages.github.com)<br>
这里简单做一个总结，<br>
1. 申请一个github的账号，如果已经有了可以忽略这步。<br>
2. 新建一个repository,如下图所示 <br>
![create](https://gangdong.github.io/daviddong.github.io/assets/create-repository.png)
输入repository的名字，注意这里一定要用申请的主页的地址加github.io结尾！
![create2](https://gangdong.github.io/daviddong.github.io/assets/create-repository2.png)
3. 点击create repository 按钮，仓库就创建好了。<br>
4. 进入到刚刚建好的仓库的setting页面，会看到你的仓库的名称和个人网页的访问地址。记录下来在浏览器里打开相应的地址就可以看到你的主页内容了。这里要在仓库的根目录下新建一个index.html的文档，
用来修改网页的内容，提交后可以实时看到修改的内容。<br>
![create3](https://gangdong.github.io/daviddong.github.io/assets/create-repository4.png)
至此，一个个人主页基本就搭建好了。接下来就可以添加内容到主页中去了。github提供了很多好的主题模板，大家可以直接使用模板来创建会更加快捷一些。github上的主题模板大多是基于jekyII 来搭建的，因此有必要对jekyII做一些了解。关于jekyII的内容不在本文的讨论中。我会单独在写一篇文章对jekyII做一个介绍。<br>


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
   id: 'github/2019/03/23/Others-how-to-build-blog-on-github.html',
   title: 'comments'
    });
   gitalk.render('gitalk-container');
</script>
<!-- Gitalk end -->

<br><br><br>

<font size="2" color="#aaa">作者：David Dong<br></font>
<font size="2" color="#aaa">来源：https://gangdong.github.io/daviddong.github.io/github/2019/03/23/Others-how-to-build-blog-on-github.html</font>
<font size="2" color="#aaa">转载请注明出处。</font>
<span id="busuanzi_container_page_pv" ></span><font size="2" color="#aaa">
本文总阅读量</font><font size="2" color="#aaa"><span id="busuanzi_value_page_pv"></font></span><font size="2" color="#aaa">次</font>