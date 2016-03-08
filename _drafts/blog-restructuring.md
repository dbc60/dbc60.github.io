---
layout: post
title: Taking Inventory of HTML and JavaScript
category: blog
tags: [jekyll, yaml, liquid-templates,
       markdown,
       html, css
       git,
       mathjax,
       bundler]
---
What an ugly blog. Headings are crazy sizes. Both headings and paragraphs have awkward line spacing. While syntax highlighting is a great feature, poor color choices make code very hard to read.

<!--more-->

## Contents
{:.no_toc}

* TOC
{:toc}

This blog started with Jekyll, Compass, Git and a simple design for my blog. It would have a banner to hold the title, followed by a navigation strip, a section that would be used to list the last few posts (just a title, excerpt and date) or the post itself. There would be a sidebar on the right for listing post titles in chronological order. Finally, it would have a footer to hold some social media icons with links and a simple licensing statement.

## HTML Layout
The overall layout is basic HTML5: `<!DOCTYPE html>` followed by an `html` element which contains `head` and `body` elements.

```html
<!DOCTYPE html>
<html lang="en">
    {% include head.html %}

    <body>
        <div id="container">
            {% include header.html %}

            {% include navigation.html %}

            <div id="boxes">  <!-- New div wrapper around the two boxes whose height we want to match -->
                <section id="main" role="main">
                    {{ content | replace: '<li>[ ]', '<li class="checkbox"><input type="checkbox" disabled/>' | replace: '<li>[x]', '<li class="checkbox_done"><input type="checkbox" checked disabled/>'  }}
                </section>

                {% include sidebar.html %}
            </div>

            {% include footer.html %}
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="{{ site.baseurl }}/js/vendor/jquery-1.11.3.min.js"><\/script>')</script>

        <script src="{{ site.baseurl }}/js/plugins.js"></script>
        <script src="{{ site.baseurl }}/js/main.js"></script>

        {% include analytics.html %}

    </body>
</html>
```

The contents of `head.html` contains links to CSS files, and a couple of JavaScript files. There's [Modernizr](https://modernizr.com/) and [MathJax](https://www.mathjax.org/). Here's an excerpt:

```html
    <link rel="stylesheet" href="{{ site.baseurl }}/css/normalize.css">
    <link rel="stylesheet" href="{{ site.baseurl }}/css/style.css" type="text/css" media="screen">

    <!-- Add in Google font call  -->
    <!--<link href='http://fonts.googleapis.com/css?family=Kreon' rel='stylesheet' type='text/css'>-->

    <script src="{{ site.baseurl }}/js/vendor/modernizr-2.8.3.min.js"></script>

    <!-- cruft elided -->

    <!-- MathJax configuration -->
    <script type="text/x-mathjax-config">
        MathJax.Hub.Config({
            tex2jax: {
                inlineMath: [ ["\\(","\\)"] ],
                displayMath: [ ['$$','$$'], ["\\[","\\]"] ],
                processEscapes: true
            },
            "HTML-CSS": {
                preferredFont: "TeX",
                availableFonts: ["STIX","TeX"],
                styles: {
                    ".MathJax .merror": {
                        color:   "#dd0000",
                        padding: "1px 3px",
                        "font-style": "normal",
                        "font-size":  "90%"
                    }
                },
                linebreaks: { automatic: true },
                scale: 100
            }
        });
    </script>

<!-- Load MathJax -->
<script type="text/javascript"
    src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML">
</script>
{% include meta.html %}

```

I don't think Modernizr is even in use. Additionally, the header has links to `/css/normize.css` and `/css/style.css`. The problem is `_sass/style.scss` imports `normalize.scss`, so the link to `normalize.css` is redundant. It's time to inventory this blog, clean it up and simplify where possible before moving on.

The redundant link to `/css/normalize.css` is gone. The meta data needed some repair. I had:

```html
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<title>{% if page.title %}{{ page.title }} – {% endif %}{{ site.title }}</title>

<meta name="author" content="{{ site.author }}">
<meta name="viewport" content="width=device-width, initial-scale=1">

<meta property="og:locale" content="en_US">
{% if page.title %}
<meta property="og:title" content="{{ page.title }}">
<meta property="twitter:title" content="{{ page.title }}">
{% endif %}

{% seo %}
```

I slapped in the Jekyll SEO tag at some point without considering what it generates. I found it automatically generates the `<title>` and `<meta property="og:title" content="{site or post title} />"` content, so I can safely remove those.
