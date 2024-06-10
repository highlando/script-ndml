# Support Vector Machines

\newcommand\ipro[2]{\bigl ( #1, \, #2\bigr) }

In diesem Kapitel betrachten wir, wie das Klassifizierungsproblem (erstmal
bez&uuml;glich zweier Merkmale) durch eine optimale Wahl einer trennenden
Hyperebene gel&ouml;st werden kann.
In der Tat sind die Merkmale der SVM

* dass die *beste* Hyperebene
* effizient berechnet wird
* und das sogar f&uuml;r m&ouml;glicherweise nichtlineare Einbettungen in
  h&ouml;here Dimensionen (*kernel-SVM*)

![Beispiel Illustration von Punktwolken mit zwei verschiedenen Labels (hier rot
und blau) und verschiedener trennender Hyperebenen](bilder/08_hyperebene-punkte-bsp.png){#fig:cases-cntrd-HA width="65%"}

::: {.definition #def-svm-problem name="Problemstellung f&uuml;r die SVM"}
1. Gegeben sei eine Wolke im $\mathbb R^{n}$ von $N$ Datenpunkten $$\mathbb X :=
   \bigl \{(x_i,y_i)\colon x_i \in \mathbb R^{n}, \, y_i\in \{-1,+1\}, \,
   i=1,\dotsc, N\bigr \}$$ wobei $x_i$ der Datenpunkt ist und $y_i$ das
   zugeh&ouml;rige Label.

2. Eine *Hyperebene* $H\subset \mathbb R^{n}$, definiert durch den
   St&uuml;tzvektor $b\subset \mathbb R^{n}$ und den Normalenvektor $w\in
   \mathbb R^{n}$, hei&szlig;t **trennend**, falls 
   $$
   y_i\ipro{x_i-b}{w} >0, \quad i=1,\dotsc,N
   $$

3. Die Hyperebene $H$ hei&szlig;t *Support Vector Machine* falls, $H$ die
   Hyperebene ist, f&uuml;r die der **kleinste** Abstand 
   $$d(H, \mathbb X) = \min_{s\in H, i=1, \dotsc, N}\{\|s-x_i\|_2\}$$
   **maximal** wird.

:::

Ein Paar Bemerkungen dazu.

1. Dass die Labels mit $\pm 1$ gew&auml;hlt werden hat ganz praktische
   Gr&uuml;nde:
2. Zun&auml;chst l&auml;sst sich anhand des Vorzeichen des inneren Produktes
   $\ipro{x-b}{w}$ entscheiden, auf *welcher Seite* von $H$ ein Punkt $x$ liegt.
   (Punkte auf der gleichen Seite haben das gleiche Vorzeichen). Mit der Wahl
   der labels als $\pm 1$ kann das kompakt in einer Gleichung wie in der
   Definition geschrieben werden.
3. Ist die Hyperebene bekannt, k&ouml;nnen neue Datenpunkte $x$ &uuml;ber das
   Vorzeichen von $\ipro{x-b}{w}$ gelabelt werden -- das ist die eigentliche
   Motivation, diese Hyperebene m&ouml;glichst gut zu bestimmen.
4. Es gilt $\ipro{x-b}{w}=\ipro{x}{w}-\ipro{b}{w}:=\ipro xw -\beta$. Und damit
   gen&uuml;gt es zur Definition (und zum Einsatz in der Klassifizierung), nur
   den Vektor $w\in \mathbb R^{n}$ und den *bias* $\beta \in \mathbb R^{}$ zu
   bestimmen (beziehungsweise zu kennen).
5. Klassischere Methoden zur Klassifizierung mittels Hyperebene benutzen
   beispielsweise einfache neuronale Netze um ein passendes $(w, \beta)$ zu bestimmen.
6. Eine solche Hyperebene kann durchaus auch **nicht existieren**, dann
   hei&szlig;en die Daten *nicht linear trennbar*. Existiert eine solche Ebene,
   dann existieren unendlich viele -- ein weiterer Grund, die Ebene optimal (und
   damit hoffentlich eindeutig) zu w&auml;hlen.
