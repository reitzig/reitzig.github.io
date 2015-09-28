---
  title: Collected Thoughts
  layout: default
  mathjax: true
---

<h1 class="content-listing-header sans">{{ page.title }}</h1>
<ul class="content">
  {% for post in site.posts %}
    <li class="listing">
    	<hr class="slender">
    	<h4 class="contrast"><a href="{{ post.url }}">{{ post.title }}</a></h4>
    	<p class="below_title" style="margin-top: 0;">
        <span class="date">{{ post.date | date: "%B %-d, %Y" }}</span>
        {% if post.tags.size > 0 %}
          <span class="separator">&mdash;</span>
          <span class="tags">{{ post.tags | sort | join: ", " }}</span>
        {% endif %}
      </p>
	<div>{{ post.excerpt }}</div>
	
    </li>
  {% endfor %}
</ul>
