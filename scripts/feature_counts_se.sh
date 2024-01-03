#!/bin/bash

SRR=$1
TRIMMING_TOOL=$2
ALIGNMENT_TOOL=$3
COUNT_TOOL=$4

featureCounts -T 8 -t CDS -a data/ref/GCA_000007565.2_ASM756v2_genomic.gtf -o results/counts/${COUNT_TOOL}/${ALIGNMENT_TOOL}/${TRIMMING_TOOL}/${SRR}.txt results/alignment/${ALIGNMENT_TOOL}/${TRIMMING_TOOL}/${SRR}.sorted.bam
