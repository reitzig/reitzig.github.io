---
  title: Quick Images with TikZ
  tags: LaTeX TikZ Scripting
  categories: cs
---

How do you create high-quality technical images for documents, your website
or posts on Stack Exchange? I have used tools in an ad-hoc manner for a while 
and have become frustrated lately. Once you have used 
  [TikZ](http://pgf.sourceforge.net/)
  {% marginnote "tikz_refs" "Check out the awesome [gallery of examples](http://www.texample.net/tikz/examples) and the comprehensive [manual](http://mirror.ctan.org/graphics/pgf/base/doc/generic/pgf/pgfmanual.pdf)." %} 
with {% latex %} most other tools feel inferior. 
The only problem is: TikZ is a {%latex %} package and can not be used on its own. 
So how to convert TikZ to, say, PNG comfortably?
<!--more-->

{% tex %}-guru [Martin Scharrer](http://www.scharrer-online.de/) comes to the rescue: he wrote the package [`standalone`](http://ctan.org/pkg/standalone) for exactly this use case. Based on his [explanation on tex.SE](http://tex.stackexchange.com/a/11880/3213) I built a small bash script that does all the repetitive work for you. With one simple command, this

~~~latex
%p% \usetikzlibrary{arrows,automata,positioning}
\begin{tikzpicture}[shorten >=1pt,node distance=2cm,auto]
  \node[state,initial]    (q_0)                {$q_0$};
  \node[state,accepting]  (q_1) [right of=q_0] {$q_1$};

  \path[->] (q_0) edge [bend left]  node {$a$} (q_1)
            (q_1) edge [bend left]  node {$b$} (q_0);
\end{tikzpicture}
~~~

becomes this in a matter of seconds:

{% tikz %}
%p% \usetikzlibrary{arrows,automata,positioning}
\begin{tikzpicture}[shorten >=1pt,node distance=2cm,auto]
  \node[state,initial]    (q_0)                {$q_0$};
  \node[state,accepting]  (q_1) [right of=q_0] {$q_1$};

  \path[->] (q_0) edge [bend left]  node {$a$} (q_1)
            (q_1) edge [bend left]  node {$b$} (q_0);
\end{tikzpicture}
{% endtikz %}

You can find some more examples [here](http://akerbos.github.io/sesketches/).

Get <code>tikz2png</code> [on Github](https://github.com/akerbos/scripts/blob/master/tikz2png) and enjoy!

*Update:* There is [tikz2svg](https://github.com/akerbos/scripts/blob/master/tikz2svg) now as well.

<sub>Originally posted on [lmazy.verrech.net](http://lmazy.verrech.net/2012/03/quick-images-with-tikz/).<sub>
