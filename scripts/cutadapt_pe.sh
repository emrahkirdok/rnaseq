#!/bin/bash
# kullanmak icin once conda activate cutadapt yaz
# calistirmak icin ./scripts/rnaseq.sh yaz 

SRR=${1}
END=${2}

ADAPTER1=AGATCGGAAGAG
ADAPTER2=AGATCGGAAGAG
THREADS=8
Q1=20
Q2=20
MIN_LEN=36

cutadapt -q ${Q1} \
	-m ${MIN_LEN} --trim-n \
	-Z -j ${THREADS} \
	-a ${ADAPTER1} -A ${ADAPTER2} \
	-o results/processed/cutadapt/${END}/${SRR}_1.fastq.gz \
	-p results/processed/cutadapt/${END}/${SRR}_2.fastq.gz \
	data/raw/${END}/${SRR}_1.fastq.gz data/raw/${END}/${SRR}_2.fastq.gz


fastqc results/processed/cutadapt/${END}/${SRR}_1.fastq.gz results/processed/cutadapt/${END}/${SRR}_2.fastq.gz
