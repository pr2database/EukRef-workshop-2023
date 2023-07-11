# Annotation Chloropicophyceae

## 2023-07-08 - EukRef workshop

* Use Chloropicophyceae plus Picocystophyceae

## Cluster analysis
* Sequence have been ordered first by assignement type (first PR2 authentic, second dada2), then taxa, then decreasing length
* Sequence labelled with * correspond to sequence automatically assigned with dada2
* Clustering done at 99.5%
* Bash file ()
* Annotation done directly on clustering file (`Chloropicophyceae-clusters.xlsx`, XLSX format) using tree as guide
* Alignement visualized with Geneious
* Tree:
  * Visualized with TreeViewer
  * Chimera marked in yellow
  * Sequences for which annotation changed with blue square
* Change in taxonomy are recorded in the cluster file (imported into Excel) using a new column `species_updated`

## Merging and final verification
* The updated species is merged with  `pr2_export.xlsx` using R dplyr::left_join
* A column `species_final` is created that contains species_updated if it is filled or species_old (old assignment) if not (case that no update is needed)
* A fasta file and a text file with 4 columns (pr2_accession, species, gb_strain, pr2_ocean) are exported
* The fasta file is aligned and a tree is built (see `run_tree_all.sh`)
* The final tree is visualized with the species assignation and bad assignation are further corrected in the 

* The final merged table file is exported saved into a new file called `Chloropicophyceae_pr2_main_updated.xlsx`. 
  * It contains only 4 columns, `pr2_accession`, `species_updated`, `edited_by`,`edited_version`, `edited_ramark`.
  * All rows without `species_updated` are removed
  * The different fields  `edited_by`,`edited_version`, `edited_ramark` are merged with current values.
  * This file is used to update the `pr2_main` table in the MySQL database


## Bash files
### Clustering - file `run_tree_cluster.sh`

```
#!/bin/bash

cd /shared/projects/dipo/vaulot/pr2/eukref_2023/Chloropicophyceae

# srun --mem=64G  --cpus-per-task=32 run_tree_cluster.sh

module load vsearch/2.22.1

CLADE="pr2_export"

# Sorting step is not used since sorting is done when creating the file
# vsearch --sortbylength  $CLADE.fas --output $CLADE.sort.fas --minseqlength 500 -notrunclabels

vsearch --cluster_smallmem $CLADE.fas --id 0.995 --usersort --centroids $CLADE.clustered.fas -uc $CLADE.cluster

module load mafft/7.313

mafft --reorder --auto $CLADE.clustered.fas > $CLADE.clustered.aligned.fas

module load trimal/1.4.1

# trimall parameters
#    -gt -gapthreshold <n>    1 - (fraction of sequences with a gap allowed).
#    -st -simthreshold <n>    Minimum average similarity allowed.

trimal -in $CLADE.clustered.aligned.fas -out $CLADE.trimal.fas -gt 0.3 -st 0.001

rm -f RAxML_*

module load raxml/8.2.12

raxmlHPC-PTHREADS-SSE3 -T 32 -m GTRCAT -c 25 -e 0.001 -p 31415 -f a -N 100 -x 02938 -n tre -s $CLADE.trimal.fas

```

### Clustering - file `run_tree_all.sh`

```
#!/bin/bash

cd /shared/projects/dipo/vaulot/pr2/eukref_2023/Chloropicophyceae

# srun --mem=64G  --cpus-per-task=32 run_tree_all.sh

# module load vsearch/2.22.1

CLADE="Chloropicophyceae_updated"

module load mafft/7.313

mafft --reorder --auto $CLADE.fas > $CLADE.aligned.fas

module load trimal/1.4.1

# trimall parameters
#    -gt -gapthreshold <n>    1 - (fraction of sequences with a gap allowed).
#    -st -simthreshold <n>    Minimum average similarity allowed.

trimal -in $CLADE.aligned.fas -out $CLADE.trimal.fas -gt 0.3 -st 0.001

module load raxml/8.2.12

raxmlHPC-PTHREADS-SSE3 -T 32 -m GTRCAT -c 25 -e 0.001 -p 31415 -f a -N 100 -x 02938 -n $CLADE.all.tre -s $CLADE.trimal.fas



```
