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

## What is an Algorithm

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

## Consistency, Stability, Accuracy

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

Note that terms like 

* *accuracy* -- how close the computed output matches that actual solution or
* *convergence* -- how fast (typically with respect to the computational effort) the algorithm approaches the actual solution

are not intrinsic properties of an algorithm because they depend on the problem that is to be solved.
However, one can talk of *order consistency* of an algorithm to specify the expected accuracy for a class or problems and call an algorithm convergent or a certain order if it is stable too.

## Computational Complexity

The *computational complexity* of an algorithm is important both theoretically (to estimate how the effort scales with, say, the size of the problem) and practically (to say how long the procedure will last and which costs in terms of CPU time or memory usage it will generate).

Typically, the complexity is measured by counting the elementary operations, often referred to as *FLOP*s, which is short for *floating point operations*. 
To classify the algorithms in terms of complexity versus problem size the following function classes are helpful

::: {.definition #landau-symbs name="Landau Symbols or big O notation"}
Let $g\colon \mathbb R^{} \to \mathbb R^{}$ and $a\in\mathbb R^{} \cup \{-\infty, +\infty\}$. Then we say for a function $f\colon \mathbb R \to \mathbb R^{}$ that $f\in O(g)$ if
\begin{equation*}
\limsup_{x\to a} \frac{|f(x)|}{|g(x)|} < \infty
\end{equation*}
and that $f\in o(g)$ if
\begin{equation*}
\limsup_{x\to a} \frac{|f(x)|}{|g(x)|} = 0.
\end{equation*}
:::

The sense and functionality of these concepts might become clear from looking at the typical applications: 

* if $h> 0$ is a discretization parameter and, say, $e(h)$ is the discretization error, then we may say that $e(h) = O(h^2)$, if *asymptotically*, i.e. for ever smaller $h$ -- the error approaches $0$ at least as fast as $h^2$
* if $C(n)$ is the complexity of an algorithm for a problem size $n$, than we could say that $C(n) = O(n)$ to express that the complexity grows *asymptotically*, i.e. for ever larger $n$, at the same speed as the problem size

Unfortunately, the common use of the Landau symbols is a bit sloppy. 

1. the often used "$=$"-sign is informal and by no means an equality
2. what is the limit $a$ is hardly ever mentioned explicitly but fortunately generally clear from the context

As an example we look at two different ways to evaluate a polynomial $p$ of the degree $n$ at the abscissa $x$ based on the two equivalent representations
\begin{equation*}
\begin{split}
p(x) &= a_0 + a_1x +  a_2x^2+ \dotsm + a_nx^n \\
     &= a_0 + x(a_1 + x(a_2 + \dotsm +x(a_{n-1} + a_nx) \dotsm ))
\end{split}
\end{equation*}

For a direct implementation of the first representation we obtain

```py
'''computation of p(x) in standard representation
'''
n = 10                                      # example value for n
ais = [(-1)**k*1/k for k in range(1, n+2)]  # list of example coefficients
x = 5                                       # an example value for x
cpx = ais[0]                                # the k=0 case
for k in range(n):
    cpx = cpx + ais[k+1] * x**(k+1)         # the the k-th contribution
print(f'x={x}: p(x)={cpx:.4f}')             # print the output 
```

In the $k$-th step, the algorithm requires one addition (if we also count the initialization as an addition) and $k$ multiplications. That makes an overall complexity of
\begin{equation*}
C(n) = \sum_{k=0}^n(1+k) = n+1 + \frac{n(n-1)}{2} = 1 + \frac n2 + \frac{n^2}2 = O(n^2)
\end{equation*}

For the second representation, we can implement the so-called *Horner scheme* that would read

```py
'''computation of p(x) using the Horner scheme
'''
n = 10                                      # example value for n
ais = [(-1)**k*1/k for k in range(1, n+2)]  # list of example coefficients
x = 5                                       # an example value for x
cpx = ais[n]                                # the k=n case
for k in reversed(range(n)):                
    cpx = ais[k] + x*cpx                    # the the k-th contribution
print(f'x={x}: p(x)={cpx:.4f}')             # print the output 
```
Overall, this scheme needs $n+1$ additions and $n$ multiplications, i.e. $2n+1$ FLOPs, so that we can say that *this algorithm is $O(n)$*.

## Exercises

1. Compare the two implementations for evaluating a polynomial by plotting the complexity as a function of $n$ and by measuring and plotting the CPU time needed for an example evaluation versus $n$.

Further reading: 

* [wikipedia:Algorithmus](https://de.wikipedia.org/wiki/Algorithmus#Definition)
