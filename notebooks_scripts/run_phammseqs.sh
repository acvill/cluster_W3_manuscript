#$ -S /bin/bash
#$ -N phammseqs
#$ -V
#$ -o /workdir/users/acv46/phage_52kb/log/phammseqs_$JOB_ID.out
#$ -e /workdir/users/acv46/phage_52kb/log/phammseqs_$JOB_ID.err
#$ -wd /workdir/users/acv46/phage_52kb
#$ -l h_vmem=80G
#$ -q long.q@cbsubrito2
#$ -t 1
#$ -pe parenv 10

cd /workdir/users/acv46/phage_52kb

source /home/acv46/miniconda3/bin/activate
conda activate phammseqs

mkdir -p phammseqs
phammseqs Bacillus_simple_filtered.faa \
	-c 10 \
	-v \
	--sensitivity 7 \
	-o phammseqs
