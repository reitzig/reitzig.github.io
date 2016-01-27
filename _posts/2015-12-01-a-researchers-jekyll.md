---
  title: A Researcher's Jekyll
  tags: Website
  mathjax: false
---

{% newthought There %} are myriads of ways to build websites.
When I decided to create a new one for my work, I evaluated my past
experiences -- mostly with Wordpress and 
Joomla{% marginnote "joomla" "I don't know if there *is* a use-case for Joomla." %} -- 
and decided to go with something less bloated. That is, something that

 * serves fast,
 * is easy to maintain,
 * does not hide my material in a database and
 * is easy to adapt.

{% marginnote "There are many such systems, but I knew Ruby already." %}
I ended up choosing [Jekyll](http://jekyllrb.com/), a Ruby application that 
generates static HTML pages from plain text source. 
There is lots of documentation on Jekyll on the web, so I will just quickly
relate some adaptions I made that may be relevant to other researchers.

 1. I wanted the site to work as well as possible without Javascript.
    In particular, visitors dropping by with active script blocking -- 
    a practice I support fully -- should be able to see *something*,
    and read everything.
    
    In particular, that meant getting rid of icon fonts; a weird practice
    if you ask me.
    Lucky for me, the [IcoMoon App](https://icomoon.io/) exports icon sets
    as SVG as well, so that is what I use for the links in the footer.
    Those icons specific to academia I got from [Academicons](http://jpswalsh.github.io/academicons/); thanks, James!
    
    As a side note, I have not taken any care about old browsers.
    I'll use recent CSS, SVG and maybe HTML5 down the line.
    If any of that gives you trouble, please do yourself a favor and
    upgrade.
 
 2. That said, I *do* need mathematics typesetting and thus
    [MathJax](http://mathjax.org).
    {% marginnote "mathjax" "MathJax is not the *only* way to get mathematics on a website, but it is the only one I have found bearable." %} 
    It is a quite heavy Javascript dependency but I think it is worth it.
    
    I have taken care to include it only on pages where it *may* be needed,
    and the full version only where I *know* it is needed.
    
    If you want to see rendered mathematics, you need to allow scripts from 
    this domain and `mathjax.org`.
 
 3. Comments are one thing that is impossible to implement with a static
    site generator. Since I appreciate comments to my often opinionated 
    posts, I needed a solution.
    
    As a user, I have found [Disqus](https://disqus.com) to be a useful
    service. I have to assume that they track their users, so
    {% marginnote "heise" "Inspired by the [efforts of heise.de](https://github.com/heiseonline/shariff)." %}
    I have taken care that even with Javascript enabled you have to opt-in
    to the feature.
    
    If you want to use the commenting feature, you have to allow
    scripts from this domain, `disqus.com` and `disquscdn.com`, 
    *and* click on that thing below the post in question.
 
 4. A convenient way to include literature references is an absolute must.
    Of course there is a plugin for that, 
      [jekyll-scholar](https://github.com/inukshuk/jekyll-scholar).
    It works quite well out of the box.
    
    However, I elected to tweak both the CSS styling and the 
      [citation style](https://github.com/reitzig/reitzig.github.io/blob/sources/_includes/structured-refs-web.csl) 
    I chose a bit, and wrote plugins for
      [text citations](https://github.com/reitzig/reitzig.github.io/blob/sources/_plugins/textcite.rb)
    and
      [fixing some issues of the bibliography](https://github.com/reitzig/reitzig.github.io/blob/sources/_plugins/fixbibliography.rb).
    I am quite satisfied with the result now.

 5. I wrote some convenience 
      [plugins](https://github.com/reitzig/reitzig.github.io/tree/sources/_plugins),
    {% abbr eg %} for properly typeset abbreviations.
    The biggest development effort went into my 
      [TikZ plugin](https://github.com/reitzig/reitzig.github.io/blob/sources/_plugins/tikz.rb).
    It allows you to specify TikZ code right in your post files which is then
    converted into SVG behind the scenes. Pretty exciting!

 6. I have decided to host on Github Pages for now. 
    This has the advantage that I just have to push my changes to a Git 
    repository and they go live almost immediately.
    
    However, Github does not allows most plugins for safety reasons
    so I have to compile locally. This results in two branches,
    {% marginnote "git" "This is the first time I have used Git branches." %}
    one for the sources and one for the compiled site.
    
    This is the basic process of making a change to the site:
 
    ~~~bash
    git checkout sources
    ... make changes ...
    git commit -m "Something new"
    jekyll build -d /tmp/website
    git checkout master
    cp -r /tmp/website/* ./
    git add [new files]
    git commit -a -m "Something new"
    git push --all
    ~~~
 
So, if you are curious about how I have done something on these pages you
can just head over to [Github](https://github.com/reitzig/reitzig.github.io/)
and check out the sources yourself.

*Nota bene:* I ported some posts which I thought would fit here from my old blog.
I hope to post more, new things soon.
