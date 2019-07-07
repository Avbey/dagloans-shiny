library(shinydashboard)
source("pages/mediation-turkic.R")

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("About project", tabName = "about", icon = icon("info")),
    menuItem("How to cite this project", tabName = "howto", icon = icon("question")),
    menuItem("The database", tabName = "database", icon = icon("th")),
    menuItem("Map of the surveyed villages", tabName = "mapsurv", icon = icon("map-marked")),
    menuItem("Sample lexical map", tabName = "maplex", icon = icon("map-marked")),
    menuItem("Sources of lexical influence", tabName = "sourceslex", icon = icon("table")),
    menuItem("Cluster Dendrogram of Foreign Influence", tabName = "clusterdend", icon = icon("chart-bar")),
    menuItem(HTML("Cluster Dendrogram of Foreign Influence<br> (Strict Distances)"), tabName = "clusterdend-strict", icon = icon("chart-bar")),
    menuItem("Mediation of Turkic influence (Speakers)", tabName = "mediation-speakers", icon = icon("chart-bar")),
    menuItem("Mediation of Turkic influence (Villages)", tabName = "mediation-villages", icon = icon("chart-bar")),
    menuItem("Mediation of Total Turkic Influence", tabName = "mediation-turkic", icon = icon("chart-bar")),
    menuItem("Mediation of Standard Azerbaijani Influence", tabName = "mediation-azer", icon = icon("chart-bar")),
    menuItem(HTML("Mediation of Turkic Influence<br>via Major Languages"), tabName = "mediation-azer-major", icon = icon("chart-bar")),
    menuItem("Acknowledgements", tabName = "acknowledgements", icon = icon("bookmark")),
    menuItem("References", tabName = "references", icon = icon("paperclip"))
  ),
  width = 308
)

body <- dashboardBody(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
  ),
  tabItems(
    tabItem(tabName = "about",
          uiOutput("about")
    ),

    tabItem(tabName = "howto",
           uiOutput("howto")
    ),

    tabItem(tabName = "database",
           uiOutput("theDatabase")
    ),

    tabItem(tabName = "mapsurv",
           uiOutput("mapsurv")
    ),

    tabItem(tabName = "maplex",
           uiOutput("maplex")
    ),

    tabItem(tabName = "sourceslex",
            uiOutput("sourceslex")
    ),

    tabItem(tabName = "clusterdend",
            uiOutput("clusterDend")
    ),

    tabItem(tabName = "clusterdend-strict",
            uiOutput("clusterDendStrict")
    ),

    tabItem(tabName = "mediation-speakers",
            uiOutput("mediationSpeakers")
    ),

    tabItem(tabName = "mediation-villages",
            uiOutput("mediationVillages")
    ),

    tabItem(tabName = "mediation-turkic",
            mediationTurkicUI("mediationturkictotal")),
    
    tabItem(tabName = "mediation-azer",
            uiOutput("mediationAzer")
    ),
    tabItem(tabName = "mediation-azer-major",
            uiOutput("mediationAzerMajor")
    ),
    tabItem(tabName = "acknowledgements",
            uiOutput("acknowledgements")
    ),
    tabItem(tabName = "references",
            uiOutput("references")
    )
  )
)

# Put all together into dashboardPage
shinyUI(dashboardPage(
  dashboardHeader(title = "Daghestanian loans database", titleWidth = 308),
  sidebar,
  body
)
)
