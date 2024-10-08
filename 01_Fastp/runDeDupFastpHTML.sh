#!/bin/bash

#SBATCH --partition=day-long-cpu
#SBATCH --job-name=fastpDeDupLoop
#SBATCH --output=%x.%j.out
#SBATCH --time=6:00:00
#SBATCH --qos=normal
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haogg@colostate.edu

module purge
source activate base
conda activate rnaPseudo

for FILE in RawFastq/*R1_001.fastq.gz
do
  TWO=${FILE/_R1_/_R2_}
  OUT=${TWO/#RawFastq\/}
  TRIM1=${FILE/RawFastq\//DeDupTrimmed\/DeDupTrimmed.}
  TRIM2=${TWO/RawFastq\//DeDupTrimmed\/DeDupTrimmed.}  
  echo ${OUT}
  fastp -i ${FILE} -I ${TWO} -o ${TRIM1} -O ${TRIM2} -h DeDupFastqHTMLs/${OUT}.html -w 12 --dedup
  rm fastp.json
done
