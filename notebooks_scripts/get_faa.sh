#$ -S /bin/bash
#$ -N get_faa
#$ -V
#$ -o /workdir/users/acv46/phage_52kb/log/getfaa_$JOB_ID.out
#$ -e /workdir/users/acv46/phage_52kb/log/getfaa_$JOB_ID.err
#$ -wd /workdir/users/acv46/phage_52kb
#$ -l h_vmem=10G
#$ -q long.q@cbsubrito2
#$ -t 1
#$ -pe parenv 8

cd /workdir/users/acv46/phage_52kb
EFE=/home/acv46/edirect/efetch

while read line; do
	num=$(grep -n ",${uid}," Bacillus_phage.txt | cut -d : -f 1)
	uid=$(echo $line | awk -F',' '{print $3}')
	$EFE -db nuccore -format fasta_cds_aa -id ${uid} \
	>> Bacillus_349_db.faa
	echo "${num} / 349"
done < Bacillus_phage.txt

