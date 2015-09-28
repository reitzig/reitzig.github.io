<p class="bibdetailhead">
  <em>{{ page.entry.author }}</em><br/>
  <strong>{{ page.entry.title }}</strong><br/>
  <span>
    {% if page.entry.journal %}{{ page.entry.journal }}, 
    {% elsif page.entry.booktitle %}{{ page.entry.booktitle }}, 
    {% endif %}
    {{ page.entry.year }}
  </span>
</p>

{{ reference page.entry }}

{{ page.entry.abstract }}

{% if page.entry.doi %} -- [doi](//dx.doi.org/{{ page.entry.doi }}){% endif %}{% if page.entry.archiveprefix == "arXiv" %} -- [arXiv](//arxiv.org/abs/{{ page.entry.eprint }}){% endif %}{% if page.entry.url %} -- [website]({{ page.entry.url }}){% endif %}{% if page.entry.pdf %} -- [pdf]({{ page.entry.pdf }}){% endif %} --

Cite as:

~~~bibtex
{{ page.entry.bibtex }}
~~~
