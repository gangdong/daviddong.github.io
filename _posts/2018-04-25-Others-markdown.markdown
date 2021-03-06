---
layout: post
title:  "Mark一下 Markdown 语言的基本语法"
date:   2018-04-25 11:03:36 +0800
categories: Blog
tags: Blog
language: chinese
Published: true
toc: true
sidebar: true
about: true
author: david.dong
description: 本文介绍了 Markdown 的基本语法和使用
keywords: Markdown
---
![示例图片]({{site.cdn_baseurl}}/assets/image/others-markdown-01.jpg "example")
最近在写博客的时候用到了 Markdown 语言，做为一个学习总结，有必要把常用的语法mark一下。

Markdown 是一种轻量级的「标记语言」，它允许人们使用易读易写的纯文本格式编写文档。

Markdown 的语法十分简单。常用的标记符号也不超过十个，Markdown 编写的文档可以导出 HTML 、Word、图像、PDF、Epub 等多种格式的文档。

Markdown 的语法学习归纳起来可以从下面几个方面来学习。
1. [字体](#1)  2. [标题](#2) 3. [图片](#3) 4. [链接](#4) 5. [分割线](#5) 6. [列表](#6) 7. [表格](#7) 8. [代码](#8) 

## <span id = "1">字体</span>
**语法**

- 斜体：文字两边用 `*` 包起来
- 粗体：文字两边用 `**` 包起来
- 粗斜体：文字两边用 `***` 包起来
- 删除线：文字两边用 `~~` 包起来<br>

示列如下：<br>
{% highlight plaintext %}
   *斜体*
   **粗体**
   ***粗斜体***
   ~~删除线~~
{% endhighlight %}
效果如下：<br>
*斜体*    
**粗体**   
***粗斜体***   
~~删除线~~<br>
## <span id = "2">标题</span>
**语法**    
共分为6级标题，分别在前面加 `#` ，同时在`#`号后加一个`空格`。
示列：<br>
{% highlight plaintext %}
# 一级标题
## 二级标题
### 三级标题
#### 四级标题
{% endhighlight %}
效果如下：<br>
# 一级标题
## 二级标题
### 三级标题
#### 四级标题
依次论推...

## <span id = "3">图片</span>
**语法**
{% highlight plaintext %}
![picname](图片地址''图片title'')
{% endhighlight %}
效果如下：<br>

![示例图片]({{site.cdn_baseurl}}/assets/image/others-markdown-example.png "example"){: .center-image }

## <span id = "4">链接</span>
**语法**   
和图片的语法很类似，只是前面缺少一个`!`。<br>
{% highlight plaintext %}
[名称](地址''title'')
{% endhighlight %}
效果如下：<br>
[DAVID DONG的博客]({{site.baseurl}}/blog/index.html)<br>
## <span id = "5">分割线</span>
**语法**   
三个或者更多的 `---` 或者 `***` <br>
{% highlight plaintext %}
我是分割线 
---
{% endhighlight %}
效果如下:<br>
##### 我是分割线 
---
## <span id = "6">列表</span>
### 无序列表
**语法**   
在内容前使用`*` `-` `+` 都可以。<br>
{% highlight plaintext %}
- 名称
- 年龄
- 性别
{% endhighlight %}
效果如下:<br>
- 名称
- 年龄
- 性别

### 有序列表
**语法**   
在内容前使用`数字`。<br>
{% highlight plaintext %}
1. 名称
2. 年龄
3. 性别
{% endhighlight %}
效果如下:   
1. 名称
2. 年龄
3. 性别

## <span id = "7">表格</span>
**语法**      
语法如下，其中第二行的 `---`: 表示了对齐方式，默认**左对齐**，还有**右对齐（右边加：）** 和**居中（两边加：）**
{% highlight plaintext %}
表头|表头|表头
---|:--:|---:
内容|内容|内容
内容|内容|内容
{% endhighlight %}
效果如下:<br>

语言|面向对象|动态语言
:---:|:--:|:---:
Java|是|否
C|否|否
Python|是|是

## <span id = "8">代码</span>
**语法**<br>
对于码农来说是非常有用的，方便打印代码在博客里。
对于单条语句用`'`包裹语句即可。
对于代码块，用`'''`包裹即可。<br>
效果如下:<br>
{% highlight c %}
int void main(){
	printf("just show how to print me!");
	return 1;
}
{% endhighlight %}
到这里 **markdown** 一些基本的命令就讲完了，用 **markdown** 写文档还是很方便的。
最后再介绍几款好用的 **markdown** 的编辑器，方便网友使用。<br>
目前比较主流的支持 **markdown** 语言的编辑有 `markdownpad`,`typora`,`sublime`,`Mou`,`atom`,`Cmd Markdown` 等，这些软件大部分都能支持 windows/liunx 和 ios(Mou只支持ios) 的平台。而且大部分是免费使用。功能上大同小异，都支持实时预览和 HTML/PDF 输出，有些还能够自定义语法的高亮显示等。我目前使用的是 `markdownpad2`,编辑起来还是很方便的。
