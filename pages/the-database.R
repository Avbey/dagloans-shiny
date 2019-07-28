database$`Concept nr.` <- as.factor(database$`Concept nr.`)
database$`List ID` <- as.factor(database$`List ID`)
database$Gender <- as.factor(database$Gender)
database$Birthyear <- as.integer(database$Birthyear)
database$Family <- as.factor(database$Family)
database$Group <- as.factor(database$Group)
database$Language <- as.factor(database$Language)
database$Village <- as.factor(database$Village)
database$Concept <- as.factor(database$Concept)
database$Set <- as.factor(database$Set)
database$District <- as.factor(database$District)

# library(DT)
# library(plyr)
# library(tidyverse)
# library(ggplot2)
# library(plotly)
# library(lingtypology)
# library(dendextend)
# library(pvclust)
# library(UpSetR)
# library(leaflet)
# library(colourpicker)
# library(dplyr)
# Kaitag <- words_meta[which(database$District %in% c("Kaitag", "Dictionary")),]
# Kaitag <- Kaitag[,which(colnames(Kaitag) %in% c("Code", "Word", "Concept"))]
# Kaitag_aggr <- ddply(Kaitag, .(Code, Concept), summarize,
#            Wordc=paste(Word,collapse=", "))
# Kaitag_wide <- spread(Kaitag_aggr, Code, Wordc)
# write_tsv(as.data.frame(Kaitag_wide), "Kaitag.tsv", na = "NA")

databaseTable <- DT::renderDataTable({database}, class = 'cell-border stripe compact', 
                                     filter = 'top', 
                                     extensions = 'Buttons', 
                                     options = list(
                                       autoWidth = TRUE,
                                       columnDefs = list(list(width = '50px', targets = c(1, 5))),
                                       pageLength = 100,
                                       dom = 'lBfrtip',
                                       scrollX = TRUE,
                                       buttons = c('copy', 'csv')))

databasePage <- fluidPage(fluidRow(column(
  12,
  p("For now, the table shows source, ", tags$b("Concepts"), " and target ", tags$b("Words."), 
  "Each target word is grouped in a similarity ", tags$b("Set"), "- a set of words that have the same meaning and look similar. In the future, data will be added on borrowing sources. Metadata includes the name of the ",
  tags$b("Village"), "where the word was recorded, the administrative ", tags$b("District"), " it is part of, the ", tags$b("Language"),  " spoken there, and the ", tags$b("List ID:"), " these ID's correspond to a particular speaker or in some cases a written source like a dictionary.",
  "Data is accessible at: ", tags$a(href="https://github.com/LingConLab/DagloanDatabase", "Github/LingConLab/DagloanDatabase")),
  p("The dataset in the one-hot format is available ", tags$a(href="https://github.com/LingConLab/Dagloan_database/blob/master/Convert/words_28032019_dummy.tsv", "here")),
  p(renderText("The table below can be sorted and filtered, the resulting subset can be downloaded by pressing on the 'CSV' button.")),
  div(databaseTable)
)))