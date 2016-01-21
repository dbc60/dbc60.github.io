---
layout: post
title: Project Planning
category: blog
tags: [project]
---
I'd like to have some tools for displaying project plans in this blog.

<!--more-->
It would be nice to have Jekyll build a calendar that represents a roadmap of projects and potential release dates. I can see having a page that displays several weeks, months or years with a row (swim lane) for each project. The data for those swim lanes would be recorded in YAML, JSON or CSV files in the _data directory. It would consist of events (milestones) and dates for each project.

It turns out that TimelineJS will read JSON files. However, it looks like TimelineJS and TimelineJS3 are geared toward making slideshows. I don't know if either of them can be coopted into making a more simple calendar or slider representation w/o the slideshow.

Some of my projects I'd like to track are:
- This project to make a project roadmap.
    - Perhaps start with a static roadmap using just HTML and CSS, with some constants defined in JSON or YAML files stored in the _data directory.
    - Migrate to a JavaScript version, perhaps using TimelineJS and JSON files.
- Blog Updates
    - Make this blog mobile friendly by using a responsive grid.
    - Create a better color scheme, one where highlighted code looks better and is generally easier to read.
- Puzzles from Steven S. Skiena's book "Programming Chanllenges: The Programming Contest Training Manual." Write them in C++ and Python. See:
    - [http://www.programming-challenges.com](Programming Challenges)
    - [https://uva.onlinejudge.org/][UVa Online Judge]
- A better set of C++ templates for creating Windows services in a layered manner. I want to update the template I have so it's easier to add layers for logging and other aspects.
- Kitchen 2.0, my kitchen renovation project.
- What would I need to do to create an electronic journal similar to the manual Bullet Journal?
    - Monthly to-do list that carried over from one month to the next.
    - To-do list
    - notebook
    - sketchbook
