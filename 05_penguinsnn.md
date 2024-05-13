# Ein NN Beispiel

Zur Illustration der Konzepte, betrachten wir ein Beispiel in dem ein einfaches
*Neuronales Netz* f&uuml;r die Klassifizierung von Pinguinen anhand vierer
Merkmale aufgesetzt, trainiert und auf Funktion gepr&uuml;ft wird.

## Der PENGUINS Datensatz

Die Grundlage ist der [*Pinguin Datensatz*](https://allisonhorst.github.io/palmerpenguins/), der eine gern genommene Grundlage f&uuml;r die Illustration in der Datenanalyse ist. Die Daten wurden von [Kristen Gorman](https://www.uaf.edu/cfos/people/faculty/detail/kristen-gorman.php) erhoben und beinhalten 4 verschiedene Merkmale (engl. *features*) von einer Stichprobe von insgesamt 344^[allerdings mit 2 unvollst&auml;ndigen Datenpunkten, die ich entfernt habe f&uuml;r unsere Beispiele]Pinguinen die 3 verschiedenen Spezies zugeordnet werden k&ouml;nnen oder sollen (Fachbegriff hier: *targets*). Im Beispiel werden die Klassen mit `0, 1, 2` codiert und beschreiben die Unterarten *Adele*, *Gentoo* und *Chinstrap* der Pinguine. Die Merkmale sind gemessene L&auml;nge und H&ouml;he des Schnabels (hier *bill*), die L&auml;nge der Flosse (*flipper*) sowie das K&ouml;pergewicht ^[Im Originaldatensatz ist das Gewicht in Gramm angegeben, um die Daten innerhalb einer 10er Skala zu haben, habe ich das Gewicht auf in kg umgerechnet]
(*body mass*).

Wir stellen uns die Frage:

> K&ouml;nnen wir aus den Merkmalen (*features*) die Klasse (*target*) erkennen und wie machen wir gegebenenfalls die Zuordnung?

In h&ouml;heren Dimensionen ist schon die graphische Darstellung der Daten ein Problem. Wir k&ouml;nnen aber alle m&ouml;glichen 2er Kombinationen der Daten in 2D plots visualisieren.

![Pinguin Datenset 2D plots](bilder/05-all-pairs.png){#fig:05-penguin-allpairs width="75%"}

Ein Blick auf die Diagonale zeigt schon, dass manche Merkmale besser geeignet als andere sind, um die Spezies zu unterscheiden. Allerdings reichen (in dieser linearen Darstellung) zwei Merkmale nicht aus, um eine eindeutige Diskriminierung zu erreichen.

## Ein *2*-Layer Neuronales Netz zur Klassifizierung

Wir definieren ein neuronales Netzes $\mathcal N$ mit einer *hidden layer* als
\begin{equation*}
\eta_i = \mathcal N (x_i):=\tanh \bigl (A_2 \tanh (A_1 x_i + b_1) + b_2\bigr ),
\end{equation*}
das f&uuml;r einen Datenpunkt $x_i \in \mathbb R^{n_0}$ einen Ergebniswert $\eta_i\in \mathbb R^{n_2}$ liefert.
Die sogenannten Gewichte $A_1 \in \mathbb R^{n_1 \times n_0}$, $b_1 \in \mathbb R^{n_1}$, $A_2 \in \mathbb R^{n_2, n_1}$, $b_2 \in \mathbb R^{n_2}$ parametrisieren diese Funktion. Eine Schicht besteht aus der einer affin-linearen Abbildung und einer *Aktivierungsfunktion* die hier als $\tanh$ gew&auml;hlt wird und die komponentenweise angewendet wird.

Wir werden $n_0=4$ (soviele Merkmale als Eingang) und $n_2=1$ (eine
Entscheidungsvariable als Ausgang) setzen und das Netzwerk so trainieren, dass
anhand der gemessenen Daten $x_i$ die bekannte Pinguin Population
[`penguin-data.json`](files/penguin-data.json) in zwei Gruppen aufgeteilt
werden, wobei in der ersten Gruppe eine Spezies enthalten ist und in der anderen
die beiden anderen Spezies.

Dazu kann eine Funktion $\ell \colon X \mapsto \{-1, 1\}$ definiert werden, die die bekannten Pinguine $x_i$ aus dem Datensatz $X$ ihrer Gruppe zuordnet. Dann k&ouml;nnen die Koeffizienten von $\mathcal N$ &uuml;ber das Optimierungsproblem
\begin{equation*}
\frac{1}{|X|}\sum_{x_i \in X} \|\ell(x_i)-\mathcal N(x_i)\|^2 \to \min_{A_1, b_1, A_2, b_2}
\end{equation*}
mittels des *stochastischen (batch) Gradientenabstiegs* bestimmt werden.

Zur Optimierung wird typischerweise ein Teil (z.B. 90%) der Datenpunkte
verwendet &uuml;ber die mehrfach (in sogenannten *epochs*) iteriert wird.

Danach kann mittels der verbliebenen Datenpunkte getestet werden, wie gut das
Netzwerk Daten interpretiert, die es noch nicht "gesehen" hat.
