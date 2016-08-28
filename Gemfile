source "https://rubygems.org"

# github-pages will ensure the supported version of Jekyll and its dependencies are installed.
gem "github-pages"

# 2016.06.19 - trying a LiveReload related gem again. OMG - it works!
group :jekyll_plugins do
  gem 'hawkins'
end

# jekyll-seo-tag will add metadata tags for search engines and social networks to
# better index and display your site's content. It seems to be necessary.
gem 'jekyll-seo-tag'
gem 'jekyll-sitemap'    # Automatically generates sitemap.xml
gem 'kramdown'      # a fast markdown parser
gem 'liquid'        # a template engine
gem 'listen'        # listens to file modifications and notifies you about the changes
gem 'rouge'         # a syntax highligher
gem 'coderay'       # alternative syntax highlighter
gem 'safe_yaml'     # parse YAML safely
gem 'sass'          # Sass makes CSS fun again

# This could be fun if it works outside of Github
gem 'jemoji'    # Github-flavored emoji plug-in for Jekyll.

# I don't know if I need Compass considering Jekyll has a Sass converter. 
# gem 'compass'

# Added asciidoctor and asciidoctor-diagram to create SVG diagrams from AsciiDoc/PlanUML text.
gem 'asciidoctor'
gem 'asciidoctor-diagram'

# Added in response to a warning from Jekyll
gem 'wdm', '>= 0.1.0' if Gem.win_platform?

