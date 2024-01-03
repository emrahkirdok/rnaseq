#!/bin/bash
# kullanmak icin conda activate cutadapt

SRR=$1
END=$2
REFERENCE=$3
TRIMMING_TOOL=$4

OUT=results/alignment/bowtie2/${TRIMMING_TOOL}

echo "aligning ${SRR}"

bowtie2-align-s -x data/ref/${REFERENCE} -p 8 \
	-1 results/processed/${TRIMMING_TOOL}/${END}/${SRR}_1.fastq.gz \
	-2 results/processed/${TRIMMING_TOOL}/${END}/${SRR}_2.fastq.gz | samtools view -F4 -q30 -Sb > ${OUT}/${SRR}.bam

samtools sort ${OUT}/${SRR}.bam -o ${OUT}/${SRR}.sorted.bam

samtools index ${OUT}/${SRR}.sorted.bam

