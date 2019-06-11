library(shinydashboard)

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
            sidebarLayout(
              sidebarPanel(
              tabsetPanel(
                id = "upset_plot",
                type = "tabs",
                tabPanel(
                  "Settings",
                  htmlOutput("sets"),
                  numericInput(
                    "nintersections",
                    label = "Number of intersections to show",
                    value = 30,
                    min = 1,
                    max = 60
                  ),
                  
                  selectInput(
                    "order",
                    label = "Order intersections by",
                    choices = list("Degree" = "degree",
                                   "Frequency" = "freq"),
                    selected = "freq"
                  ),
                  selectInput(
                    "decreasing",
                    label = "Increasing/Decreasing",
                    choices = list("Increasing" = "inc",
                                   "Decreasing" = "dec"),
                    selected = "dec"
                  ),
                  
                  selectInput(
                    "scale.intersections",
                    label = "Scale intersections",
                    choices = list(
                      "Original" = "identity",
                      "Log10" = "log10",
                      "Log2" = "log2"
                    ),
                    selected = "identity"
                  ),
                  
                  selectInput(
                    "scale.sets",
                    label = "Scale sets",
                    choices = list(
                      "Original" = "identity",
                      "Log10" = "log10",
                      "Log2" = "log2"
                    ),
                    selected = "identity"
                  ),
                  
                  
                  sliderInput(
                    "upset_width",
                    label = "Plot width",
                    value = 650,
                    min = 400,
                    max = 1200,
                    ticks = FALSE,
                    step = 10
                  ),
                  
                  sliderInput(
                    "upset_height",
                    label = "Plot height",
                    value = 400,
                    min = 300,
                    max = 1000,
                    ticks = FALSE,
                    step = 10
                  ),
                  
                  sliderInput(
                    "mbratio",
                    label = "Bar matrix ratio",
                    value = 0.30,
                    min = 0.20,
                    max = 0.80,
                    ticks = FALSE,
                    step = 0.01
                  ),
                  
                  checkboxInput('show_numbers', label = "Show numbers on bars", value = TRUE),
                  
                  sliderInput(
                    "angle",
                    label = "Angle of number on the bar",
                    min = -90,
                    max = 90,
                    value = 0,
                    step = 1,
                    ticks = F
                  ),
                  
                  checkboxInput('empty', label = "Show empty intersections", value = FALSE),
                  checkboxInput('keep.order', label = "Keep set order", value = FALSE),
                  
                  numericInput(
                    "pointsize",
                    label = "Connecting point size",
                    value = 2.5,
                    min = 1,
                    max = 10
                  ),
                  
                  numericInput(
                    "linesize",
                    label = "Connecting line size",
                    value = 0.8,
                    min = 0.5,
                    max = 10
                  )
                ),
                tabPanel(
                  "Font & Colors",
                  colourInput("mbcolor", "Select main bar colour", "#ea5d4e"),
                  colourInput("sbcolor", "Select set bar colour", "#317eab"),
                  
                  numericInput(
                    "intersection_title_scale",
                    label = "Font size of intersection size label",
                    value = 1.8,
                    min = 0.5,
                    max = 100
                  ),
                  numericInput(
                    "set_title_scale",
                    label = "Set size label font",
                    value = 1.8,
                    min = 0.5,
                    max = 100
                  ),
                  numericInput(
                    "intersection_ticks_scale",
                    label = "Intersection size ticks font",
                    value = 1.2,
                    min = 0.5,
                    max = 100
                  ),
                  numericInput(
                    "set_ticks_scale",
                    label = "Set Size ticks font",
                    value = 1.5,
                    min = 0.5,
                    max = 100
                  ),
                  numericInput(
                    "intersection_size_numbers_scale",
                    label = "Intersection Size Numbers font size",
                    value = 1.2,
                    min = 0.5,
                    max = 100
                  ),
                  numericInput(
                    "names_scale",
                    label = "Set Names font size",
                    value = 1.5,
                    min = 0.5,
                    max = 100
                  )
                ),
                tabPanel(
                  HTML("<i class='fas fa-file-download'></i>"),
                  radioButtons(
                    inputId = "filetype",
                    label = "Choose file type to download:",
                    inline = TRUE,
                    choices = list("PDF", "PNG", "SVG", "TIFF")
                  ),
                  
                  downloadButton(outputId = "UpSetDown", label = "Download Plot")
                )
              )
            ),
            mainPanel(
              id = "upsetplottab",
              plotOutput('mediationTurkic')
            ))),
    
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

# Put all together into a dashboardPage
shinyUI(dashboardPage(
  dashboardHeader(title = "Daghestanian loans database", titleWidth = 308),
  sidebar,
  body
)
)
