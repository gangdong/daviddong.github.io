---
layout: post
title:  "A quick way to fix the Gitalk Error: Validation Failed"
date:   2021-03-08 10:27:13 +0800
categories: Blog
tags: Blog 
Published: true
toc: false
sidebar: true
about: true
author: david.dong
description: Teach how to fix the "validation failed" error when using Gitalk.
keywords: Gitalk/
---
I've met an error `Validation Failed (422)` when using Gitalk in my blog. This article records how I fixed this error. If you are in trouble with this issue and you are looking for a solution, reading this article may help you. 

I posted a new article in my blog and found the Gitalk report on such an issue. My Gitalk has been working for a long time before this issue occurs. I've checked that the Gitalk for my other posts works normally and only the new post has an issue, which means the issue should be a standalone problem that is related to the post self. 

By searching google [gitalk issue #102](https://github.com/gitalk/gitalk/issues/102) I understood the problem is that the length of my new post's URL is excessive long `(> 50 characters)`. 

For every post, Gitalk will create a Github issue under your blog project repository to track the comment thread. The issue's id is used to form the issue's label and Gitalk uses the label to identify comment thread. 

![example]({{site.cdn_baseurl}}/assets/image/web-gitalk-fix-01.PNG "example"){: .center-image }

However, the problem here is that label length is restricted to maximum of 50 characters ( Not sure if it is a hidden rule or a BUG here 😕 ).

In my Gitalk configuration, the issue id is set to 

{% highlight ruby %}
id: { {page.url} },
{% endhighlight %}

So if the `page.url` is too long and is beyond the restriction, the issue's label cannot be created and the `Validation Failed` error will be thrown out.

Since the root cause is clear now, let's fix it.    <br> 

The straightforward way is to use a shorter URL to avoid this issue. But I don't like this restriction that blocking I write a post. To convert the URL to a fixed-length string looks like a better solution. Why not try the hash function? The interesting thing is that I found there has already been the same solution online [-> issue fix](https://blog.csdn.net/death05/article/details/83618887), which use the **MD5** method. This method not only unifies the URL length but also differentiates them.

It is good! 

There is a workable [JavaScript-MD5](https://github.com/blueimp/JavaScript-MD5) lib on the Github, I folk it, and the rest thing is quite simple.

I add the below code snippet for calling `JavaScript-MD5` lib in my `comments.html` 

{% highlight html %}
<script type="text/javascript" src="{{site.cdn_baseurl}}/assets/js/md5.min.js"></script>
{% endhighlight %}

and reset the Gitalk id to 

{% highlight ruby %}
id: md5(location.pathname),
{% endhighlight %}

Commit the change. 

I reopen the page and the error is gone, by checking the Gitalk issue's label, it has been converted to MD5 code. 

![example]({{site.cdn_baseurl}}/assets/image/web-gitalk-fix-02.PNG "example"){: .center-image }

This means the solution is working now! 😊



 