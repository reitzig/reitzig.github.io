---
  title: Signing Websites
  tags: Website, Security
  mathjax: false
---

{% newthought "Today" %} I reread some 
  [thoughts of mine](http://worldbuilding.stackexchange.com/a/27379/3657)
on how super-computers may engage in battle.
What I wrote got me thinking in another direction:
how can we, even today, be sure that what we read on the internet is what
the alleged author intends us to see? Especially if our connection to the
webserver is not encrypted, man-in-the-middle attacks are a very real possibility.

How far do you trust your own hosting provider not to manipulate your content?  
How far do you trust your ISP not to manipulate what you access?  
How far do you trust the providers of *other* people?

{% newthought "It" %} struck me that we already have technology to alleviate 
such concerns: cryptographic signatures. 
We{% marginnote "crypto" "Not enough people do, sadly." %} already use them for
emails and the principle transfers to websites.
Just like for emails, adoption can only happen if it is *easy to use*;
a criterion encryption features of mail clients frequently fail to satisfy.

The 
  [process I use for this website]({% post_url 2015-12-01-a-researchers-jekyll %})
lends itself very well to fully integrating the signing of the generated websites.
A quickly coded 
  [proof-of-concept implementation](https://github.com/reitzig/reitzig.github.io/blob/sources/_plugins/pgp-sign.rb)
provides a fair user experience already; no user interaction is necessary at all.
Now, every (local) file used on this website has been signed with PGP; the
footer links to the relevant files. For instance, find the signatures of this
post
  [here]({% post_url 2015-12-01-a-researchers-jekyll %}.sig.html).

{% newthought "Of course" %}, I am 
  [not the first person to have this idea](http://www.sanface.com/pgphtml.html).
There has even been 
  [a proposal for integrating signatures into HTML](http://www.w3.org/2007/11/h6n/),
and 
  [standards for XML exist](http://www.w3.org/standards/techs/xmlsig).
But: have you ever seen a signed website? I have not.

Need, standards and tools are necessary for anything like this to get traction.
Do you see the need for signing websites?
