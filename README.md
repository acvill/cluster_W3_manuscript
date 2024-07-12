https://doi.org/10.1089/phage.2022.0030

# cluster_W3_manuscript
This repository contains code and data related to our manuscript on *Bacillus* phage subcluster W3, including
- a [list of phage names and accession numbers](https://github.com/acvill/cluster_W3_manuscript/blob/main/data/Bacillus_phage.txt) used to construct the PhaMMseqs database
- shell scripts used to [pull phage protein sequences](https://github.com/acvill/cluster_W3_manuscript/blob/main/notebooks_scripts/get_faa.sh), [run PhaMMseqs](https://github.com/acvill/cluster_W3_manuscript/blob/main/notebooks_scripts/run_phammseqs.sh), and [create a pham matrix](https://github.com/acvill/cluster_W3_manuscript/blob/main/notebooks_scripts/parse_phams.sh)
- an [R notebook](https://github.com/acvill/cluster_W3_manuscript/blob/main/notebooks_scripts/phams_26July2023.Rmd) with code used to process pham data
- [ANI](https://github.com/acvill/cluster_W3_manuscript/blob/main/data/W3_ani_matrix_14Aug2023.txt) and [AAI](https://github.com/acvill/cluster_W3_manuscript/blob/main/data/W3_aai_matrix_14Aug2023.txt) matrices for the W3 phages output from the [enveomics Genome Matrix web tool](http://enve-omics.ce.gatech.edu/g-matrix/)
- an [R notebook](https://github.com/acvill/cluster_W3_manuscript/blob/main/notebooks_scripts/ani_aai_plot.Rmd) with code to visualize the ANI/AAI data as a heatmap
- an [R notebook](https://github.com/acvill/cluster_W3_manuscript/blob/main/notebooks_scripts/intergenic_repeats_W3phages.Rmd) with code to process STREME data and visualize intergenic repeat sequence logos 
