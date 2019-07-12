LexicalMapUI <- function(id) {
  ns <- NS(id)
  bootstrapPage(
    leafletOutput(ns("map"), width = "100%", height = "88vh"),
    absolutePanel(id = "map-controls", class = "panel panel-default", fixed = TRUE,
                  draggable = FALSE, top = 70, left = "auto", right = 20, bottom = "auto",
                  width = 330, height = "auto",
                  h2("Lexical map"),
                  htmlOutput(ns("concepts")),
                  checkboxInput(ns("legend"), "Show legend", TRUE)
    )
  )
}