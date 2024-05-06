# Iterative Methoden

Allgemein nennen wir ein Verfahren, das sukzessive (also *iterativ*) eine L&ouml;sung $z$ &uuml;ber eine iterativ definierte Folge $x_{k+1}=\phi_k(x_k)$ ann&auml;hert ein *iteratives Verfahren*.

Hierbei k&ouml;nnen $z$, $x_k$, $x_{k+1}$ skalare, Vektoren oder auch unendlich dimensionale Objekte sein und $\phi_k$ ist die Verfahrensfunktion, die das Verfahren beschreibt.
Oftmals ist das Verfahren immer das gleiche egal bei welchem Schritt $k$ Jan gerade ist, weshalb auch oft einfach $\phi$ geschrieben wird.

Bekannte Beispiele sind iterative Verfahren zur

 * L&ouml;sung linearer Gleichungssysteme (z.B. *Gauss-Seidel*)
 * L&ouml;sung nichtlinearer Gleichungssysteme (z.B. *Newton*)
 * Optimierung (z.B. von ML Modellen mittels *Gradientenabstieg*)

Der Einfachheit halber betrachten wir zun&auml;chst $z$, $x_k$, $x_{k+1}\in \mathbb R^{}$. 
Die Erweiterung der Definitionen erfolgt dann &uuml;ber die Formulierung mit Hilfe passender Normen anstelle des Betrags.

