# Fehler und Konditionierung

\def\kij{(\kappa_{A,x})_{ij}}
Berechnungen auf einem Computer verursachen unvermeidlich Fehler, und die Effizienz oder Leistung von Algorithmen ist immer das Verhältnis von Kosten zu Genauigkeit. 

Zum Beispiel:

 * Allein aus der Betrachtung von Rundungsfehlern kann die Genauigkeit einfach und signifikant verbessert werden, indem auf *Langzahlarithmetik* zurückgegriffen wird, was jedoch höhere Speicheranforderungen und eine höhere Rechenlast mit sich bringt.

 * In iterativen Verfahren können Speicher und Rechenaufwand leicht eingespart werden, indem die Iteration in einem frühen Stadium gestoppt wird - nat&uuml;rlich auf Kosten einer weniger genauen Lösungsapproximation.

::: {#rem-accu-iter .JHSAYS data-latex=''}
Beide, irgendwie trivialen Beobachtungen sind grundlegende Bestandteile des Trainings neuronaler Netzwerke. Erstens wurde beobachtet, dass Zahldarstellungen mit *einfacher Genauigkeit* (im Vergleich zum g&auml;ngigen *double precision*) Rechenkosten sparen kann, mit nur geringen Auswirkungen auf die Genauigkeit. Zweitens ist das Training ein iterativer Prozess mit oft langsamer Konvergenz, sodass der richtige Zeitpunkt für einen vorzeitigen Abbruch des Trainings entscheidend ist.
:::

## Fehler

::: {.definition #errors name="Absolute und relative Fehler"}
Sei $x\in\mathbb R^{}$ die interessierende Größe und $\tilde x \in \mathbb R^{}$ eine Annäherung daran. Dann wird der *absolute Fehler* definiert als $|\delta x|:=|\tilde x- x|$ und der *relative Fehler* als $\frac{|\delta x|}{|x|}=\frac{|\tilde x- x|}{|x|}$.
:::

::: {#rem-rel-abs-err .JHSAYS data-latex=''}
Generell wird der relative Fehler bevorzugt, da er den gemessenen Fehler in den richtigen Bezug setzt. Zum Beispiel kann ein absoluter Fehler von $10$ km/h je nach Kontext groß oder klein sein.
:::

## Kondition

Als Nächstes definieren wir die *Kondition* eines Problems $A$ und analog eines Algorithmus (der das Problem löst). Dafür lassen wir $x$ einen Parameter/Eingabe des Problems sein und $y=A(x)$ die entsprechende Lösung/Ausgabe. Die Kondition ist ein Maß dafür, inwieweit eine Änderung $x+\delta x$ in der Eingabe die resultierende relative Änderung in der Ausgabe beeinflusst. Dafür betrachten wir
\begin{equation*}
\delta y = \tilde y - y = A(\tilde x) - A(x) = A(x+\delta x) - A(x)
\end{equation*}
welches nach Division durch $y=A(x)$ und Erweiterung durch $x\,\delta x$ wird zu
\begin{equation*}
\frac{\delta y}{y} = \frac{A(x+\delta x)-A(x)}{\delta x}\frac{x}{A(x)}\frac{\delta x}{x}.
\end{equation*}
Für infinitesimal kleine $\delta x$ wird der Differenzenquotient $\frac{A(x+\delta x)-A(x)}{\delta x}$ zur Ableitung $\frac{\partial A}{\partial x}(x)$, so dass wir die Kondition des Problems/Algorithmus bei $x$ abschätzen können durch
\begin{equation}(\#eq:eqn-scalar-cond)
\frac{|\delta y|}{|y|} \leq |\frac{\partial A}{\partial x}(x)|\frac{|x|}{|A(x)|}\frac{|\delta x|}{|x|}=:\kappa_{A,x}\frac{|\delta x|}{|x|}.
\end{equation}
Wir nennen $\kappa_{A,x}$ die Konditionszahl.

Für vektorwertige Probleme/Algorithmen können wir die Konditionszahl darüber definieren, wie eine Differenz in der $j$-ten Eingabekomponente $x_j$ die $i$-te Komponente $y_i=A_i(x)$ der Ausgabe beeinflusst.

::: {.definition #condition name="Konditionszahl"}
Für ein Problem/Algorithmus $A\colon \mathbb R^{n}\to \mathbb R^{m}$ nennen wir
\begin{equation*}
(\kappa_{A,x})_{ij} := \frac{\partial A_i}{\partial x_j}(x) \frac{x_j}{A_i(x)}
\end{equation*}
die partielle *Konditionszahl* des Problems. Ein Problem wird als *gut konditioniert* bezeichnet, wenn $|\kij|\approx 1$ und als *schlecht konditioniert*, wenn $|\kij \gg 1$, für alle $i=1,\dotsc,m$ und $j=1,\dotsc,m$.
:::

::: {#rem-vector-valued-cond .JHSAYS data-latex=''}
Anstatt die skalaren Komponentenfunktionen von $A\colon \mathbb R^{n} \to \mathbb R^{m}$ zu verwenden, kann man die Berechnungen, die zu \@ref(eq:eqn-scalar-cond) geführt haben, mit vektorwertigen Größen in den entsprechenden Normen wiederholen.
:::

## Kondition der Grundrechenarten

Da einfach jede Operation von Zahlen auf dem Computer auf die Grundrechenarten zurueckgeht, ist es wichtig sich zu vergegenw&auml;rtigen wie sich diese Basisoperationen in Bezug auf kleine Fehler verhalten.

### Addition 

```py
def A(x, y):
    return x+y

x, tx, y = 1.02, 1.021, -1.00
z = A(x, y)
tz = A(tx, y)
relerrx = (tx - x)/x        # here: 0.00098039
relerrz = (tz - z)/z        # here: 0.04999999
kondAx = relerrz/relerrx    # here: 50.9999999
```


In diesem Code Beispiel liegt der relative Fehler in $x$ bei etwa $0.01$\% und im Ausgang $z$ bei etwa $5$\%, was einer etwa $50$-fachen Verst&auml;rkung entspricht. 
F&uuml;r die Konditionszahl der Addtion $A_y\colon x \to y+x$ gilt:
\begin{equation*}
\kappa_{A_y;x} = \frac{|x|}{|x+y|} = \frac{1}{|1+\frac{y}{x}|}.
\end{equation*}

Diese Konditionszahl kann offenbar beliebig gro&szlig; werden, wenn $x$ nah an $-y$ liegt. Jan spricht von Ausl&ouml;schung und tats&auml;chlich l&auml;sst sich nachvollziehen, dass in diesem Fall die vorderen (korrekten) Stellen einer Zahl von einander abgezogen werden und die hinteren (m&ouml;glicherweise inkorrekten) Stellen &uuml;brig bleiben.


::: {#rem-accu-iter .JHSAYS data-latex=''}
Praktisch gesagt: Hantiert Jan mit Addition gro&szlig;er Zahlen um ein kleines Ergebnis erzielen ist das numerisch sehr ung&uuml;nstig. 
:::

### Multiplikation 

```py
def M(x, y):
    return x*y

x, tx, y = 1.02, 1.021, -1.00
z = M(x, y)
tz = M(tx, y)
relerrx = (tx - x)/x        # here: 0.00098039
relerrz = (tz - z)/z        # here: 0.00098039
kondMx = relerrz/relerrx    # here: 1.0
```

Das Ergebnis `1.0` f&uuml;r die empirsch ermittelte Konditionszahl war kein Zufall. Es gilt im Allgemeinen f&uuml;r $M_y \colon x \to yx$ dass 
\begin{equation*}
\kappa_{M_y;x} = |y|\frac{|x|}{|xy|} = 1.
\end{equation*}
Die Multiplikation ist also generell gut konditioniert.

### Wurzelziehen

Das Berechnen der Quadratwurzel $W\colon x \to \sqrt x$ hat die Konditionszahl $\frac 12$. Bei Konditionszahlen kleiner als $1$ verringert sich der relative Fehler, Jan spricht von *Fehlerd&auml;mpfung*.

## Übungen

1. Leiten Sie die *Konditionszahl* wie in \@ref(eq:eqn-scalar-cond) für eine vektorwertige Funktion $A\colon \mathbb R^{n} \to \mathbb R^{m}$ her. Wo spielt eine Matrixnorm eine Rolle?
1. Leiten Sie mite dem selben Verfahren die Konditionszahl einer invertierbaren Matrix $M$ her, d.h. die Kondition des Problems $x\to y = M^{-1}x$. Wo spielt die Matrixnorm eine Rolle?
1. Leiten Sie die Konditionszahlen f&uuml;r die Operationen *Division* und *Quadratwurzelziehen* her.
1. Veranschaulichen Sie an der Darstellung des Vektors $P=[1, 1]$ in der Standardbasis $\{[1, 0], \,[0, 1]\}$ und in der Basis $\{[1, 0], \,[1, 0.1]\}$ unter Verweis auf die Kondition der Addition, warum *orthogonale Basen* als *gut konditioniert* gelten.
