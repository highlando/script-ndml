# Introduction

What is *Numerical Methods for Machine Learning*? (ML)

In short, for the training of an ML model, a computer steps through millions of instructions that are formulated in terms of mathematical expressions. 
Same holds for the evaluation of such a model.
Then questions arise like *will there be a point when the training is comes to an end?* and *will the model be accurate?*.

In order to describe what is happening and for the analysis later, we introduce the general concepts of

* algorithm
* consistency/accuracy
* stability
* computational effort

some of which are classical *numerical analysis*.

Curiously, the term *algorithm* is similarly intuitive and abstract. It took great efforts to come up with a general and concise definition that would meet requirements and limitations of all fields (ranging from, say, *cooking recipes* to the analysis of of *formal languages*).

::: {.definition #algorithm name="Algorithm"}
A problem solution procedure is called an *algorithm* if, and only if, there exists a *Turing machine* that is equivalent to the procedure and that, for every input for which a solution exists, *stops*.
:::

This definition is not too helpful in its generality -- we haven't even defined what is a Turing machine.

::: {#rem-coors .JHSAYS data-latex=''}
A *Turing machine* can be described as a machine that reads a strip of instructions and that can write onto this strip. Depending on what it reads it may move forward, move backward, or stop (when the strip has reached a predefined state). The beauty is that this setup can be put into an entirely mathematical framework.
:::

It is more helpful and more common, to look at the implications of this definition to check if a procedure meets at least the necessary conditions for being an algorithm

* The algorithm is described by finitely many instructions (finiteness).
* Every step is *feasible*.
* The algorithm requires a finite amount of memory.
* It will finish after finitely many steps.
* At every step, the next step is uniquely defined (*deterministic*).
* For the same initial state, it will stop at the same final state (*determined*).

Thus, an informal good-practice definition of an algorithm could be

::: {.definition #info-algorithm name="Algorithm -- informally"}
An procedure of finitely many instructions is called an *algorithm* if it computes a determined solution -- if it exsists -- to a problem in finitely many steps.
:::

::: {#rem-coors .JHSAYS data-latex=''}
Note how some properties (like finitely many instructions) are assumed a-priori.
:::

As an even more informal reference to algorithms we will use the term **_ (numerical) method_** or **_scheme_** to address a procedure by listing its underlying ideas and sub procedures, whereas *algorithm* will refer to a specific realization of a *method*.

Furthermore, we will distinguish

* *direct* methods -- that compute the solution exactly (like the solution of a linear system by *Gauss elimination*) and
* *iterative* methods -- that iteratively compute a sequence of approximations to the solution (like the computation of roots using a *Newton scheme*).

For the analysis of numerical methods the following terms are generally used:

::: {.definition #consistency name="Consistency"}
If, in exact arithmetics, an algorithm computes the solution to the problem with a given accuracy, it is called *consistent*.
:::

::: {.definition #stability name="Stability (informal)"}
If the output of an algorithm depends continously on differences in the input and continously on differences in the instructions, then the algorithm is called *stable*.
:::

The *differences in the instructions* are typically due to rounding errors as they occur in *inexact arithmetics*.

::: {#rem-coors .JHSAYS data-latex=''}
One could say that an algorithm is consistent if *it does the right thing* and that is stable *if it works despite all kinds of small inaccuracies*. If an algorithm is consistent and stable, it is often called *convergent* to express that it will eventually compute the solution even in inexact arithmetics.
:::

However, terms like 

* *accuracy* -- how close the computed output matches that actual solution or
* *convergence* -- how fast (typically with respect to the computational effort) the algorithm approaches the actual solution

are not intrinsic properties of an algorithm because they depend on the problem that is to be solved.
However, one can talk of *order consistency* of an algorithm to specify the expected accuracy for a class or problems and call an algorithm convergent or a certain order if it is stable too.

Finally, the *computational effort* of an algorithm is important both theoretically (to estimate how the effort scales with, say, the size of the problem) and practically (to say how long the procedure will last and which costs in terms of CPU time or memory usage it will generate).

Further reading: 

* [wikipedia:Algorithmus](https://de.wikipedia.org/wiki/Algorithmus#Definition)
