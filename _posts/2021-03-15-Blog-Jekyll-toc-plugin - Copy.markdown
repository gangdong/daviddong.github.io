---
layout: post
title:  "How did I implement related posts list in my blog"
date:   2018-11-14 10:51:56 +0800
categories: Blog
tags: Blog
Published: true
toc: true
sidebar: true
---
What will you learn in this post?     
This post introduces how to implement `related posts` function with Jekyll. 

## Jekyll’s Native Support
My blog was constructed with Jekyll, Jekyll has native support for related posts function, which can be used with Liquid as `site.related_posts`. 

However, when I used it, I found this function has some points not as good as I required.

### problem
+ This function collects the related posts and group them by searching the same tags among them. But if there aren’t enough posts sharing the same tags. It will return ten most recent posts as default.<br>   
This behavior doesn't make sense to me!<br>         
Why should a post be related to another post that they have nothing to do with the contents just because they are close in release time and there are no other related posts existing?

+ This function lists posts with mutual tags without ordering by how many mutual tags they share. In this way, if A post is tagged with `a`, `b` and `c`, B post is tagged with `a` and C post is tagged with `a` and `c`, There is no problem if you do not limit the count of the related posts. It will return B and C as A's related posts. But if you set the limit to 1, A’s related posts may contain only B instead of C. Apparently, C should be selected for this case since it is more close to A.

+  To achieve this function, need to run the jekyll command with the `--lsi` (`latent semantic indexing`) option when build.<br>   
Unfortunately GitHub Pages does not support the `lsi` option when generating sites.

{% highlight ruby %}
jekyll server --lsi
{% endhighlight %}


## Use plugins
So I decide not to use this function and find other support. 

I found two plugins that can support the related posts function.    

[toshimaru/jekyll-tagging-related_posts](https://github.com/toshimaru/jekyll-tagging-related_posts)    
[lawrencewoodman/related_posts-jekyll_plugin](https://github.com/LawrenceWoodman/related_posts-jekyll_plugin)  

By reading the readme file, both of them has the same function that overrides the built in related_posts function to calculate related posts based on a posts' tags. And the embedded algorithm is identical, from `related_posts-jekyll_plugin` by @[LawrenceWoodman](https://github.com/LawrenceWoodman).

So I chose one of them to try the function. 

I installed the plugin and inserted below code to my post.html

{% highlight html %}
{% raw %}
{% if site.related_posts.size >= 1 %}
<div>
  <h3>Related Posts</h3>
  <ul>
  {% for related_post in site.related_posts limit: 5 %}
    <li><a href="{{ related_post.url }}">{{ related_post.title }}</a></li>
  {% endfor %}
  </ul>
</div>
{% endif %}
{% endraw %}
{% endhighlight %}

I tested and the above problem are fixed!

The plugin will return nothing if no related posts found instead of recent posts and looks also adding the ordering of the searched tags count. 

Only one problem, the Github Pages cannot support these two plugins since they are not in the [whitelist](https://pages.github.com/versions/) and will be blocked to build for security reasons.