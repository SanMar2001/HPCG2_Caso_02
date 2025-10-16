#!/bin/bash

> nodo1/Sequential.txt
> nodo1/OMP.txt
> nodo1/OMP_T.txt

for j in {1..5}
do
    for i in 400 800 1000 1200 1600
    do
        ./sequential $i >> nodo1/Sequential.txt
    done

    for i in 400 800 1000 1200 1600
    do
        for k in 2 4 8
        do
            OMP_NUM_THREADS=$k ./OMP $i >> "nodo1/OMP.txt"
            OMP_NUM_THREADS=$k ./OMP_T $i >> "nodo1/OMP_T.txt"
        done
    done
done