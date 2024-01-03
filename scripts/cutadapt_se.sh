#!/bin/bash

SRR=${1}
END=${2}

ADAPTER1=AGATCGGAAGAG
ADAPTER2=AGATCGGAAGAG
THREADS=8
Q1=20
MIN_LEN=36

#conda activate cutadapt

cutadapt -q ${Q1} \
	-m ${MIN_LEN} --trim-n \
	-Z -j ${THREADS} \
	-a ${ADAPTER1} \
	-o results/processed/cutadapt/${END}/${SRR}.fastq.gz \
	data/raw/${END}/${SRR}.fastq.gz


fastqc results/processed/cutadapt/${END}/${SRR}.fastq.gz
