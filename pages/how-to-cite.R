howPage <- fluidPage(fluidRow(column(
  12,
  h5(
    "If you use data from the database in your research, please cite as follows:"
  ),
  p(
    "Chechuro I., Daniel M., Dobrushina N., and Verhees S. 2019. Daghestanian loans database. Linguistic Convergence Laboratory, HSE. (Available online at https://lingconlab.github.io/Dagloan_database/)"
  ),
  tags$img(src = "https://zenodo.org/badge/164257298.svg"),
  p("accessed on ", format(Sys.time(), '%B %d, %Y'))
)))