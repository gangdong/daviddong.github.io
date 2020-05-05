---
layout: post
title:  Getting started with Jekyll (2)
date:   2019-04-13 23:21:15 +0800
categories: Web
published: true
---
After read [last article](https://gangdong.github.io/daviddong.github.io/web/2019/03/27/Web-jekyll-installation.html) you should complete the installation of Jekyll and download a Jekyll theme on your computer. 

Let's start this article from the source code of the theme you downloaded. 

### Jekyll directory structure
Unzip the package you downloaded and check the directory structure.The Jekyll directory structure mainly includes the following directories.

![directory](https://gangdong.github.io/daviddong.github.io/assets/image/web-jekyll-2-directory.png)

The description of each folder.

![directory](https://gangdong.github.io/daviddong.github.io/assets/image/web-jekyll-2-directory-description.png)

Every file or directory beginning with the following characters: ., _ , # or ~ in the source directory will not be included in the destination folder. Such paths will have to be explicitly specified via the config file in the include directive to make sure they’re copied over.

### Liquid

Jekyll uses the Liquid templating language to process templates.
Generally in Liquid you output content using two curly braces e.g. {{ variable }} and perform logic statements by surrounding them in a curly brace percentage sign e.g. {% if statement %}. To learn more about Liquid, check out the [official Liquid Documentation](https://shopify.github.io/liquid/).

### Variables

ekyll traverses your site looking for files to process. Any files with front matter are subject to processing. For each of these files, Jekyll makes a variety of data available via Liquid. The following is a reference of the available data.

#### global variables
![directory](https://gangdong.github.io/daviddong.github.io/assets/image/web-jekyll-2-variables-global.png)

#### site variables
![directory](https://gangdong.github.io/daviddong.github.io/assets/image/web-jekyll-2-variables-site.png)

#### page variables
![directory](https://gangdong.github.io/daviddong.github.io/assets/image/web-jekyll-2-variables-page.png)

#### paginator variables
![directory](https://gangdong.github.io/daviddong.github.io/assets/image/web-jekyll-2-variables-paginator.png)


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
   id: 'web/2019/03/27/Web-jekyll-installation.html',
   title: 'comments'
    });
   gitalk.render('gitalk-container');
</script>
<!-- Gitalk end -->

<br><br><br>

<font size="2" color="#aaa">作者：David Dong<br></font>
<font size="2" color="#aaa">来源：https://gangdong.github.io/daviddong.github.io/web/2019/03/27/Web-jekyll-installation.html</font>
<font size="2" color="#aaa">转载请注明出处。</font>
<span id="busuanzi_container_page_pv" ></span><font size="2" color="#aaa">
本文总阅读量</font><font size="2" color="#aaa"><span id="busuanzi_value_page_pv"></font></span><font size="2" color="#aaa">次</font>
