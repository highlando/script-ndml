# Best and Universal Approximation

\def\PLab{\operatorname{PL}[a, b]}
\def\Cab{\mathcal{C}[a, b]}

Alle bisher betrachteten Approximationsprobleme waren in Bezug auf eine *2-norm*
("least squares") formuliert. Die f&uuml;r die Berechnung unmittelbaren Vorteile
sind die

1. Differenzierbarkeit der Norm und die
2. Charakterisierung der Optimall&ouml;sung &uuml;ber Orthogonalit&auml;t.

Ein g&auml;ngiges Optimierungsproblem, eine Bestapproximation zu einer stetigen
Funktion $f\colon [a, b]\to \mathbb R^{}$ in einer passenden Menge von Funktionen
$\mathcal G$ bez&uuml;glich der *Supremumsnorm*^[f&uuml;r ein kompaktes
Intervall wird das zur *Maximumsnorm*] zu finden
\begin{equation*}
\min_{g\in \mathcal G} \|f-g\|_\infty = 
\min_{g \in \mathcal G}\bigl (\max_{x\in [a, b]}|f(x)-g(x)|\bigr )
\end{equation*}
f&auml;llt nicht darunter.
Die entstehenden Schwierigkeiten und theoretische und praktische Ans&auml;tze
zur m&ouml;glichen L&ouml;sung dieses sogenannten
*Tschebyscheff-Approximation*-Problem, sind in [Kapitel 8.7.2, @RicW17] gut
nachzulesen.

Wir wollen hier nachvollziehen, dass klassische neuronale Netze, dieses Problem
approximativ aber mit beliebiger Genauigkeit $\epsilon$ l&ouml;sen k&ouml;nnten. Die
Schritte da hin sind wie folgt

1. Zu einem gegebenen $f\in \mathcal C[a, b]$ (einer reellwertigen, stetigen Funktion
   auf einem
   endlichen und abgeschlossenen Intervall) existiert immer eine st&uuml;ckweise
   Stetige Funktion $f_N$ mit endlich vielen *Sprungstellen*, sodass 
   \begin{equation*}
   \|f-f_N\|_\infty < \frac \epsilon2
   \end{equation*}

2. Zu diesem $f_N$ k&ouml;nnen wir immer eine Funktion
   \begin{equation*}
   s_M(x) = c_0 + \sum_{i=1}c_i \tanh (a_ix + b_i)
   \end{equation*}
   konstruieren (durch Anpassung der Parameter $c_0$, $c_i$, $b_i$, $a_i$,
   $i=1,\dotsc, M$) sodass 
   \begin{equation*}
   \|f_N-s_M\| < \frac \epsilon2.
   \end{equation*}

3. Wir interpretieren $s_M$ als ein neuronales Netz mit einer *hidden layer* und
   k&ouml;nnen konstatieren dass
   \begin{equation*}
   \|f-s_M\|_\infty \leq \|f-f_N\|_\infty + \|f_N-s_M\|_\infty < \frac \epsilon2
   + \frac \epsilon2 = \epsilon.
   \end{equation*}

Einige Fragen werden wir unbeantwortet lassen m&uuml;ssen, vor allem

 * wie w&auml;hlen wir $M$ (das Resultat sagt nur $M$ muss gro&szlig; genug
   sein)

und 

 * wie wirkt sich in der Praxis die approximative Berechnung von $a_i$--$c_i$
   auf die Approximation aus?

Dennoch gibt dieses Beispiel einen Einblick in die Funktionsweise der
Approximation und das referenzierte *universal
approximation theorem* ist Grundlage vieler Analyseans&auml;tze f&uuml;r
neuronale Netzwerke.

In Schritt 1, wird die st&uuml;ckweise stetige Funktion $f_N$ definiert. Die
Existenz folgt aus dem Satz

::: {.theorem #thm-pl-dense-C name="St&uuml;ckweise stetige Funktion liegen dicht"}
Sei $[a, b]\subset \mathbb R^{}$ ein abgeschlossenes endliches Intervall. 
Die Menge $\operatorname{pl}[a, b]$ aller st&uuml;ckweise stetigen Funktionen auf $[a, b]$ *liegt dicht*
in $\mathcal C[a, b]$ sodass f&uuml;r ein beliebiges $f\in \mathcal C[a, b]$ und $\varepsilon > 0$, immer ein $g\in
\operatorname{pl}[a, b]$ existiert mit $\|f-g\|_\infty<\varepsilon$.
:::

::: {.proof}
Der Beweis ist klassisch -- hier nur die relevanten und konstruktiven Elemente.

An sich muss f&uuml;r Dichtheit gezeigt werden, dass es zu jeder Funktion $f\in
\mathcal C[a, b]$ als eine Folge in $\PLab$ gibt, mit $f$ als Grenzwert. Wir
zeigen nur die Konstruktion eines potentiellen Folgengliedes.

Sei $f\in \Cab$ beliebig. Da stetige Funktionen auf kompakten Mengen
gleichm&auml;&szlig;ig stetig sind, gibt es zu jedem $\varepsilon>0$ ein $\delta>0$, sodass
\begin{equation*}
|f(x\pm h) - f(x)| < \epsilon
\end{equation*}
f&uuml;r alle $h<\delta$. Damit k&ouml;nnen wir zu jedem $\varepsilon$ eine
Unterteilung von $(a, b]$ in $N(\delta)$ halboffene disjunkte Intervalle $I_j$,
$j=1, \dotsc, N(\delta)$ finden, sodass
\begin{equation*}
f_N(x) = \sum_{j=1}^N\max_{x\in I_j}f(x)\Chi_{I_j}
\end{equation*}
:::
eine Funktion aus $\PLab$ darstellt, die um maximal $\varepsilon$ von $f$
abweicht.
