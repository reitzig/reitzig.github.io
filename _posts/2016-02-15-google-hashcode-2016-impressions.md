---
  title: "Google Hashcode 2016: Impressions"
  tags: [Programming, Algorithms]
  mathjax: false
  categories: cs
---

{% newthought "Last week," %} a colleague and I participated in
[Google's Hash Code](https://hashcode.withgoogle.com/).
The idea of the event is simple: give small teams of programmers a hard task
and give them too little time to solve it. See what they can come up with.

{% newthought "The problem" %} we received -- serving many orders from few
warehouses using a couple of drones -- was clearly (NP-)hard, so clever *and*
quickly coded heuristics were asked for.
The data were given in an ad-hoc-formatted text file,
{% marginnote "inputformat" "Do code golfers like such inputs?" %}
the output was required to be another text file with commands for the drones.

{% flairimg "/assets/posts_img/2016-02-15-hashcode-coding.jpg" "Coding fuel at hand." %}

{% newthought "It took" %} us about one hour to get input parsing set up. 
We then took a coffee and did the thinking, 
followed by another two hours of programming.
We finished the first feature-complete revision ten minutes late,
and had to debug for another two hours before we could upload solutions.
So clearly, programming speed and accuracy was the limiting factor for us --
that is not too surprising.

{% flairimg "/assets/posts_img/2016-02-15-hashcode-coffee.jpg" "A coffee for the last mile." %}

{% newthought "We" %} had
  [fun](https://twitter.com/hashtag/hashcodeTUKL),
even though we did not finish in time.
Hashcode is definitely a good event for bringing people with different sets of
expertise together so they can collaboratively tinker on a cute problem
for an evening.

Some quick observations.

### Organization

The concept of hubs is nice.
We got to connect with several other teams from the university and talked about
our respective strategies afterwards.
Despite Google's photo contest there was
  [not much activity on Twitter](https://twitter.com/hashtag/hashcodeTUKL)
et&thinsp;al. -- apparently everybody fell in a coding frenzy!
You can see some of the contents of the swag box our hub got in action there.
I have a new stress ball now, too.

### Lessons learned

 * Get at least one programmer on board.
 * You need to agree more than discuss.
 * Algorithmic intuition/skill is helpful.
 * Look at the data *before* you start thinking.

### Questions

 * [Our approach](google-hashcode-2016-our-approach) was deterministic and 
   basically online.

   * How much does randomization help?
   * Are there any (fast) solutions that exploit (parts of the) total knowledge?

 * Are there languages and/or frameworks that are per se more suited than others
   for tasks like this?

    {% marginnote "kotlin" "I know [Kotlin](http://kotlinlang.org/) now. Too late." %}
    For instance, using Java forced us to write some boilerplate code, but
    it also allowed us to use rich features of our IDE and get all the
    help from static typing.
    Plus, it is what we (both) know.

 * Could libraries have been of help? We did not use any; the functionality
   that was needed was rather simple.

### Wishlist

 * The input format could have made known in advance without spoiling the
   problem. That is, unless Google *wants* to test for solving this part in
   the given time. For us, it was an annoyance that distracted us from the
   real task.
   
 * Input could be given in CSV format. Not only would that enable the use of
   off-the-shelf parsers, but also quick data inspection with tools like
   R or Mathematica.
   
   
<hr class="slender">

What are your observations? Which lessons did you learn?
