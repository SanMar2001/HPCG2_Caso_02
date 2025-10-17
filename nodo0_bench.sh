#!/bin/bash

OUTDIR="nodo0"
mkdir -p "$OUTDIR"

> "$OUTDIR/PERF_Sequential.txt"
> "$OUTDIR/PERF_OMP.txt"
> "$OUTDIR/PERF_OMP_T.txt"

perf stat -o "$OUTDIR/PERF_Sequential.txt" ./sequential 1600
export OMP_NUM_THREADS=4
perf stat -o "$OUTDIR/PERF_OMP.txt" ./OMP 1600
export OMP_NUM_THREADS=4
perf stat -o "$OUTDIR/PERF_OMP_T.txt" ./OMP_T 1600
