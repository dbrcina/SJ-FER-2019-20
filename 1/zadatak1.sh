#!/bin/bash

#(a)
proba="Ovo je proba"

#(b)
echo $proba

#(c)
lista_datoteka=*
echo $lista_datoteka

#(d)
proba3=""
for i in {1..3}; do proba3+="$proba. "; done && echo $proba3

#(e)
a=4 && b=3 && c=7
d=$(((a+4)*b%c))
echo $d

#(f)
broj_rijeci=`cat *.txt 2> /dev/null | wc -w`
echo $broj_rijeci

#(g)
ls ~

#(h)
cut -d ":" -f 1,6,7 /etc/passwd

#(i)
ps u n -A | tr -s " " | cut -d " " -f 2,3,12
