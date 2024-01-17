#!/bin/bash

PATH=${PATH}:/home/ekirdok/.conda/envs/htseq_env/bin/

SRR=$1
TRIMMING_TOOL=$2
ALIGNMENT_TOOL=$3
COUNT_TOOL=$4

htseq-count results/alignment/${ALIGNMENT_TOOL}/${TRIMMING_TOOL}/${SRR}.sorted.bam data/ref/GCA_000007565.2_ASM756v2_genomic.gtf -s no -n 8 -t gene > results/counts/${COUNT_TOOL}/${ALIGNMENT_TOOL}/${TRIMMING_TOOL}/counts-${SRR}.txt
