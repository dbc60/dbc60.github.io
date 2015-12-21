---
layout: page
title: Blog Configuration Notes
excerpt:
categories: [notes, jekyll]
---
## Jekyll
I started this blog by forking Barry Clark's [Jekyll Now](https://github.com/barryclark/jekyll-now) repository. It's not a bad place to start, but I found Jekyll has a lot of knobs to fiddle with. I wanted to know more, so I'm keeping a few notes here and some of the links from his [README](https://github.com/barryclark/jekyll-now/blob/master/README.md).

### Things to Remember
- Use the page layout (```layout: page```) in the YAML front matter for static pages.

### Some Jekyll Themes
You can use the [Quick Start](https://github.com/barryclark/jekyll-now#quick-start) workflow with other themes. Here are some good ones:

- [Hyde](https://github.com/poole/hyde) by MDO
- [Lanyon](https://github.com/poole/lanyon) by MDO
- [mojombo.github.io](https://github.com/mojombo/mojombo.github.io) by Tom Preston-Werner
- [Left](https://github.com/holman/left) by Zach Holman
- [Minimal Mistakes](https://github.com/mmistakes/minimal-mistakes) by Michael Rose
- [Skinny Bones](https://github.com/mmistakes/skinny-bones-jekyll) by Michael Rose

### Other Links
- [Jekyll](https://github.com/jekyll/jekyll)
- [SVG icons](https://github.com/neilorangepeel/Free-Social-Icons) - Beautiful icons.

## GitHub
There are a limited set of [plug-ins](https://pages.github.com/versions/) available for using with Jekyll on GitHub. That page lists the versions. It looks like GitHub (as of 2015.12.21) uses Jekyll v2.4.0. I'm on 3.0.1. I'd better keep things simple until GitHub catches up.

In the meantime, look at the [GitHub Pages Ruby Gem](https://help.github.com/articles/using-jekyll-with-pages/#installing-jekyll) on GitHub and the [Jekyll for Windows](http://jekyllrb.com/docs/windows/#installation) in the Jekyll documentation.

According to [this article](http://collectiveidea.com/blog/archives/2014/09/17/how-we-write-a-gemfile/), the Gemfile should contain only the names of the gems I wish to install and shouldn't reference their versions. Bundler will keep track of the correct versions in its Gemfile.lock file. When you want to update the gems checkout a new branch and use Bundler:

  git checkout -b upgrade-gems
  bundle update

If you run into a problem after testing, then run ```git diff``` to see what's changed in ```Gemfile.lock```. Fix the version of those gems to the one that worked and put in a comment explaining why that particular version is in use.

From here on out, always run Jekyll through bundle (as in "```bundle exec jekyll serve```"). It will run the supported version of Jekyll rather than the default version installed on your system.
