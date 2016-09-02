---
  title: How useful is Landau notation? 
  tags: [Algorithm Analysis, Discussion, Notation]
  mathjax: true
---

In the context of a new answer to 
  [an old question on Computer Science SE](//cs.stackexchange.com/q/3523/98)
and a subsequent
  [chat](//chat.stackexchange.com/rooms/33862/discussion-between-raphael-and-kaveh),
I started thinking about how useful Landau notation (also "Big-Oh") really is.
Since I am quite opinionated about the whole thing I thought a blog post
would be a better place than Stack Exchange for collecting these thoughts.

To be clear, I have Landau notation as commonly used in algorithm analysis 
in mind, {% abbr ie %} something along the lines of

$$ O(f) = \{ g : \mathbb{N} \to \mathbb{N}_0 \mid 
                   \exists c > 0, n_0 \in \mathbb{N}.\
                     \forall n > n_0.\ g(n) \leq c \cdot f(n) \} $$.

The usual theme you see is that some cost measure (usually running time)
is said to be "in $$O(n^2)$$" (or some other function).
When I write "Landau-bounds" in the sequel I mean the ensemble of
$$O$$, $$\Omega$$ and $$\Theta$$ in the above flavor. 
You may add $$o$$ and $$\omega$$; they do not change the picture significantly.

### Advantages

 * Landau-bounds are easier to prove than more precise results, in particular
   because we can restrict ourselves to counting a dominant operation.
   That makes their use attractive for the training grounds, {% abbr ie %}
   undergrad education.
   
 * Sometimes it *is* hard to get more. 
 
   Consider, for example, divide-and-conquer recurrences; do you know how to solve
   them more precisely than with the commonly taught 
    [Master theorem](http://cs.stackexchange.com/a/2823/98)?
    {% marginnote "disclaimMT" "I saw a more precise analysis of Mergesort in class once. It was quite involved, and the technique did not stay with me." %}
   I for one do not.
   
   As it turns out, there *is* the continuous Master theorem by 
     {% textcite Roura1997 --file references %} 
   -- it is not *that* old a result. 
   It is certainly not something that is usually taught in computer science
   education, as far as I am aware.
   
 * Landau bounds are easy and shorter to say and write down.
 
### Alleged Advantages

 * Focus on what is essential.
 
   This one you hear often. It is true -- assuming one buys into the "constant 
   factors and small input sizes don't matter" narrative. I argue below why I
   do not.
   
   It is *definitely* true if you only talk about algorithmic *ideas*; 
   without a specific implementation in mind, precise analysis does not make
   a lot of sense.
 
### Problems

#### Technical

 * It is 
     [unclear](http://cs.stackexchange.com/q/3149/98) 
   how the commonly taught definition extends to multiple variables -- despite 
   everybody and their mother using it that way!
   
 * Constant factors matter in practice. 
 
   Without analyzing constant factors, you can not even start analyzing
   the speedup of parallel algorithms (on constantly many processing units). 
   You also can not compare different flavors or implementations of 
   the same algorithm; for instance, what is
     [the best Quicksort](http://cs.stackexchange.com/q/11458/98)?
     
 * Small (read: finite) input sizes matter in practice.
 
   Formally, $$O(\_)$$ does not say you *anything* for any finite input size,
   but even *really* small sizes matter; for instance, how do you choose when
   to stop recursing to Quicksort and to which algorithm to switch?
   
 * Lower-order terms matter in practice.
 
   Even though their contribution vanishes *relatively* in the limit,
   it can be very significant in *absolute* terms for the input sizes 
   you actually encounter.
   
 * Landau-bounds alone do not enable you to predict running times 
   (or *any* measure).
   
   [How to do *science*](https://www.cs.princeton.edu/~rs/talks/ScienceCS10.pdf)
   (according to the scientific method) in such a situation?

In summary, Landau notation alone is neither useful for predicting the behavior 
of algorithms in practice with any amount of precision, 
*nor* is it useful for comparing algorithms of similar performance.

#### Cultural

 * Landau-bounds have become the end when they should be a means.
 
 * Analysis (too) often focuses on the worst case.
 
 * The literature is rife with abuse of notation.
 
   It starts with (ab)using the equality sign, doing arithmetics with $$O$$-terms,
   and other things that *can* be rigorously defined,
   but continues to things which
     [everybody disagrees on the meaning of](http://cs.stackexchange.com/q/48527/98).
     
 * Laypeople use it without knowing what it means.
 
   {% marginnote "landau-vs-cases" "[No. Nonono. No!](http://cs.stackexchange.com/q/23068/98)" %}
   The amount of programmer-types you encounter on the internet who think
   $$O$$ means worst-case, $$\Theta$$ average-case and $$\Omega$$ best case is ...
   appalling.
   But then, apparently even
     [published textbooks get things (horribly) wrong](http://cs.stackexchange.com/q/50993/98).
     
 * Focus on Landau-bounds alone encourages coarse, abstract formulations 
   of algorithms that leave gaps in important places.
   
 * Focus on Landau-bounds alone encourages sloppy, hand-wavy analysis of 
   algorithms and use of mathematics. 
   {% marginnote "sloppyproofs" "You should never have to say \"this usually works\" when doing proofs." %}
  
   
### Alternatives

 * Derive exact formulae.
 
   Well, Knuth can do it, but I agree that this is not a workable solution
   for most people in most situations.
   
 * Derive more precise asymptotics.
 
   This is actually something you *can* often do with reasonable effort. 
   Note how a statement like
   
   $$T(n) = 2n\log n - n \pm O(\log n)$$
   {% marginnote "disclaimer-equality" "We still have to be careful to agree on what \"$$=$$\" and \"$$\\pm$$\" mean here!" %}
   
   is way more informative (and useful) than a bland $$T(n) \in \Theta(n \log n)$$! 
   In fact, this use of Landau-bounds as "error terms" is pretty much the only 
   one I can condone without hesitation. 
   For many purposes, we still need an absolute bound on the hidden terms, though.
   
   {% marginnote "sedgewick-coursera" "Sedgewick's [Coursera course](https://www.coursera.org/course/aofa) is pretty well done as well." %}
   You are not alone, by the way:
   Knuth&nbsp;{% cite ConcreteMathematics TAOCP --file references %} as well as 
   {% textcite SedgewickFlajolet2013 --file references %}
   can teach you how to do this.
   
 * Alternative definitions may circumvent some of the technical problems
   (but break the literature); see {% abbr eg %} recent work by
   {% textcite Rutanen2015 --file references %}.
   
 * Teach the limitations and more responsible use of Landau-bounds.
 
### Verdict

Arguably, notation has one purpose and one purpose only:
enable effective and efficient communication. 
Do Landau-bounds really serve this purpose in the context of rigorous algorithm analysis?

I say no. We should use them as little as possible and strive to produce
better, more precise results.

Dear readers, did I miss something? 
Do you agree on the lists but not with my conclusion?
Please leave your comments below!

<hr class="slender">

### References

{% fixbibliography --keyaslabel --nodetails %}
  {% bibliography --cited --file references %}
{% endfixbibliography %}
