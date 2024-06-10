# Support Vector Machines

\newcommand\ipro[2]{\bigl \langle #1, \, #2\bigr\rangle }

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

## Problemstellung 

::: {.definition #def-svm-problem name="Problemstellung f&uuml;r die SVM"}
1. Gegeben sei eine Wolke im $\mathbb R^{n}$ von $N$ Datenpunkten $$\mathbb X :=
   \bigl \{(x_i,y_i)\colon x_i \in \mathbb R^{n}, \, y_i\in \{-1,+1\}, \,
   i=1,\dotsc, N\bigr \}$$ wobei $x_i$ der Datenpunkt ist und $y_i$ das
   zugeh&ouml;rige Label.

2. Eine *Hyperebene* $H\subset \mathbb R^{n}$, definiert durch den
   St&uuml;tzvektor $b\subset \mathbb R^{n}$ und den Normalenvektor $w\in
   \mathbb R^{n}$, hei&szlig;t **trennend**, falls 
   \begin{equation}(\#eq:eqn-trennende-hyperebene)
   y_i\ipro{x_i-b}{w} >0, \quad i=1,\dotsc,N
   \end{equation}

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
   der labels als $\pm 1$ kann das kompakt in einer einzigen Gleichung wie 
   in \@ref(eq:eqn-trennende-hyperebene)
   in der Definition geschrieben werden.
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

## Maximierung des Minimalen Abstands

Um den Abstand maximieren zu k&ouml;nnen leiten wir eine Formel her.

Dazu sei $w\in \mathbb R^{n}$ der Normalenvektor von $H$ sei $h\in \mathbb R^{}$
so, dass $b=\frac{h}{\|w\|}w$ ein St&uuml;tzvektor ist. (Insbesondere kann Jan eine
Hyperebene auch &uuml;ber den Normalenvektor und den Abstand von $H$ zum
Ursprung charakterisieren). Damit bekommen wir den Abstand von $H$ zum Ursprung
als $h$ (Achtung: das $h$ kann auch negativ sein -- es sagt uns wie weit
m&uuml;ssen wir den normalisierten Vektor $w$ entlanglaufen, bis wir zu Ebene
$H$ gelangen).

Zu einem beliebigen Punkt $x\in \mathbb R^{n}$ bekommen wir den Abstand zu $H$
als

* den Abstand der Ebene $H$ zur Ebene $H_x$, die parallel zu $H$ verl&auml;uft
  und $x$ enth&auml;lt
* beziehungsweise als die Differenz der Abst&auml;nde von $H_x$ und $H$ zum Ursprung

Da auch $w$ der Normalenvektor von $H_x$ ist, gilt f&uuml;r den Abstand $h'$,
dass
\begin{equation*}
h_x = \|x\|_2\cos(\phi(w,x))=\|x\|_2 \frac{\ipro wx }{\|w\|_2\|x\|_2} = \frac{\ipro
wx}{\|w\|_2}
\end{equation*}
wobei 
$\cos(\phi(w, x))$ 
aus dem Winkel zwischen $x$ und $w$ herr&uuml;hrt.

Mit dieser Formel und mit $b=hw$, erkennen wir, dass der Test auf das Vorzeichen
\begin{equation*}
\ipro{x-b}{w} = \ipro{x-\frac{h}{\|w\|_2} w}{w} = \ipro{x}{w} - h\|w\|_2
= \|w\|_2 (\frac{\ipro xw }{\|w\|_2} - h) = \|w\|_2(h_x - h)
\end{equation*}
den mit $\|w\|_2$ skalierten Abstand (inklusive dem Vorzeichen) enth&auml;lt,
beziehungsweise, dass der Abstand als
\begin{equation*}
y_i\frac{\ipro{x_i-b}{w}}{\|w\|_2} = y_i\frac{\ipro{x_i}{w}-\beta}{\|w\|_2}
\end{equation*}
(f&uuml;r eine trennende Hyperebene $(w, \beta)$) auch immer das richtige Vorzeichen erh&auml;lt (da $\|w\|_2>0$. Dementsprechend kann das SVM Problem als
\begin{equation*}
\max_{w\in \mathbb R^{n}, \, \beta \in \mathbb R^{}} \min_{x_i \in \mathbb X} y_i\frac{\ipro{x_i}{w}-\beta}{\|w\|_2}
\end{equation*}
formuliert werden.

So ein $\min \max$ Problem ist generell schwierig zu analysieren und zu
berechnen. Aber wir k&ouml;nnen direkt sagen, dass die *Zul&auml;ssigkeit* der Optimierung  gesichert
ist, da "der $\max$-imierer" nach M&ouml;glichkeit eine trennende Hyperebene
w&auml;hlt und so schon mal sicherstellt, dass "der $\min$-inimierer" nur
&uuml;ber positive Zahlen minimiert.

Dar&uuml;berhinaus, wenn eine trennendes Hyperebene existiert, sodass 
\begin{equation*}
y_i(\ipro{x_i}{w}-\beta) = y_i(\ipro{x_i}{w} -h \|w\|_2) \geq q > 0
\end{equation*}
dann k&ouml;nnen wir durch die Wahl von $\tilde w =\frac 1q w$, immer
erreichen, dass das Minimum $\min_{ x_i \in \mathbb X} y_i \ipro{x_i}{w}-\beta=1$ ist und das Max-Min durch ein Maximierungsproblem unter Zul&auml;ssigkeitsnebenbedingungen
\begin{equation*}
\min_{w,\beta} \frac 12 \|w\|_2^2, \quad{s.t.}\quad y_i(\ipro{x_i}{w}-\beta) \geq 0, \,
i=1,\dotsc, N
\end{equation*}
ersetzen. Dabei haben wir noch ausgenutzt, dass $\max_w \frac
1{\|w\|}\leftrightarrow \min_w \frac 12 \|w\|^2$ entspricht, um die Standardform
eines *quadratischen Optimierungsproblems* unter (affin) *linearen
Ungleichungsnebenbedingungen* zu erhalten.

F&uuml;r solche Optimierungsprobleme kann das *duale Problem* direkt hergeleitet
werden, was sich in diesem Fall als die Suche eines Vektors $a\in \mathbb R^{n}$
&uuml;ber das restringierte Minimierungsproblem
\begin{equation*}
\min_{a} \left(\frac 12 \sum_{i=1}^N\sum_{k=1}^Na_ia_k y_i y_k \ipro{x_i}{x_k} -
\sum_{i=1}^N a_i\right) \quad{s.t.}\quad a\geq0, \, \sum_{i=1}^Na_iy_i=0
\end{equation*}
ergibt. 

Aus der KKT Theorie kann abgeleitet werden, dass $a_i>0$, genau dann wenn $x_i$
die Gleichheit $y_i(\ipro{x_i}{w}-\beta)=1$ erf&uuml;llt ist, also $x_i$ ein
sogenannter *support vector* ist. Ist $S$ die Menge aller Indices, die die
*support vectors* indizieren, so kann die Klassifikation eines neuen
Datenpunktes $x$ mittels
\begin{equation*}
y(x) = \sum_{i\in S}a_iy_i\ipro{x}{x_i}+\gamma
\end{equation*}
vorgenommen werden, wobei der *bias* als
\begin{equation*}
\gamma = \sum_{i\in S}(y_i - \sum_{k\in S}a_ky_k\ipro{x_i}{x_k})
\end{equation*}
vorberechnet werden kann.

## Aufgaben

1. Sei die Hyperebene &uuml;ber $w$ und $b$ gegeben. Bestimmen Sie den
   (m&ouml;glicherweise negativen) Abstand
   $h\in \mathbb R^{}$, sodass $hw\in H$.
