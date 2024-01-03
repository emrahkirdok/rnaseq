#!/bin/bash
# kullanmak icin conda activate cutadapt

SRR=$1
END=$2
FASTA=$3
TRIMMING_TOOL=$4

OUT=results/alignment/bowtie2/${TRIMMING_TOOL}

echo "aligning ${SRR}"

bowtie2-align-s -x data/ref/${FASTA} -p 8 \
	-U results/processed/${TRIMMING_TOOL}/${END}/${SRR}.fastq.gz |  samtools view -F4 -q30 -Sb > ${OUT}/${SRR}.bam

samtools sort ${OUT}/${SRR}.bam -o ${OUT}/${SRR}.sorted.bam

samtools index ${OUT}/${SRR}.sorted.bam

