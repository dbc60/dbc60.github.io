---
layout: post
title: Jekyll Configuration
category: blog
tags: [jekyll, yaml, liquid-templates, markdown, html, css, javascript, compass, sass, git, mathjax, bundler]
---
Jekyll is so easy to get up and running. According to the (Jekyll website)[https://jekyllrb.com] all you have to do is:

    gem install jekyll
    jekyll new my-blog
    cd my-blog
    jekyll serve

to install Jekyll, create a new blog project and start a web server that watches for changes. If you open a web browser to ```http://localhost:4000```, you'll see the default site that ```jekyll new``` created.

The thing with GitHub pages is that you have to run Bundler to ensure you have a set of gems installed that are compatible with GitHub, but that's for another blog post. I'm going to write about configuring Jekyll to organize my posts and static pages the way I want them organized.

## The Configuration File
The ```_config.yml``` file contains the site configuration information. The first topic I'd like to get a handle on is how Jekyll should create the URL for each post.

According to [this Whiteboard Friday](https://moz.com/blog/subdomains-vs-subfolders-rel-canonical-vs-301-how-to-structure-links-optimally-for-seo-whiteboard-friday) article on Mozilla's blog, it's not a good idea, from an SEO point of view, to put content in a subdomain. Mozilla also has an article on [structuring URLs](https://moz.com/blog/15-seo-best-practices-for-structuring-urls) for SEO. With this information in mind, I'm setting ```permalink: /blog/:year/:title/```.

I think I'm okay with the other values I've set in ```_config.yml```.
