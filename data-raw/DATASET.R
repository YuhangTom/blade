## code to prepare `x3p_subsamples` dataset
library(purrr)

wire_names <- c(
  "T1AW-LO-R1"
)

wire_dir <- wire_names %>%
  paste0("../Wirecuts/scans/", .) %>%
  paste0(".x3p")

wire_subsamples <- purrr::map(wire_dir, x3ptools::x3p_read) %>%
  purrr::map(x3ptools::x3p_average, b = 10) %>%
  purrr::set_names(wire_names)

blade_names <- c(
  "T1AS-R1"
)

blade_dir <- blade_names %>%
  paste0("../Wirecuts/sheet-scans/", .) %>%
  paste0(".x3p")

blade_subsamples <- purrr::map(blade_dir, x3ptools::x3p_read) %>%
  purrr::map(x3ptools::x3p_average, b = 10) %>%
  purrr::set_names(blade_names)

x3p_subsamples <- c(wire_subsamples, blade_subsamples)

usethis::use_data(x3p_subsamples, overwrite = TRUE)
