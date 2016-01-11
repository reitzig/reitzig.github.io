---
  title: Ramblings
  layout: default
  mathjax: true
---

<h1 class="title">{{ page.title }}</h1>
<ul class="content-listing">
  {% for post in site.posts %}
    <li class="listing">
    	<hr class="slender">
    	<h3 class="contrast"><a href="{{ post.url }}">{{ post.title }}</a></h3>
    	<p class="below_title" style="margin-top: 0;">
        <span class="date">{{ post.date | date: "%B %-d, %Y" }}</span>
        {% if post.tags.size > 0 %}
          <span class="separator">&mdash;</span>
          <span class="tags">{{ post.tags | sort | join: ", " }}</span>
        {% endif %}
      </p>
	<div>
	  {{ post.excerpt }}
	  <span class="read-more"><a href="{{ post.url }}">Continue reading&hellip;</a></span>
	</div>
	
    </li>
  {% endfor %}
</ul>
