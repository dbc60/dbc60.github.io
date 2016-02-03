---
layout: post
title: Miscellaneous Notes
excerpt:
categories: [notes, jekyll]
---
The directory structure in your repository and the configuration of Jekyll and Compass are tied closely together.

<!--more-->
It's important to tell Jekyll to exclude the Compass configuration file and the bundler Gemfile and Gemfile.lock files. Include the following in your _config.yml file:

```
# Exclude these files from your production _site
exclude:      [
                'config.rb',
                'Gemfile',
                'Gemfile.lock',
              ]
```

Configuring Compass is simple. You just need to tell it where the Sass files are and where it should place the resulting .css files. Here's an example configuration file.

```
require 'compass/import-once/activate'
# Require any additional compass plugins here.

# Set this to the root of your project when deployed:
http_path = "/"
css_dir = "css"
sass_dir = "_sass"
images_dir = "img"
javascripts_dir = "js"
```

This is the directory structure that

```
.
├── .git/
├── .sass-cache/
├── _drafts/
├── _includes/
├── _layouts/
├── _plugins/
├── _posts/
├── _sass/
├── _site/
├── css/
├── fonts/
├── img/
├── js/
├── .gitignore
├── _config.yml
├── 404.md
├── about.md
├── archive.md
├── config.rb
├── css-sampler.md
├── favicon.ico
├── feed.xml
├── Gemfile
├── Gemfile.lock
├── humans.txt
├── index.html
├── LICENSE.md
├── NOTES.MD
├── README.md
├── robots.txt
```

There is a lot of things to learn to get a blog setup.

- Jekyll configuration
- Organize Jekyll layouts, include files, drafts, posts and static pages.
- Markdown
- YAML
- Liquid templates
- How to structure the HTML layout to make it easy to style
- Write CSS/SCSS to style the HTML
- Compass configuration
- A goot Git workflow
- Bundler to keep the gems up-to-date

I think that should cover the basics. I learned that the pygments highlighter is built in Python, but isn't used in Jekyll 3.0 (rouge is the default highlighter going forward). Once GitHub updates their gem to use Jekyll 3.0, I don't think I'll have to be concerned with Python for this blog. Until then, I might have to become more familiar with it.
