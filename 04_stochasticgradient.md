# Stochastisches Gradientenverfahren

Das stochastische Gradientenverfahren formuliert den Fall, dass im $k$-ten Schritt anstelle des eigentlichen Gradienten $\nabla f(x_k)\in \mathbb R^{n}$ eine Sch&auml;tzung $g(x_k, \xi)\in \mathbb R^{n}$ vorliegt, die eine zuf&auml;llige Komponente in Form einer Zufallsvariable $\xi$ hat. Dabei wird angenommen, dass $g(x_k, \xi)$ *erwartungstreu* ist, das hei&szlig;t
\begin{equation*}
\mathbb E_\xi [g(x_k, \xi)] = \nabla f(x_k),
\end{equation*}
wobei $\mathbb E_\xi$ den Erwartungswert bez&uuml;glich der Variablen $\xi$ beschreibt.

## Motivation und Algorithmus

Im *Maschinellen Lernen* oder allgemeiner in der *nichtlinearen Regression* spielt die Minimierung von Zielfunktionalen in Summenform
\begin{equation*}
Q(w) = \frac{1}{N}\sum_{i=1}^N Q_i(w)
\end{equation*}
eine Rolle, wobei der Parametervektor $w\in \mathbb R^n$, der
$Q$ minimiert, gefunden oder gesch&auml;tzt werden soll.
Jede der Summandenfunktionen $Q_i$ ist typischerweise assoziiert mit einem $i$-ten Datenpunkt (einer Beobachtung) beispielsweise aus einer Menge von Trainingsdaten.

Sei beispielsweise eine parametrisierte nichtlineare Funktion  $T_w\colon \mathbb R^{m}\to \mathbb R^{n}$ gegeben die durch Optimierung eines Parametervektors $w$ an Datenpunkte $(x_i, y_i)\subset \mathbb R^{n}\times \mathbb R^{m}$, $i=1, \dotsc, N$, *gefittet* werden soll, ist die *mittlere quadratische Abweichung* 
\begin{equation*}
\mathsf{MSE}\,(w) := \frac 1N \sum_{i=1}^N \|N(x_i)-y_i\|_2^2
\end{equation*}
genannt *mean squared error*, ein naheliegendes und oft gew&auml;hltes Optimierungskriterium.

Um obige Kriterien zu minimieren, w&uuml;rde ein sogenannter Gradientenabstiegsverfahren den folgenden Minimierungsschritt 

\begin{equation*}
w^{k+1} := w^{k} - \eta \nabla Q(w^k) = w^k - \eta \frac{1}{N} \sum_{i=1}^N \nabla Q_i(w^k),
\end{equation*}
iterativ anwenden, wobei $\eta$ die Schrittweite ist, die besonders in der *ML* community oft auch *learning rate* genannt wird.

Die Berechnung der Abstiegsrichtung erfordert hier also in jedem Schritt die Bestimmung von $N$ Gradienten $\nabla Q_i(w^k)$ der Summandenfunktionen. Wenn $N$ gro&szlig; ist, also beispielsweise viele Datenpunkte in einer Regression beachtet werden sollen, dann ist die Berechnung entsprechend aufw&auml;ndig.

Andererseits entspricht die Abstiegsrichtung 
\begin{equation*}
\frac{1}{N} \sum_{i=1}^N \nabla Q_i(w^k)
\end{equation*}
dem Mittelwert der Gradienten aller $Q_i$s am Punkt $w_k$, der durch ein kleineres Sample 

\begin{equation*}
\frac{1}{N} \sum_{i=1}^N \nabla Q_i(w^k) \approx \frac{1}{|\mathcal J|} \sum_{j\in \mathcal J} \nabla Q_j(w^k),
\end{equation*}

angen&auml;hert werden k&ouml;nnte, wobei $\mathcal J \subset \{1, \dotsc, N\}$ eine Indexmenge ist, die den *batch* der zur Approximation gew&auml;hlten $Q_i$s beschreibt.

