## 2023-08-16 - Nina

Hi Daniel, I checked the file again. There were a few sequences missing from the tree and subsequently were wrongly annotated. I ran a new tree with all sequences and corrected the annotation in respective sequences.

Here is the new alignment file and tree (although in the final nothing has really changed) and the annotation file.

Regarding the sequences belonging to Picomonadea you’re right. Those belong to the class, but below the class there is no further annotation possible. 

Thanks for the corrections! I hope the annotation is fine now.


## 2023-07-21 - Daniel

Hi Nina

I have changed quite a few things in your file (attached below). If you can check that this OK.

The key point is that when something is changed at a higher level, e.g. the subdivision, this needs to be propagated down to the species level, because if this is not case the same species name (e.g. Picozoa_XXXXX_sp. will correspond to different taxonomic paths.
The second point is that I prefer to have in PR2 things that are more explicit so that at the species level you an idea from which group the sequence belongs (this is a bit different from the initial phylosophy of eukref which prefered short names... ).

I have marked:

* in yellow the change I made (changing the clade names to be more explicit and
* in red these are sequences that are removed from PR2 for other reasons (too many N usually)
* in orange chimera
Two points which you should more specifically check

* Within subdivision 1, there are some sequences that we part of Picomonadea but annotated by you as Picozoa_XXXXX_sp. I guessed that these sequences where part of the class but could not be assigned to the genus Picomonas, so I assigned them at the sepcies level as Picomonadea_XXX_sp.
* Sequence JN418965.1.524_U was marked as part of Picozoa_subdivision_2 (PIC2) but still labelled as the species level as Picomonas_sp.
Thanks a lot.