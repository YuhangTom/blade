## code to prepare `x3p_subsamples` dataset
wire_name <- "T1AW-LO-R1"
blade_name <- "T1AS-R1"

cors_df <- readr::read_rds(sprintf("../Wirecuts/sheet-wire-alignments-hh/%s_%s.rds", blade_name, wire_name))
usethis::use_data(cors_df, overwrite = TRUE)