## Stochastisches Abstiegsverfahren  {#iterative_method}

Beim stochastischen (oder "Online") Gradientenabstieg wird der wahre Gradient von $Q(w^k)$ durch einen Gradienten bei einer einzelnen Probe angenähert:
\begin{equation*}
w^{k+1} = w^k-\eta \nabla Q_j(w^k),
\end{equation*}
mit $j\in \{1,\dotsc, N\}$ zuf&auml;llig gew&auml;hlt (ohne zur&uuml;cklegen).

Während der Algorithmus den Trainingssatz durchläuft, führt er die obige Aktualisierung für jede Trainingsprobe durch. Es können mehrere Durchgänge (sogenannte *epochs*) über den Trainingssatz gemacht werden, bis der Algorithmus konvergiert. Wenn dies getan wird, können die Daten für jeden Durchlauf gemischt werden, um Zyklen zu vermeiden. Typische Implementierungen verwenden zudem eine adaptive Lernrate, damit der Algorithmus &uuml;berhaupt oder schneller konvergiert.

Die wesentlichen Schritte als Algorithmus sehen wie folgt aus:


```python
###################################################
# The basic steps of a stochastic gradient method #
###################################################

w = ...  # initialize the weight vector
eta = ... # choose the learning rate
I = [1, 2, ..., N]  # the full index set

for k in range(number_epochs):
    J = shuffle(I)  # shuffle the indices
    for j in J:
        # compute the gradient of Qj at current w
        gradjk = nabla(Q(j, w))  
        # update the w vector
        w = w - eta*gradjk
    if convergence_criterion:
       break
###################################################
```

Die Konvergenz des *stochastischen Gradientenabstiegsverfahren* als Kombination von *stochastischer Approximation* und *numerischer Optimierung* ist gut verstanden. Allgemein und unter bestimmten Voraussetzung l&auml;sst sich sagen, dass das stochastische Verfahren &auml;hnlich konvergiert wie das *exakte Verfahren* mit der Einschr&auml;nkung, dass die Konvergenz *fast sicher* stattfindet.

In der Praxis hat sich der Kompromiss etabliert, der anstelle des Gradienten eines einzelnen Punktes $\nabla Q_j(w_k)$, den Abstieg aus dem Mittelwert &uuml;ber mehrere Samples berechnet, also (wie oben beschrieben)
\begin{equation*}
\frac{1}{N} \sum_{i=1}^N \nabla Q_i(w^k) \approx \frac{1}{|\mathcal J|} \sum_{j\in \mathcal J} \nabla Q_j(w^k).
\end{equation*}
Im Algorithmus wird dann anstelle der zuf&auml;lligen Indices $j \in \{1, \dotsc, N\}$, &uuml;ber zuf&auml;llig zusammengestellte Indexmengen $\mathcal J \subset \{1, \dotsc, N\}$ iteriert.

Da die einzelnen Gradienten $\nabla Q_j(w^K)$ unabh&auml;ngig voneinander berechnet werden k&ouml;nnen, kann so ein *batch* Verfahren effizient auf Computern mit mehreren Prozessoren realisiert werden. Die Konvergenztheorie ist nicht wesentlich verschieden vom eigentlichen *stochastischen Gradientenabstiegsverfahren*, allerdings erscheint die beobachte Konvergenz weniger erratisch, da der Mittelwert statistische Ausrei&szlig;er ausmitteln kann.

## Konvergenzanalyse

Wir betrachten den einfachsten Fall wie im obigen Algorithmus beschrieben, dass im $k$-ten Schritt, die Sch&auml;tzung 
$$g(x_k, \xi)=g(x_k, i(\xi))=:\nabla Q_{i(\xi)}(x_k)$$
also dass der Gradient von $\frac 1N \nabla \sum Q_i$ gesch&auml;tzt wird durch den Gradienten der $i(\xi)$-ten Komponentenfunktion, wobei $i(\xi)$ zuf&auml;llig aus der Indexmenge $I=\{1, 2, \dotsc, N\}$ gezogen wird. 

