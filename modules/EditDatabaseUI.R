EditDatabaseUI <- function(id) {
  ns <- NS(id)
  fluidPage(
    uiOutput(ns("App_Panel"))
  )
}