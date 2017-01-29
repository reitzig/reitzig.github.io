---
  title: On Planarity of Control Flow Graphs
  tags: Graphs Programming
  categories: cs
  mathjax: true
  excerpt_separator: <!--more-->
---

For our master's project, we include visualization of control flow graphs of Java bytecode as a user interface feature. When discussing the feature, a question quickly became apparent: are control flow graphs (CFG) [planar](http://en.wikipedia.org/wiki/Planar_graph "Definition of Planar Graphs")? If so, we expect drawing them to be relatively easy. If not, however, we can abandon hope for being able to always draw nice graphs.

Obviously, unconditional jumps can cause arbitrarily nasty CFGs; that is not surprising as `goto` is generally to be [considered harmful](http://dl.acm.org/citation.cfm?doid=362947). We agreed, however, that we should rather consider [basic blocks](http://en.wikipedia.org/wiki/Basic_block) of actual Java rather than arbitrary bytecode, as it is Java code we want to talk about. Sadly, even if we disregard labeled `break` just to be save, Java CFGs are not planar in general. The examples we found suggest that this is true for most procedural and object oriented languages, too.
<!--more-->

### Dynamic Binding

Consider the following snippet:

~~~java
class A { void m() { ... } }
class B extends A { @Override void m() { ... } }
class C extends B { @Override void m() { ... } }

public class Main {
  static void m(A a) { a.m(); }
  static void n(A a) { a.m(); }
  static void o(A a) { a.m(); }
}
~~~

Due to dynamic binding, every call to `A.m` in `Main` might bind to any of the three implementations. In particular, this main method

~~~java
public static void main(String[] args) {
    A a = new A(); B b = new B(); C c = new C();
    m(a); m(b); m(c);
    n(a); n(b); n(c);
    o(a); o(b); o(c);
  }
}
~~~

implies this CFG:

{% tikz --style "height: 15ex;" %}
  %p%\usetikzlibrary{arrows.meta}
  \begin{tikzpicture}[every node/.style={draw,rectangle,inner sep=5pt}]
    \foreach \m/\i in {m/1,n/3,o/5} {
      \node (\m) at (\i,0) {\texttt{Main.\m}};
    }
    
    \foreach \c/\i in {A/1,B/3,C/5} {
      \node (\c) at (\i,-2) {\texttt{\c.m}};
    }
    
    \path[-{Stealth[]}] 
      \foreach \m in {m,n,o} {
        \foreach \c in {A,B,C} {
          (\m) edge (\c)
        }
      };
  \end{tikzpicture}
{% endtikz %}

In graph theory, a graph of this form is called the [*complete bipartite graph*](http://en.wikipedia.org/wiki/Complete_bipartite_graph "Definition of Complete Bipartite Graph") with three nodes on each side, in short $$K_{3,3}$$. Now, a beautiful [result](http://en.wikipedia.org/wiki/Planar_graph#Kuratowski.27s_and_Wagner.27s_theorems "Kuratowski's Theorem") due to Kuratowski states that any graph that has a subgraph homeomorphic to $$K_{3,3}$$ is not planar. Therefore, any program that has at least three calls to a dynamically bound method with at least three implementations does not have a planar CFG; we imagine that this is the usual case in typical programs.

### Multiple Returns

There is another way to create $$K_{3,3}$$ without having to assume inheritance and dynamic binding. Have a look at method

~~~java
void m(int i) {
  if ( i == 0 ) return; //#1
  if ( i == 1 ) return; //#2
  return;               //#3
}
~~~

together with a series of calls:

~~~java
void n(int i) {
  m(i); do1();
  m(i); do2();
  m(i); do3();
}
~~~

Any program that calls `n` at least once with each of `0`, `1` and another number will imply a CFG that has this one as a subgraph:

{% tikz --style "height: 15ex;" %}
  %p%\usetikzlibrary{arrows.meta}
  \begin{tikzpicture}[every node/.style={draw,rectangle,inner sep=5pt}]
    \foreach \r/\i in {1/1,2/3.5,3/6} {
      \node (r\r) at (\i,0) {\texttt{return \#\r}};
    }
    
    \foreach \m/\i in {1/1,2/3.5,3/6} {
      \node (m\m) at (\i,-2) {\texttt{do\m()}};
    }
    
    \path[-{Stealth[]}] 
      \foreach \r in {1,2,3} {
        \foreach \m in {1,2,3} {
          (r\r) edge (m\m)
        }
      };
  \end{tikzpicture}
{% endtikz %}


By the same reasoning as above, when this pattern occurs in a program its CFG can not be planar. As having only one `return` per method is not a wide-spread practice, this should be the usual case.

### Open Questions
Above examples show that features common to typical state of the art programming languages render CFGs of many programs non-planar. What are other features that have this effect? Can we characterize language features that can safely be allowed? Are there combinations of features that together break planarity while subsets are safe? Does non-planarity imply complex programs, {% abbr ie %} can the degree of planarity of a program's CFG be used as a meaningful quality measure?

<sub>Originally posted on [lmazy.verrech.net](http://lmazy.verrech.net/2011/10/on-planarity-of-control-flow-graphs/).</sub>
