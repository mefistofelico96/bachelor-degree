# progetto-triennale
Progetto di tesi triennale.

# Strutture dati per le interazioni tra i corpi
## Sommario
Il problema degli $n$-corpi è una classe di problemi ancora continuamente studiati nel campo della fisica matematica, ma che ha molteplici possibili applicazioni che vanno dalla meccanica celeste all’ingegneria applicata. Questi problemi riguardano la possibile interazione che avviene tra un numero di corpi maggiore di due, il che rende piuttosto complessa la modellazione e la formulazione delle leggi che governano tali processi. Analiticamente, risolvere tali problemi significa costruire sistemi di varie equazioni differenziali, alle quali devono essere assegnate le condizioni iniziali. Dal punto di vista computazionale, questa metodologia è molto costosa da affrontare numericamente. Per questo motivo si utilizzano modelli numericamente semplificati, cioè che riducono notevolmente il numero di operazioni da svolgere, in modo da ridurre la complessità computazionale ed, eventualmente, i tempi di calcolo.

Questo lavoro di tesi ha riguardato lo sviluppo di un algoritmo per la soluzione efficiente ed efficace di un problema ad $n$-corpi basato sull'approccio Barnes-Hut. Il problema considerato consisteva nel calcolo del campo di forza elettrico stabilito da una rete non uniforme di cariche tutte dello stesso segno.

Volendo risolvere un problema di $n$-corpi in maniera esatta numericamente avrebbe un costo computazionale pari a $O(n^2)$. L'algoritmo di Barnes-Hut ha il merito di ridurre la complessità computazionale ad un valore proporzionale a $O(n \log{n})$ al costo di una leggera e controllabile diminuzione della precisione grazie al parametro $\theta$.

L'approccio discusso è stato implementato in un codice scritto in linguaggio MATLAB e le prestazioni dell'algoritmo Barnes-Hut sono state confrontate con un calcolo esatto delle interazioni tra particelle in termini di accuratezza e costo computazionale.

## Il codice
Il codice è diviso in due parti:
1. la parte che contiene il quadtree e l'algoritmo di Barnes-Hut;
2. la parte che conta le operazioni da eseguire per calcolare la forza totale su ogni particella.

### Il quadtree e l'algoritmo di Barnes-Hut
Questa parte mostra come funzionano il quadtree e l'algoritmo di Barnes-Hut. Per eseguire questa parte, aprire il file `quadtree_main.m` su MATLAB ed eseguirlo.

### Il numero di interazioni
Questa parte confronta la complessità computazionale dell'algoritmo di Barnes-Hut con il calcolo esatto delle forze su ogni particella. Per eseguire questa parte, aprire il file `opCount_main.m` su MATLAB ed eseguirlo.
