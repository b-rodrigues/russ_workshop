library(targets)
library(tarchetypes)

list(
  tar_force(
    name = paper,
    command = quarto::quarto_render("dipf_pres.qmd"),
    format = "file", 
    force = TRUE
  )

)
