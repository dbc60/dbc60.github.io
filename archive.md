---
layout: page
title: Archive
permalink: /archive/
---
<section class="archive">
<!--    <ul>
    {% for post in site.posts %}
        <li>
            <div class="date">{{ post.date | date_to_string }}</div>
            <a href="{{ site.prefix  }}{{ post.url }}">{{ post.title }}</a>
        </li>
    {% endfor %}
    </ul>
-->
    <h2>This Year's Posts</h2>
    {%for post in site.posts %}
      {% unless post.next %}
        <ul class="this">
      {% else %}
        {% capture year %}{{ post.date | date: '%Y' }}{% endcapture %}
        {% capture nyear %}{{ post.next.date | date: '%Y' }}{% endcapture %}
        {% if year != nyear %}
          </ul>
          <h2>{{ post.date | date: '%Y' }}</h2>
          <ul class="past">
        {% endif %}
      {% endunless %}
        <li><time>{{ post.date | date:"%d %b" }}</time><a href="{{ post.url }}">{{ post.title }}</a></li>
    {% endfor %}
    </ul>
</section>
