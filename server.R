source("pages/about.R")
source("pages/how-to-cite.R")
source("pages/the-database.R")
source("pages/mapsurv.R")

shinyServer(function(input, output) {
  output$about <- renderUI({aboutPage})
  output$howto <- renderUI({howPage})
  output$theDatabase <- renderUI({databasePage})
  #output$mapsurv <- 
})