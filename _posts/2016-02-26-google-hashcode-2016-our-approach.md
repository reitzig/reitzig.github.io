---
  title: "Google Hashcode 2016: Our approach"
  tags: [Programming, Algorithms]
  mathjax: true
  categories: cs
---

{% newthought "In this post," %} I briefly discuss the approach we developed 
for [Google Hashcode 2016](google-hashcode-2016-impressions). 

### Design

We make two fundamental decisions:

 * There will be no delivery network or prefetching; every order is served 
   directly from warehouses that have the necessary products.  
   <small>This is a judgement call; we have not looked at the data.</small>
   
 * Drones never serve more than one order at the same time.  
   <small>This is supported by data; we observe that most orders require 
   more than one drone load.</small>
   

The main algorithmic idea is, in the interest of time, *greedy*.
We schedule orders by a earliest-completion-first (ECF) heuristic.

{% newthought "In every step," %} determine the order that can be completed 
the soonest using the following strategy:
{% marginnote "fastestSolution" "[Details on Github](http://github.com/reitzig/2016_hashcode/blob/master/src/drones/EarliestCompletionFirst.java#L53)" %}


 0. Fix an order $$o$$.
 1. Order warehouses by distance from the order target.
 2. Pick as many items as possible from the closest, then second-closest, etc.
 3. Separate the sub-orders into drone-load portions.
 4. Assign portions to drones by greedily preferring drone-warehouse
     pairs $$(d,w)$$ that minimize 
    
     $$t_{\mathrm{idle}}(d) + \operatorname{dist}(d,w) + \operatorname{dist}(w,o).$$
 5. The completion time of the order is the largest such value of all drones 
     we actually use. Note that some drones may be used multiple times on the 
     same order.
   
   
All we need as global state (in addition to the set of unfulfilled orders) are 
the current state of the warehouses (with already scheduled orders removed
preemptively), and for each drone the time $$t_{\mathrm{idle}}$$ and 
position at which it will be idle for the next time. This is not too much.

You can find our code on 
  [Github](http://github.com/reitzig/2016_hashcode/); 
the revision from Hashcode night is
  [this one](https://github.com/reitzig/2016_hashcode/tree/e38ad3d230d7f207acabf0ab64561a4edf5cc9ef).
   
### Code complexity

The algorithm is simple enough to code in about two hours, using an object-oriented
design and modularized code.
{% marginnote "codequality" "Thank god there was no beauty contest as well!" %}
We had a couple of (rather dumb) programming bugs; the logic was sound from
the beginning. That is, we never created conceptually wrong outputs.
Also, our first run scored reasonably high (top 40, had we finished in time).

So I daresay we did not overthink. Had we been better programmers, able to
split the work (rather than pair-program) and/or had experienced programmers
on board -- in particular for the input parsing part -- I think we could have 
finished with this approach in time.
   
### Running time

We did not perform a full analysis. Just from looking at the rough outline
of the algorithm, we observe that it runs in time 
$$\Theta(O^2 \cdot f(W,D) )$$ with&nbsp;$$O$$ the number of orders,
preprocessing aside. 
The function&nbsp;$$f$$ depends only on the number of warehouses&nbsp;$$W$$ and
drones&nbsp;$$D$$; since these two quantities are smaller than the number of 
orders by several orders of magnitudes (in the given data sets), 
we did not care too much about it.

### Memory usage

The amount of memory our program uses is non-trivial but not an issue. 
We copy parts of the global state in the inner-most loop in order to virtually 
execute orders -- for *every order under consideration*. 
That create quite some temporary data but the GC can remove it quickly. 
Nevertheless, there is some potential for improvement here.

### Performance

We managed to implement the logic soundly almost in time. 
After fixing programming bugs, the code ran in under 11 minutes on a 
five-year-old laptop and reached a score of over 275k points. 

I am satisfied with that turnout. Our algorithmic expertise clearly helped us
coming up with a reasonable approach -- and our lack of programming routine
prevented us from handing in on time. Next time, then!

<hr class="slender">

### Post mortem

For the fun of it, I implemented a 
  [parallel version of ECF](http://github.com/reitzig/2016_hashcode/blob/master/src/drones/ParallelECF.java)
which is notably faster and not at all hard to code.
Out of curiosity -- and because I wanted to settle a disagreement -- I also
implemented a
  [variant with a redistribution phase](http://github.com/reitzig/2016_hashcode/blob/master/src/drones/PrefetchedECF.java)
that ensures that every order can be fulfilled from only the nearest warehouse.
It reached a slightly lower score than than pure ECF; I used very crude heuristics
for scheduling the redistribution phase, though.

I also wanted to see how quickly we could have written a 
  [converter to CSV](http://github.com/reitzig/2016_hashcode/blob/master/in2csv.rb)
  {% marginnote "tidydata" "[Tidy Data](http://dx.doi.org/10.18637/jss.v059.i10) by [Hadley Wickham](http://hadley.nz/) (2014)." %}
and ran 
  [data analyses](http://github.com/reitzig/2016_hashcode/blob/master/data_analysis/generateR.rb)
on them. It is close, but I think this is the more useful route, provided you
can use a ready-made CSV-to-objects library.

If you have read this far, you have earned a fun anecdote.
Due to an oversight we never initialized the drone positions correctly;
we used the default integers, that is the origin, instead of the first 
warehouse as starting point.
The fixed version performed worse! Go figure.


