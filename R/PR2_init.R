
# Libraries for bioinfo ----------------------------------------------------

  # library("dada2")
  # library("Biostrings")
  # library(bioseq) # Easier to use to manipulate sequences
  # library("taxa")
  # library("scales")  # necessary to transform heatmaps

# Libraries tidyr ---------------------------------------------------------

  library("ggplot2") 
  library("dplyr")
  library("tidyr")   
  library("tibble")
  library("readr")  # Keep for tsv reading/writing
  library("purrr")
  library("forcats")
  library("lubridate")
  library("stringr")
  library(rio) # For import / export
  library(here)

# Libraries dvutils and pr2database -------------------------------------------------------

  if(any(grepl("package:dvutils", search()))) detach("package:dvutils", unload=TRUE)
  library("dvutils")

# Helper function to add remarks
  
  str_append<- function(x, y) ifelse(is.na(x), y, str_c(x, y, sep= "; "))

# Define PR2 global variables ----------------------------

  pr2.env <- list()
  pr2.env$pr2_directory = str_replace(here::here(), "/data", "/")
  
  pr2.env$version = "5.0.0"
  
  pr2.env$date = format(Sys.time(), "%Y-%m-%d")
  
  # do not forget to add in the annotator table in the MySQL database
  pr2.env$editor = "D. Vaulot"
  
  pr2.env$ambiguities_max = 20
  pr2.env$sequence_length_min = 500
  pr2.env$sequence_length_max = 15000 # only for imported GenBank sequences
  pr2.env$sequence_N_repeat = "NN"
  
  # Useful strings
  pr2.env$taxo_levels <- list()
  pr2.env$taxo_levels[[8]] = c("kingdom", "supergroup", "division", "class", "order", "family", "genus", "species")
  pr2.env$taxo_levels[[9]] = c("domain", "supergroup", "division", "subdivision", "class", "order", "family", "genus", "species")
  
  pr2.env$taxo_levels_number = 9
  
  pr2.env$ambig_regex ="[^ATGCU]"
  
  # create a regex containing the names of the levels (kingdom|supergroup|....)
  pr2.env$taxo_levels_regex <- str_c(pr2.env$taxo_levels[[pr2.env$taxo_levels_number]], collapse="|")
  pr2.env$taxo_levels_regex <- str_c("(",pr2.env$taxo_levels_regex, ")")
  
  # The Eukref must be searched in this direction (first sp. and cf. and then the Genus species)
  pr2.env$genus_sp_regex <- "(^[A-Z]{1}[a-z]+)[ ]sp[.]"
  pr2.env$genus_cf_regex <- "(^[A-Z]{1}[a-z]+)[ ]cf[.][ ]([a-z]+)"
  pr2.env$genus_species_regex <- "(^[A-Z]{1}[a-z]+)[ ]([a-z]+)[ ]?"
  
  # pr2_traits used
  pr2.env$traits_used <- c("mixoplankton")
  
