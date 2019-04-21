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
            includeMarkdown(knitr::knit("pages/about.Rmd"))
    ),
    
    tabItem(tabName = "howto",
            includeMarkdown(knitr::knit("pages/how-to-cite.Rmd"))
    ),
    
    tabItem(tabName = "database",
            includeMarkdown(knitr::knit("pages/the-database.Rmd"))
    ),
    
    tabItem(tabName = "mapsurv",
            h2("Content 3")
    ),
    
    tabItem(tabName = "maplex",
            h2("Content 4")
    ),
    
    tabItem(tabName = "sourceslex",
            h2("Content 5")
    ),
    
    tabItem(tabName = "cluster",
            h2("Content 6")
    ),
    
    tabItem(tabName = "speakers",
            h2("Content 7")
    ),
    
    tabItem(tabName = "villages",
            h2("Content 8")
    )
  )
)

# Put all together into a dashboardPage
dashboardPage(
  dashboardHeader(title = "Daghestanian loans database", titleWidth = 308),
  sidebar,
  body
)

