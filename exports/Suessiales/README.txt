# Pipeline Summary

Goal is to build a well-supported Suessiales Tree for 18S rRNA read mapping for EukRef/PR2 Initiative

We will start by using operons. Then use this backbone to combined with those from Dr. Mawash Jamy's 2022 Paper in a constrained operon tree.

We will then use these to constrain the PR2 SSUs (first the long reads over 1000bp then the short ones), then finally EPA place SSC (single-study clades) ASVs on top


# Final Report - Suessiales by Anthony Bonacolta

Final Tree = Bonacolta_RAxML_bipartitions.suessiales.tre

Final Tree w/ SSCs EPA-mapped to it = Bonacolta_RAxML_suessiales_placement_tree.tre

GAPPA Taxa Assignment of EPA-mapped SSCs = Bonacolta_gappa_SC_taxa.tsv

PR2 Representatives Annotation File = Bonacolta_suessiales_representatives.xlsx

PR2 Final Annotation File = Bonacolta_suessiales_propagated_taxonomy.xlsx
- Updated annotations in yellow
- Sequences to remove in red

Jamy et al Operons Re-annotated = Bonacolta_suessiales_Jamy_reannotated.xlsx

If you need any of the intermediate files included above please let me know. 


# Pipeline (detailed)

## 1. Operon reference Tree (w/o Jamy et al seqs)
```
vsearch -sortbylength operon_backbone.fa -output operon_backbone.sorted.fa -minseqlength 2000 -maxseqlength 15000
vsearch -cluster_smallmem operon_backbone.sorted.fa -id 1 -centroids operon_backbone.clustered.fa -uc backbone.clustered.uc 
mafft --auto operon_backbone.sorted.fa > operon_backbone.aligned.fa
trimal -in operon_backbone.aligned.fa -out operon_backbone.trimal.fa -gt 0.3 -st 0.001 -cons 30
scp operon_backbone.trimal.fa amb195@triton.ccs.miami.edu:/scratch/marinemicrobes_t/eukref
#raxmlHPC -T 2 -m GTRCAT -p 31415 -x 20398 -d -f a -N 1000 -n operon_backbone.tre -s operon_backbone.trimal.fa
scp -r amb195@triton.ccs.miami.edu:/scratch/marinemicrobes_t/eukref .
mv eukref operon_backbone_tree
cp operon_backbone_tree/RAxML_bipartitions.operon_backbone.tre .
```

## 2. Use the operon backbone to constrain Jamy et al OTUs
```
vsearch -sortbylength jamy.fa -output jamy.sorted.fa -minseqlength 3000 -maxseqlength 15000
vsearch -cluster_smallmem jamy.sorted.fa -id 1 -centroids jamy.clustered.fa -uc jamy.clustered.uc 
cat tree1_operon_backbone_tree/operon_backbone.clustered.fa/operon_backbone.clustered.fa jamy.clustered.fa > operon_constrained.fa
mafft --auto operon_constrained.fa > operon_constrained.aligned.fa
trimal -in operon_constrained.aligned.fa -out operon_constrained.trimal.fa -gt 0.3 -st 0.001 -cons 30
scp operon_constrained.trimal.fa amb195@triton.ccs.miami.edu:/scratch/marinemicrobes_t/eukref
#raxmlHPC-PTHREADS -T 2 -m GTRCAT -p 31415 -x 20398 -r RAxML_bipartitions.operon_backbone.tre -d -f a -m GTRGAMMA -s operon_constrained.trimal.fa -N 1000 -n operon_constrained_tree1.tre
scp -r amb195@triton.ccs.miami.edu:/scratch/marinemicrobes_t/eukref .
mv eukref/* tree2_operon_and_jamy/
```

## 3. Add reference 18S sequences + PR2 seqs longer than 1000 bp
- Re-annotated or removed the following seqs bc weird placement in previous trees:
      - EF058240_Jadwigia_applanata 
      - JQ639765.1.1610_U
      - AY443025.1.1753_U
      - JF317692.1.598_U
      - MH071712_Biecheleriopsis_sp.
      
Start with the clustered file (pr2.clustered.fa) separate into two files. Those 1000 BP+ and those under.
```
awk '/^>/ { if (length(seq) >= 1000) { if (seq != "") print seq; print $0; seq = "" } else seq = "" } !/^>/ { seq = seq $0 } END { if (length(seq) >= 1000) print seq }' pr2.clustered.fa > pr2_1000bp.fasta
awk '/^>/ { if (length(seq) < 1000) { if (seq != "") print seq; print $0; seq = "" } else seq = "" } !/^>/ { seq = seq $0 } END { if (length(seq) < 1000) print seq }' pr2.clustered.fa > pr2_under1000bp.fasta
```
Now build the constrained tree with the larger sequences

