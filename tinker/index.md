---
  title: Tinkering in the Trenches
  layout: default
  mathjax: true
---

<h1 class="title">{{ page.title }}</h1>
This is my developer blog where I talk about issues around building software.

<ul class="content-listing">
  {% for post in site.categories.dev %}
    {% include post-in-list.html %}
  {% endfor %}
</ul>
