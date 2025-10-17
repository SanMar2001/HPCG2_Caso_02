#!/bin/bash

OUTDIR="nodo1"
mkdir -p "$OUTDIR"

> "$OUTDIR/PERF_Sequential.txt"
> "$OUTDIR/PERF_OMP.txt"
> "$OUTDIR/PERF_OMP_T.txt"

perf stat -o "$OUTDIR/PERF_Sequential.txt" ./sequential 1600
export OMP_NUM_THREADS=4
perf stat -o "$OUTDIR/PERF_OMP.txt" ./omp 1600
export OMP_NUM_THREADS=4
perf stat -o "$OUTDIR/PERF_OMP_T.txt" ./omp_t 1600
