---
layout: post
title:  "How to build your personal blog on github"
date:   2019-03-23 21:03:36 +0800
categories: Web Github
---
I have constructed my personal website by jekyll on github pages, I thought I would write a little blog post about how to make your own website by jekyll on GitHub Pages.<br>
I would separate the contents into short blogs, reading long articles are always easy to make people feel weary.<br>
This page will introduce how to create your personal blog based on github pages. Next pages I will introduce Jekyll and how to use it to enrich your blog.<br>

Because I have much work on the github and github also provides the personal homepage service. It is possible to build your personal website on it. To me, it is a good idea to move my personal blog to github in the benefit of saving lots of time on the maintenance of the blog contents on different sites. That's why I'd like to do this thing. The way of hosting your website on GitHub is static access, but it can fully meet my needs. So here comes the question, how do we build it on github? The procedure is simple, just need to create a new repository and upload your website code onto it. After then you can access it at any time and anywhere.
To learn how to build your website on the github, a quick way is referring to the official help document.
[Link](https://pages.github.com)<br>
Here is a short summary，<br>
1. apply a github account, you can skip this step if you already have.<br>
2. create a new repository as below. <br>
![create](https://gangdong.github.io/daviddong.github.io/assets/create-repository.png)
fill the name of repository，please note the name must be your website's url and ending with github.io!
![create2](https://gangdong.github.io/daviddong.github.io/assets/create-repository2.png)
3. click create repository button，the repository will be created。<br>
4. open the settings page of your new repository, find your website url and record it. Input your website url into the web browser and then you will see your website's homepage. It is an empty page at the beginning. To add content, you need to create a index.html file in your repository directory. Write what you want into it and submit the modification, you we will see the contents you added.<br>
![create3](https://gangdong.github.io/daviddong.github.io/assets/create-repository4.png)
For now, all work are done! you've got your personal website with some simple elements. If you want to enrich your website, You need to do some extra work. A fast way is to use github template. GitHub provides many beautiful theme templates. You can use them directly to create your own. The theme templates on GitHub are mostly built based on jekyll, so it is necessary to understand jekyll. However the introduction of jekyll is not discussed in this paper. I'll write a separate article for jekyll.<br>
See you soon.<br>

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
   id: 'web/github/2019/03/23/Others-how-to-build-blog-on-github-en.html',
   title: 'comments'
    });
   gitalk.render('gitalk-container');
</script>
<!-- Gitalk end -->

<br><br><br>

<font size="2" color="#aaa">作者：David Dong<br></font>
<font size="2" color="#aaa">来源：https://gangdong.github.io/daviddong.github.io/web/github/2019/03/23/Others-how-to-build-blog-on-github-en.html</font>
<font size="2" color="#aaa">转载请注明出处。</font>
<span id="busuanzi_container_page_pv" ></span><font size="2" color="#aaa">
本文总阅读量</font><font size="2" color="#aaa"><span id="busuanzi_value_page_pv"></font></span><font size="2" color="#aaa">次</font>