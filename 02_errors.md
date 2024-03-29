# Errors and Conditioning
\def\kij{(\kappa_{A,x})_{ij}}
Computations on a computer inevitably cause errors and the efficiency or performance of algorithms are always the ratio of costs versus accuracy. 
For example

 * just looking at rounding errors, the accuracy can simply and significantly be improved by resorting to high-precision arithmetics which, however, comes at the cost of higher memory requirements and a higher computational load 

 * in iterative schemes, memory and computational effort can be saved easily by stopping the iteration at an early stage -- at the expense of a less accurate solution approximation

::: {#rem-accu-iter .JHSAYS data-latex=''}
Both these somehow trivial observations are fundamental components of training neural networks. Firstly, it has been observed that low-precision arithmetics can save computational costs with only minor effects on accuracy. Secondly, the training is an iterative process with often slow convergence so that the right time for a premature stop of the training is key.
:::


::: {.definition #errors name="Absolute and relative errors"}
Let $x\in\mathbb R^{}$ be the quantity of interest and $\tilde x \in \mathbb R^{}$ be an approximation to it. Then, the *absolute error* is defined as $|\delta x|:=|\tilde x- x|$ and the *relative error* as $\frac{|\delta x|}{|x|}=\frac{|\tilde x-\tilde x|}{|x|}$.
:::

::: {#rem-rel-abs-err .JHSAYS data-latex=''}
Generally, the relative error is preferred as it puts the measured error into the right reference. For example, an absolute error of $10$ km/h can be large or small depending on the context. On the other hand, the relative error requires knowledge of the actual value and the division by a value close to $0$ can amplify the error estimate.
:::

Next, we will define the *condition* of a problem $A$ and, analogously, of an algorithm (that solves the problem). For that we let $x$ be a parameter/input of the problem and $y=A(x)$ be the corresponding solution/output. The condition is a measure to what extend a change $x+\delta x$ in the input will affect the resulting relative change in the output. For that we consider
\begin{equation*}
\delta y = \tilde y - y = A(\tilde x) - A(x) = A(x+\delta x) - A(x)
\end{equation*}
which after division by $y=A(x)$ and expansion by $x\,\delta x$ becomes
\begin{equation*}
\frac{\delta y}{y} = \frac{A(x+\delta x)-A(x)}{\delta x}\frac{x}{A(x)}\frac{\delta x}{x}.
\end{equation*}
For infinitesimal small $\delta x$, the difference quotient $\frac{A(x+\delta x)-A(x)}{\delta x}$ becomes the derivative $\frac{\partial A}{\partial x}(x)$ so that we can estimate the condition of the problem/algorithm at $x$ through
\begin{equation}(\#eq:eqn-scalar-cond)
\frac{|\delta y|}{|y|} \leq |\frac{\partial A}{\partial x}(x)|\frac{|x|}{|A(x)|}\frac{|\delta x|}{|x|}=:\kappa_{A,x}\frac{|\delta x|}{|x|}.
\end{equation}
and call $\kappa_{A,x}$ the condition number.

For vector valued problems/algorithm we can define the condition number through how a difference in the $j$-th input component $x_j$ will affect the $i$-th component $y_i=A_i(x)$ of the output.

::: {.definition #condition name="Condition number"}
For a problem/algorithm $A\colon \mathbb R^{n}\to \mathbb R^{m}$, we call
\begin{equation*}
(\kappa_{A,x})_{ij} := \frac{\partial A_i}{\partial x_j}(x) \frac{x_j}{A_i(x)}
\end{equation*}
the partial *condition number* of the problem. A problem is called *well-conditioned* if $|\kij|\approx 1$ and *badly-conditioned* if $|\kij \gg 1$, for all $i=1,\dotsc,m$ and $j=1,\dotsc,m$.
:::

::: {#rem-vector-valued-cond .JHSAYS data-latex=''}
Rather than using the scalar component functions of $A\colon \mathbb R^{n} \to \mathbb R^{m}$, one can repeat the calculations that led to \@ref(eq:eqn-scalar-cond) with vector valued-quantities in the corresponding norms.
:::

## Exercises

1. Derive the *condition* number as in \@ref(eq:eqn-scalar-cond) for a vector valued function $A\colon \mathbb R^{n} \to \mathbb R^{m}$. Where does a matrix norm play a role?
1. Derive condition number of an invertible matrix $M$, i.e. condition of the problem $x\to y = M^{-1}x$, by the same procedure. Where does the matrix norm play a role?
