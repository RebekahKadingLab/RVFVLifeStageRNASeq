#!/bin/bash

#SBATCH --partition=amilan
#SBATCH --job-name=htseqPieces
#SBATCH --output=%x.%j.out
#SBATCH --time=12:00:00
#SBATCH --qos=normal
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haogg@colostate.edu

module purge
module load anaconda
conda activate rnaPseudo

for FILE in hisatRNA/22_mock*.sam
do
  #echo ${TWO}
  pref=${FILE::-4}
  pref=${pref:9}
  echo ${pref}
  htseq-count --stranded=reverse $FILE genes.gtf > AllCounts/${pref}HSCounts.txt
done
