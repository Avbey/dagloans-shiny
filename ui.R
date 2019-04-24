library(shinydashboard)
library(knitr)
library(rmdformats)

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("About project", tabName = "about", icon = icon("info")),
    menuItem("How to cite this project", tabName = "howto", icon = icon("question")),
    menuItem("The database", tabName = "database", icon = icon("th")),
    menuItem("Map of the surveyed villages", tabName = "mapsurv", icon = icon("map-marked")),
    menuItem("Sample lexical map", tabName = "maplex", icon = icon("map-marked")),
    menuItem("Sources of lexical influence", tabName = "sourceslex", icon = icon("table")),
    menuItem("Cluster Dendrogram of Foreign Influence", tabName = "cluster", icon = icon("file-alt")),
    menuItem("Mediation of Turkic influence (Speakers)", tabName = "speakers", icon = icon("chart-bar")),
    menuItem("Mediation of Turkic influence (Villages)", tabName = "villages", icon = icon("chart-bar"))
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
            h2("upcoming")
    ),

    tabItem(tabName = "cluster",
            h2("upcoming")
    ),

    tabItem(tabName = "speakers",
            h2("upcoming")
    ),

    tabItem(tabName = "villages",
            h2("upcoming")
    )
  )
)

# Put all together into a dashboardPage
shinyUI(dashboardPage(
  dashboardHeader(title = "Daghestanian loans database", titleWidth = 308),
  sidebar,
  body
)
)
