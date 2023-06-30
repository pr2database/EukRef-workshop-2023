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
    TTGATCCTGCCAGTAGTCATATGCTTGTCTCAAAGATTAAGCCATGCATGTCTAAGTATAAGCACCTTATACTGTGAAACTGCGAATGGCTCATTAAATCAGTTATCGTTTATTTGATGATCTCTTGCTACTTGGATACCCGTGGTAATTCTAGAGCTAATACATGCGACAACACCCGACTTCTGGAAGGGTGGTATTTATTAGATAAAAAACCTACTCGCTTCGGCGATCCTTCGGTGATTCATAATAACTTTTCGAAGTGCATGACCTTGTGTCGGCGCTGGTTCATTCAAATTTCTGCCCTATCAACTTTCGATGGTAGGATAGAGGCCTACCATGGTGGTAACGGGTAACGGAGAATTAGGGTTCGATTCCGGAGAGGGAGCCTGAGAGACGGCTACCACATCCAAGGAAGGCAGCAGGCGCGCAAATTACCCAATCCTGACACAGGGAGGTAGTGACAAAAAATACCAATACAGGGCATTACATGTCTTGTAATTGGAATGAGAACAATTTAAATCCCTTATCGAGGATCCATTGGAGGGCAAGTCTGGTGCCAGCAGCCGCGGTAATTCCAGCTCCAATAGCGTATATTAAAGTTGTTGCAGTTAAAAAGCTCGTAGTCGGATTTTGGCATCACGCCGTACTGTCTGCCGATTGGTATGCACGGTTTGGCGGGTGCTTCCTTCCGGAGGCTCGTTCCCTCCTTAACTGAAGGGTTCGTTGGTTCCGGTTCTTTTACTTTGAGAAAATTAGAGTGTTCAAAGCAGGCCTATGCTCTGAATAGGTTAGCATGGAATAATAGAATAGGACTTTGGTTCTATTTTGTTGGTTTCTAGGACCGAAGTAATGATTAATAGGGACAGTTGGGGGCATTCATATTCCATTGTCAGAGGTGAAATTCTTGGATTAACGGAAGATGAACTTCTGCGAAAGCATCTGCCAAGGATGTTTTCATTGATCAAGAACGAAAGTTAGGGGATCGAAGACGATCAGATACCGTCGTAGTCTTAACCATAAACTATGCCGACTAGGGATGTGGAGGTGTTAACTTTGTACGACCCTCCATGCACCTTATGAGAAATCAAAGTCTATGGGTTCCGGGGGGAGTATGGTCGCAAGGCTGAAACTTAAAGGAATTGACGGAAGGGCACCACCAGGAGTGGAGCCTGCGGCTTAATTTGACTCAACACGGGAAAACTTACCAGGTCCAGACATAGTTAGGATTGACAGATTGAGAGCTCTTTCTTGATTCTATGGGTGGTGGTGCATGGCCGTTCTTAGTTGGTGGAGTGATTTGTCTGGTTAATTCCGATAACGAACGAGACCTTAACCTGCTAAATAGTAGTCCGATGATTTCTTCATCGTGTCGACTTCTTAGAGGGACTATCGGTGTCTAACCGATGGAAGTTTGAGGCAATAACAGGTCTGTGATGCCCTTAGATGTTCTGGGCCGCACGCGCGCTACACTGATGAATTCAACGAGTTTTCCACCTTGACCGAGAGGTCCGGGAAATCTTTTCAACTTTCATCGTGCTGGGGATAGATTATTGCAATTATTAATCTTGAACGAGGAATTCCTAGTAAGCGCGAGTCATCAGCTCGCGTTGATTACGTCCCTGCCCTTTGTACACACCGCCCGTCGCTACTACCGATTGAGCATTAGGGTGAAATCTTCGGACCGTGGCATACTTCTGGCCTAGCCAGTCTTTGTCCGTGGGAGGTCGCTTAAATCCTGATGCTTAGAGGAAGTAAAAGTCGTAACAAGGTTTCCGTAGGTGAACCTGCGGAAGGATCATTACCACAT

### pr2_export.txt

Contains the taxonomy for each sequence

    "pr2_accession" "tax"
    "JX988758.1.1807_U" "Eukaryota; Archaeplastida; Picozoa; Picozoa_X; Picomonadea; Picomonadida; Picomonadidae; Picomonas; Picomonas_judraskeda"
    "AB238147.1.571_U"  "Eukaryota; Archaeplastida; Picozoa; Picozoa_X; Picomonadea; Picomonadida; Picomonadidae; Picomonas; Picomonas_judraskeda"
    "AJ965237.1.608_U"  "Eukaryota; Archaeplastida; Picozoa; Picozoa_X; Picomonadea; Picomonadida; Picomonadidae; Picomonas; Picomonas_judraskeda"
    "AY295566.1.543_U"  "Eukaryota; Archaeplastida; Picozoa; Picozoa_X; Picomonadea; Picomonadida; Picomonadidae; Picomonas; Picomonas_judraskeda"
    "AY295445.1.548_U"  "Eukaryota; Archaeplastida; Picozoa; Picozoa_X; Picomonadea; Picomonadida; Picomonadidae; Picomonas; Picomonas_judraskeda"

### pr2_export.xlsx

This file contains two sheets:

#### Sheet “taxonomy”

This is a summary of the taxonomy with the number of sequences assigned
to each species

| supergroup     | division | subdivision | class       | order        | family        | genus         | species              | n   |
|----------------|----------|-------------|-------------|--------------|---------------|---------------|----------------------|-----|
| Archaeplastida | Picozoa  | Picozoa_X   | Picomonadea | Picomonadida | Picomonadidae | Picomonas     | Picomonas_judraskeda | 74  |
| Archaeplastida | Picozoa  | Picozoa_X   | Picozoa_XX  | Picozoa_XXX  | Picozoa_XXXX  | Picozoa_XXXXX | Picozoa_XXXXX_sp.    | 391 |

### Sheet “metadata”

Contains all the metadata of the PR2 database.

Please see a complete list of the fields
[here](https://pr2-database.org/documentation/pr2-fields/)

In addition columns:

- `pr2_annotated` is TRUE if the sequence is part of the PR2 database
  and false if it is not been annotated
- `species_old` should not be changed if you edit the species column
