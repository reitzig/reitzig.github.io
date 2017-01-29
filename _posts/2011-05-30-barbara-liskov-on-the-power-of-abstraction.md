---
  title: Barbara Liskov on the Power of Abstraction
  tags: Programming Talk
  categories: cs
---

Last week, Barbara Liskov visited Kaiserslautern and gave her talk <em>On the Power of Abstraction</em>. I had known her from the [substitution principle](http://en.wikipedia.org/wiki/Liskov_substitution_principle) named after her{% sidenote "principle" "She did not name it, of course. Apparently, she received an email in the 90's by somebody asking her whether he got "her" principle right, surprising her. She had not known that the principle had borne her name for years in the community." %} and taught to every computer scientist and programmer, but she is far more distinguished than that: 
Barbara Liskov is an [ACM Fellow](http://fellows.acm.org/fellow_citation.cfm?id=1108679&amp;srt=alpha&amp;alpha=L), holds the [ACM Turing Award](http://awards.acm.org/citation.cfm?id=1108679&amp;srt=alpha&amp;alpha=L&amp;aw=140&amp;ao=AMTURING&amp;yr=2008), the [IEEE John von Neumann Medal](http://www.ieee.org/about/awards/bios/vonneumann_recipients.html#sect7), and a couple of other awards, telltale of her influence on the field.

{% flairimg "/assets/posts_img/2011-05-30-liskov.png" "Liskov speaking" %}

The talk she gave is actually her Turing lecture, obligatory for Turing awardees. The room was so packed that quite some people had to remain standing, and it was worthwhile to have come. You can watch the lecture---in another instance---in full [here](http://amturing.acm.org/vp/liskov_1108679.cfm). For me as a CS novice, the lecture is a small time travel machine to the seventies: Barbara talks about the history of how abstract datatypes and related concepts came to be. As someone who grew up with languages like Java, it is hard to imagine a world where all programming there is is literally done on assembler level. So, lots of the material presented should feel trivial to the modern mind, but Barbara manages to instill the spirit of the time into her listeners. After her talk, you know why she got awards for things you take for granted today.

Since the lecture itself can be watched online, I just want to share my favorite quotes and anecdotes I wrote down during the talk; I hope I am not misquoting.

> [Barbara] did not apply at MIT because she did not want to be a nerd.

On her finding abstract datatypes:

> I have no idea how I got that idea. [...] It was ready to be discovered.

On overhead caused by abstract programming features:

> You never need optimal performance, you need good-enough performance. [...] Programmers are far too hung up with performance.

On design decisions in CLU:

> There were no GOTOs because I believed Dijkstra.

On the substitution principle named after her:

> It's really just common sense.

Unaccredited critique of Liskov getting the Turing award:

> Why did she get this award? Everybody knows this anyway!

Especially the last quote demonstrates, if unintentionally, the impact of Liskov's and others' work of that time. If something you conceive is considered common sense 30 years later, you really had a brilliant idea.

<sub>Originally posted on [lmazy.verrech.net](http://lmazy.verrech.net/2011/05/b-liskov-on-the-power-of-abstraction/).</sub>
