# README

## Files generated for EukRef worshop - 2023 - Barcelona

PR2 version: 5.0.1

Files are in directory `exports`. There is a sub-directory for each
taxonomic group.

Please note that there are two types of sequences:

- Sequences that have been annotated in PR2 and that are part of the
  released database
- Sequences that are not part of PR2 and that have been annotated
  automatically using the naive Bayes assignment as implemented in dada2
  R package. The database used for assignment is PR2 version 5.0.1.

There are 3 files:

### pr2_export.fas.gz

Contains the sequence labelled with the PR2 accession number

    >JX988758.1.1807_U
    TTGATCCTGCCAGTAGTCATATGCTTGTCTCAAAGATTAAGCCATGCATGTCTAAGTATAAGCACCTTATACTGTGAAACTGCGAATGGCTCATTAAATCAGTTATCGTTTATTTGATGATCTCTTGCTACTTGGATACCCGTGGT...
    ...

### pr2_export.txt

- Contains information about each sequence that can be uploaded to
  TreeView or TreeViewer.
- Fields are separated by tabulation (.
- Species that have been assigned automatically by dada2 are labelled
  with 1 in the column `pr2_annotated`

<!-- -->

    pr2_accession   domain  supergroup  division    subdivision class   order   family  genus   species pr2_annotated   gb_strain
    AF265331.1.1123_U   Eukaryota   TSAR    Stramenopiles   Bigyra  Sagenista   Labyrinthulomycetes Amphifilaceae   Amphifila   Amphifila_marina    1    
    AY082983.1.1879_U   Eukaryota   TSAR    Stramenopiles   Bigyra  Sagenista   Labyrinthulomycetes Amphifilaceae   Amphifila   Amphifila_sp.   1    
    EF023442.1.1807_U   Eukaryota   TSAR    Stramenopiles   Bigyra  Sagenista   Labyrinthulomycetes Amphifilaceae   Amphifilaceae_X Amphifilaceae_X_sp. 1    
    EF023338.1.1806_U   Eukaryota   TSAR    Stramenopiles   Bigyra  Sagenista   Labyrinthulomycetes Amphifilaceae   Amphifilaceae_X Amphifilaceae_X_sp. 1    
    EF023208.1.1805_U   Eukaryota   TSAR    Stramenopiles   Bigyra  Sagenista   Labyrinthulomycetes Amphifilaceae   Amphifilaceae_X Amphifilaceae_X_sp. 1    
    EF023658.1.1802_U   Eukaryota   TSAR    Stramenopiles   Bigyra  Sagenista   Labyrinthulomycetes Amphifilaceae   Amphifilaceae_X Amphifilaceae_X_sp. 1    
    EF023821.1.1802_U   Eukaryota   TSAR    Stramenopiles   Bigyra  Sagenista   Labyrinthulomycetes Amphifilaceae   Amphifilaceae_X Amphifilaceae_X_sp. 1    

    ...

### pr2_export.xlsx

This file contains two sheets:

#### Sheet “taxonomy”

This is a summary of the taxonomy with the number of sequences assigned
to each species

| supergroup     | division | subdivision | class       | order        | family        | genus         | species              | n   |
|----------------|----------|-------------|-------------|--------------|---------------|---------------|----------------------|-----|
| Archaeplastida | Picozoa  | Picozoa_X   | Picomonadea | Picomonadida | Picomonadidae | Picomonas     | Picomonas_judraskeda | 74  |
| Archaeplastida | Picozoa  | Picozoa_X   | Picozoa_XX  | Picozoa_XXX  | Picozoa_XXXX  | Picozoa_XXXXX | Picozoa_XXXXX_sp.    | 391 |

#### Sheet “metadata”

Contains all the metadata of the PR2 database.

Please see a complete list of the fields
[here](https://pr2-database.org/documentation/pr2-fields/)

In addition columns:

- `pr2_annotated` is 1 if the sequence is part of the PR2 database and 0
  if it is not been annotated
- `species_old` should not be changed if you edit the species column

## PR2 curation pipeline for EukRef workshop

[PR2_Curation.Rmd](R/PR2_Curation.Rmd)

## Groups exported

[PR2-exports-stats.md](exports/PR2-exports-stats.md)
