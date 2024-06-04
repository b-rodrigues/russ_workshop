library(targets)
library(tarchetypes)

list(
  tar_force(
    name = paper,
    command = quarto::quarto_render("russ_pres"),
    format = "file", 
    force = TRUE
  )

)
