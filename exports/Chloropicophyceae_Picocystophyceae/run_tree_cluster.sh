#!/bin/bash

cd /shared/projects/dipo/vaulot/pr2/eukref_2023/Chloropicophyceae

# srun --mem=64G  --cpus-per-task=32 run_tree_cluster.sh

module load vsearch/2.22.1

CLADE="pr2_export"

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

raxmlHPC-PTHREADS-SSE3 -T 32 -m GTRCAT -c 25 -e 0.001 -p 31415 -f a -N 100 -x 02938 -n $CLASD.cluster.tre -s $CLADE.trimal.fas

