---
layout: post
title: How I Setup this Blog
excerpt: What do I really need to know to setup a blog on GitHub?
category: blog
tags: [jekyll, yaml, liquid-templates,
       markdown,
       html, css, javascript,
       compass, sass,
       git,
       mathjax,
       bundler,
       dns
       ]
---
What do I really need to know to setup a blog on GitHub?

I thought it would be a good idea to  create a blog to talk about software development, design patterns, learning programming languages and development environments and a whole slew of related topics I find interesting. I also thought I could keep it simple by using [GitHub User Pages](https://help.github.com/articles/user-organization-and-project-pages/),  [Jekyll](https://jekyllrb.com/) and [Compass](http://compass-style.org/). What I've found is that I have only a passing familiarity with most of the technologies one needs to know to use these tools.

I need to learn about the following to get this blog setup the way I want it.

- Jekyll configuration
- Organize Jekyll layouts, include files, drafts, posts and static pages.
- Markdown
- YAML
- Liquid templates
- How to structure the HTML layout to make it easy to style
- Write CSS to style the HTML
- Compass configuration
- Using SASS to create style sheets
- Practice Git branching and get used to a workflow
- Bundler to keep the gems up-to-date
- DNS to setup a CNAME and sorting out how to keep some content on my Digital Ocean droplet, while having a blog on GitHub user pages (with the option of moving it to the droplet w/o creating an SEO fiasco). GitHub wants a CNAME, not an A-record. There's also a lot of information on the web regarding subdomains vs subfolders.

I think that should cover the basics. I learned that the pygments highlighter is built in Python, but isn't used in Jekyll 3.0 (rouge is the default highlighter going forward). Once GitHub updates their gem to use Jekyll 3.0, I don't think I'll have to be concerned with Python for this blog. Until then, I might have to become more familiar with it.

Here's a short list of related things, just in case I have to review them:

- Python - it seems to be needed for the pygments
- MathJax - needed for writing mathematical expressions in the posts
- Ruby - it's what Jekyll and Compass are written in
- Ruby gems -
