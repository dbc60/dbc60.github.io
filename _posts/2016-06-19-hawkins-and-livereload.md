---
layout: post
title: Hawkins and LiveReload
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
Some fun has been restored (with limitations). Hawkins appears to be a great little gem implementing LiveReload. However, it doesn't work with the `--incremental` command-line option. Also, it doesn't work if there's more than one Jekyll session open at a time.
