# This is run only once to Read the database from Gcloud and save it as qs file


source("R/PR2_init.R")

# Read pr2 database  ----------------------------

taxo_levels_number = pr2.env$taxo_levels_number

taxo_levels<- list()
taxo_levels[[9]] = c("domain", "supergroup", "division", "subdivision", "class", "order", "family", "genus", "species")


pr2_db <- db_info("pr2_google")

pr2_db_con <- db_connect(pr2_db)

pr2_main <- tbl(pr2_db_con, "pr2_main") %>%
  collect() 


pr2_seq <- tbl(pr2_db_con, "pr2_sequences") %>%
  collect()

pr2_taxo <- tbl(pr2_db_con, "pr2_taxonomy") %>%
  filter (is.na(taxo_removed_version)) %>%
  collect()

pr2_metadata <- tbl(pr2_db_con, "pr2_metadata") %>%
  collect() 

pr2_assign_bayes <- tbl(pr2_db_con, "pr2_assign_bayes") %>%
  collect()

eukribo <- tbl(pr2_db_con, "eukribo_v2") %>%
  select(genbank_accession = gb_accession, eukribo_UniEuk_taxonomy_string, eukribo_V4, eukribo_V9) %>% 
  collect() 

# Join the tables and keep only sequences that are not removed

pr2_join <- pr2_main %>%
  left_join(pr2_taxo, by = c("species"="species")) %>%
  left_join(pr2_seq) %>%
  left_join(pr2_metadata) %>%
  left_join(eukribo) %>%
  left_join(pr2_assign_bayes) %>%
  relocate(!!taxo_levels[[taxo_levels_number]], .after = pr2_accession)  %>%
  select_if(~!all(is.na(.))) %>%  # remove empty columns
  select(-gb_sequence) %>% 
  filter(is.na(removed_version))

db_disconnect(pr2_db_con)

qs::qsave(pr2_join, here::here("databases", "pr2_active.qs"))

# pr2_join <- qs::qread(here::here("databases", "pr2_active.qs")) # to read in case reset

pr2_18S <- pr2_join %>% 
  filter(gene == "18S_rRNA") # Will include nucleomorph

# Save as qs file
# - Only 18S
# - Contains quarantined entries but not removed ones

qs::qsave(pr2_18S, here::here("databases", "pr2_18S.qs"))