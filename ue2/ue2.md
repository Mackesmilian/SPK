# UE-2 Wolf

Korrektes formatting: https://github.com/Mackesmilian/SPK/blob/master/ue2/ue2.md

## 1 Ableitung & Ableitungsbaum

### Geben Sie für die Grammatik G1 die Ableitung für aaucc und den Ableitungsbaum für aaavccc an.

aaucc: S → aSc → aaScc → aaTcc → aaucc\
aaavccc: S → aSc → aaScc → aaaSccc → aaaTccc → aaavccc

![Ableiutngsbaum aaavccc](2.jpg?raw=true "aaavccc")

$$ L(G) = \{a^mu^nv^xc^m|m>0,n=1<=>x=0\} $$

n=1x=0 Soll heißen, dass entweder u oder v vorkommen kann, aber nicht beide gleichzeitig. n=1 genau dann wenn x = 0 und umgekehrt.

### Geben Sie für die Grammatik G2 die Ableitung die Ableitung und den Ableitungsbaum für 0011111000 an.

0011111000: S → TU → 0T1U → 00T11U → 0011U → 00111U0 → 001111U00 → 0011111000

$$ L(G) = \{0^m1^m1^x0^x|m>=0,x>0\} $$

![Ableiutngsbaum 0011111000](1.jpg?raw=true "0011111000")

## 2 Sequenz
### a) Wie lauten die restlichen Komponenten der Grammatik G = (N, T, P, S)?
G1 = (N, T, P, S) mit:\
N = {W,A,S}\
T = {l,d}\
P = {S -> W=dA; S->W=dA,S; A -> ε; W -> lW; W -> ld}
### b) Inkorrekte Sequenzen
- aa1=bb1=0,cc1=1; weil zwischen zwei Assignments muss immer ein Komma vorkommen
- i3=1,k2=i weil kein Strichkomme am Ende und auf der rechten Seite der Zuweisung immer ein digit stehen muss
- s5=25; digit ist maximal bis 9
- a12b=3, weil <letter> <digit> oder <letter> <word> erlaubt ist, dh ein digit an dritter Stelle ist nicht erlaubt
- a=1 bb1=7; links vom assignment fehlt ein digit, dann fehlt das Komma zwischen assignments bb1=7 ist korrekt
- r25=6 zwei digits hintereinander in der Form nicht möglich, weil maximal ein digit erlaubt und Strichkomme am Ende fehlt
- A7=9; Großbuchstaben sind nicht erlaubt
 - klmno1=0 Strichkomma am Ende fehlt

 ## 3 Tokens
 float myArr[1][10]\
 myArr set 2\
 myArr1 set myArr2\
 resArr set myArr1 + myArr2

 - PLUS: "\\+"
 - MINUS: "\\-"
 - MULTIPLY: "\\*"
 - DIVIDE: "\/"
 - NAME: "\w+\d*"
 - SET: " set "
 - TYPE: "(float|int)(?(?=>0) ?| +)(>0)?"
 - DIMENSION: "\\[(1|2|3)\\]"
 - SIZE: "\\[[1-9]+[0-9]*\\]"
 - VALUE: "\\-?[0-9,?]+"

 ## 4 Backus-Naur Form

 - \<declaration\> ::= TYPE NAME DIMENSION
 - \<assignment> ::= NAME SET VALUE 
 - \<copy> ::= NAME SET NAME
 - \<result> ::= NAME SET NAME + NAME | NAME SET NAME - NAME | NAME SET NAME * NAME | NAME SET NAME / NAME
 - \<statement> ::= \<assignment> | \<copy> | \<result>
 - \<statement-list> ::= \<declaration> \<statement-list> | \<statement>
 