::: {#sdg-put-it-back .JHSAYS data-latex=''}
Im folgenden Beweis wird verwendet werden, dass *zur&uuml;ckgelegt* wird, also dass im $k$-ten Schritt alle m&ouml;glichen Indizes gezogen werden k&ouml;nnen. Das ist notwendig um zu schlussfolgern, dass 
\begin{equation*}
\mathbb E_{i(\xi)} [g(x_k, k_\xi)] = \nabla Q(x_k)
\end{equation*}
In der Praxis (und oben im Algorithmus) wir **nicht** zur&uuml;ckgelegt, es gilt also $I_{k+1} = I_k \setminus \{k_\xi\}$. Der Grund daf&uuml;r ist, dass gerne gesichert wird, dass auch in wenig Iterationsschritten alle Datenpunkte *besucht* werden.
:::


Und die Iteration lautet
\begin{equation*}
x_{k+1} = x_k - \eta_k g(x_k, i(\xi)).
\end{equation*}

::: {.theorem #thm-convergence-stoch-grad name="Konvergenz des stochastischen Gradientenabstiegsverfahren"}
Sei $Q:=\frac 1N \sum_{i=1}^NQ_i$ zweimal stetig differenzierbar und *streng konvex* mit *Modulus* $m>0$ und es gebe eine Konstante $M$ mit $\frac 1N \sum_{i=1}^N \|\nabla Q_i \|_2^2 \leq M$. Ferner sei
<!-- seien die Funktionen $Q_i$ konvex und es sei -->
$x^*$ das Minimum von $Q$. Dann konvergiert das einfache stochastische Gradientenabstiegsverfahren mit $\eta_k \leq \frac{1}{km}$ linear im Erwartungswert des quadrierten Fehlers, d.h. es gilt
\begin{equation*}
a_{k+1} := \frac 12 \mathbb E [\| x_{k+1} - x^*\|^2 ] \leq \frac {C}{k+1}
\end{equation*}
f&uuml;r eine Konstante $C$.
:::

:::{.proof}
Streng konvex mit Modulus $m>0$ bedeutet, dass alle Eigenwerte der Hessematrix $H_Q$ gr&ouml;&szlig;er als $m$ sind. 
<!--Daraus l&auml;sst sich ableiten, dass f&uuml;r alle *subgradienten* $g$ gilt, dass-->
Insbesondere gilt, dass
\begin{equation*}
Q(z) \leq Q(x) + \nabla Q(x)^T(z-x) + \frac12 m \|z-x\|^2
\end{equation*}
f&uuml;r alle $z$ und $x$ aus dem Definitionsbereich von $Q$.

<!-- Aus $Q_i$ konvex, folgt dass $\nabla Q_k (x_k)$ ein Subgradient ist, sodass wir obige Relation in der folgenden Argumentation verwenden k&ouml;nnen. -->

Zun&auml;chst erhalten wir aus der Definition der 2-norm, dass
\begin{equation*}
\begin{split}
\frac 12 \|x_{k+1} - x^* \|^2 &= 
\frac 12 \|x_{k} - \eta_k \nabla Q_{i(k;\xi)}(x_k) - x^* \|^2 \\
&=
\frac 12 \|x_{k} - x^* \|^2 - \eta_k \nabla Q_{i(k;\xi)}(x_k)^T( x_{k} -x^*) + \eta_k^2 \|\nabla Q_{i(k;\xi)}(x_k)\|^2
\end{split}
\end{equation*}

Im n&auml;chsten Schritt nehmen wir den Erwartungswert dieser Terme. Dabei ist zu beachten, dass auch die $x_k$ zuf&auml;llig (aus der Sequenz der zuf&auml;llig gezogenen Richtungen) erzeugt wurden. Dementsprechend m&uuml;ssen wir zwischen $\mathbb E$ (als Erwartungswert bez&uuml;glich aller bisherigen zuf&auml;lligen Ereignisse f&uuml;r $\ell=0, 1, \dotsc, k-1$) und zwischen $\mathbb E_{i(k;\xi)}$ (was wir im $k$-ten Schritt bez&uuml;glich der aktuellen Auswahl der Richtung erwarten k&ouml;nnen) unterscheiden.

In jedem Fall ist der Erwartungswert eine lineare Abbildung, sodass wir die einzelnen Terme der Summe separat betrachten k&ouml;nnen.

F&uuml;r den Mischterm erhalten wir
\begin{equation*}
\eta_k \mathbb E[ \nabla Q_{i(k;\xi)}(x_k)^T( x_{k} -x^*) ] = 
\eta_k \mathbb E\bigl [\mathbb E_{i(k;\xi)}[ \nabla Q_{i(k;\xi)}(x_k)^T( x_{k} -x^*)\,|\, x_k ]\bigr ]
\end{equation*}
wobei der innere Term die Erwartung ist unter der Bedingung das $x_k$ eingetreten ist (folgt aus dem Satz der [*iterated expectation*](https://en.wikipedia.org/wiki/Law_of_total_expectation)).
Da im inneren Term nur noch die Wahl von $i$ zuf&auml;llig ist und wegen der Linearit&auml;t des Erwartungswertes bekommen wir
\begin{equation*}
\begin{split}
\mathbb E_{i(k;\xi)}[ \nabla Q_{i(k;\xi)}(x_k)^T( x_{k} -x^*)\,|\, x_k ] &=
\mathbb E_{i(k;\xi)}[ \nabla Q_{i(k;\xi)}(x_k)^T\,|\, x_k ]( x_{k} -x^*) \\
& = \nabla Q(x_k)^T(x_k - x^*).
\end{split}
\end{equation*}
sodass mit der $m$-Konvexit&auml;t gilt dass 
\begin{equation*}
\mathbb E[ \nabla Q_{i(k;\xi)}(x_k)^T( x_{k} -x^*) ] \geq m \mathbb E[\|x_k - x^*\|^2].
\end{equation*}

::: {#sdg-cnv-independent .JHSAYS data-latex=''}
Diese Manipulation mit den Erwartungswerten ist der formale Ausdruck daf&uuml;r, dass, egal woher das $x_k$ kam, die zuf&auml;llige Wahl der aktuellen Richtung f&uuml;hrt im statistischen Mittel auf $\nabla Q(x_k)$.
:::

Mit gleichen Argumenten und der Annahme der Beschr&auml;nktheit $\|\nabla Q(x)\|^2 < M$, bekommen wir f&uuml;r die erwartete quadratische Abweichung $a_k$, dass
\begin{equation*}
\begin{split}
\frac 12 \|x_{k+1} - x^* \|^2 \leq (1-2\eta_k m) \frac 12 \|x_{k} - x^*\| + \frac 12 \eta_k^2 M^2
\end{split}
\end{equation*}
beziehungsweise
\begin{equation*}
a_{k+1} \leq (1-2\eta_km)a_k + \frac 12\eta_k^2M.
\end{equation*}

Insbesondere wegen des konstanten Terms in der Fehlerrekursion, bedarf es bis zur $1/k$-Konvergenz weiterer Absch&auml;tzungen. Wir zeigen induktiv, dass f&uuml;r $\eta_k<\frac{1}{km}$ gilt, dass
\begin{equation*}
a_{k+1} \leq \frac{c}{2(k+1)}, \quad c = \max\{\| x_1 - x^*\|^2, \frac{M^2}{m^2} \}.
\end{equation*}
F&uuml;r $k=0$ gilt die Absch&auml;tzung direkt. F&uuml;r $k\geq 1$ gilt mit $\eta_k < \frac{1}{mk}$
\begin{equation*}
\begin{split}
a_{k+1} \leq & (1-2m \eta_k)a_k + \frac 12 \eta_k^2 M \\
\leq&  (1-\frac 2k)a_k + \frac 12 \frac{M}{k^2m^2} \\
\leq&  (1-\frac 2k)\frac c2 + \frac 12 \frac{1}{k^2} \frac c2\\
&=  \frac{k^2-1}{k^2}\frac{c}{2(k+1)} \leq \frac {c}{2(k+1)}
\end{split}
\end{equation*}
sodass der Beweis erbracht ist mit $C:=\frac c2$.

:::

## &Uuml;bungen

1. Eine Funktion hei&szlig;t $L$-glatt (*$L$-smooth*) wenn sie stetig
   differenzierbar ist und der Gradient *Lipschitz*-stetig mit Konstante $L$ ist.
   Zeigen Sie, dass f&uuml;r ein $L$-glatte Funktion, die zweimal differenzierbar ist, gilt:
   1. $f(y) \leq f(x) + \nabla f(x)^T(y-x) + \frac L2 \|y-x\|^2$ f&uuml;r alle $x$ und $y$ aus dem Definitionsbereich.
   2. $-LI \leq H_f(x) \leq LI$ f&uuml;r alle $x$, f&uuml;r die Hesse-Matrix
      $H_f$ und f&uuml;r "$\leq$" im Sinne der *Loewner-Halbordnung* definiter
      Matrizen.

2. Zeigen Sie, dass aus *m-Konvexit&auml;t* von $Q\colon \mathbb R^{n}\to \mathbb R^{}$ und $\mathbb E_\xi [g(\xi)] = \nabla Q(x)$ folgt, dass im Minimum $x^*$ von $Q$ gilt, dass
   \begin{equation*}
   \mathbb E_\xi[g(\xi)^T(x-x^*)] \geq Q(x)-Q(x^*) + \frac m2\|x - x^*\|^2  \geq m\|x - x^*\|^2,
   \end{equation*}
f&uuml;r alle $x$.

3. Berechnen sie n&auml;herungsweise den Gradienten der Beispielfunktion 
\begin{equation*}
f(x_1, x_2, x_3) = \sin(x_1) + x_3\cos(x_2) - 2x_2 + x_1^2 + x_2^2 + x_3^2
\end{equation*}
im Punkt $(x_1, x_2, x_3) = (1, 1, 1)$, 
indem sie die partiellen Ableitungen durch den Differenzenquotienten, z.B.,
\begin{equation*}
\frac{\partial g}{\partial x_2}(1, 1, 1) \approx \frac{g(1, 1+h, 1) - g(1, 1,1)}{h}
\end{equation*}
f&uuml;r $h\in\{10^{-3}, 10^{-6}, 10^{-9}, 10^{-12}\}$ berechnen. Berechnen sie auch die Norm der Differenz zum exakten Wert von $\nabla g(1, 1, 1)$ (s.o.) und interpretieren sie die Ergebnisse.


```python
import numpy as np
 
def gfun(x):
    return np.sin(x[0]) + x[2]*np.cos(x[1]) \
        - 2*x[1] + x[0]**2 + x[1]**2 \
        + x[2]**2

def gradg(x):
    return np.array([np.NaN,
                     -x[2]*np.sin(x[1]) - 2 + 2*x[1],
                     np.NaN]).reshape((3, 1))

# Inkrement
h = 1e-3

# der x-wert und das h-Inkrement in der zweiten Komponente
xzero = np.ones((3, 1))
xzeroh = xzero + np.array([0, h, 0]).reshape((3, 1))

# partieller Differenzenquotient
dgdxtwo = 1/h*(gfun(xzeroh) - gfun(xzero))
# Alle partiellen Ableitungen ergeben den Gradienten
hgrad = np.array([np.NaN, dgdxtwo, np.NaN]).reshape((3, 1))

# Analytisch bestimmter Gradient
gradx = gradg(xzero)

# Die Differenz in der Norm
hdiff = np.linalg.norm((hgrad-gradx)[1])
# bitte alle Kompenenten berechnen
# und dann die Norm ueber den ganzen Vektor nehmen

print(f'h={h:.2e}: diff in gradient {hdiff.flatten()[0]:.2e}')
```
