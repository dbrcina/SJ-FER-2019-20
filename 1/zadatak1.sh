#!/bin/bash

#(a)
proba="Ovo je proba"

#(b)
printf "%s\n" "$proba"

#(c)
lista_datoteka=*
echo $lista_datoteka

#(d)
proba3=""
for i in {1..3}; do proba3+="$proba. "; done

#(e)
a=4 && b=3 && c=7
d=$((($a+4)*$b%$c))

#(f)
broj_rijeci=$(cat *.txt 2> /dev/null | wc -w)

#(g)
ls ~

#(h)
cut -d ":" -f 1,6,7 /etc/passwd

#(i)
ps u n -A | tr -s " " | cut -d " " -f 2,3,12
