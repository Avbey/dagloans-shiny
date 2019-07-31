source("modules/ViewDatabase.R")
source("modules/EditDatabase.R")
source("modules/UpSet-mediation.R")
source("modules/LexicalMap.R")
source("pages/about.R")
source("pages/how-to-cite.R")
source("pages/mapsurv.R")
source("pages/sourceslex.R")
source("pages/cluster-dendrogram.R")
source("pages/cluster-dendrogram-strict.R")
source("pages/mediation-speakers.R")
source("pages/mediation-villages.R")
source("pages/mediation-via-major.R")
source("pages/acknowledgements.R")
source("pages/references.R")

shinyServer(function(input, output) {
  
  # Callback functions for db editing
  my.insert.callback <- function(data, row) {
    database <- rbind(data, database)
    return(database)
  }
  
  my.update.callback <- function(data, olddata, row) {
    database[row,] <- data[1,]
    return(database)
  }
  
  my.delete.callback <- function(data, row) {
    database <- database[-row,]
    return(database)
  }
  
  DTedit::dtedit(input, output, name = 'datatable',
                 thedata = database,
                 edit.cols = colnames(database),
                 edit.label.cols = colnames(database),
                 view.cols = colnames(database),
                 callback.update = my.update.callback,
                 callback.insert = my.insert.callback,
                 callback.delete = my.delete.callback)
  
  output$about <- renderUI({aboutPage})
  output$howto <- renderUI({howPage})
  output$theDatabase <- renderUI({databasePage})
  callModule(ViewDatabase, "viewdb")
  callModule(EditDatabase, "editdb")
  output$mapsurv <- renderUI({mapSurvPage})
  callModule(LexicalMap, "maplex", maplex_words)
  output$sourceslex <- renderUI({sourcesLexPage})
  output$clusterDend <- renderUI({clusterDendPage})
  output$clusterDendStrict <- renderUI({clusterDendStrictPage})
  output$mediationSpeakers <- renderUI({mediationSpeakersPage})
  output$mediationVillages <- renderUI({mediationVillagesPage})
  callModule(UpSetMediation, "turkictotalvillages", all_turkic_wide_total_village)
  callModule(UpSetMediation, "turkictotallanguages", all_turkic_wide_total_language)
  output$mediationTurkicMajor <- renderUI({mediationTurkicMajorPage})
  callModule(UpSetMediation, "azervillages", all_turkic_wide_az_village)
  callModule(UpSetMediation, "azerlanguages", all_turkic_wide_az_language)
  output$acknowledgements <- renderUI({acknowledgementsPage})
  output$references <- renderUI({referencesPage})
})