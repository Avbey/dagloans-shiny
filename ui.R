library(leaflet)

navbarPage("Dagloans",
           tabPanel("Main",
                    sidebarLayout(
                      sidebarPanel(
                        
                        
                      ),
                      mainPanel(
                        
                        leafletOutput("samplemap")
                      )
                    )
           ),
           tabPanel("Summary",
                    verbatimTextOutput("summary")
           ),
           tabPanel("Table",
                    DT::dataTableOutput("table")
           ),
           tabPanel("About",
                    fluidRow(
                      column(9,
                             includeMarkdown("about.Rmd")
                      )
                    )
           )
           
)