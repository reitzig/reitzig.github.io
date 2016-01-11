<p class="bibdetailhead">
  <em>{{ page.entry.author }}</em><br/>
  <strong>{{ page.entry.title }}</strong><br/>
  <span>
    {% if page.entry.journal %}{{ page.entry.journal }}, 
    {% elsif page.entry.booktitle %}{{ page.entry.booktitle }},
    {% elsif page.entry.howpublished %}{{ page.entry.howpublished }}, 
    {% endif %}
    {{ page.entry.year }}
  </span>
</p>

{{ reference page.entry }}

{{ page.entry.abstract }}

{% nolinebreaks %}
  {% if page.entry.doi %} 
    -- [doi](//dx.doi.org/{{ page.entry.doi }})
  {% endif %}
  {% if page.entry.archiveprefix == "arXiv" %} 
    -- [arXiv](//arxiv.org/abs/{{ page.entry.eprint }})
  {% endif %}
  {% if page.entry.url %}
    -- [website]({{ page.entry.url }})
  {% endif %}
  {% if page.entry.pdf %} 
    -- [pdf]({{ page.entry.pdf }})
  {% endif %}
  {% if page.entry.talk %}
    -- [talk]({{ page.entry.talk }})
  {% endif %}
  {% if page.entry.code %} 
    -- [code]({{ page.entry.code }})
  {% endif %} 
  --
{% endnolinebreaks %}

{% if page.entry.note %}---

  {{ page.entry.note || markdownify }}
{% endif %}

<!-- Not helpful in this form as it reproduces "jekyll-only" fields.
---

Cite as:

~~~bibtex
{{ page.entry.bibtex }}
~~~
-->
