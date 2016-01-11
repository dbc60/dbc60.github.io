---
layout: post
title: Jekyll Configuration
excerpt: Jekyll is so easy to get up and running.
category: blog
tags: [jekyll, yaml]
---

Jekyll is so easy to get up and running.

<!--more-->
According to the (Jekyll website)[https://jekyllrb.com] all you have to do to install Jekyll, create a new blog project and start a web server that watches for changes is:

    gem install jekyll
    jekyll new my-blog
    cd my-blog
    jekyll serve

If you open a web browser to ```http://localhost:4000```, you'll see the default site that ```jekyll new``` created.

The thing with GitHub pages is that you have to run Bundler to ensure you have a set of gems installed that are compatible with GitHub. Since that set of gems doesn't currently include the most recent version of Jekyll, you have to run something like ```bundle exec jekyll server```.

## The Configuration File
The ```_config.yml``` file contains the site configuration information. The first topic I'd like to get a handle on is how Jekyll should create the URL for each post.

According to [this Whiteboard Friday](https://moz.com/blog/subdomains-vs-subfolders-rel-canonical-vs-301-how-to-structure-links-optimally-for-seo-whiteboard-friday) article on Mozilla's blog, it's not a good idea, from an SEO point of view, to put content in a subdomain. Mozilla also has an article on [structuring URLs](https://moz.com/blog/15-seo-best-practices-for-structuring-urls) for SEO. With this information in mind, I'm setting ```permalink: /blog/:year/:title/```.

I think I'm okay with the other values I've set in ```_config.yml```.

## YAML Front Matter
The [YAML specification](http://www.yaml.org/spec/1.2/spec.html) has all the details on what a YAML document can contain. Here are some highlights:

YAML users three dashes ("```---```") to separate directives from document content. For example, this post starts with:

    ---
    layout: post
    title: Jekyll Configuration
    category: blog
    tags: [jekyll, yaml]
    ---
    Jekyll is so ...

YAML comments start with a hash mark ("```#```").
