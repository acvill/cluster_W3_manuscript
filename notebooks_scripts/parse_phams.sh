#$ -S /bin/bash
#$ -N parse_phams
#$ -V
#$ -o /workdir/users/acv46/phage_52kb/log/parsephams_$JOB_ID.out
#$ -e /workdir/users/acv46/phage_52kb/log/parsephams_$JOB_ID.err
#$ -wd /workdir/users/acv46/phage_52kb
#$ -l h_vmem=10G
#$ -q long.q@cbsubrito2
#$ -t 1
#$ -pe parenv 5

WRK=/workdir/users/acv46/phage_52kb
fasta=$WRK/phammseqs/pham_fastas
names=$WRK/Bacillus_phage.txt
parse=$WRK/phammseqs/pham_table.txt

# initiate table with names and accession numbers

while read acc; do
	name=$(grep "${acc}" $WRK/Bacillus_phage.txt | awk -F',' '{print $1}')
	echo "${name},${acc}" >> $parse
done < $WRK/acc_list_25proteins.txt

# get ordered list of pham numbers

ls $fasta | \
	sed "s/pham_//g" | \
	sed "s/.faa//g" | \
	sort -n > $WRK/phammseqs/pham_ids.txt

totphams=$(wc -l < $WRK/phammseqs/pham_ids.txt)

# iteratively build binary pham table
# add 0 to every row, if match, replace with 1

while read id; do

        echo "processing pham ${id} of ${totphams}"
        grep ">" ${fasta}/pham_${id}.faa | \
        sed "s/>//g" | \
        sed "s/_prot.*//g" | \
        sort | uniq \
        > $WRK/phammseqs/tmp_pham_${id}

	nmem=$(wc -l < $WRK/phammseqs/tmp_pham_${id})
	if [[ "$nmem" == 1 ]]; then
		echo "--> pham ${id} is an orpham"
	else
        	echo "--> pham ${id} has ${nmem} members"
	fi

	sed -i s/$/,0/ $parse

        while read line; do
                if grep -q "${line}" $WRK/phammseqs/tmp_pham_${id}; then
                        sed -i "/,${line}/s/,0$/,1/" $parse
                fi
        done < <(awk -F',' '{print $2}' $parse)

        rm $WRK/phammseqs/tmp_pham_${id}

done < $WRK/phammseqs/pham_ids.txt

# slower version, adds 0 and 1 iteratively

# while read id; do
#	echo "processing pham ${id} of ${totphams}"
#	grep ">" ${fasta}/pham_${id}.faa | \
#	sed "s/>//g" | \
#	sed "s/_prot.*//g" | \
#	sort | uniq \
#	> $WRK/phammseqs/tmp_pham_${id}
#	echo "--> pham ${id} has $(wc -l < $WRK/phammseqs/tmp_pham_${id}) members"
#	while read line; do
#		if grep -q "${line}" $WRK/phammseqs/tmp_pham_${id}; then
#			sed -i "/,${line}/s/$/,1/" $parse
#		else
#			sed -i "/,${line}/s/$/,0/" $parse
#		fi
#	done < <(awk -F',' '{print $2}' $parse)
#	rm $WRK/phammseqs/tmp_pham_${id}
# done < $WRK/phammseqs/pham_ids.txt
