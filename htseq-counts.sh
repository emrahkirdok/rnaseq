#!/bin/bash


#htseq_count [options] alignment_files gff_file or phyton -m HTSeq.scripts.count [options] alignment_files gff_file
TRIMMING_TOOL=$2
ALIGNMENT_TOOL=$3
COUNT_TOOL=htseq-count

mkdir -p results/counts/${COUNT_TOOL}/${ALIGNMENT_TOOL}/${TRIMMING_TOOL}

while read LINE
do
	SRR=$(echo "$LINE" | cut -d " " -f1)
	END=$(echo "$LINE" | cut -d " " -f2)

	if [ ${END} == "pe" ]
	then
		sbatch -M snowy --time=06:00:00 --job-name=${COUNT_TOOL}_${ALINGMENT_TOOL}_${TRIMMING_TOOL}_${SRR} --output=slurm_logs/htseq_${ALIGNMENT_TOOL}_${TRIMMING_TOOL}_${SRR}.out --ntasks-per-node 8 -A naiss2023-5-252 --mail-type=FAIL scripts/htseq.sh ${SRR} ${TRIMMING_TOOL} ${ALIGNMENT_TOOL} ${COUNT_TOOL}
	else
		sbatch -M snowy --time=06:00:00 --job-name=${COUNT_TOOL}_${ALINGMENT_TOOL}_${TRIMMING_TOOL}_${SRR} --output=slurm_logs/htseq_${ALIGNMENT_TOOL}_${TRIMMING_TOOL}_${SRR}.out --ntasks-per-node 8 -A naiss2023-5-252 --mail-type=FAIL scripts/htseq.sh ${SRR} ${TRIMMING_TOOL} ${ALIGNMENT_TOOL} ${COUNT_TOOL}
	fi

done < $1
