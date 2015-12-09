---
  title: Open Questions
  mathjax: true
---

Here are some problems I have encountered but not yet solved.

 * [Parallel Dynamic Programming under NUMA](#parallel-dynamic-programming-under-numa)
 * [Average Height of Regular Trees](#average-height-of-regular-trees)
 * [Analysis of Top-Level Parallel Recursive Algorithms](#analysis-of-top-level-parallel-recursive-algorithms)
 * [Average-Case Analysis of Parallel Algorithms with Petri Nets](#average-case-analysis-of-parallel-algorithms-with-petri-nets)
 
I am happy to receive any comments, hints or solutions via [email](mailto:{{ site.email }})!

<hr class="slender">

### Parallel Dynamic Programming under NUMA

{% newthought When %} wrapping up my [master's thesis](/publications/Reitzig2012.html), 
I discovered that my results only held for the [shared memory model](https://en.wikipedia.org/wiki/Uniform_Memory_Access). 
Unfortunately, true shared memory platforms are rare in practice;
most machines have non-uniform memory access (NUMA), {% abbr ie %} processors 
have different access cost for different parts of the memory.

Is it still possible to classify the set of parallelisable dynamic programming 
recurrences?

*Idea:* If the *dependency radius* around each cell is small in a suitable sense,
  then we have $$o(N)$$ expensive accesses, $$N$$ the number of entries.

<hr class="slender">

### Average Height of Regular Trees

{% newthought Regular %} tree languages are almost the same as parsing trees of 
context-free grammars;
for the details, see {% textcite TATA --file references %}.
In particular, all simple varieties of trees {% cite AC --file references %} 
with finite set of node degrees $$\Omega$$ are regular.
Conversely, all regular tree languages describable by regular tree grammars with only one non-terminal are simple varieties. 
It is known that all simple varieties with 
$$\Omega \cap \mathbb{N}_{\geq 2} \neq \emptyset$$ have average height in 
$$\Theta(\sqrt{n})$$.

There are clearly tree languages with linear average height, {% abbr eg %} the
one defined by $$S \to a(S) \mid a$$.

The question is now:{% marginnote "cs.SE ref" "Originally posted on [cs.SE](http://cs.stackexchange.com/questions/16073/)." %}
Are there (infinite) regular tree languages with average height
not in $$\Theta(n) \cup \Theta(\sqrt{n})$$?

I gave a 
  [talk on this](http://www.slideshare.net/rreitzig/sind-regulre-bume-immer-tief-oder-flachwurzler) 
at FORMAT 2014 and 
  [wrote up some related results](/assets/pdf/avgtreeheight_notes.pdf) 
that may be of independent interest.

It may be possible to adapt the height analysis for simple 
varieties&nbsp;{% cite FlajoletOdlyzko1982 -l 200-205 --file references %}
to more than one non-terminal; I could not tell if and how.

<hr class="slender">

### Analysis of Top-Level Parallel Recursive Algorithms

{% newthought During %} average-case running-time analysis of recursive algorithms, 
we routinely solve recurrences of the form

$$\mathbb{E}T_n = \mathbb{E}\bigl[ T_k + T_{n-k} + f(n) \bigr]
                = \mathbb{E}T_k + \mathbb{E}T_{n-k} + \mathbb{E}f(n);$$

note how we use that expectation is linear in addition.

Now consider the most simple way to exploit parallelism: fork for each 
recursive call *on the top level only*.
Then, the recurrence becomes

$$\mathbb{E}T'_n = \mathbb{E}\bigl[ \max\{ T_k, T_{n-k}\} \bigr] + \mathbb{E}f(n).$$

Unfortunately, expectation is *not* linear in taking the maximum. So what do we do?

*Ideas:*

 * If we know the distribution of $$T_n$$ really, *really* well,
    we may be able to derive decent tail bounds, {% abbr eg %}
    Chernoff bounds. Since we are interested in bounding speedup from below,
    upper bounds on $$T'_n$$ may already help us.
    
 * Can we use that

    $$\max \{X_1, \dots, X_p\} = \lim_{p \to \infty} \Bigl( \sum_{i=1}^p |X_i|^p \Bigr)^{1/p}?$$

    The powers of $$X_i$$ can be obtained from the moment generating function of the $$X_i$$ (which are {% abbr iid %} up to maybe a size parameter).
    Note that we still have to deal with $$\mathbb{E} (\_)^{1/p}$$.

<hr class="slender">

### Average-Case Analysis of Parallel Algorithms with Petri Nets

{% newthought Sequential %} programs can be modelled as something akin to 
(finite, discrete) Markov chains {% cite LaubeNebel2010 --file references %}: 
one state per statement, edges from statements to those that can be executed next, 
and probabilities to indicate which edge is taken with which likelihood.
In this model, we can determine the expected runtime of an algorithm.

Can we transfer this to parallel algorithms? Even if the number processors $$p$$
is small, the size of the automaton explodes with $$n^p$$ which soon becomes 
intractable. There is no natural extension that treats $$p$$ as a parameter *and*
maintains the method.

{% newthought "A natural" %} candidate model for parallel algorithms are 
  [*Petri nets*](https://en.wikipedia.org/wiki/Petri_net).
Statements become transitions and places contain a (labelled) token for each
processor that currently waits to execute the next transition. More places and
other tokens can be used to model, say, 
  [mutexes](https://en.wikipedia.org/wiki/Mutual_exclusion);
we would require transitions to be able to distinguish between processor
and helper tokens.

The first question is, what kind of stochastic versions have been studied at all?
In order to remain somewhat consistent with 
  {% textcite LaubeNebel2010 --file references %},
we would want to have transitions move the input marker to different places
with certain probabilities.
We would also require all enabled transitions to fire in each time step; otherwise,
we would study concurrency but not parallelism.
{% marginnote "tie-resolving" "Some transitions may want to let only one processor pass at a time. Such ties should be resolved non-deterministically." %}
If this works out, the expected runtime of the parallel algorithm would be
given by the expected number of steps until all processor markers reach a sink place.

{% newthought There %} may be a natural barrier for this approach. 
Abovementioned method yields only the expected value; 
higher moments are inaccessible. 
A simple example is a plain `for`-loop:

~~~java
  for ( int i = 1; i < n; i++ ) {
    foo();
  }
  bar();
~~~

We *know* that this loop runs for *exactly* $$n$$ iterations, every time.
However, after translation it becomes:

{% tikz --style "height: 10ex;" %}
  %p%\usetikzlibrary{positioning,automata,arrows.meta,calc}
  \begin{tikzpicture}[auto,state/.append style={rectangle}]
    \node[state] (a) {\texttt{for}};
    \node[state,right=of a] (b) {\texttt{foo}};
    \node[state,right=of b] (c) {\texttt{end\_for}};
    \node[state,right=of c] (d) {\texttt{bar}};
    
    \path[draw,black,-{Stealth[]}] 
      ($(a.west) + (-0.5cm,0)$) to (a)
      (a) edge node[swap] {$\frac{n-1}{n}$} (b)
      (b) edge node {$1$} (c) 
      (c) edge[to path={|- ($(c)!0.5!(a) + (0,1cm)$) -| (\tikztotarget)}] (a)
      (a) edge[to path={|- ($(a)!0.5!(d) + (0,-1cm)$) -| (\tikztotarget)}] (d)
      (d) edge ($(d.east) + (0.5cm,0)$);
      
    % Extra edge labels that can't be drawn because of `to path`
    \node at ($(c)!0.5!(a) + (0,0.8cm)$) {$1$};
    \node at ($(a)!0.5!(d) + (0,-0.7cm)$) {$\frac{1}{n}$};
  \end{tikzpicture}
{% endtikz %}

This can no longer be distinguished from other loops with the same probabilities,
{% abbr eg %}

~~~java
  while ( true ) {
    if ( uniformInt(1,n) == 1 ) {
      break;
    }
  }
  bar();
~~~

Why is this a larger problem for the model proposed above?
Well, if we have *conflicts* aka communication, {% abbr eg %} in case of a
mutex, the probability of processors interfering is crucial for the expected
runtime -- but depends on higher moments! Consider, for instance, this net:
{% marginnote "notation" "Inventing notation here. Say thick edges transport processor tokens ($$ 1,2, \\dots $$) and thin edges helper tokens (&#9679;). Small numbers next to places indicate a capacity limit." %}

{% tikz --style "height: 20ex;" %}
  %p%\usepackage{nicefrac}
  %p%\usetikzlibrary{positioning,arrows.meta,calc}
  \begin{tikzpicture}[auto,
    place/.style={draw,circle,minimum width=0.7cm},
    trans/.style={draw,rectangle,minimum height=0.7cm},
    proc/.style={black,thick,-{Stealth[]}},
    aux/.style={black,thin,-{Stealth[]}}]
    
    \node[place] (o1) {$1$};
    \node[trans,right=of o1] (o2) {};
    \node[place,below right=0.5 and 1 of o2] (m1) {};
    \node[trans,below left=0.5 and 1 of m1] (u2) {};
    \node[place,left=of u2] (u1) {$2$};
    \node[trans,right=of m1] (m2) {};
    \node[place,right=of m2] (m3) {};
    \node[place,above=0.5 of m3] (m5) {\textbullet};
    \node[trans,right=of m3] (m4) {};
      \node at ($(m3.south) + (0,-0.2cm)$) {\footnotesize$1$};
    \node[place,right=of m4] (m6) {};
    
    \draw[proc]
      (o1) edge (o2)
      (u1) edge (u2)
      (m1) edge (m2)
      (m2) edge (m3)
      (m3) edge (m4)
      (m4) edge (m6);
      
    \draw[proc] ($(u2.east) + (0,0.1cm)$) -- ++(0.5cm,0) |- (m1);
      \node at  ($(u2.east) + (0.9cm,0.425)$) {$\frac{1}{n-1}$};
    \draw[proc] ($(u2.east) + (0,-0.1cm)$) -- ++(0.5cm,0) -- ++(0,-0.75cm) -| (u1);
      \node at  ($(u2.east) + (0.9cm,-0.475)$) {$\frac{n-2}{n-1}$};
    
    \draw[proc] ($(o2.east) + (0,-0.1cm)$) -- ++(0.5cm,0) |- (m1);
      \node at  ($(o2.east) + (0.9cm,-0.425)$) {$\frac{1}{n+1}$};
    \draw[proc] ($(o2.east) + (0,+0.1cm)$) -- ++(0.5cm,0) -- ++(0,0.75cm) -| (o1);
      \node at  ($(o2.east) + (0.9cm,0.475)$) {$\frac{n-1}{n+1}$};
    
    \draw[aux] (m4) |- (m5);
    \draw[aux] (m5) -| (m2);
    
  \end{tikzpicture}
{% endtikz %}

Which kinds of loop are behind this? If both are of the first type I gave above,
we *never* have a conflict; note that the two processors enter their respective 
loops at the same time here, and $$p_1$$ leaves the mutex before $$p_2$$ reaches it. 
If they are of the second kind, however, we have a non-zero probability for conflict.

So, the question remains: is there any hope here? 
If yes, what can we get out of a stochastic Petri net model?

<hr class="slender">

### References

{% fixbibliography --keyaslabel --nodetails %}
  {% bibliography --cited --file references %}
{% endfixbibliography %}

*[NUMA]: Non-Uniform Memory Access
