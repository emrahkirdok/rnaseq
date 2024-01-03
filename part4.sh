#!/bin/bash


REFERENCE=GCA_000007565.2_ASM756v2_genomic.fna
THREADS=8
TRIMMING_TOOL=$2

mkdir -p results/alignment/bowtie2/${TRIMMING_TOOL}

#bowtie2-build data/ref/${REFERENCE} data/ref/${REFERENCE}

while read LINE
do 
        SRR=$(echo "$LINE" | cut -d " " -f1)
        END=$(echo "$LINE" | cut -d " " -f2)

        if [[ ${END} == "pe" ]]
        then 
            sbatch -M snowy --time=08:00:00 --job-name=bowtie2_${TRIMMING_TOOL}_${SRR} --output=slurm_logs/log_bowtie2_${TRIMMING_TOOL}_${SRR}.out --ntasks-per-node 8 -A naiss2023-5-252 --mail-type=FAIL ./scripts/bowtie_pe.sh ${SRR} ${END} ${REFERENCE} ${TRIMMING_TOOL}
        else 
            sbatch -M snowy --time=08:00:00 --job-name=bowtie2_${TRIMMING_TOOL}_${SRR} --output=slurm_logs/log_bowtie2_${TRIMMING_TOOL}_${SRR}.out --ntasks-per-node 8 -A naiss2023-5-252 --mail-type=FAIL ./scripts/bowtie_se.sh ${SRR} ${END} ${REFERENCE} ${TRIMMING_TOOL}
        fi

done < $1

