---
  title: Thoughts from the Tower
  layout: default
  mathjax: true
---

<h1 class="title">{{ page.title }}</h1>
This is my computer science blog where I collect more academic thoughts.

<ul class="content-listing">
  {% for post in site.categories.cs %}
    {% include post-in-list.html %}
  {% endfor %}
</ul>
