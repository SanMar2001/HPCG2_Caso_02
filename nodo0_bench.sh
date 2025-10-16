#!/bin/bash

OUTDIR="nodo0"
mkdir -p "$OUTDIR"

> "$OUTDIR/LIKWID_Sequential.txt"
> "$OUTDIR/LIKWID_OMP.txt"
> "$OUTDIR/LIKWID_OMP_T.txt"

for i in 800 1000 1200 1600 1800
do
    likwid-perfctr -C 0 -g CPI ./sequential $i >> "$OUTDIR/LIKWID_Sequential.txt"
    likwid-perfctr -C 0 -g CACHE ./sequential $i >> "$OUTDIR/LIKWID_Sequential.txt"
    likwid-perfctr -C 0 -g L3 ./sequential $i >> "$OUTDIR/LIKWID_Sequential.txt"
    likwid-perfctr -C 0 -g MEM1 ./sequential $i >> "$OUTDIR/LIKWID_Sequential.txt"
done

for i in 800 1000 1200 1600 1800
do
    for k in 2 4 8
    do
        OMP_NUM_THREADS=$k likwid-perfctr -C 0-$((k-1)) -g CPI ./OMP $i >> "$OUTDIR/LIKWID_OMP.txt"
        OMP_NUM_THREADS=$k likwid-perfctr -C 0-$((k-1)) -g CACHE ./OMP $i >> "$OUTDIR/LIKWID_OMP.txt"
        OMP_NUM_THREADS=$k likwid-perfctr -C 0-$((k-1)) -g L3 ./OMP $i >> "$OUTDIR/LIKWID_OMP.txt"
        OMP_NUM_THREADS=$k likwid-perfctr -C 0-$((k-1)) -g MEM1 ./OMP $i >> "$OUTDIR/LIKWID_OMP.txt"
        OMP_NUM_THREADS=$k likwid-perfctr -C 0-$((k-1)) -g CPI ./OMP $i >> "$OUTDIR/LIKWID_OMP_T.txt"
        OMP_NUM_THREADS=$k likwid-perfctr -C 0-$((k-1)) -g CACHE ./OMP $i >> "$OUTDIR/LIKWID_OMP_T.txt"
        OMP_NUM_THREADS=$k likwid-perfctr -C 0-$((k-1)) -g L3 ./OMP $i >> "$OUTDIR/LIKWID_OMP_T.txt"
        OMP_NUM_THREADS=$k likwid-perfctr -C 0-$((k-1)) -g MEM1 ./OMP $i >> "$OUTDIR/LIKWID_OMP_T.txt"
    done
done
