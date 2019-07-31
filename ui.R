source("modules/ViewDatabaseUI.R")
source("modules/EditDatabaseUI.R")
source("modules/UpSet-mediationUI.R")
source("modules/LexicalMapUI.R")

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("About project", tabName = "about", icon = icon("info")),
    menuItem("How to cite this project", tabName = "howto", icon = icon("question")),
    menuItem("The database", tabName = "database", icon = icon("th"),
             menuSubItem("View", tabName = "database-view", icon = icon("eye")),
             menuSubItem("Edit", tabName = "database-edit", icon = icon("edit"))),
    menuItem("Interactive maps", tabName = "maps", icon = icon("map"),
             menuSubItem("Map of the surveyed villages", tabName = "mapsurv", icon = icon("map-marked")),
             menuSubItem("Lexical map", tabName = "maplex", icon = icon("map-marked-alt"))),
    menuItem("Sources of lexical influence", tabName = "sourceslex", icon = icon("table")),
    menuItem("Cluster Dendrograms", tabName = "clusterdends", icon = icon("chart-area"),
             menuSubItem("Foreign Influence", tabName = "clusterdend", icon = icon("chart-area")),
             menuSubItem("Foreign Influence (Strict Distances)", tabName = "clusterdend-strict", icon = icon("chart-area"))),
    menuItem("Mediation of Turkic influence", tabName = "mediation-turkic", icon = icon("chart-bar"),
             menuSubItem("Between speakers", tabName = "mediation-turkic-speakers", icon = icon("user-friends")),
             menuSubItem("Between villages", tabName = "mediation-turkic-villages", icon = icon("home")),
             menuSubItem("Via major languages", tabName = "mediation-turkic-major", icon = icon("list"))),
    menuItem("Mediation of Total Turkic Influence", tabName = "mediation-turkic-total", icon = icon("chart-bar"),
             menuSubItem("Between villages", tabName = "mediation-turkic-total-villages", icon = icon("home")),
             menuSubItem("Between languages", tabName = "mediation-turkic-total-languages", icon = icon("atlas"))),
    menuItem(HTML("Mediation of Standard<br>Azerbaijani Influence"), tabName = "mediation-azer", icon = icon("chart-bar"),
             menuSubItem("Between villages", tabName = "mediation-azer-villages", icon = icon("home")),
             menuSubItem("Between languages", tabName = "mediation-azer-languages", icon = icon("atlas"))),
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
    tabItem(tabName = "about", uiOutput("about")),
    tabItem(tabName = "howto", uiOutput("howto")),
    tabItem(tabName = "database-view", ViewDatabaseUI("viewdb")),
    tabItem(tabName = "database-edit", EditDatabaseUI("editdb")),
    tabItem(tabName = "mapsurv", uiOutput("mapsurv")),
    tabItem(tabName = "maplex", LexicalMapUI("maplex")),
    tabItem(tabName = "sourceslex", uiOutput("sourceslex")),
    tabItem(tabName = "clusterdend", uiOutput("clusterDend")),
    tabItem(tabName = "clusterdend-strict", uiOutput("clusterDendStrict")),
    tabItem(tabName = "mediation-turkic-speakers", uiOutput("mediationSpeakers")),
    tabItem(tabName = "mediation-turkic-villages", uiOutput("mediationVillages")),
    tabItem(tabName = "mediation-turkic-total-villages", UpSetMediationUI("turkictotalvillages")),
    tabItem(tabName = "mediation-turkic-total-languages", UpSetMediationUI("turkictotallanguages")),
    tabItem(tabName = "mediation-turkic-major", uiOutput("mediationTurkicMajor")),
    tabItem(tabName = "mediation-azer-villages", UpSetMediationUI("azervillages")),
    tabItem(tabName = "mediation-azer-languages", UpSetMediationUI("azerlanguages")),
    tabItem(tabName = "acknowledgements", uiOutput("acknowledgements")),
    tabItem(tabName = "references", uiOutput("references"))
  )
)

# Put all together into dashboardPage
shinyUI(dashboardPage(
  dashboardHeader(title = "Daghestanian loans database", titleWidth = 308),
  sidebar,
  body
)
)
