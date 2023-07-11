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