```
cat tree2_operon_and_jamy/operon_constrained.fa ../tree2/pre-constrained.clustered.fa ../tree1/pr2_1000bp.fasta > suessiales_operon_refs_longpr2_tree3.fa
seqkit rmdup -s < suessiales_operon_refs_longpr2_tree3.fa > suessiales_operon_refs_longpr2_tree3.nodups.fa #9 duplicates removed
mafft --auto suessiales_operon_refs_longpr2_tree3.nodups.fa > tree3.aligned.fa
trimal -in tree3.aligned.fa  -out tree3.aligned.trimal.fa  -gt 0.3 -st 0.001 -cons 30
scp tree3.aligned.trimal.fa amb195@triton.ccs.miami.edu:/scratch/marinemicrobes_t/eukref
#raxmlHPC-PTHREADS -T 2 -m GTRCAT -p 31415 -x 20398 -r RAxML_bipartitions.operon_constrained_tree1.tre -d -f a -s tree4.aligned.trimal.fa -N 1000 -n 18S_constrained_tree3.tre
scp -r amb195@triton.ccs.miami.edu:/scratch/marinemicrobes_t/eukref .
mv eukref/*tree3* .
```

## 4.  Add in short PR2 (under 1000bp), excluding single study clades
```
cd ..
cat tree3_operons_and_longpr2/suessiales_operon_refs_longpr2_tree3.nodups.fa ../tree3/pr2_under1000bp.noKC.fasta > tree4.fa
mafft --auto tree4.fa > tree4.aligned.fa
trimal -in tree4.aligned.fa  -out tree4.trimal.fa -gt 0.3 -st 0.001
scp tree4.trimal.fa amb195@triton.ccs.miami.edu:/scratch/marinemicrobes_t/eukref
#raxmlHPC-PTHREADS -T 2 -m GTRCAT -p 31415 -x 20398 -r RAxML_bipartitions.18S_constrained_tree3.tre -f a -s tree4.trimal.fa -N 1000 -n tree4.tre
scp -r amb195@triton.ccs.miami.edu:/scratch/marinemicrobes_t/eukref .
mv eukref/*tree4* tree4_operons_longpr2_and_shortpr2/

mv tree4.tre Bonacolta_RAxML_suessiales_placement_tree.tre
```

At this point, the representative sequences + Jamy et al 18S-28S sequences were annotated.


## 5. EPA place SSC clades onto a redone tree 5
```
perl ~/Desktop/scripts/fasta2stockholm.pl tree4.aligned.fa > suessiales.aligned.sto
hmmbuild suessiales.hmm suessiales.aligned.sto
hmmalign --dna --mapali tree4_operons_longpr2_and_shortpr2/tree4.aligned.fa suessiales.hmm ssc.fa > suessiales_epa.aligned.sto
perl ~/Desktop/scripts/stockholm2fasta.pl suessiales_epa.aligned.sto > suessiales_epa.aligned.fa
awk '/^>/ {print; next} {gsub("\\.", "-"); print}' suessiales_epa.aligned.fa > cleaned_suessiales_epa.aligned.fa
# Fix dots to dashes
# Fix naming FIND: >(\D{1,2}\d{5,7})-(1|2)-(.*_U) REPLACE: >\1.\2.\3
# FIND: >(\D{1,4}\d{5,9})-(1|2)-(.*_U) REPLACE: >\1.\2.\3
# Symbiodinium_linucheae_CCMP2456
# Few times do FIND: (>.*)- REPLACE: \1.
# IS AY336095 there?
# Lastly, remove duplicates:
awk '/^>/{f=!d[$1];d[$1]=1}f' cleaned_suessiales_epa.aligned.fa > suessiales_epa.aligned.nodups.fa
raxmlHPC -T 4 -m GTRCAT -f v -G 0.2 -n EPARUN.tre -s suessiales_epa.aligned.nodups.fa -t tree4_operons_longpr2_and_shortpr2/RAxML_bipartitions.tree4.tre
sed 's/QUERY___//g' RAxML_labelledTree.EPARUN.tre | sed 's/\[I[0-9]*\]//g' > Bonacolta_RAxML_suessiales_placement_tree.tre
```

### Taxa assignment of SSC Clades
```
gappa examine assign --jplace-path RAxML_portableTree.EPARUN.tre.jplace --taxon-file taxon-file.txt --per-query-results --best-hit \
	--root-outgroup outgroup.txt --ranks-string 'supergroup|division|subdivision|class|order|family|genus|species' \
	--resolve-missing-paths --out-dir SSC_taxa --verbose --threads 2
```

The SSCs were re-annotated according to this classification. 




























