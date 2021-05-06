---
layout: post
title:  Getting started with Jekyll (1)
date:   2018-03-27 20:56:30 +0800
categories: Blog
tags: Blog
Published: true
toc: true
sidebar: true
about: true
author: david.dong
description: Jekyll is a website generate/debug tool. This article introduced what Jekyll is and how to install Jekyll as a startup.
keywords: Jekyll
---
![Jekyll theme pic]({{site.cdn_baseurl}}/assets/image/web-jekyll-1-cover.png)    
In my last article, I have introduced how to create a blog based on Github Pages, if you haven't read it and you want to read it, find the article at [here]({{site.baseurl}}/blog/github/2018/03/23/Github-github-blog.html). Following that article, this page will give a brief introduction to Jekyll and its installation.

{% include toc.html %}

## Jekyll
What's Jekyll?

Jekyll is a simple and free blog generation tool, similar to WordPress. But it's very different from WordPress because Jekyll is just a tool for generating static web pages and does not need database support. It can work with third-party services, such as Disqus. The key is that Jekyll can be deployed on GitHub Pages free of charge and can bind its own domain name.

<div class = "post-note info">
  <div class = "header"></div>
  <div class = "body">
    <p>Github Pages use Jekyll to build and generate the website.
    </p>
  </div>
</div>

As a static site generator, Jekyll provides many advantages. For example, a website constructed by Jekyll will get a faster page speed over a dynamic, database-driven site.

Jekyll also offers a way of storing data in a more human-readable format, such as `YAML` or `JSON`. This means you can store data that is used in multiple places across your site in one file and reference it in many places.

Others are Jekyll gives the developer more freedom to design and build the site. It is free to write your own HTML and text onto the page in the format you want.

Generally, Jekyll is a static site generator. It will transform your plain text into static websites and blogs. No more databases, slow loading websites, risk of being hacked…just your content.

Let's turn to how to build the website by Jekyll, I suggest you construct your website on Github Pages because Jekyll is well deployed on Github Pages and there are many Jekyll theme templates for you powering your website. More important is all of these are free of charge. If you like, you can even bind your domain on it. you can view my previous [article]({{site.baseurl}}/blog/github/2018/03/23/Github-github-blog.html) to learn how to create a blog on GitHub Pages. 
## Installation
The first step is installing the Jekyll tools on your PC, here I just introduce the installation on the windows platform.

+ download Ruby at [here](https://rubyinstaller.org/) and install it. You can skip it if you have already installed.
+ download RubyGems at [here](https://rubygems.org/pages/download). Again, skip this step if you have done.
+ unzip the RubyGems folder and enter the directory. Execute the below command.
{% highlight ruby %}
ruby setup.rb
{% endhighlight %} 
+ execute command install Jekyll.
{% highlight ruby %}
gem install Jekyll
{% endhighlight %}
After the installation, check it by creating a Jekyll template.
{% highlight ruby %}
cd d:
d:
Jekyll new testblog
cd testblog
Jekyll server
{% endhighlight %}
If you see below output message, Jekyll is working on your PC now.
{% highlight ruby %}
Generating...
    done in 1.684 seconds.
Please add the following to your Gemfile to avoid polling for changes:
    gem 'wdm', '>= 0.1.0' if Gem.win_platform?
Auto-regeneration: enabled for 'D:/Study/backup/daviddong.github.io'
    Server address: http://127.0.0.1:4000
Server running... press ctrl-c to stop.
{% endhighlight %}
So far you can input http://127.0.0.1:4000/ in the browser to view the blog you just created.

## Jekyll theme
Jekyll provides a lot of beautiful theme templates, you can use them to power your website easily.<br> 

You can view the demo, download the source code and use it on your own website.

![Jekyll theme pic]({{site.cdn_baseurl}}/assets/image/web-jekyll-1-template.png)

Now go and choose the one you like -> [Jekyll theme](http://jekyllthemes.org/).

In next article, I will introduce Jekyll grammar. If you have questions about this article, please add them to the comment box. I will try to answer you as promptly as I can.
