# Einführung

Was sind *Numerische Methoden für Maschinelles Lernen* (ML)?

Kurz gesagt, beim Training eines ML-Modells durchläuft ein Computer Millionen von Anweisungen, die in Form mathematischer Ausdrücke formuliert sind. 
Gleiches gilt für die Bewertung eines solchen Modells.
Dann stellen sich Fragen wie *wird es einen Punkt geben, an dem das Training endet?* und *wird das Modell genau sein?*.

Um zu beschreiben, was passiert, und für die spätere Analyse führen wir die allgemeinen Konzepte von

* Algorithmus
* Konsistenz/Genauigkeit
* Stabilität
* Rechenaufwand

ein, von denen einige klassische *numerische Analysen* sind.

## Was ist ein Algorithmus

Interessanterweise ist der Begriff *Algorithmus* ähnlich intuitiv und abstrakt. Es bedurfte großer Anstrengungen, um eine allgemeine und prägnante Definition zu finden, die den Anforderungen und Einschränkungen aller Bereiche gerecht wird (von *Kochrezepten* bis zur Analyse von *formalen Sprachen*).

::: {.definition #algorithm name="Algorithmus"}
Ein Problemlösungsverfahren wird als *Algorithmus* bezeichnet, wenn und nur wenn es eine *Turing-Maschine* gibt, die dem Verfahren entspricht und die, für jede Eingabe, für die eine Lösung existiert, *anhalten* wird.
:::

Diese Definition ist in ihrer Allgemeinheit nicht allzu hilfreich - wir haben nicht einmal definiert, was eine Turing-Maschine ist.

::: {#rem-coors .JHSAYS data-latex=''}
Eine *Turing-Maschine* kann als eine Maschine beschrieben werden, die einen Streifen von Anweisungen liest und auf diesen Streifen schreiben kann. Abhängig davon, was sie liest, kann sie vorwärts bewegen, rückwärts bewegen oder anhalten (wenn der Streifen einen vordefinierten Zustand erreicht hat). Das Schöne daran ist, dass dieses Setup in einen vollständig mathematischen Rahmen gestellt werden kann.
:::

Hilfreicher und gebräuchlicher ist es, die Implikationen dieser Definition zu betrachten, um zu überprüfen, ob ein Verfahren zumindest die notwendigen Bedingungen für einen Algorithmus erfüllt

* Der Algorithmus wird durch endlich viele Anweisungen beschrieben (Endlichkeit).
* Jeder Schritt ist *machbar*.
* Der Algorithmus erfordert eine endliche Menge an Speicher.
* Er wird nach endlich vielen Schritten beendet.
* In jedem Schritt ist der nächste Schritt eindeutig definiert (*deterministisch*).
* Für denselben Anfangszustand wird er im selben Endzustand anhalten (*bestimmt*).

Somit könnte eine informelle, gute Praxisdefinition eines Algorithmus sein

::: {.definition #info-algorithm name="Algorithmus -- informell"}
Ein Verfahren aus endlich vielen Anweisungen wird als *Algorithmus* bezeichnet, wenn es eine bestimmte Lösung -- falls sie existiert -- zu einem Problem in endlich vielen Schritten berechnet.
:::

::: {#rem-coors .JHSAYS data-latex=''}
Beachten Sie, wie einige Eigenschaften (wie endlich viele Anweisungen) a priori angenommen werden.
:::

Als noch informelleren Verweis auf Algorithmen werden wir die Begriffe **_(numerische) Methode_** oder **_Schema_** verwenden, um ein Verfahren durch Auflistung seiner zugrundeliegenden Ideen und Unterprozeduren anzusprechen, wobei *Algorithmus* sich auf eine spezifische Realisierung einer *Methode* bezieht.

Weiterhin unterscheiden wir

* *direkte* Methoden -- die die Lösung exakt berechnen (wie die Lösung eines linearen Systems durch *Gauß-Elimination*) und
* *iterative* Methoden -- die iterativ eine Folge von Annäherungen an die Lösung berechnen (wie die Berechnung von Wurzeln mit einem *Newton-Schema*).

## Konsistenz, Stabilität, Genauigkeit

Für die Analyse numerischer Methoden werden allgemein die folgenden Begriffe verwendet:

::: {.definition #consistency name="Konsistenz"}
Wenn ein Algorithmus in exakter Arithmetik die Lösung des Problems mit einer gegebenen Genauigkeit berechnet, wird er als *konsistent* bezeichnet.
:::

::: {.definition #stability name="Stabilität (informell)"}
Wenn die Ausgabe eines Algorithmus kontinuierlich von Unterschieden in der Eingabe und kontinuierlich von Unterschieden in den Anweisungen abhängt, dann wird der Algorithmus als *stabil* bezeichnet.
:::

Die *Unterschiede in den Anweisungen* sind typischerweise auf Rundungsfehler zurückzuführen, wie sie in *ungenauer Arithmetik* auftreten.

::: {#rem-coors .JHSAYS data-latex=''}
Man könnte sagen, dass ein Algorithmus konsistent ist, wenn *er das Richtige tut* und dass er stabil ist, *wenn er trotz aller Arten von kleinen Ungenauigkeiten funktioniert*. Wenn ein Algorithmus konsistent und stabil ist, wird er oft als *konvergent* bezeichnet, um auszudrücken, dass er schließlich die Lösung auch in ungenauer Arithmetik berechnen wird.
:::

Beachten Sie, dass Begriffe wie 

* *Genauigkeit* -- wie nahe die berechnete Ausgabe der tatsächlichen Lösung kommt oder
* *Konvergenz* -- wie schnell (typischerweise in Bezug auf den Rechenaufwand) der Algorithmus sich der tatsächlichen Lösung nähert

keine intrinsischen Eigenschaften eines Algorithmus sind, da sie von dem zu lösenden Problem abhängen.
Man kann jedoch von *Ordnungskonsistenz* eines Algorithmus sprechen, um die erwartete Genauigkeit für eine Klasse von Problemen zu spezifizieren, und einen Algorithmus als konvergent einer bestimmten Ordnung bezeichnen, wenn er auch stabil ist.

## Rechenkomplexität

Die *Rechenkomplexität* eines Algorithmus ist sowohl theoretisch (um abzuschätzen, wie der Aufwand mit beispielsweise der Größe des Problems skaliert) als auch praktisch (um zu sagen, wie lange das Verfahren dauern wird und welche Kosten in Bezug auf CPU-Zeit oder Speichernutzung es generieren wird) wichtig.

Typischerweise wird die Komplexität durch Zählen der elementaren Operationen gemessen, oft als *FLOP*s bezeichnet, was für *floating point operations* steht. 
Um die Algorithmen in Bezug auf Komplexität versus Problemgröße zu klassifizieren, sind die folgenden Funktionsklassen hilfreich

::: {.definition #landau-symbs name="Landau-Symbole oder große O-Notation"}
Sei $g\colon \mathbb R^{} \to \mathbb R^{}$ und $a\in\mathbb R^{} \cup \{-\infty, +\infty\}$. Dann sagen wir für eine Funktion $f\colon \mathbb R \to \mathbb R^{}$, dass $f\in O(g)$, wenn
\begin{equation*}
\limsup_{x\to a} \frac{|f(x)|}{|g(x)|} < \infty
\end{equation*}
und dass $f\in o(g)$, wenn
\begin{equation*}
\limsup_{x\to a} \frac{|f(x)|}{|g(x)|} = 0.
\end{equation*}
:::

Der Sinn und die Funktionalität dieser Konzepte wird vielleicht deutlich, wenn man sich die typischen Anwendungen ansieht:

* Wenn $h> 0$ ein Diskretisierungsparameter ist und, sagen wir, $e(h)$ der Diskretisierungsfehler ist, dann könnten wir sagen, dass $e(h) = O(h^2)$, wenn *asymptotisch*, d.h. für immer kleinere $h$ -- der Fehler mindestens so schnell wie $h^2$ gegen $0$ geht.
* Wenn $C(n)$ die Komplexität eines Algorithmus für eine Problemgröße $n$ ist, dann könnten wir sagen, dass $C(n) = O(n)$, um auszudrücken, dass die Komplexität *asymptotisch*, d.h. für immer größere $n$, mit derselben Geschwindigkeit wie die Problemgröße wächst.

Leider ist die übliche Verwendung der Landau-Symbole etwas nachlässig.

1. Das oft verwendete "$=$"-Zeichen ist informell und keineswegs eine Gleichheit.
2. Was das Limit $a$ ist, wird kaum jemals explizit erwähnt, aber glücklicherweise ist es in der Regel aus dem Kontext klar.

Als Beispiel betrachten wir zwei verschiedene Wege, ein Polynom $p$ vom Grad $n$ an der Abszisse $x$ zu bewerten, basierend auf den zwei äquivalenten Darstellungen
\begin{equation*}
\begin{split}
p(x) &= a_0 + a_1x +  a_2x^2+ \dotsm + a_nx^n \\
     &= a_0 + x(a_1 + x(a_2 + \dotsm +x(a_{n-1} + a_nx) \dotsm ))
\end{split}
\end{equation*}

Für eine direkte Implementierung der ersten Darstellung erhalten wir

```py
'''Berechnung von p(x) in Standarddarstellung
'''
n = 10                                      # Beispielwert für n
ais = [(-1)**k*1/k for k in range(1, n+2)]  # Liste der Beispielkoeffizienten
x = 5                                       # Ein Beispielwert für x
cpx = ais[0]                                # der Fall k=0
for k in range(n):
    cpx = cpx + ais[k+1] * x**(k+1)         # der Beitrag des k-ten Schritts
print(f'x={x}: p(x)={cpx:.4f}')             # Ausgabe des Ergebnisses
```

Im $k$-ten Schritt benötigt der Algorithmus eine Addition (wenn wir auch die Initialisierung als Addition zählen) und $k$ Multiplikationen. Das ergibt eine Gesamtkomplexität von
\begin{equation*}
C(n) = \sum_{k=0}^n(1+k) = n+1 + \frac{n(n-1)}{2} = 1 + \frac n2 + \frac{n^2}2 = O(n^2)
\end{equation*}

Für die zweite Darstellung können wir das sogenannte *Horner-Schema* implementieren, das lauten würde

```py
'''Berechnung von p(x) mit dem Horner-Schema
'''
n = 10                                      # Beispielwert für n
ais = [(-1)**k*1/k for k in range(1, n+2)]  # Liste der Beispielkoeffizienten
x = 5                                       # Ein Beispielwert für x
cpx = ais[n]                                # der Fall k=n
for k in reversed(range(n)):                
    cpx = ais[k] + x*cpx                    # der Beitrag des k-ten Schritts
print(f'x={x}: p(x)={cpx:.4f}')             # Ausgabe des Ergebnisses
```
Insgesamt benötigt dieses Schema $n+1$ Additionen und $n$ Multiplikationen, d.h. $2n+1$ FLOPs, so dass wir sagen können, dass *dieser Algorithmus $O(n)$ ist*.

## Übungen

1. Vergleichen Sie die beiden Implementierungen zur Bewertung eines Polynoms, indem Sie die Komplexität als Funktion von $n$ darstellen und die benötigte CPU-Zeit für eine Beispielbewertung im Vergleich zu $n$ messen und darstellen.

Weiterführende Literatur:

* [wikipedia:Algorithmus](https://de.wikipedia.org/wiki/Algorithmus#Definition)
