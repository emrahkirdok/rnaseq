#!/bin/bash

mkdir -p results/processed/trimmomatic/se
mkdir -p results/processed/trimmomatic/pe
mkdir -p slurm_logs

while read LINE
	do 
	SRR=$(echo "$LINE" | cut -d " " -f1)
	END=$(echo "$LINE" | cut -d " " -f2)
	if [[ ${END} == "pe" ]]
	
	then
		echo "pe"
		sbatch -M snowy --time=06:00:00 --job-name=trimmomatic_${SRR} --output=slurm_logs/log_trimmomatic_${SRR}.out --ntasks-per-node 8 -A naiss2023-5-252 --mail-type=FAIL ./scripts/trimmomatic_pe.sh ${SRR} ${END}
	else

		echo "se"
		echo ${SRR}
		echo ${END}
		sbatch -M snowy --time=06:00:00 --job-name=trimmomatic_${SRR} --output=slurm_logs/log_trimmomatic_${SRR}.out --ntasks-per-node 8 -A naiss2023-5-252 --mail-type=FAIL ./scripts/trimmomatic_se.sh ${SRR} ${END}
	fi

done<$1
