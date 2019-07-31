ViewDatabaseUI <- function(id) {
  ns <- NS(id)
  navbarPage(" ", id = "the-db",
    tabPanel("Raw",
             fluidRow(column(12,
               p(
                 "For now, the table shows source, ",
                 tags$b("Concepts"),
                 " and target ",
                 tags$b("Words."),
                 "Each target word is grouped in a similarity ",
                 tags$b("Set"),
                 "- a set of words that have the same meaning and look similar. In the future, data will be added on borrowing sources. Metadata includes the name of the ",
                 tags$b("Village"),
                 "where the word was recorded, the administrative ",
                 tags$b("District"),
                 " it is part of, the ",
                 tags$b("Language"),
                 " spoken there, and the ",
                 tags$b("List ID:"),
                 " these ID's correspond to a particular speaker or in some cases a written source like a dictionary.",
                 "Data is accessible at: ",
                 tags$a(href = "https://github.com/LingConLab/DagloanDatabase", "Github/LingConLab/DagloanDatabase")
               ),
               p(
                 "The dataset in the one-hot format is available ",
                 tags$a(href = "https://github.com/LingConLab/Dagloan_database/blob/master/Convert/words_28032019_dummy.tsv", "here")
               ),
               p(
                 renderText(
                   "The table below can be sorted and filtered, the resulting subset can be downloaded by pressing on the 'CSV' button."
                 )
               )
             )),
             fluidRow(column(12, DT::dataTableOutput(ns("basictable"))))
             ),
    tabPanel("Custom format",
      fluidRow(
        column(4, selectInput(ns("districts"), label = "Disticts",
          choices = c("All districst" = "", database$District), multiple = TRUE)
      ),
      column(8, conditionalPanel(condition = paste0('input[\'', ns('districts'), "\']"),
          selectInput(ns("villages"), "Villages", c("All villages" = ""), multiple = TRUE)
        )
      )),
      fluidRow(
        column(4, conditionalPanel(condition = paste0('input[\'', ns('districts'), "\']"),
                 selectInput(ns("languages"), "Languages", c("All languages" = ""), multiple = TRUE)
               )),
        column(4, conditionalPanel(condition = paste0('input[\'', ns('languages'), "\']"),
                 selectInput(ns("families"), "Families", c("All families" = ""), multiple = TRUE)
               )),
        column(4, conditionalPanel(condition = paste0('input[\'', ns('languages'), "\']"),
                 selectInput(ns("groups"), "Groups", c("All groups" = ""), multiple = TRUE)
               ))
      ),
      fluidRow(column(12, DT::dataTableOutput(ns("advancedtable"))))
    )
  )
}