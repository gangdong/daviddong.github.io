---
layout: post
title:  "Pagination in Jekyll"
date:   2018-06-28 19:43:17 +0800
categories: Blog
tags: Blog
toc: true
sidebar: true
---
If you don't have pagination for your blog and you want to do it, this page is probably helpful to you.

My blog is constructed by Jekyll, so I will only write down how to paginate the blog powered by Jekyll. Actually below part are some experiences when I paginated my blog. 

When you have a long post list, breaking them into smaller lists and display them over multiple pages will become a common requirement. 
Fortunately, Jekyll offers a pagination plugin, which can automatically generate the appropriate files and folders you need for paginated listings.

{% include toc.html %}

## Install plugin
Add the `jekyll-paginate` into your website's Gemfile and declare it at your configuration file `_config.yml` under plugins.

Like below Gemfile.

{% highlight ruby %}
gemspec
group :jekyll_plugins do
    gem 'jekyll-feed'
    gem 'jekyll-sitemap'
    gem 'jekyll-paginate'
end
{% endhighlight %}
## Enable pagination
Add a line to the `_config.yml` file that specifies how many items should be displayed per page:
{% highlight yaml %}
paginate: 12
{% endhighlight %}
The number should be the maximum number of posts you’d like to be displayed per page in the generated site.

Because Jekyll can only support pagination for HTML files so far, do not work from within Markdown files from your Jekyll site. Pagination works when called from the HTML file, named `index.html`, which optionally may reside in and produce pagination from within a subdirectory, via the `paginate_path` configuration value. <br>
You can specify the destination of the pagination pages:
{% highlight yaml %}
paginate_path: "/blog/page:num/"
{% endhighlight %}
Jekyll will search the /blog/ directory and read in `blog/index.html`, send it to each pagination page, and write the output to `blog/page:num/`, where `:num` is the pagination page number, starting with 2. 

For example, if you output 3 pages, if you look at the _site directory, you will find a /blog folder with two subfolders /page2 and /page3 in it. Each folder has an `index.html` file, which contains the contents that need to be displayed.

<div class = "post-note info">
  <div class = "header"></div>
  	<div class = "body">
		<p>because the pages start with 2, which means no page1 exists.That will require special handling for the first page when rendering the pages. Actually, page1 contents are displayed on the <span>index.html</span> of <span>/blog</span> directory.
		</p>
  	</div>
</div>

 

For me, I tried to set the path as below firstly, but failed to load the `index.html`. After I change to `/blog/page:num`, it started to work. Who can tell what the reason is here?
{% highlight yaml %}
paginate_path: "/page:num/" 
{% endhighlight %}
## Attributes
The pagination plugin exposes the paginator Liquid object. <br>
You can find the attributes in my another blog [Getting started with Jekyll (2)]({{site.baseurl}}/blog/2018/04/13/Web-jekyll-grammar.html)

## Render the pages
You have enabled the pagination so far, next thing is to display your posts in a list using the paginator variable that will now be available to you.
Below code is an example from my blog's `pagination.html` file. These pieces of code renders a list of each page with links to all but the current page.
{% highlight liquid %}
{% raw %}
<!-- Pagination links -->
{% if paginator.total_pages > 1 %}
<div class="pagination">
  {% if paginator.previous_page %}
    <a href="{{ paginator.previous_page_path | prepend: site.baseurl | replace: '//', '/' }}">&laquo; Prev</a>
  {% else %}
    <span>&laquo; Prev</span>
  {% endif %}

  {% for page in (1..paginator.total_pages) %}
    {% if page == paginator.page %}
      <span class="active">{{ page }}</span>
    {% elsif page == 1 %}
      <a href="{{ '/blog/index.html' | prepend: site.baseurl | replace: '//', '/' }}">{{ page }}</a>
    {% else %}
      <a href="{{ site.paginate_path | prepend: site.baseurl | replace: '//', '/' | replace: ':num', page }}">{{ page }}</a>
    {% endif %}
{% endfor %}
  
  {% if paginator.next_page %}
    <a href="{{ paginator.next_page_path | prepend: site.baseurl | replace: '//', '/' }}">Next &raquo;</a>
  {% else %}
    <span>Next &raquo;</span>
  {% endif %}
</div>
{% endif %}
{% endraw %}
{% endhighlight %}
Besides, you still need to change your `page.html` or `home.html` where displays the every pages. <br>
I moved these code to `/blog/index.html` from `page.html` and change the loop from `site.posts` to `paginator.posts`.<br>
Below code loops through the paginated posts.
{% highlight liquid %}
{% raw %}
    {%- for post in paginator.posts -%}
      <li>
        {%- assign date_format = site.minimal.date_format | default: "%b %-d, %Y" -%}
        <a class="post-link" href="{{ post.url | relative_url }}">
          <h2 class="post-title">{{ post.title | escape }}</h2>
        </a>
        <div class="post-meta">
          <ul class="post-categories">
            {%- for tag in post.categories -%}
              <li>{{ tag }}</li>
            {%- endfor -%}
          </ul>
          <div class="post-date">
            <i class="icon-calendar"></i>
            {{ post.date | date: date_format }}</div>
        </div>
        <div class="post">
          {%- if site.show_excerpts -%}
            {{ post.excerpt }}
          {%- endif -%}
        </div>
		<footer>
          <a class="post-link" href="{{ post.url | relative_url }}">
          <h5 class="morebox">Read More...</h5>
        </a>
        </footer>
      </li>
    {%- endfor -%}
{% endraw %}
{% endhighlight %}
## Others
Currently jekyll-paginate plugin doesn't allow paging over groups of posts linked by a common tag or category. 
The more recent [jekyll-paginate-v2](https://github.com/sverrirs/jekyll-paginate-v2) plugin can support the pagination for categories, tags and collections. See the pagination examples in the repository.<br> 

<div class = "post-note info">
  <div class = "header"></div>
  <div class = "body">
    <p>This plugin is not supported by GitHub Pages. I haven't tried it!🙂
    </p>
  </div>
</div>