::: {.definition #iterative-convergence name="Konvergenz einer Iteration"}
Eine Iteration die eine Folge $(x_k)_{k\in \mathbb N^{}}\subset \mathbb R^{}$ produziert, hei&szlig;t *konvergent der Ordnung $p$* (gegen $z\in \mathbb R^{}$) mit $p\geq 1$, falls eine Konstante $c>0$ existiert sodass
\begin{equation}
|x_{k+1} - z| \leq c|x_k-z|^p,
(\#eq:eqn-iterative-cnvrgnc)
\end{equation}
f&uuml;r $k=1, 2, \dotsc$.

Ist $p=1$, so ist $0<c<1$ notwendig f&uuml;r Konvergenz, genannt *lineare Konvergenz* und das kleinste $c$, das \@ref(eq:eqn-iterative-cnvrgnc) erf&uuml;llt, hei&szlig;t *(lineare) Konvergenzrate*.

Gilt $p=1$ und gilt $|x_{k+1} - z| \leq c_k|x_k-z|^p$ mit $c_k \to 0$ f&uuml;r $k\to \infty$ hei&szlig;t die Konvergenz *superlinear*.
:::

::: {#rem-conv-iterat .JHSAYS data-latex=''}
Wiederum gelten Konvergenzaussagen eigentlich f&uuml;r die Kombination aus Methode und Problem. Dennoch ist es allgemeine Praxis, beispielsweise zu sagen, dass das *Newton-Verfahren quadratisch konvergiert*.
:::


Wir stellen fest, dass im Limit (und wenn vor allem $\phi_k \equiv \phi$ ist) gelten muss, dass
\begin{equation*}
x=\phi(x),
\end{equation*}
die L&ouml;sung (bzw. das was berechnet wurde) ein *Fixpunkt* der Verfahrensfunktion ist.

In der Tat lassen sich viele iterative Methoden als Fixpunktiteration formulieren und mittels Fixpunkts&auml;tzen analysieren. Im ersten Teil dieses Kapitels, werden wir Fixpunktmethoden betrachten.

Als eine Verallgemeinerung, z.B. f&uuml;r den Fall dass $\phi$ tats&auml;chlich von $k$ abh&auml;ngen soll oder dass kein Fixpunkt sondern beispielsweise ein Minimum angen&auml;hert werden soll, werden wir au&szlig;erdem sogenannte *Auxiliary Function Methods* einf&uuml;hren und anschauen.

## Iterative Methoden als Fixpunktiteration

Um eine iterative Vorschrift, beschrieben durch $\phi$, als (konvergente) Fixpunktiteration zu charakterisieren, sind zwei wesentliche Bedingungen nachzuweisen

1. die gesuchte L&ouml;sung $z$ ist ein Fixpunkt des Verfahrens, also $\phi(z)=z$.
2. F&uuml;r einen Startwert $x_0$, konvergiert die Folge $x_{k+1}:=\phi(x_k)$, $k=1,2,\dotsc$, gegen $z$.

Dazu kommen Betrachtungen von Konditionierung, Stabilit&auml;t und Konvergenzordnung.

Wir beginnen mit etwas analytischer Betrachtung. Sei $g \colon \mathbb R^{}\to \mathbb R^{}$ stetig differenzierbar und sei $z\in \mathbb R^{}$ ein Fixpunkt von $g$. Dann gilt, dass
\begin{equation*}
\lim_{x\to z} \frac{g(x)-g(z)}{x-z} = \lim_{x\to z} \frac{g(x)-z}{x-z} = g'(z)
\end{equation*}
und damit, dass f&uuml;r ein $x_k$ in einer Umgebung $U$ um $z$ gilt, dass 
\begin{equation*}
|g(x_k)-z|\leq c |x_k-z|
\end{equation*}
mit $c=\sup_{x\in U}|g'(x)|$.
Daraus k&ouml;nnen wir direkt ableiten, dass

* wenn $|g'(z)|<1$ ist, dann ist die Vorschrift $x_{k+1}=\phi(x_k):=g(x_k)$ *lokal* linear konvergent
* wenn $g'(z)=0$ dann sogar *superlinear*
* wenn $|g'(z)|>1$ ist, dann divergiert die Folge weg von $z$ (und der Fixpunkt wird *absto&szlig;end* genannt).

F&uuml;r h&ouml;here Konvergenzordnungen wird diese Beobachtung im folgenden Satz verallgemeinert.

::: {.theorem #thm-smooth-fp-conv name="Konvergenz h&ouml;herer Ordnung bei glatter Fixpunktiteration"}
Sei $g\colon D\subset \mathbb R^{}\to \mathbb R^{}$ $p$-mal stetig differenzierbar, sei $z\in D$ ein Fixpunkt von $g$. Dann  konvergiert die Fixpunktiteration $x_{k+1}=g(x_k)$ *lokal* mit Ordnung $p$, genau dann wenn
\begin{equation*}
g'(z)=\dotsm g^{(p-1)}(z)=0, \quad g^{(p)}\neq 0.
\end{equation*}
:::

::: {.proof}
Siehe [@RicW17, Thm. 6.31]
:::

::: {#rem-smooth-fp-conv .JHSAYS data-latex=''}
Das *genau dann wenn* in Satz \@ref(thm:thm-smooth-fp-conv) ist so zu verstehen, dass die Konvergenzordnung genau gleich $p$ ist, was insbesondere beinhaltet, dass wenn $g^{(p)}=0$ ist, die Ordnung eventuell gr&ouml;sser als $p$ ist. (Jan ist verleitet zu denken, dass in diesem Fall die Iteration nicht (oder mit einer niedrigeren Ordnung) konvergieren w&uuml;rde).
:::

Ist die Iterationsvorschrift linear (wie bei der iterativen L&ouml;sung linearer Gleichungssysteme), so ist die erste Ableitung $\phi'$ konstant (und gleich der Vorschrift selbst) und alle weiteren Ableitungen sind $0$. Dementsprechend, k&ouml;nnen wir

* maximal lineare Konvergenz erwarten 
* (die aber beispielsweise durch dynamische Anpassung von Parametern auf superlinear verbessert werden kann)
* daf&uuml;r aber vergleichsweise direkte Verallgemeinerungen zu mehrdimensionalen und sogar $\infty$-dimensionalen Problemstellungen.

Zur Illustration betrachten wir den *Landweber-Algorithmus* zur n&auml;herungsweisen L&ouml;sung von "$Ax=b$". 
Dieser Algorithmus wird zwar insbesondere nicht verwendet um ein lineares Gleichungssystem zu l&ouml;sen, durch die Formulierung f&uuml;r m&ouml;glicherweise &uuml;berbestimmte Systeme und die Verbindung zur iterativen Optimierung hat er aber praktische Anwendungen in *compressed sensing* und auch beim *supervised learning* gefunden; vgl. [wikipedia:Landweber_iteration](https://en.wikipedia.org/wiki/Landweber_iteration).

::: {.definition #def-landweber-alg name="Landweber Iteration"}
Sei $A\in \mathbb R^{m\times n}$ und $b\in \mathbb R^{m}$. Dann ist, ausgehend von einem Startwert $x_0 \in \mathbb R^{n}$, die *Landweber Iteration* definiert &uuml;ber
\begin{equation*}
x_{k+1} = x_k - \gamma A^T(Ax_k -b ),
\end{equation*}
wobei der Parameter $\gamma$ als $0<\gamma< \frac{2}{\|A\|_2}$ gew&auml;hlt wird.
:::

Zur Illustration der Argumente, die die Konvergenz einer Fixpunktiteration mit linearer Verfahrensfunktion herleiten, zeigen wir die Konvergenz im Spezialfall, dass $Ax=b$ ein regul&auml;res lineares Gleichungssystem ist.

::: {.theorem #thm-lw-conv name="Konvergenz der Landweber Iteration"}
Unter den Voraussetzungen von Definition \@ref(def:def-landweber-alg) und f&uuml;r $m=n$ und $A\in \mathbb R^{n\times n}$ regul&auml;r, konvergiert die Landweber Iteration linear f&uuml;r einen beliebigen Startwert $x_0$.
:::

::: {.proof}
Ist das Gleichungssystem $Az=b$ eindeutig l&ouml;sbar, bekommen wir direkt, dass
\begin{equation*}
\begin{split}
x_{k+1} - z &= x_k - \gamma A^T(Ax_k -b ) - z  \\
&= x_k - \gamma A^TAx_k -\gamma A^Tb - z \\
&= (I-\gamma A^TA)x_k -\gamma A^TAz - z \\
&= (I-\gamma A^TA)(x_k - z)
\end{split}
\end{equation*}
Damit ergibt eine Absch&auml;tzung in der $2$-Norm und der induzierten Matrixnorm, dass
\begin{equation*}
\|x_{k+1}-z\|_2 \leq \|I-\gamma A^TA\|_2\|x_k-z\|_2
\end{equation*}
gilt, was lineare Konvergenz mit der Rate $c=\|I-\gamma A^TA\|_2$ bedeutet, wobei $c<1$ gilt nach der getroffenen Voraussetzung, dass $0<\gamma<\frac{2}{\|A^TA\|_2}$ ist.
:::

::: {#rem-fpconv-iteration-contraction .JHSAYS data-latex=''}
Das Prinzip dieser Beweise ist festzustellen, dass die Verfahrensfunktion in der N&auml;he des Fixpunkts eine *Kontraktion* ist, d.h. Lipschitz-stetig mit Konstante $L<1$.
:::

## Gradientenabstiegsverfahren

Anstelle der Nullstellensuche behandeln wir jetzt die Aufgabe
\begin{equation*}
f(x) \to \min_{x\in \mathbb R^{n}}
\end{equation*}
f&uuml;r eine Funktion $f \colon \mathbb R^{n} \to \mathbb R^{}$, also die Aufgabe ein $z^*\in \mathbb R^{n}$ zu finden, f&uuml;r welches der Wert von $f$ minimal wird.

Ist $f$ differenzierbar (der Einfachheit halber nehmen wir an, dass *totale* Differenzierbarkeit vorliegt; es w&uuml;rde aber Differenzierbarkeit in einer beliebigen Richtung, also *Gateaux*-Differenzierbarkeit, gen&uuml;gen), so gilt, dass in einem Punkt $x_0$, der Gradient $\nabla f(x_0)$ (ein Vektor im $\mathbb R^{n}$) in die Richtung des st&auml;rksten Wachstums zeigt und der negative Gradient $-\nabla f(x_0)$ in die Richtung, in der $f$ kleiner wird. 

Auf der Suche nach einem Minimum k&ouml;nnten wir also ausnutzen, dass 
\begin{equation*}
f(x_0 - \gamma_0 \nabla f(x_0)):=f(x_1)   < f(x_0)
\end{equation*}
falls $\gamma_0$ nur gen&uuml;gend klein ist und $\nabla f(x_0) \neq 0$.

::: {#rem-gamma-zerograd .JHSAYS data-latex=''}
Was ist, wenn $\nabla f(x_0) = 0$ ist und warum gibt es andernfalls so ein $\gamma_0$ und wie k&ouml;nnten wir es systematisch bestimmen?
:::

Diese Beobachtung am n&auml;chsten Punkt $x_1$ wiederholt, f&uuml;hrt auf des *Gradientenabstiegsverfahren*.

::: {.definition #def-grad-descent name="Gradientenabstiegsverfahren"}
Sei $f\colon \mathbb R^{n} \to \mathbb R^{}$ differenzierbar, dann hei&szlig;t die Iteration
\begin{equation}
x_{k+1} := x_k - \gamma_k\nabla f(x_k)
(\#eq:eqn-grad-desc)
\end{equation}
f&uuml;r passend gew&auml;hlte $\gamma_k>0$, das
Gradientenabstiegsverfahren zur Berechnung eines Minimums von $f$.
:::

::: {.lemma #lem-graddesc-as-fp name="Gradientenabstieg als konvergente Fixpunkt Iteration"}
Sei $f\colon D\subset \mathbb R^{n}\to \mathbb R$ konvex und zweimal stetig differenzierbar auf $D$ offen. Ist $z^*\in D$ ein Minimum von $f$ und sei $\overline \lambda$ die *Lipschitz-Konstante* von $\nabla f$, dann definiert \@ref(eq:eqn-grad-desc) mit $\gamma_k \equiv \frac 2{\overline \lambda}$ eine konvergente Fixpunktiteration f&uuml;r $\phi(x) = x-\gamma \nabla f(x)$ mit einem lokalen Minimum $z^*$ von $f$ als Fixpunkt.
:::

::: {.proof}
Vorlesung.
:::

Die vorhergegangenen &Uuml;berlegungen gingen von $z^*$ innerhalb eines offenen Definitionsbereichs $D$ von $f$ aus, wo ein Minimum durch $\nabla f(x^*)=0$ und $f(x^*)\leq f(x)$ f&uuml;r alle $x$ aus einer Umgebung von $x^*$ gegeben ist. 

Ein typischer Anwendungsfall ist jedoch, dass $x^*$ in einem zul&auml;ssigen Bereich $C$ liegen muss, der eine echte Teilmenge von $D$ ist. 
Dann besteht die M&ouml;glichkeit, dass ein (lokales) Minimum am Rand des Bereichs $C$ vorliegt (wo die Funktion $f$ zwar weiter f&auml;llt, aber "das Ende" der Zul&auml;ssigkeit erreicht ist).

Ist $C\subset \mathbb R^{n}$ konvex und abgeschlossen, so gilt folgendes allgemeine Resultat (dessen Argumente und Voraussetzungen auch leicht auf beispielsweise Funktionen auf allgemeinen Hilbertr&auml;umen oder Mengen die nur lokal konvex sind angepasst werden k&ouml;nnen).

::: {.theorem #thm-prj-grad-desc name="Projiziertes Gradientenabstiegsverfahren"}
Sei $C \subset \mathbb R^{n}$ konvex und abgeschlossen, dann ist die Projektion $P_C\colon \mathbb R^{n} \to C$ mittels
\begin{equation*}
P_C(x) := x^*,
\end{equation*}
wobei $x^*$ das Minimierungsproblem
\begin{equation*}
\min_{z\in C} \|x-z\|_2
\end{equation*}
l&ouml;st, wohldefiniert.

Sei ferner $f\colon D \to \mathbb R^{}$, mit $C \subset D$, konvex und differenzierbar mit Lipschitz-stetigem Gradienten mit Konstante $L$. Dann konvergiert das projizierte Gradientenabstiegsverfahren
\begin{equation}
x_{k+1} := P_C(x_k - \gamma_k\nabla f(x_k))
(\#eq:eqn-prj-grad-desc)
\end{equation}
f&uuml;r jeden Anfangswert $x_0\in D$ und beliebige Wahl von $\gamma_k < \frac 1L$ zu einem lokalen Minimum $z^*\in C$ von $f$.
:::

::: {.proof}
Technisch...
:::

## Auxiliary Function Methods

In manchen F&auml;llen ist es hilfreich, wenn das Problem selbst iterativ definiert wird. 
Dann wird in jedem Schritt ein vereinfachtes Problem gel&ouml;st und mit der gewonnenen Information, kann das Problem dem eigentlichen aber schwierigen Originalproblem n&auml;her gebracht werden. 

Als Beispiel betrachten wir das Problem 
\begin{equation}
f(x)=x_1^2+x_2^2 \to \min_{x\in D\subset \mathbb R^{2}}, \quad \text{wobei }D:=\{x\in \mathbb R^{2}\,|\, x_1+x_2 \geq 0\}.
(\#eq:eqn-exa-cnstrnt-optiprob)
\end{equation}

Zwar ist hier das projizierte Gradientenabstiegsverfahren unmittelbar anwendbar, wir werden aber sehen, dass wir mit einer Hilfsfunktion, sogar die analytische L&ouml;sung direkt ablesen k&ouml;nnen.

F&uuml;r $k=1,2,\dotsc$, sei das Hilfsproblem definiert als
\begin{equation}
B_k(x):=x_1^2+x_2^2 - \frac{1}{k}\log(x_1+x_2-1)\to \inf_C,
(\#eq:eqn-exa-relaxed-optiprob)
\end{equation}
wobei $C=\{x\,|\,x_1+x_2>0\}$. Aus dem "0-setzen" der partiellen Ableitungen von $B_k$, bekommen wir 
\begin{equation*}
x_{k,1}=x_{k,2} = \frac 14 + \frac 14 \sqrt{1 + \frac 4k},
\end{equation*}
also eine Folge, die zum Minimum des eigentlichen Problems konvergiert.

Zur Analyse solcher Verfahren, allgemein geschrieben als
\begin{equation}
G_k(x) = f(x) + g_k(x) \to \min_C, \quad k=1,2,\dotsc
(\#eq:eqn-gen-af-method)
\end{equation}
werden die folgenden zwei Bedingungen gerne herangenommen:

1. Die Iteration \@ref(eq:eqn-gen-af-method) hei&szlig;t *auxiliary function* (AF) Methode, falls $g_k(x)\geq 0$, f&uuml;r alle $k\in \mathbb N$ und $x\in C$, $g_k(x_{k-1})=0$.

2. Die Iteration geh&ouml;rt zur *SUMMA* Klasse, falls $G_k(x)-G_k(x_k) \geq g_{k+1}(x)$.

Unter der 1. Annahme gilt sofort, dass
\begin{equation*}
f(x_{k}) \leq f(x_{k}) + g_k(x_k) = G_k(x_k) \leq G_k(x_{k-1}) = f(x_{k-1}) + g_k(x_{k-1}) = f(x_{k-1}),
\end{equation*}
also dass die Folge $\{f(x_k)\}_{k\in \mathbb N}$ monoton fallend ist.

Aus der 2. Annahme folgt dann, dass $f(x_k) \to \beta^*=\inf_{x\in c}f(x)$, f&uuml;r $k\to \infty$, was sich wie folgt argumentieren l&auml;&szlig;t:

Angenommen, $f(x_k) \to \beta > \beta^*$, dann existiert ein $z\in C$, sodass $\beta > f(z) \geq \beta^*$. Dann ist, der 2. 2. Annahme nach,
\begin{equation*}
\begin{split}
g_k(z) - g_{k+1}(z) &= g_k(z) - (G_k(z)-G_k(x_k))    \\
&=g_k(z) - (f(z) + g_k(z) - f(x_k) - g_k(x_k)) \\
&\quad \geq f(z) - \beta + g_k(x_k) \geq f(z) - \beta > 0,
\end{split}
\end{equation*}
was impliziert, dass $0\leq g_{k+1}(z)<g_k(z)+c$, f&uuml;r alle $k$ und eine konstantes $c>0$, was ein Widerspruch ist.

Wir rechnen nach, dass \@ref(eq:eqn-exa-relaxed-optiprob) die Annahmen 1. und 2. erf&uuml;llt (allerdings erst nach einigen &auml;quivalenten Umformungen).

Zun&auml;chst halten wir fest, dass die Iteration in \@ref(eq:eqn-exa-relaxed-optiprob) geschrieben werden kann als
\begin{equation}
B_k(x) = f(x) + \frac 1k b(x) \to \min
(\#eq:eqn-min-barrier)
\end{equation}
was, da eine Skalierung das Minimum nicht &auml;nder ebensowenig wie die Addition eines konstanten Termes (konstant bez&uuml;glich $x$),
&auml;quivalent ist zu
\begin{equation*}
G_k(x) = f(x) + g_k(x)
\end{equation*}
mit
\begin{equation*}
g_k(x) = [(k-1)f(x) + b(x)] - [(k-1)f(x_{k-1}) + b(x_{k-1})].
\end{equation*}

Wir rechnen direkt nach, dass $g_k(x)\geq 0$ ist (folgt daraus, dass $x_{k-1}$ optimal f&uuml;r $G_{k-1}$ ist), dass $g_k(x_{k-1})=0$ ist, und dass $G_k(x)-G_k(x_k)=g_{k+1}(x)$ ist (daf&uuml;r muss ein bisschen umgeformt werden), sodass die Voraussetzungen f&uuml;r AF und SUMMA erf&uuml;llt sind.

Zum Abschluss einige Bemerkungen

 * das allgemeine $b$ in \@ref(eq:eqn-min-barrier) und im speziellen in \@ref(eq:eqn-exa-relaxed-optiprob) ist eine sogenannte *barrier* Funktion, die beispielsweise einen zul&auml;ssigen Bereich als $C=\{x\,|\, b(x)< \infty\}$ definiert.
 * weitere Methoden der Optimierung, die in die betrachteten (AF) Klassen fallen sind beispielsweise *Majorization Minimization*, *Expectation Maximization*, *Proximal Minimization* oder *Regularized Gradient Descent*.
 * Eine sch&ouml;ne Einf&uuml;hrung und &Uuml;bersicht liefert das Skript *Lecture Notes on Iterative Optimization Algorithms* [@Byr14].

## &Uuml;bungen

1. Bestimmen Sie die Konvergenzordnung und die Rate f&uuml;r das Intervallschachtelungsverfahren zur Nullstellenberechnung.

2. Benutzen Sie Satz \@ref(thm:thm-smooth-fp-conv) um zu zeigen, dass aus $f$ zweimal stetig differenzierbar und $f(z)=0$, $f'(z)\neq 0$ f&uuml;r ein $z\in D(f)$ folgt, dass das Newton-Verfahren zur Berechnung von $z$ lokal quadratisch konvergiert. *Hinweis*: Hier ist es wichtig zun&auml;chst zu verstehen, was die Funktion $f$ ist und was die Verfahrensfunktion $\phi$ ist.

3. Bestimmen sie die Funktion $h$ in $\phi(x) = x+h(x)f(x)$ derart, dass unter den Bedingungen von 2. die Vorschrift $\phi$ einen Fixpunkt in $z$ hat und derart, dass die Iteration quadratisch konvergiert.

4. Erkl&auml;ren Sie an Hand von Satz \@ref(thm:thm-smooth-fp-conv) (und den vorhergegangenen &Uuml;berlegungen) warum Newton f&uuml;r das Problem *finde $x$, so dass $x^2=0$ ist* **nicht** quadratisch (aber doch superlinear) konvergiert.

5. Beweisen Sie, dass f&uuml;r $0<\gamma< \frac{2}{\|A^TA\|_2}$ gilt, dass$\|I-\gamma A^TA\|_2<1$ f&uuml;r beliebige $A\in \mathbb R^{m \times n}$. 

6. Rechnen Sie nach, dass die Landweber Iteration aus Definition \@ref(def:def-landweber-alg) einem ged&auml;mpften Gradientenabstiegsverfahren f&uuml;r $\|Ax-b\|_2^2 \to \min_{x\in \mathbb R^{m}}$ entspricht.

7. Implementieren Sie das projizierte Gradientenabstiegsverfahren f&uuml;r \@ref(eq:eqn-exa-cnstrnt-optiprob) und das *nichtprojizierte* aber an $k$ angepasste Gradientenabstiegsverfahren f&uuml;r \@ref(eq:eqn-exa-relaxed-optiprob). Vergleichen Sie die Konvergenz f&uuml;r verschiedene Startwerte.
