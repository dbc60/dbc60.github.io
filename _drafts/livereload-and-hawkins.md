---
layout: post
title: LiveReload and the Hawkins Plug-in
category: blog
tags: [jekyll, config]
---
Jekyll is a good tool for generating sites from Markdown, but it is a bit fickle and very slow. Nevertheless, I found a nice gem, Hawkins, that will refresh a browser with the LiveReload extension installed.

<!--more-->

## Contents
{:.no_toc}

- TOC
{:toc}

## LiveReload and Hawkins
Some fun has been restored. LiveReload works as long as Jekyll is listening on a unique reload-port (use `--reload-port [PORT]` on the command-line) and the `--incremental` option is not used. 
